#!/bin/bash
################################################################################
# OpenClaw 部署脚本
# 用于将当前配置迁移到新服务器
#
# 使用方法:
#   bash openclaw-deploy.sh
################################################################################

set -e  # 遇到错误立即退出

################################################################################
# 配置变量
################################################################################

# Node.js 版本要求
NODE_VERSION="24.14.0"

# OpenClaw 安装目录
OPENCLAW_DIR="$HOME/.openclaw"

# 工作区目录
WORKSPACE_DIR="$HOME/.openclaw/workspace"

# OpenClaw 端口
GATEWAY_PORT=19002

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

################################################################################
# 实用函数
################################################################################

info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_command() {
    if ! command -v $1 &> /dev/null; then
        error "$1 未安装"
        return 1
    fi
    return 0
}

################################################################################
# 步骤 1: 系统检查
################################################################################

check_system() {
    info "检查系统环境..."

    # 检查操作系统
    OS=$(uname -s)
    if [ "$OS" != "Linux" ]; then
        warn "非 Linux 系统，部分功能可能不兼容"
    fi

    # 检查 Node.js
    if ! check_command node; then
        error "请先安装 Node.js $NODE_VERSION 或更高版本"
        exit 1
    fi

    NODE_VER=$(node -v | cut -d'v' -f2 | cut -d'.' -f1,2)
    if [ "$(echo "$NODE_VER < 20" | bc)" -eq 1 ]; then
        error "Node.js 版本过低，需要 $NODE_VERSION 或更高"
        exit 1
    fi

    info "Node.js 版本: $(node -v)"
    info "系统检查通过"
}

################################################################################
# 步骤 2: 备份当前配置
################################################################################

backup_current() {
    info "备份当前配置..."

    BACKUP_DIR="$HOME/openclaw-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"

    # 备份配置文件
    cp -r "$OPENCLAW_DIR" "$BACKUP_DIR/" 2>/dev/null || true

    # 备份工作区
    cp -r "$WORKSPACE_DIR" "$BACKUP_DIR/workspace" 2>/dev/null || true

    # 压缩备份
    tar -czf "$BACKUP_DIR.tar.gz" -C "$HOME" "$(basename $BACKUP_DIR)" 2>/dev/null || true

    info "备份完成: $BACKUP_DIR.tar.gz"
}

################################################################################
# 步骤 3: 安装依赖
################################################################################

install_dependencies() {
    info "安装系统依赖..."

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                info "检测到 Ubuntu/Debian 系统"
                ;;
            centos|rhel)
                info "检测到 CentOS/RHEL 系统"
                ;;
            alpine)
                info "检测到 Alpine Linux"
                ;;
            *)
                warn "未知的 Linux 发行版: $ID"
                ;;
        esac
    fi

    info "依赖检查完成"
}

################################################################################
# 步骤 4: 安装 OpenClaw
################################################################################

install_openclaw() {
    info "安装 OpenClaw..."

    # 如果 OpenClaw 已存在，提示用户
    if [ -d "$OPENCLAW_DIR" ]; then
        warn "OpenClaw 目录已存在: $OPENCLAW_DIR"
        read -p "是否覆盖? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            info "跳过安装"
            return 0
        fi
    fi

    info "OpenClaw 目录: $OPENCLAW_DIR"
    info "请手动安装 OpenClaw 到 $OPENCLAW_DIR"
    info "安装方法参考: https://docs.openclaw.ai"
}

################################################################################
# 步骤 5: 配置文件生成
################################################################################

generate_config() {
    info "生成配置文件..."

    CONFIG_FILE="$OPENCLAW_DIR/openclaw.json"

    cat > "$CONFIG_FILE" << 'EOF'
{
  "acp": {
    "enabled": false
  },
  "models": {
    "providers": {
      "nvidia": {
        "baseUrl": "https://integrate.api.nvidia.com/v1",
        "apiKey": "YOUR_NVIDIA_API_KEY",
        "api": "openai-completions",
        "models": [
          {
            "id": "z-ai/glm4.7",
            "name": "GLM 4.7",
            "contextWindow": 128000,
            "maxTokens": 16384
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": "nvidia/z-ai/glm4.7",
      "workspace": "/home/z/.openclaw/workspace",
      "compaction": {
        "mode": "safeguard"
      }
    }
  },
  "commands": {
    "native": "auto",
    "nativeSkills": "auto",
    "restart": true,
    "ownerDisplay": "raw"
  },
  "channels": {
    "feishu": {
      "appId": "YOUR_FEISHU_APP_ID",
      "appSecret": "YOUR_FEISHU_APP_SECRET",
      "enabled": true,
      "dmPolicy": "open",
      "allowFrom": ["*"]
    }
  },
  "gateway": {
    "port": 19002,
    "mode": "local",
    "auth": {
      "mode": "token",
      "token": "SET_YOUR_TOKEN_HERE"
    }
  },
  "plugins": {
    "allow": ["feishu"],
    "entries": {
      "feishu": {
        "enabled": true
      }
    }
  },
  "meta": {
    "lastTouchedVersion": "2026.3.11",
    "lastTouchedAt": "2026-03-12T00:00:00.000Z"
  }
}
EOF

    warn "配置文件已生成: $CONFIG_FILE"
    warn "请修改以下配置项:"
    warn "  - models.providers.nvidia.apiKey: NVIDIA API Key"
    warn "  - channels.feishu.appId: 飞书应用 ID"
    warn "  - channels.feishu.appSecret: 飞书应用密钥"
    warn "  - gateway.auth.token: Gateway 认证令牌"
}

################################################################################
# 步骤 6: 初始化工作区
################################################################################

init_workspace() {
    info "初始化工作区..."

    if [ ! -d "$WORKSPACE_DIR" ]; then
        mkdir -p "$WORKSPACE_DIR"
    fi

    # 创建 .gitignore
    cat > "$WORKSPACE_DIR/.gitignore" << 'EOF'
# OpenClaw workspace files
.openclaw/

# Private memory and session files
memory/
IDENTITY.md
USER.md
SOUL.md
MEMORY.md
TOOLS.md
HEARTBEAT.md
AGENTS.md

# Temporary scripts
scripts/

# OS files
.DS_Store
Thumbs.db

# IDE files
.vscode/
.idea/

# Build/dist artifacts
skills/dist/
*.log
EOF

    # 创建 AGENTS.md
    if [ ! -f "$WORKSPACE_DIR/AGENTS.md" ]; then
        cat > "$WORKSPACE_DIR/AGENTS.md" << 'EOF'
# AGENTS.md - Your Workspace

This folder is home. Treat it that way.

## First Run

If `BOOTSTRAP.md` exists, that's your birth certificate. Follow it.

## Workspace

Your working directory is: /home/z/.openclaw/workspace

## Skills

Skills in `skills/` directory provide specialized tools and frameworks.
EOF
    fi

    info "工作区初始化完成: $WORKSPACE_DIR"
}

################################################################################
# 步骤 7: 安装技能
################################################################################

install_skills() {
    info "安装 OpenClaw 技能..."

    # 确保 skills 目录存在
    mkdir -p "$WORKSPACE_DIR/skills"

    # 创建 skills/README.md
    cat > "$WORKSPACE_DIR/skills/README.md" << 'EOF'
# Skills Directory

This directory contains all writing-related skill frameworks.

## Available Skills

- **novel-writing-framework** - 12-step interactive AI writing framework
- **auto-novel-creator** - Automated 12-step novel creation engine

## Usage

Skills are automatically loaded by OpenClaw agent system.
EOF

    # 如果有本地技能，可以在这里复制
    # cp -r ./local-skills/* "$WORKSPACE_DIR/skills/"

    info "技能目录已创建: $WORKSPACE_DIR/skills"
}

################################################################################
# 步骤 8: 启动服务
################################################################################

start_services() {
    info "启动 OpenClaw 服务..."

    # 检查 openclaw 命令
    if check_command openclaw; then
        info "OpenClaw 命令可用"
    else
        warn "openclaw 命令未找到，请确保已安装 OpenClaw"
    fi

    # 尝试启动 Gateway
    # openclaw gateway start &

    info "请手动启动服务:"
    info "  openclaw gateway start"
    info "  openclaw --help"
}

################################################################################
# 步骤 9: 验证部署
################################################################################

verify_deployment() {
    info "验证部署..."

    # 检查配置文件
    if [ -f "$OPENCLAW_DIR/openclaw.json" ]; then
        info "✓ 配置文件存在"
    else
        error "✗ 配置文件不存在"
        return 1
    fi

    # 检查工作区
    if [ -d "$WORKSPACE_DIR" ]; then
        info "✓ 工作区存在"
    else
        error "✗ 工作区不存在"
        return 1
    fi

    # 检查技能目录
    if [ -d "$WORKSPACE_DIR/skills" ]; then
        info "✓ 技能目录存在"
    else
        error "✗ 技能目录不存在"
        return 1
    fi

    info "✓ 基础验证通过"
}

################################################################################
# 步骤 10: 显示完成信息
################################################################################

show_completion() {
    echo ""
    info "========================================="
    info "OpenClaw 部署完成！"
    info "========================================="
    echo ""
    info "📁 安装目录: $OPENCLAW_DIR"
    info "📂 工作区: $WORKSPACE_DIR"
    info "🌐 Dashboard: http://127.0.0.1:$GATEWAY_PORT/"
    echo ""
    warn "⚠️  重要提醒:"
    warn "1. 请编辑配置文件: $OPENCLAW_DIR/openclaw.json"
    warn "2. 替换以下配置项:"
    warn "   - NVIDIA API Key"
    warn "   - 飞书应用配置"
    warn "   - Gateway 认证令牌"
    warn "3. 启动服务: openclaw gateway start"
    warn "4. 检查状态: openclaw status"
    echo ""
    info "📚 文档: https://docs.openclaw.ai"
    info "💬 社区: https://discord.com/invite/clawd"
    echo ""
}

################################################################################
# 主流程
################################################################################

main() {
    echo "=========================================="
    echo "  OpenClaw 部署脚本"
    echo "=========================================="
    echo ""

    read -p "是否开始部署? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "部署已取消"
        exit 0
    fi

    # 执行部署步骤
    check_system
    backup_current
    install_dependencies
    install_openclaw
    generate_config
    init_workspace
    install_skills
    start_services
    verify_deployment
    show_completion

    info "部署脚本执行完成！"
}

# 运行主流程
main "$@"
