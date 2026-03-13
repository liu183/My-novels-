# Git 工作流与项目管理指南

> 单仓库多项目管理策略的详细说明

---

## 📊 仓库结构

```
My-novels-/
├── README.md                    # 仓库总览
├── GIT-WORKFLOW.md              # 本文件
├── create-novel.sh              # 新小说快速创建脚本 ⭐
├── skills/                      # 共享技能框架
│   ├── novel-writing-framework/
│   ├── male-web-novel/
│   └── ...
├── projects/                    # 小说项目目录（核心）
│   ├── reborn-1980-rich-village/
│   └── [新小说]/
└── templates/                   # 项目模板
    └── novel-template/
```

---

## 🌿 分支策略

### 主分支

| 分支 | 用途 | 实现方式 |
|------|------|---------|
| `main/{project-name}` | 某个小说的稳定版本 | 手动创建 |
| `origin/main` | 仓库主目录（README、skills） | 默认分支 |

### 功能分支

| 类型 | 命名规则 | 示例 | 生命周期 |
|------|---------|------|---------|
| **新项目初始化** | `feature/{project}-init` | `feature/reborn-1980-init` | 临时 |
| **功能开发** | `feature/{project}-{feature}` | `feature/reborn-1980-ch05` | 临时 |
| **技能开发** | `skills/{skill-name}` | `skills/male-web-novel` | 临时 |

### 优化分支

| 类型 | 命名规则 | 示例 | 生命周期 |
|------|---------|------|---------|
| **版本重写** | `refactor/{project}-v{X}` | `refactor/reborn-1980-v2` | 临时 |

---

## 🚀 工作流程

### 场景1：创建新小说项目

#### 方法A：使用快速脚本（推荐）

```bash
# 1. 使用脚本创建项目
./create-novel.sh reborn-1978-factory "重生一九七八工厂" "作者名"

# 2. 脚本已自动：
#    - 复制模板
#    - 创建 Git 分支
#    - 提交初始化
```

#### 方法B：手动创建

```bash
# 1. 复制模板
cp -r templates/novel-template projects/reborn-1978-factory

# 2. 编辑 projects/reborn-1978-factory/README.md
#    更新小说标题、作者、类型等信息

# 3. 创建 feature 分支
git checkout -b feature/reborn-1978-factory-init

# 4. 提交
git add projects/reborn-1978-factory/
git commit -m "Init reborn-1978-factory - 创建项目"

# 5. 推送到远程
git push origin feature/reborn-1978-factory-init
```

---

### 场景2：完成写作步骤并提交

```bash
# 每完成一个 Step，提交一次
git add projects/reborn-1978-factory/step1-ideation/
git commit -m "reborn-1978-step1: 创意生成完成"
git push origin feature/reborn-1978-factory-init

# 继续 Step 2
git add projects/reborn-1978-factory/step2-synopsis/
git commit -m "reborn-1978-step2: 锚点提要锁定"
git push origin feature/reborn-1978-factory-init

# ...
```

---

### 场景3：小说章节创作

```bash
# 每完成一章，提交一次
git add projects/reborn-1978-factory/novel/chapter01.md
git commit -m "reborn-1978-ch01: 第1章创作完成"
git push origin feature/reborn-1978-factory-init
```

---

### 场景4：版本优化（重写）

#### 创建优化分支

```bash
# 1. 切换到 refactor 分支
git checkout -b refactor/reborn-1978-factory-v2

# 2. 在项目下创建版本目录
mkdir -p projects/reborn-1978-factory/versions/v2

# 3. 复制需要优化的文件（例如：step6 场景大纲）
cp projects/reborn-1978-factory/step6-scenes/scenes.md \
   projects/reborn-1978-factory/versions/v2/

# 4. 开始优化（在 versions/v2 下工作）
#    编辑 projects/reborn-1978-factory/versions/v2/scenes.md

# 5. 提交
git add projects/reborn-1978-factory/versions/v2/
git commit -m "Refactor reborn-1978 v2 - 场景大纲优化"
git push origin refactor/reborn-1978-factory-v2
```

#### 对比不同版本

```bash
# 对比 v1 和 v2 的差异
git diff HEAD~1 projects/reborn-1978-factory/step6-scenes/scenes.md \
   projects/reborn-1978-factory/versions/v2/scenes.md

# 查看某个版本的完整内容
git show HEAD~1:projects/reborn-1978-factory/step6-scenes/scenes.md
```

---

### 场景5：合并优化后的版本

```bash
# 1. 切换回 feature 分支
git checkout feature/reborn-1978-factory-init

# 2. 合并 refactor 结果
git merge refactor/reborn-1978-factory-v2

# 3. 替换主目录文件为新版本
cp projects/reborn-1978-factory/versions/v2/scenes.md \
   projects/reborn-1978-factory/step6-scenes/

# 4. 清理版本目录（可选）
rm -rf projects/reborn-1978-factory/versions/v2

# 5. 提交
git add -A
git commit -m "Merge v2 refactor into main - 优化完成"
git push origin feature/reborn-1978-factory-init

# 6. 创建项目主干（可选）
git checkout -b main/reborn-1978-factory
git merge feature/reborn-1978-factory-init
git push origin main/reborn-1978-factory
```

---

### 场景6：在多个小说间切换

```bash
# 查看所有分支
git branch -a

# 切换到小说的分支
git checkout feature/reborn-1980-rich-village
git checkout feature/reborn-1978-factory-init

# 切换到技能开发
git checkout skills/male-web-novel
```

---

## 📝 提交信息规范

### 格式

```
[项目]-[操作]: [描述]
```

### 示例

| 项目类型 | 提交信息 | 说明 |
|---------|---------|------|
| **初始化** | `reborn-1978-init: 创建项目模板` | 新小说开始 |
| **Step完成** | `reborn-1978-step1: 创意生成完成` | 完成12步中的某一步 |
| **章节完成** | `reborn-1978-ch01: 第1章创作完成` | 完成一章小说 |
| **版本优化** | `reborn-1978-v2-refactor: 场景压缩完成` | 重写优化 |
| **技能更新** | `skills-add: 新增男频网文指南` | 技能框架更新 |
| **结构调整** | `refactor: 移动项目到projects/` | 结构调整 |

---

## 🎯 实用命令速查

### 查看项目中所有小说

```bash
ls -la projects/
```

### 查看某个小说的修改内容

```bash
git diff feature/reborn-1980 -- projects/reborn-1980-rich-village/
```

### 查看某个小说的提交历史

```bash
git log --oneline --all --grep="reborn-1980"
```

### 查看某个小说的完整历史

```bash
git log --all --projects/reborn-1980-rich-village/
```

### 查看当前的 Step 进度

```bash
ls -la projects/[项目名]/step*/
```

### 查看章节数量

```bash
ls -la projects/[项目名]/novel/*.md
```

### 切换到某个小说的工作目录

```bash
cd projects/reborn-1980-rich-village/
```

---

## 📚 版本管理

### 小说版本命名

```
{novel-name}-v{major}.{minor}
例如：
- reborn-1980-v1.0    # 初始完成版
- reborn-1980-v1.1    # 小修复（改错字、调整对白）
- reborn-1980-v2.0    # 大重写（结构调整、新章节）
```

### 创建标签

```bash
# 小说初版完成
git tag reborn-1980-v1.0

# 推送标签到远程
git push origin reborn-1980-v1.0
```

---

## ⚠️ 注意事项

### 1. 分支命名一致性

- 新小说：`feature/{project-name}-init`
- 优化分支：`refactor/{project-name}-v{X}`
- 提交信息：`{project}-{action}: {description}`

### 2. Step 2 锚点原则

- Step 2（一页提要）是全文锚点
- 任何结构变更必须先更新 Step 2
- 不要跳过 Step 2 直接开始后续步骤

### 3. 版本管理

- 小修复：直接在主分支修改
- 大重写：创建 refactor/{project}-v{X} 分支
- 合并后确保主分支与优化分支同步

### 4. 清理无用分支

```bash
# 删除本地分支
git branch -d refactor/reborn-1980-v2

# 删除远程分支
git push origin --delete refactor/reborn-1980-v2
```

---

## 🛠️ 工具脚本

### create-novel.sh

快速创建新小说项目的便捷脚本：

```bash
# 使用方法
./create-novel.sh <项目名称> [小说标题] [作者名]

# 示例
./create-novel.sh reborn-1978-factory "重生一九七八工厂" "作者名"

# 脚本功能：
# - 复制项目模板
# - 更新配置文件
# - 创建 Git 分支
# - 提交初始化
```

---

## 📅 工作流示例

### 完整的小说开发周期

```
1. ./create-novel.sh reborn-1978-factory "重生1978工厂"
2. 编辑 step1-ideation/ (创意生成)
   → git commit -m "reborn-1978-step1: 创意生成完成"
3. 编辑 step2-synopsis/ (锚点提要)
   → git commit -m "reborn-1978-step2: 锚点提要锁定"
4. 编辑 step3-12/ (角色→重写)
   → 每个 Step 提交一次
5. 开始创作 novel/chapter01.md
   → git commit -m "reborn-1978-ch01: 第1章创作完成"
6. 继续创作章节 2-12
7. 小说初版完成 → git tag reborn-1978-v1.0
8. 如需优化 → 创建 refactor 分支 → 优化 → 合并
9. 最终版完成 → 创建 main/reborn-1978 分支
10. 持续更新新章节
```

---

**版本**: v2.0
**最后更新**: 2026-03-13
