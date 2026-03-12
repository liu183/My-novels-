# OpenClaw 服务器迁移部署包

本目录包含将当前 OpenClaw 配置迁移到新服务器的完整部署工具。

---

## 📦 文件列表

| 文件 | 说明 | 大小 |
|------|------|------|
| `openclaw-deploy.sh` | 完整部署脚本（带备份、验证） | 10KB |
| `openclaw-quick-deploy.sh` | 快速部署脚本（交互式） | 8KB |
| `openclaw-config-template.json` | JSON 配置模板 | 2KB |
| `openclaw.env.template` | 环境变量模板 | 6KB |
| `DEPLOYMENT.md` | 详细部署文档 | 6KB |
| `DEPLOYMENT-README.md` | 本文件 | - |

---

## 🎯 选择合适的部署方式

### 方案 1: 快速部署（推荐新手）

**适用场景：**
- 新服务器，无冲突
- 需要快速上手
- 配置较简单

**使用步骤：**

```bash
# 1. 上传文件到新服务器
scp openclaw-quick-deploy.sh user@new-server:~/deploy/

# 2. 连接到新服务器
ssh user@new-server

# 3. 运行快速部署脚本
cd ~/deploy
chmod +x openclaw-quick-deploy.sh
bash openclaw-quick-deploy.sh

# 4. 按提示输入配置信息
#    - NVIDIA API Key
#    - 飞书 App ID/Secret
#    - Gateway Token（可自动生成）

# 5. 启动服务
openclaw gateway start
```

**优点：**
- ✅ 交互式配置，简单直观
- ✅ 自动生成安全令牌
- ✅ 一步到位

---

### 方案 2: 完整部署（推荐生产环境）

**适用场景：**
- 生产环境部署
- 需要备份现有配置
- 需要完整验证

**使用步骤：**

```bash
# 1. 上传所有文件
scp openclaw-deploy.sh \
   openclaw-config-template.json \
   user@new-server:~/deploy/

# 2. 连接到新服务器
ssh user@new-server

# 3. 运行完整部署脚本
cd ~/deploy
chmod +x openclaw-deploy.sh
bash openclaw-deploy.sh

# 4. 编辑生成的配置文件
nano ~/.openclaw/openclaw.json
# 替换占位符：
# - YOUR_NVIDIA_API_KEY_HERE
# - YOUR_FEISHU_APP_ID_HERE
# - YOUR_FEISHU_APP_SECRET_HERE
# - CHANGE_THIS_TO_SECURE_TOKEN...

# 5. 启动服务
openclaw gateway start

# 6. 验证部署
openclaw status
```

**优点：**
- ✅ 自动备份现有配置
- ✅ 完整的环境检查
- ✅ 部署验证

---

### 方案 3: 手动部署（推荐高级用户）

**适用场景：**
- 需要精细控制
- 自定义配置
- 了解 OpenClaw 架构

**使用步骤：**

1. 参考 `openclaw-config-template.json` 手动创建配置
2. 参考 `openclaw.env.template` 设置环境变量
3. 按照 `DEPLOYMENT.md` 手动配置各组件

**优点：**
- ✅ 完全可控
- ✅ 可自定义配置
- ✅ 适合特殊需求

---

## 🔑 必需的配置项

部署前请准备以下信息：

| 配置项 | 说明 | 获取方式 |
|--------|------|----------|
| **NVIDIA API Key** | NVIDIA GPU 云服务密钥 | https://build.nvidia.com/ |
| **飞书 App ID** | 飞书开放平台应用 ID | https://open.feishu.cn/app |
| **飞书 App Secret** | 飞书开放平台应用密钥 | https://open.feishu.cn/app |
| **Gateway Token** | 网关认证令牌 | 运行 `openssl rand -hex 32` |

---

## 📋 部署前检查清单

在新服务器上部署前，确认以下内容：

### 系统环境

- [ ] 操作系统：Linux（Ubuntu 20.04+ / CentOS 8+ / Alpine 3+）
- [ ] Node.js 版本：20+（建议 24.x）
- [ ] npm 版本：10+
- [ ] 可用内存：≥ 2GB
- [ ] 可用磁盘：≥ 10GB

### 网络要求

- [ ] 能访问 NVIDIA API (https://integrate.api.nvidia.com)
- [ ] 能访问飞书 API (https://open.feishu.cn)
- [ ] 19002 端口未被占用（或修改 Gateway 端口）

### 凭证准备

- [ ] NVIDIA API Key（以 `nvapi-` 开头）
- [ ] 飞书 App ID
- [ ] 飞书 App Secret

---

## 🚀 部署后验证

部署完成后，执行以下验证：

```bash
# 1. 检查 OpenClaw 版本
openclaw --version

# 2. 查看状态
openclaw status

# 3. 检查 Gateway
openclaw gateway status

# 4. 测试模型调用
# （通过飞书或其他频道发送消息测试）

# 5. 查看日志
openclaw logs gateway --tail 50
```

---

## 🔐 安全加固

### 1. 设置开机自启

创建 systemd 服务文件：

```bash
sudo nano /etc/systemd/system/openclaw-gateway.service
```

内容：

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
EnvironmentFile=/home/your_username/openclaw.env

[Install]
WantedBy=multi-user.target
```

启动服务：

```bash
sudo systemctl daemon-reload
sudo systemctl enable openclaw-gateway
sudo systemctl start openclaw-gateway
sudo systemctl status openclaw-gateway
```

### 2. 配置防火墙

```bash
# Ubuntu/Debian
sudo ufw allow 19002/tcp
sudo ufw enable

# CentOS/RHEL
sudo firewall-cmd --permanent --add-port=19002/tcp
sudo firewall-cmd --reload
```

### 3. 配置反向代理（可选）

如果需要公网访问，建议使用 Nginx 反向代理：

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
    }
}
```

---

## 🔄 迁移数据

### 导出当前数据

在当前服务器上执行：

```bash
cd ~
tar -czf openclaw-backup.tar.gz \
  .openclaw/ \
  .openclaw-workspace/ \
  openclaw.env \
  openclaw-keyring.json
```

### 导入到新服务器

```bash
# 上传备份文件
scp openclaw-backup.tar.gz user@new-server:~

# 在新服务器上恢复
cd ~
tar -xzf openclaw-backup.tar.gz

# 检查并调整配置
nano ~/.openclaw/openclaw.json

# 重启服务
openclaw gateway restart
```

---

## 🐛 故障排除

### 问题：Gateway 无法启动

```bash
# 检查端口占用
sudo lsof -i :19002

# 查看错误日志
openclaw logs gateway --tail 100

# 检查配置文件语法
cat ~/.openclaw/openclaw.json | jq .
```

### 问题：飞书连接失败

```bash
# 检查网络连接
curl -I https://open.feishu.cn

# 查看飞书相关日志
openclaw logs gateway | grep feishu

# 验证凭证
nano ~/.openclaw/openclaw.json
# 确认 appId 和 appSecret 正确
```

### 问题：AI 响应慢或失败

```bash
# 检查 NVIDIA API 连接
curl -I https://integrate.api.nvidia.com

# 验证 API Key
curl -H "Authorization: Bearer YOUR_API_KEY" \
  https://integrate.api.nvidia.com/v1/models

# 查看会话日志
openclaw logs gateway | grep "model:"
```

---

## 📚 参考文档

- **完整部署指南:** `DEPLOYMENT.md`
- **OpenClaw 官方文档:** https://docs.openclaw.ai
- **API 文档:** https://docs.openclaw.ai/api
- **社区支持:** https://discord.com/invite/clawd

---

## ⚠️ 重要提醒

1. **安全第一**
   - 不要将包含敏感信息的配置文件提交到代码仓
   - 使用强密码和安全令牌
   - 定期更新依赖和安全补丁

2. **备份数据**
   - 定期备份 `~/.openclaw/` 目录
   - 备份工作区数据
   - 备份环境变量文件

3. **监控日志**
   - 定期查看 Gateway 日志
   - 监控资源使用情况
   - 及时处理错误和警告

---

## 📞 获取帮助

- **GitHub Issues:** https://github.com/openclaw/openclaw/issues
- **Discord 社区:** https://discord.com/invite/clawd
- **文档:** https://docs.openclaw.ai

---

**版本信息：**
- OpenClaw: 2026.3.11
- 部署包版本: 1.0
- 最后更新: 2026-03-12

---

**维护者：** OpenClaw 社区
**许可证：** MIT License
