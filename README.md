# Fiction Studio - 小说创作工作空间

> 结构化小说创作工作空间，包含12步写作框架、多项目管理技能和实战小说项目。

---

## 📁 项目结构

```
My-novels-/
├── README.md                           # 仓库总览（本文件）
├── skills/                             # 共享技能框架
│   ├── novel-writing-framework/        # 12步互动式AI写作框架
│   ├── auto-novel-creator/             # 全自动小说创作引擎
│   ├── apocalypse-writing/             # 末世文创作专项指南
│   ├── ip-adaptation-guide/            # IP改编专项指南
│   ├── male-web-novel/                 # 男频网文创作指南 ⭐
│   └── README.md                       # 技能目录索引
├── projects/                           # 小说项目目录
│   ├── reborn-1980-rich-village/       # 《重生八〇，断亲后我领全镇致富》
│   │   ├── step1-ideation/             # Step 1: 创意生成
│   │   ├── step2-synopsis/             # Step 2: 一页提要（锚点）
│   │   ├── step3-characters/           # Step 3: 角色设计
│   │   ├── step4-theme/                # Step 4: 主题确立
│   │   ├── step5-structure/            # Step 5: 结构节拍
│   │   ├── step6-scenes/               # Step 6: 场景大纲
│   │   ├── step7-setpieces/            # Step 7: 关键场面
│   │   ├── step8-dialogue/             # Step 8: 对白与潜台词
│   │   ├── step9-symbolism/            # Step 9: 象征与暗线
│   │   ├── step10-pacing/              # Step 10: 节奏与张力
│   │   ├── step11-endings/             # Step 11: 结局与余韵
│   │   ├── step12-rewrite/             # Step 12: 重写与迭代
│   │   └── novel/                      # 小说正文
│   │       ├── chapter01.md
│   │       ├── chapter02.md
│   │       └── ...
│   ├── [新小说项目]/
│   └── ...
├── templates/                          # 项目模板库
│   └── novel-template/                 # 新小说启动模板
│       ├── README.md
│       ├── step1/
│       ├── step2/
│       ├── ...
│       └── novel/
└── DEPLOYMENT.md                       # OpenClaw 部署配置（可选）
```

---

## 🎯 核心功能

### Novel Writing Framework - 12步写作框架

从创意生成到重写迭代的全流程支持：

**输出流程：**
```
高概念创意 → 一页提要 → 角色与关系 → 主题确立 → 结构节拍
→ 场景规划 → 场面设计 → 对白创作 → 象征暗线 → 节奏控制
→ 结局设计 → 重写迭代
```

**设计特点：**
- **锚点机制**：Step 2（一页提要）是项目锚点，任何变更需先更新此步
- **模块化**：每个步骤可独立执行，支持并行处理
- **渐进式**：从200字创意到精细场景，信息密度逐步递增

详见：`skills/novel-writing-framework/`

---

## 📚 技能框架

### 1. novel-writing-framework (12步写作框架)
12步互动式AI写作框架，支持从创意生成到最终重写的全流程。

### 2. auto-novel-creator (全自动小说创作引擎)
全自动12步小说创作引擎，一键生成完整小说。

### 3. apocalypse-writing (末世文创作专项指南)
末世文创作专项指南，专注于末世题材的创作技巧。

### 4. ip-adaptation-guide (IP改编专项指南)
IP改编专项指南，专注于将现有作品改编剧本/短剧。

### 5. male-web-novel (男频网文创作指南) ⭐ NEW
男频网文创作指南，包含都市脑洞、玄幻脑洞、悬疑脑洞、科幻题材的完整创作框架。

详见：`skills/README.md`

---

## 🏗️ 项目管理策略

### 分支策略

| 分支类型 | 命名规则 | 用途 | 生命周期 |
|---------|---------|------|---------|
| **项目主干** | `main/{project-name}` | 某个小说的稳定版本 | 永久 |
| **feature分支** | `feature/{project-name}-{action}` | 新项目初始化、功能开发 | 临时 |
| **refactor分支** | `refactor/{project-name}-v{X}` | 版本重写和大优化 | 临时 |
| **技能分支** | `skills/{skill-name}` | 技能框架开发和更新 | 临时 |

### 工作流程

#### 创建新小说
```bash
# 1. 复制模板
cp -r templates/novel-template projects/[新项目名]

# 2. 创建 feature 分支
git checkout -b feature/[新项目名]-init

# 3. 写作并提交
git add projects/[新项目名]/
git commit -m "Init [项目名] - Step 1-7"
git push origin feature/[新项目名]-init
```

#### 版本优化
```bash
# 1. 创建 refactor 分支
git checkout -b refactor/[项目名]-v[版本号]

# 2. 在项目下创建 versions/v[X] 目录
mkdir -p projects/[项目名]/versions/v[X]

# 3. 基于新版本目录工作，提交
git add projects/[项目名]/versions/v[X]/
git commit -m "Refactor [项目名] v[X] - [描述]"
git push origin refactor/[项目名]-v[X]
```

#### 合并优化
```bash
# 1. 切换到项目主干
git checkout main/[项目名]

# 2. 合并 refactor 结果
git merge refactor/[项目名]-v[X]

# 3. 替换主目录为新版本
cp -r projects/[项目名]/versions/v[X]/* projects/[项目名]/

# 4. 提交并推送
git add -u
git commit -m "Merge v[X] into main"
git push origin main/[项目名]
```

---

## 📖 项目列表

### 《重生八〇，断亲后我领全镇致富》
- **状态**: ✅ 完成（12章，118,000字）
- **类型**: 男频短剧 × 年代重生 × 断亲爽文
- **分支**: `feature/reborn-1980-rich-village`
- **目录**: `projects/reborn-1980-rich-village/`

详见：`projects/reborn-1980-rich-village/README.md`

### 新小说项目
*待创建*

---

## 🚀 快速开始

### 使用模板创建新小说

```bash
# 1. 复制模板
cp -r templates/novel-template projects/[新项目名]

# 2. 编辑 project/[新项目名]/README.md
#    更新小说标题、作者、类型等信息

# 3. 开始创作：从 step1 创意生成开始
```

### 使用技能框架

1. **12步写作框架**：
   - 阅读 `skills/novel-writing-framework/SKILL.md`
   - 从 `step1-ideation.md` 开始执行

2. **男频网文指南**：
   - 阅读 `skills/male-web-novel/SKILL.md`
   - 参考都市、玄幻、悬疑、科幻各类型模板

3. **全自动创作**：
   - 使用 `skills/auto-novel-creator` 一键生成完整小说

---

## 📊 统计数据

- **技能数量**: 5 个框架
- **已完成小说**: 1 部
- **总字数**: ~118,000 字
- **步骤框架**: 12步写作框架完整版
- **分支数量**: 6+ 个功能分支

---

## 🤝 贡献指南

### 提交规范

```
[项目]-[操作]: [描述]
例如：
- reborn-1980-init: Step 1-7 完成
- reborn-1980-ch01: 第1章创作完成
- reborn-1980-v2-refactor: 场景压缩优化
- skills-add: 新增男频网文指南
```

### 项目结构规范

每个小说项目必须包含：
- ✅ README.md（项目信息）
- ✅ step1-12/ 目录（12步框架输出）
- ✅ novel/ 目录（小说正文）

---

## 📝 网文创作提示

- **场景密度**：网文（25-35场）vs 电影（40-60场）
- **章节规划**：每章3-5个场景，每章3000-5000字
- **悬念挂点**：每章结尾设置钩子
- **暗线管理**：长篇需系统管理伏笔回收

---

## ⚙️ 部署配置（可选）

仓库包含 OpenClaw 部署配置文件：
- `DEPLOYMENT.md` - 部署文档
- `openclaw-deploy.sh` - 部署脚本
- `openclaw.env.template` - 环境变量模板

详见：`DEPLOYMENT.md`

---

## 📄 许可证

MIT License

---

**版本**: v2.0 (多项目管理结构)
**最后更新**: 2026-03-13
**仓库**: https://github.com/liu183/My-novels-.git
