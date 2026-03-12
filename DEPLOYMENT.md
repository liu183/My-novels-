# OpenClaw 部署指南

本目录包含 OpenClaw 从当前服务器迁移到新服务器的完整部署脚本和配置。

## 📋 文件清单

- `openclaw-deploy.sh` - 自动部署脚本
- `openclaw-config-template.json` - 配置模板
- `DEPLOYMENT.md` - 本文档

## 🚀 快速开始

### 1. 复制文件到新服务器

```bash
# 在新服务器上执行
scp openclaw-deploy.sh user@new-server:/home/user/
scp openclaw-config-template.json user@new-server:/home/user/
```

### 2. 运行部署脚本

```bash
bash openclaw-deploy.sh
```

脚本将自动：
- ✅ 检查系统环境（Node.js、OS）
- ✅ 备份现有配置（如果有）
- ✅ 生成配置文件
- ✅ 初始化工作区
- ✅ 创建技能目录
- ✅ 验证部署结果

### 3. 配置 OpenClaw

编辑生成的配置文件：

```bash
nano ~/.openclaw/openclaw.json
```

**必须修改的配置项：**

| 配置项 | 说明 | 获取方式 |
|--------|------|----------|
| `models.providers.nvidia.apiKey` | NVIDIA API 密钥 | https://build.nvidia.com/ |
| `channels.feishu.appId` | 飞书应用 ID | 飞书开放平台 |
| `channels.feishu.appSecret` | 飞书应用密钥 | 飞书开放平台 |
| `gateway.auth.token` | Gateway 认证令牌 | 运行 `openssl rand -hex 32` |

### 4. 启动服务

```bash
# 启动 OpenClaw
openclaw gateway start

# 检查状态
openclaw status

# 查看日志
openclaw logs gateway
```

---

## 📝 手动配置步骤

如果自动部署脚本遇到问题，可以手动执行以下步骤：

### Step 1: 安装 Node.js

确保安装 Node.js 20+：

```bash
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# CentOS/RHEL
curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo yum install -y nodejs

# 验证
node -v
npm -v
```

### Step 2: 安装 OpenClaw

```bash
# 使用 npm 安装（推荐）
npm install -g @openclaw/cli

# 或使用 pnpm
pnpm add -g @openclaw/cli

# 或从源码安装
git clone https://github.com/openclaw/openclaw.git
cd openclaw
pnpm install
pnpm build
sudo pnpm link
```

### Step 3: 创建配置文件

```bash
mkdir -p ~/.openclaw
cp openclaw-config-template.json ~/.openclaw/openclaw.json
```

编辑 `~/.openclaw/openclaw.json`，替换所有 `YOUR_*` 和 `CHANGE_THIS_*` 占位符。

### Step 4: 初始化工作区

```bash
mkdir -p ~/.openclaw/workspace
cd ~/.openclaw/workspace

# 创建 .gitignore
cat > .gitignore << 'EOF'
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

# 创建 AGENTS.md
cat > AGENTS.md << 'EOF'
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
EOF
```

### Step 5: 安装技能

```bash
# 从 Git 仓库克隆技能
cd ~/.openclaw/workspace/skills

# 示例：克隆小说写作技能
git clone https://github.com/liu183/My-novels-.git temp-repo
cp -r temp-repo/skills/* .
rm -rf temp-repo
```

### Step 6: 启动服务

```bash
# 启动 Gateway
openclaw gateway start &

# 或作为系统服务（推荐）
# 编辑 systemd 服务文件
sudo nano /etc/systemd/system/openclaw-gateway.service
```

**systemd 服务示例：**

```ini
[Unit]
Description=OpenClaw Gateway Service
After=network.target

[Service]
Type=simple
User=your_username
WorkingDirectory=/home/your_username/.openclaw
ExecStart=/usr/local/bin/openclaw gateway start
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

启用并启动服务：

```bash
sudo systemctl daemon-reload
sudo systemctl enable openclaw-gateway
sudo systemctl start openclaw-gateway
sudo systemctl status openclaw-gateway
```

---

## 🔐 安全配置建议

### 1. 生成安全的 Gateway Token

```bash
# 生成 32 字节随机令牌
openssl rand -hex 32

# 使用生成的值替换 gateway.auth.token
```

### 2. 配置防火墙

```bash
# 仅允许特定 IP 访问 Gateway 端口（如果需要远程访问）
sudo ufw allow from YOUR_TRUSTED_IP to any port 19002

# 或者只允许本地访问（默认配置）
sudo ufw deny 19002
```

### 3. 配置反向代理（可选）

如果需要通过公网访问，建议使用 Nginx 反向代理：

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:19002;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### 4. 更新 .gitignore

确保敏感文件不会被提交：

```bash
cat >> ~/.openclaw/workspace/.gitignore << 'EOF'

# Sensitive config files (if committed)
openclaw.json.backup
*.apikey
*.secret
EOF
```

---

## 🔍 故障排除

### 问题 1: Gateway 无法启动

**症状：**

```bash
openclaw gateway start
# Error: EADDRINUSE: address already in use
```

**解决方案：**

```bash
# 检查端口占用
sudo lsof -i :19002

# 杀死占用进程
sudo kill -9 <PID>

# 或更改端口号
# 编辑 ~/.openclaw/openclaw.json
# 修改 "gateway.port": 19003
```

---

### 问题 2: 飞书连接失败

**症状：**

```bash
openclaw status
# Channel: Feishu - ERROR
```

**解决方案：**

1. 检查飞书应用配置
2. 确认 App ID 和 App Secret 正确
3. 检查服务器网络连接
4. 查看详细日志：

```bash
openclaw logs gateway | grep feishu
```

---

### 问题 3: NVIDIA API 调用失败

**症状：**

```
Error: Invalid API key or unauthorized
```

**解决方案：**

1. 验证 API Key 格式（应包含 `nvapi-` 前缀）
2. 检查 NVIDIA 账户余额
3. 访问 https://build.nvidia.com/ 获取新密钥

---

## 📊 配置说明

### Gateway 配置选项

| 选项 | 说明 | 默认值 |
|------|------|--------|
| `port` | Gateway 服务端口 | 19002 |
| `bind` | 绑定地址 | 127.0.0.1 |
| `mode` | 运行模式 (local/host/node) | local |
| `auth.mode` | 认证模式 (token/basicauth/none) | token |

### 模型配置

**NVIDIA GLM 4.7:**
- Context Window: 128K tokens
- Max Output: 16K tokens
- 适用场景: 长对话、复杂推理

**切换模型：**

编辑 `~/.openclaw/openclaw.json` 中的 `models.providers` 配置。

---

## 🔄 迁移现有数据

### 从旧服务器导出

```bash
# 在旧服务器上执行
cd ~
tar -czf openclaw-migration.tar.gz \
  .openclaw/ \
  .openclaw-workspace/ \
  openclaw-credentials.env
```

### 导入到新服务器

```bash
# 在新服务器上执行
cd ~
tar -xzf openclaw-migration.tar.gz

# 恢复配置
cp .openclaw/openclaw.json.backup .openclaw/openclaw.json

# 重新启动服务
openclaw gateway restart
```

---

## 📚 参考资源

- **官方文档:** https://docs.openclaw.ai
- **安装指南:** https://docs.openclaw.ai/installation
- **配置参考:** https://docs.openclaw.ai/configuration
- **API 文档:** https://docs.openclaw.ai/api
- **社区:** https://discord.com/invite/clawd
- **GitHub:** https://github.com/openclaw/openclaw

---

## 🆘 获取帮助

如果遇到问题：

1. 查看日志：`openclaw logs gateway`
2. 检查状态：`openclaw status`
3. 运行诊断：`openclaw doctor`
4. 查看详细错误：`openclaw --debug gateway start`

---

## 📝 版本信息

- OpenClaw 版本: 2026.3.11
- Node.js 要求: 20+
- OS: Linux (推荐 Ubuntu 20.04+, CentOS 8+, Alpine 3+)

---

**最后更新:** 2026-03-12
**维护者:** OpenClaw 社区
