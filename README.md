# Fiction Studio 📚

> AI 辅助的小说创作工作空间，结构化框架、项目管理、实战项目三位一体。

**[English](#english) | [中文](#中文)**

---

<a name="中文"></a>
## 🇨🇳 中文

### 🌟 核心亮点

- **12步写作框架** - 从创意到重写的全流程支持，确保故事完整性和质量
- **多项目管理** - 单仓库管理多部小说，分支策略清晰，版本控制灵活
- **实战项目** - 《重生八〇，断亲后我领全镇致富》完整示范（12章、118,000字）
- **男频网文指南** - 都市、玄幻、悬疑、科幻四大题材的创作技巧集锦
- **自动化工具** - 全自动小说创作引擎、快速创建脚本、Git 工作流指南

---

## 📁 仓库结构

```
My-novels-/
├── README.md                           # 仓库总览（本文件）
├── GIT-WORKFLOW.md                     # Git 工作流完整指南 ⭐
├── MIGRATION-SUMMARY.md                # 迁移总结文档
├── create-novel.sh                     # 新小说快速创建脚本 ⭐
├── skills/                             # 共享技能框架
│   ├── novel-writing-framework/        # 12步互动式AI写作框架
│   ├── auto-novel-creator/             # 全自动小说创作引擎
│   ├── apocalypse-writing/             # 末世文创作专项指南
│   ├── ip-adaptation-guide/            # IP改编专项指南
│   ├── male-web-novel/                 # 男频网文创作指南 ⭐
│   └── README.md                       # 技能目录索引
├── projects/                           # 小说项目目录
│   ├── reborn-1980-rich-village/       # 《重生八〇，断亲后我领全镇致富》
│   │   ├── README.md                   # 项目总览
│   │   ├── step1-ideation/             # Step 1: 创意生成
│   │   ├── step2-synopsis/             # Step 2: 一页提要（锚点）⚠️
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
│   │       ├── chapter01.md ~ 12.md   # 12章完整小说
│   └── [新小说项目]/
└── templates/                          # 项目模板库
    └── novel-template/                 # 新小说启动模板
        ├── README.md
        ├── step1/ ~ step12/
        └── novel/
```

---

## 🎯 核心功能

### 1. Novel Writing Framework - 12步写作框架 ⭐

**全流程支持，从创意到重写**

```
高概念创意 → 一页提要 → 角色与关系 → 主题确立 → 结构节拍
→ 场景规划 → 场面设计 → 对白创作 → 象征暗线 → 节奏控制
→ 结局设计 → 重写迭代
```

**核心特性**：
- ⚓ **锚点机制**：Step 2（一页提要）是全文锚点，任何结构变更必须先更新此步
- 🧩 **模块化**：每个步骤可独立执行，支持并行处理
- 📊 **渐进式**：从200字创意到精细场景，信息密度逐步递增
- 🎯 **适配性强**：适合传统小说、网络小说、剧本、短剧等多种格式

**适用场景**：
- 传统小说创作
- 网络小说连载（男频/女频）
- 剧本创作（电影/剧集）
- 短剧/微电影创作
- 协作写作团队

---

### 2. 项目管理系统 ⭐

**单仓库多项目，分支策略清晰**

**分支类型**：

| 分支类型 | 命名规则 | 用途 | 生命周期 |
|---------|---------|------|---------|
| **main** | `main` | 仓库主分支，存放核心文件 | 永久 |
| **feature分支** | `feature/{project}-init` | 新小说开发 | 临时 |
| **refactor分支** | `refactor/{project}-v{X}` | 版本重写/优化 | 临时 |

**工作流程**：

详见：📖 [GIT-WORKFLOW.md](GIT-WORKFLOW.md)

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

**核心内容**：
- 四步创作框架：一句概括 → 故事支点 → 切入事件 → 大纲结构
- 四大题材详解：都市、玄幻、悬疑、科幻
- 书名与开篇：标题创作技巧、开篇要素设计
- 市场洞察：番茄小说平台要求、读者偏好

详见：`skills/README.md`

---

## 🖼️ 项目展示

### 《重生八〇，断亲后我领全镇致富》 ⭐

> **类型**：男频短剧 × 年代重生 × 断亲爽文
> **字数**：12章，118,000字
> **状态**：✅ 完成

**故事梗概**：
林建国死于1989年的贫困和背叛，父母卖掉了他的妻女。一睁眼，他回到了1980年的大年初三——正是弟弟出生那天。父亲宣布家里的工分、猎物全归弟弟。这辈子，林建国直接掀桌子："分家！现在就分家！"

他用前世的信息差，从倒卖粮票到承包鱼塘，从做服装到开小工厂。然而，村霸赵恶霸、贪官王副县长步步紧逼。林建国带领全村人打了一场"民兵仗"，把恶霸团伙打跑，收集罪证连夜送省。最终，他成了全镇带头人，但一封署名"黑凤凰"的威胁信出现...

**创作特点**：
- ✅ 12步框架完整应用，从创意到重写全流程闭环
- ✅ 系统性版本管理，每步commit，可追溯可回滚
- ✅ 商业导向设计，男频短剧风格，爽感密集
- ✅ 母题递进模型，5个母题3次出现，语义演变
- ✅ 节奏波形设计，避免平线，动态波动

**Git 提交记录**：
- Step 1-7: 8个文件，921行代码
- Step 8: +385行对白脚本
- Step 9: +327行象征设计
- Step 10: +292行节奏控制
- Step 11: +261行结局设计
- Step 12: 重写迭代计划 + 三轮优化

**位置**：`projects/reborn-1980-rich-village/`

详见：📖 [项目 README](projects/reborn-1980-rich-village/README.md)

---

## 🚀 快速开始

### 创建新小说项目

#### 方法A：使用快速脚本（推荐）

```bash
# 1. 使用脚本创建项目
./create-novel.sh reborn-1978-factory "重生一九七八工厂" "作者名"

# 2. 脚本自动完成：
#    - 复制模板
#    - 更新配置
#    - 创建 Git 分支
#    - 提交初始化
```

#### 方法B：手动创建

```bash
# 1. 复制模板
cp -r templates/novel-template projects/[新项目名]

# 2. 编辑 projects/[新项目名]/README.md
#    更新小说标题、作者、类型等信息

# 3. 创建 feature 分支
git checkout -b feature/[新项目名]-init

# 4. 写作并提交
git add projects/[新项目名]/
git commit -m "Init [新项目名] - 创建项目"
git push origin feature/[新项目名]-init
```

### 使用技能框架

#### 1. 12步写作框架

```bash
# 阅读 SKILL.md 了解框架
cat skills/novel-writing-framework/SKILL.md

# 从 step1 开始创作
# 参考 skills/novel-writing-framework/references/step*.md
```

#### 2. 男频网文指南

```bash
# 阅读男频网文创作指南
cat skills/male-web-novel/SKILL.md

# 参考各类型模板
# - references/URBAN.md (都市脑洞)
# - references/FANTASY.md (玄幻脑洞)
# - references/SUSPENSE.md (悬疑脑洞)
# - references/SCI-FI.md (科幻)
```

---

## 📝 网文创作技巧

### 场景规划

| 类型 | 场景数 | 每章场景 | 每章字数 |
|------|--------|----------|----------|
| **网文** | 25-35场 | 3-5个 | 3000-5000字 |
| **短剧** | 20-30场 | 2-3集 | 15-20分钟/集 |
| **传统小说** | 40-60场 | 1-2章 | 5000-8000字 |

### 节奏控制

- **悬念挂点**：每章结尾设置钩子
- **暗线管理**：长篇需系统管理伏笔回收
- **爽感密度**：男频网文建议4-5场一反转

### 常见类型写作要点

**都市脑洞**：
- 神豪类：致富为主线
- 直播类：直播+异能
- 文娱类：娱乐圈+金手指
- 美食/宠物/校花：特定元素展开

**玄幻脑洞**：
- 无敌签到：签到处变强
- 万倍返还：馈赠万倍返还
- 长生苟道：稳健修仙
- 宗门建设：种田经营+变强

**悬疑脑洞**：
- 惊悚游戏：死亡游戏通关
- 规则怪谈：推理规则生存
- 诡异复苏：灵气+鬼怪复苏
- 恐怖末世：崩塌世界求生

**科幻**：
- 末世：社会重塑+异能
- 黑科技：未来科技在当代
- 星际：宇宙+机甲

---

## 📊 统计数据

**仓库统计**：
- 技能数量：5 个框架
- 已完成小说：1 部
- 总字数：~118,000 字
- 步骤框架：12步完整版
- 分支数量：6+ 个功能分支
- 总文件数：81+
- 代码行数：16,732+

**《重生八〇》统计**：
- 章节数：12章
- 字数：118,000字
- 场景数：29场
- 节拍数：15个核心节拍
- 关键场面：7个
- 核心场面：3个（S5/S20/S25）
- 母题设计：5个
- 副线暗线：3条
- 角色设计：8个
- 反转设计：7个
- 结局方案：2个

---

## 🤝 贡献指南

### 提交规范

```
[项目]-[操作]: [描述]

示例：
- reborn-1980-init: 创建项目
- reborn-1980-step1: 创意生成完成
- reborn-1980-ch01: 第1章创作完成
- reborn-1980-v2-refactor: 场景压缩优化
- skills-add: 新增男频网文指南
- refactor: 多项目结构调整
```

### 项目结构规范

每个小说项目必须包含：
- ✅ README.md（项目信息）
- ✅ step1-12/ 目录（12步框架输出）
- ✅ novel/ 目录（小说正文）

---

## 📚 推荐阅读

### 项目文档
- 📖 [GIT-WORKFLOW.md](GIT-WORKFLOW.md) - Git 工作流完整指南
- 📖 [MIGRATION-SUMMARY.md](MIGRATION-SUMMARY.md) - 多项目结构迁移总结

### 技能文档
- 📖 skills/novel-writing-framework/ - 12步写作框架详解
- 📖 skills/male-web-novel/ - 男频网文创作指南
- 📖 skills/README.md - 技能目录索引

### 实战项目
- 📖 projects/reborn-1980-rich-village/README.md - 《重生八〇》项目总览

---

## ⚙️ OpenClaw 部署

仓库包含 OpenClaw 部署配置文件（可选）：
- `DEPLOYMENT.md` - 部署文档
- `DEPLOYMENT-README.md` - 部署说明
- `openclaw-deploy.sh` - 部署脚本
- `openclaw-quick-deploy.sh` - 快速部署脚本
- `openclaw.env.template` - 环境变量模板

详见：`DEPLOYMENT.md`

---

## 📄 许可证

MIT License

---

## 🔗 相关链接

- **GitHub**: https://github.com/liu183/My-novels-
- **问题反馈**: 请创建 Issue 或 Pull Request

---

**版本**: v2.0
**最后更新**: 2026-03-13
**创建者**: Fiction Studio

---

<a name="english"></a>
## 🇺🇸 English

### 🌟 Core Highlights

- **12-Step Novel Writing Framework** - Complete workflow from ideation to rewrite
- **Multi-Project Management** - Single repository for multiple novels with clear branch strategy
- **Production Projects** - "Reborn in 1980" complete demonstration (12 chapters, 118k words)
- **Male Web Novel Guide** - Urban, Fantasy, Suspense, Sci-Fi writing techniques
- **Automation Tools** - Auto-creator engine, quick creation scripts, Git workflow guide

---

## 📁 Repository Structure

```
My-novels-/
├── README.md                           # Repository overview (this file)
├── GIT-WORKFLOW.md                     # Complete Git workflow guide ⭐
├── MIGRATION-SUMMARY.md                # Migration summary
├── create-novel.sh                     # Quick novel creation script ⭐
├── skills/                             # Shared skill frameworks
│   ├── novel-writing-framework/        # 12-step AI writing framework
│   ├── auto-novel-creator/             # Full-auto novel creator engine
│   ├── apocalypse-writing/             # Apocalypse writing specialized guide
│   ├── ip-adaptation-guide/            # IP adaptation guide
│   ├── male-web-novel/                 # Male web novel guide ⭐
│   └── README.md                       # Skills directory index
├── projects/                           # Novel projects directory
│   ├── reborn-1980-rich-village/       # "Reborn in 1980" project
│   │   ├── README.md                   # Project overview
│   │   ├── step1-ideation/             # Step 1: Ideation
│   │   ├── step2-synopsis/             # Step 2: One-page summary (anchor) ⚠️
│   │   ├── step3-characters/           # Step 3: Character design
│   │   ├── step4-theme/                # Step 4: Theme establishment
│   │   ├── step5-structure/            # Step 5: Structure beats
│   │   ├── step6-scenes/               # Step 6: Scene outline
│   │   ├── step7-setpieces/            # Step 7: Key scenes
│   │   ├── step8-dialogue/             # Step 8: Dialogue & subtext
│   │   ├── step9-symbolism/            # Step 9: Symbolism & subplots
│   │   ├── step10-pacing/              # Step 10: Pacing & tension
│   │   ├── step11-endings/             # Step 11: Endings & aftermath
│   │   ├── step12-rewrite/             # Step 12: Rewrite & iteration
│   │   └── novel/                      # Novel manuscript
│   │       ├── chapter01.md ~ 12.md   # 12 complete chapters
│   └── [new novel projects]/
└── templates/                          # Project template library
    └── novel-template/                 # New novel startup template
        ├── README.md
        ├── step1/ ~ step12/
        └── novel/
```

---

## 🎯 Core Features

### 1. Novel Writing Framework - 12-Step Framework ⭐

**Complete Workflow, from Ideation to Rewrite**

```
High-concept idea → One-page summary → Characters & relationships → Theme → Structure
→ Scene planning → Setpiece design → Dialogue creation → Symbolism & subplots → Pacing
→ Ending design → Rewrite iteration
```

**Key Features**:
- ⚓ **Anchor Mechanism**: Step 2 (One-page summary) is the full story anchor, any structural changes must update this step first
- 🧩 **Modular**: Each step can be executed independently, supports parallel processing
- 📊 **Progressive**: From 200-word concept to detailed scenes, information density gradually increases
- 🎯 **Adaptable**: Suitable for traditional novels, web novels, scripts, short plays, etc.

**Use Cases**:
- Traditional novel creation
- Web novel serialization (male/female audiences)
- Script writing (movies/series)
- Short drama/micro-movie creation
- Collaborative writing teams

---

### 2. Project Management System ⭐

**Single repository multi-project, clear branch strategy**

**Branch Types**:

| Branch Type | Naming Convention | Purpose | Lifecycle |
|-------------|-------------------|---------|-----------|
| **main** | `main` | Repository main branch for core files | Permanent |
| **feature branches** | `feature/{project}-init` | New novel development | Temporary |
| **refactor branches** | `refactor/{project}-v{X}` | Version rewrite/optimization | Temporary |

**Workflow**:

See: 📖 [GIT-WORKFLOW.md](GIT-WORKFLOW.md)

---

## 📚 Skill Frameworks

### 1. novel-writing-framework (12-Step Writing Framework)
12-step interactive AI writing framework, supporting complete process from ideation to final rewrite.

### 2. auto-novel-creator (Full-Auto Novel Creator Engine)
Full-auto 12-step novel creation engine, one-click complete novel generation.

### 3. apocalypse-writing (Apocalypse Writing Specialized Guide)
Apocalypse writing specialized guide, focusing on apocalypse genre writing techniques.

### 4. ip-adaptation-guide (IP Adaptation Guide)
IP adaptation guide, focusing on adapting existing works into scripts/short dramas.

### 5. male-web-novel (Male Web Novel Guide) ⭐ NEW
Male web novel writing guide, including urban brain-holes, fantasy brain-holes, suspense brain-holes, sci-fi complete creative frameworks.

**Core Content**:
- Four-step creative framework: one-sentence summary → story pivots → entry events → outline structure
- Four major genres detailed: urban, fantasy, suspense, sci-fi
- Title & opening: title creation techniques, opening element design
- Market insight: Tomato novel platform requirements, reader preferences

See: `skills/README.md`

---

## 🖼️ Project Showcase

### 《Reborn in 1980: After Cutting Ties, I Lead the Whole Town to Prosperity》 ⭐

> **Genre**: Male short drama × Era rebirth × Cutting-ties wish fulfillment
> **Word Count**: 12 chapters, 118,000 words
> **Status**: ✅ Complete

**Story Synopsis**:
Lin Jianguo dies in poverty and betrayal in 1989. After his parents sell off his wife and daughter, he wakes up on the third day of the New Year in 1980—the very day his younger brother is born. His father announces that all the family's work points and hunted game now belong to his brother. In this life, Lin Jianguo flips the table directly: "Divide the family! Right now!"

Using information from his past life, he progresses from reselling grain coupons to contracting fish ponds, from making clothing to opening small factories. However, village tyrant Zhao Eba and corrupt official Vice County Magistrate Wang step up the pressure. Lin Jianguo leads the entire village to fight a "militia battle," driving away the thug gang, collecting evidence overnight and sending it to the provincial capital. Finally, he becomes the town's leader, but a threat letter signed "Black Phoenix" appears...

**Creative Characteristics**:
- ✅ Complete application of 12-step framework, full process loop from ideation to rewrite
- ✅ Systematic version management, commit each step, traceable and rollbackable
- ✅ Commercial-oriented design, male short drama style, dense wish fulfillment
- ✅ Motif progressive model, 5 motifs appearing 3 times, semantic evolution
- ✅ Tempo waveform design, avoid flat lines, dynamic fluctuations

**Git Commit Records**:
- Steps 1-7: 8 files, 921 lines of code
- Step 8: +385 lines dialogue scripts
- Step 9: +327 lines symbolism design
- Step 10: +292 lines tempo control
- Step 11: +261 lines ending design
- Step 12: Rewrite iteration plan + three-round optimization

**Location**: `projects/reborn-1980-rich-village/`

See: 📖 [Project README](projects/reborn-1980-rich-village/README.md)

---

## 🚀 Quick Start

### Create a New Novel Project

#### Method A: Use Quick Script (Recommended)

```bash
# 1. Use script to create project
./create-novel.sh reborn-1978-factory "Reborn 1978 Factory" "Author Name"

# 2. Script automatically completes:
#    - Copy template
#    - Update configuration
#    - Create Git branch
#    - Commit initialization
```

#### Method B: Manual Creation

```bash
# 1. Copy template
cp -r templates/novel-template projects/[new project name]

# 2. Edit projects/[new project name]/README.md
#    Update novel title, author, genre, etc.

# 3. Create feature branch
git checkout -b feature/[new project name]-init

# 4. Write and commit
git add projects/[new project name]/
git commit -m "Init [new project name] - Create project"
git push origin feature/[new project name]-init
```

### Use Skill Frameworks

#### 1. 12-Step Writing Framework

```bash
# Read SKILL.md to understand the framework
cat skills/novel-writing-framework/SKILL.md

# Start creating from step1
# Reference skills/novel-writing-framework/references/step*.md
```

#### 2. Male Web Novel Guide

```bash
# Read male web novel writing guide
cat skills/male-web-novel/SKILL.md

# Reference each genre template
# - references/URBAN.md (Urban brain-hole)
# - references/FANTASY.md (Fantasy brain-hole)
# - references/SUSPENSE.md (Suspense brain-hole)
# - references/SCI-FI.md (Sci-fi)
```

---

## 📝 Web Novel Writing Tips

### Scene Planning

| Type | Scene Count | Scenes per Chapter | Words per Chapter |
|------|------------|-------------------|-------------------|
| **Web Novel** | 25-35 scenes | 3-5 | 3000-5000 words |
| **Short Drama** | 20-30 scenes | 2-3 episodes | 15-20 minutes/episode |
| **Traditional Novel** | 40-60 scenes | 1-2 chapters | 5000-8000 words |

### Tempo Control

- **Suspense Hooks**: Set hooks at the end of each chapter
- **Foil Management**: Long-form requires systematic foreshadowing management
- **Wish Fulfillment Density**: Male web novels suggest 4-5 scenes per reversal

### Common Genre Writing Points

**Urban Brain-hole**:
- God-Tycoon: Wealth-building as main thread
- Live Streaming: Streaming + supernatural powers
- Entertainment: Entertainment industry + cheat abilities
- Food/Pets/School Beauty: Specific elements展开

**Fantasy Brain-hole**:
- Invincible Check-in: Check-in places to gain power
- 10,000x Return: Gift-giving returns 10,000x
- Immortality Hiding: Steady cultivation
- Sect Construction: Farming + getting stronger

**Suspense Brain-hole**:
- Thriller Game: Death game通关
- Rule Horror: Reason rules to survive
- Ghost Recovery: Spiritual energy + ghosts复苏
- Horror Apocalypse: Collapsing world survival

**Sci-fi**:
- Apocalypse: Social reshaping + superpowers
- Black Tech: Future tech in contemporary times
- Interstellar: Universe + mecha

---

## 📊 Statistics

**Repository Stats**:
- Skill count: 5 frameworks
- Completed novels: 1
- Total word count: ~118,000 words
- Step framework: Complete 12-step version
- Branch count: 6+ feature branches
- Total files: 81+
- Code lines: 16,732+

**"Reborn in 1980" Stats**:
- Chapter count: 12 chapters
- Word count: 118,000 words
- Scene count: 29 scenes
- Beat count: 15 core beats
- Key scenes: 7
- Core scenes: 3 (S5/S20/S25)
- Motif design: 5 motifs
- Subplot foils: 3
- Character design: 8 characters
- Reversal design: 7 reversals
- Ending plans: 2 plans

---

## 🤝 Contribution Guidelines

### Commit Convention

```
[Project]-[Action]: [Description]

Examples:
- reborn-1980-init: Create project
- reborn-1980-step1: Ideation complete
- reborn-1980-ch01: Chapter 1 writing complete
- reborn-1980-v2-refactor: Scene compression optimization
- skills-add: Add male web novel guide
- refactor: Multi-project structure adjustment
```

### Project Structure Standard

Each novel project must include:
- ✅ README.md (Project information)
- ✅ step1-12/ directories (12-step framework output)
- ✅ novel/ directory (Novel manuscript)

---

## 📚 Recommended Reading

### Project Documentation
- 📖 [GIT-WORKFLOW.md](GIT-WORKFLOW.md) - Complete Git workflow guide
- 📖 [MIGRATION-SUMMARY.md](MIGRATION-SUMMARY.md) - Multi-project structure migration summary

### Skill Documentation
- 📖 skills/novel-writing-framework/ - 12-step writing framework详解
- 📖 skills/male-web-novel/ - Male web novel writing guide
- 📖 skills/README.md - Skills directory index

### Production Projects
- 📖 projects/reborn-1980-rich-village/README.md - "Reborn in 1980" project overview

---

## ⚙️ OpenClaw Deployment

Repository contains OpenClaw deployment configuration files (optional):
- `DEPLOYMENT.md` - Deployment documentation
- `DEPLOYMENT-README.md` - Deployment instructions
- `openclaw-deploy.sh` - Deployment script
- `openclaw-quick-deploy.sh` - Quick deployment script
- `openclaw.env.template` - Environment variable template

See: `DEPLOYMENT.md`

---

## 📄 License

MIT License

---

## 🔗 Related Links

- **GitHub**: https://github.com/liu183/My-novels-
- **Feedback**: Please create Issue or Pull Request

---

**Version**: v2.0
**Last Updated**: 2026-03-13
**Creator**: Fiction Studio

---
