#!/bin/bash
################################################################################
# OpenClaw 快速部署脚本
#
# 一键部署 OpenClaw 到新服务器
#
# 使用方法:
#   bash openclaw-quick-deploy.sh
################################################################################

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

################################################################################
# 交互式配置读取
################################################################################

read_config() {
    info "===== OpenClaw 快速部署配置 ====="
    echo ""

    # NVIDIA API Key
    read -p "NVIDIA API Key (nvapi-...): " NVIDIA_API_KEY
    [ -z "$NVIDIA_API_KEY" ] && { error "NVIDIA API Key 不能为空"; exit 1; }

    # 飞书配置
    read -p "飞书 App ID (cli_...): " FEISHU_APP_ID
    read -p "飞书 App Secret: " FEISHU_APP_SECRET
    [ -z "$FEISHU_APP_ID" ] || [ -z "$FEISHU_APP_SECRET" ] && {
        error "飞书配置不能为空（如不需要飞书，请手动编辑配置后设 enabled=false）"
        exit 1
    }

    # Gateway Token
    read -p "Gateway Token (留空自动生成): " GATEWAY_TOKEN
    if [ -z "$GATEWAY_TOKEN" ]; then
        GATEWAY_TOKEN=$(openssl rand -hex 32 2>/dev/null || $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1))
        info "自动生成 Gateway Token: $GATEWAY_TOKEN"
    fi

    # 其他可选配置
    read -p "Gateway 端口 [19002]: " GATEWAY_PORT
    GATEWAY_PORT=${GATEWAY_PORT:-19002}

    read -p "工作区目录 [$HOME/.openclaw/workspace]: " WORKSPACE_DIR
    WORKSPACE_DIR=${WORKSPACE_DIR:-$HOME/.openclaw/workspace}

    echo ""
    info "===== 配置摘要 ====="
    echo "NVIDIA Model: z-ai/glm4.7"
    echo "飞书应用: $FEISHU_APP_ID"
    echo "Gateway 端口: $GATEWAY_PORT"
    echo "工作区: $WORKSPACE_DIR"
    echo ""
    read -p "确认配置? (y/N): " -n 1 -r
    echo
    [[ ! $REPLY =~ ^[Yy]$ ]] && { warn "部署取消"; exit 0; }
}

################################################################################
# 检查环境
################################################################################

check_env() {
    info "检查环境..."

    # 检查 Node.js
    if command -v node &> /dev/null; then
        NODE_VER=$(node -v)
        MAJOR=$(echo $NODE_VER | cut -d'v' -f2 | cut -d'.' -f1)
        if [ "$MAJOR" -lt 20 ]; then
            error "Node.js 版本过低: $NODE_VER (需要 20+)"
            exit 1
        fi
        info "✓ Node.js: $NODE_VER"
    else
        error "未安装 Node.js"
        info "安装命令: curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt-get install -y nodejs"
        exit 1
    fi

    # 检查 npm
    if command -v npm &> /dev/null; then
        info "✓ npm: $(npm -v)"
    else
        error "未安装 npm"
        exit 1
    fi

    # 检查 OpenClaw
    if command -v openclaw &> /dev/null; then
        info "✓ OpenClaw 已安装: $(openclaw --version)"
    else
        warn "OpenClaw 未安装"
        info "安装命令: npm install -g @openclaw/cli"
    fi
}

################################################################################
# 创建配置
################################################################################

create_config() {
    info "创建配置文件..."

    OPENCLAW_DIR="$HOME/.openclaw"
    mkdir -p "$OPENCLAW_DIR"

    cat > "$OPENCLAW_DIR/openclaw.json" << EOF
{
  "acp": { "enabled": false },
  "models": {
    "providers": {
      "nvidia": {
        "baseUrl": "https://integrate.api.nvidia.com/v1",
        "apiKey": "$NVIDIA_API_KEY",
        "api": "openai-completions",
        "models": [
          {
            "id": "z-ai/glm4.7",
            "name": "GLM 4.7",
            "contextWindow": 128000,
            "maxTokens": 16384,
            "reasoning": false,
            "input": ["text"]
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": "nvidia/z-ai/glm4.7",
      "workspace": "$WORKSPACE_DIR",
      "compaction": { "mode": "safeguard" }
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
      "appId": "$FEISHU_APP_ID",
      "appSecret": "$FEISHU_APP_SECRET",
      "enabled": true,
      "dmPolicy": "open",
      "allowFrom": ["*"]
    }
  },
  "gateway": {
    "port": $GATEWAY_PORT,
    "mode": "local",
    "auth": {
      "mode": "token",
      "token": "$GATEWAY_TOKEN"
    }
  },
  "plugins": {
    "allow": ["feishu"],
    "entries": { "feishu": { "enabled": true } }
  },
  "meta": {
    "lastTouchedVersion": "2026.3.11",
    "lastTouchedAt": "$(date -u +"%Y-%m-%dT%H:%M:%S.000Z")",
    "telemetry": false
  }
}
EOF

    info "✓ 配置文件已创建: $OPENCLAW_DIR/openclaw.json"
}

################################################################################
# 初始化工作区
################################################################################

init_workspace() {
    info "初始化工作区..."

    mkdir -p "$WORKSPACE_DIR"

    # .gitignore
    cat > "$WORKSPACE_DIR/.gitignore" << 'EOF'
.openclaw/
memory/
IDENTITY.md
USER.md
SOUL.md
MEMORY.md
TOOLS.md
HEARTBEAT.md
AGENTS.md
scripts/
.DS_Store
Thumbs.db
.vscode/
.idea/
skills/dist/
*.log
EOF

    # AGENTS.md
    if [ ! -f "$WORKSPACE_DIR/AGENTS.md" ]; then
        cat > "$WORKSPACE_DIR/AGENTS.md" << 'EOF'
# AGENTS.md - Your Workspace

Welcome to your OpenClaw workspace!

This folder is home. Treat it that way.

## Quick Start

1. Create your identity in IDENTITY.md
2. Add user preferences to USER.md
3. Customize SOUL.md to define who you are

## Resources

- OpenClaw Docs: https://docs.openclaw.ai
- Community: https://discord.com/invite/clawd

Created: $(date)
EOF
    fi

    info "✓ 工作区已初始化: $WORKSPACE_DIR"
}

################################################################################
# 创建技能目录
################################################################################

init_skills() {
    info "初始化技能目录..."

    mkdir -p "$WORKSPACE_DIR/skills"

    cat > "$WORKSPACE_DIR/skills/README.md" << 'EOF'
# Skills Directory

This directory contains all OpenClaw skills.

## Available Skills

Skills are automatically loaded by OpenClaw agent system.

To add new skills:
1. Create a new directory under skills/
2. Add a SKILL.md file
3. Restart the agent

## Documentation

See: https://docs.openclaw.ai/skills
EOF

    info "✓ 技能目录已创建: $WORKSPACE_DIR/skills"
}

################################################################################
# 启动服务
################################################################################

start_service() {
    info "启动 OpenClaw Gateway..."

    if command -v openclaw &> /dev/null; then
        info "启动中..."
        info "命令: openclaw gateway start"
        info ""
        warn "请在另一个终端窗口中手动运行上述命令"
        warn "或使用 systemd 服务自动启动（见 DEPLOYMENT.md）"
    else
        warn "OpenClaw 未安装，跳过启动"
    fi
}

################################################################################
# 完成
################################################################################

show_complete() {
    echo ""
    info "========================================="
    info "OpenClaw 快速部署完成！"
    info "========================================="
    echo ""
    info "📁 配置文件: $HOME/.openclaw/openclaw.json"
    info "📂 工作区: $WORKSPACE_DIR"
    info "🌐 Dashboard: http://127.0.0.1:$GATEWAY_PORT/"
    echo ""
    warn "下一步:"
    warn "1. 启动服务: openclaw gateway start"
    warn "2. 检查状态: openclaw status"
    warn "3. 设置开机自启（可选）: 见 DEPLOYMENT.md"
    echo ""
    info "📚 详细文档: DEPLOYMENT.md"
    info "💬 社区支持: https://discord.com/invite/clawd"
    echo ""
}

################################################################################
# 主流程
################################################################################

main() {
    echo ""
    info "=========================================="
    info "  OpenClaw 快速部署脚本"
    info "=========================================="
    echo ""

    read_config
    check_env
    create_config
    init_workspace
    init_skills
    start_service
    show_complete
}

main "$@"
