# Auto Novel Creator - 自动化小说创作技能

## 概述

这是一个基于12步 Save the Cat 框架的全自动小说创作引擎。只需要提供一个创意或参考，系统会自动生成完整的小说。

**核心特性：**

- 🚀 全流程自动化 - 从创意到小说，一键生成
- 🤖 智能决策 - 基于故事学原理自动创作
- 📍 关键确认 - 只在必要时（概念选择、锚点确认、结局选择）打断
- 📊 结构化输出 - 每步都有明确格式
- 💾 版本管理 - 自动Git提交，可追溯
- 🔄 断点续传 - 保存状态，随时继续

---

## 快速开始

### 基础用法

在OpenClaw中，直接激活这个技能并提供创意：

```
我想要一个关于重生的1980年代发家致富的故事
```

系统将自动：
1. 生成3个故事概念供选择
2. 确认概念后，自动生成12个步骤文档
3. 最后生成完整小说
4. 提交到代码仓

### 进阶参数

```
请帮我写小说：
- 核心创意：程序员穿越到唐朝，用代码思维解决难题
- 类型：穿越/历史/轻松
- 风格：幽默/爽文
- 目标字数：5万字
- 避免元素：毒女、后宫、悲剧
```

---

## 工作流程

### 12步骤概览

| 步骤 | 阶段 | 用户确认 | 说明 |
|------|------|----------|------|
| 1 | 创意生成 | ✅ | 生成3-6个故事概念（200字/个） |
| 2 | 一页提要 | ✅ | 扩展为≤1000字锚点提要 |
| 3 | 角色设计 | ❌ | 8-12个角色卡 + 关系网 |
| 4 | 主题确立 | ❌ | 主题 + 反题 + 5个母题 |
| 5 | 结构节拍 | ❌ | 15节拍完整结构 |
| 6 | 场景大纲 | ❌ | 30-150个场景（按字数计算） |
| 7 | 关键场面 | ❌ | 8-12个关键场面设计 |
| 8 | 对白创作 | ❌ | 5-8个核心场面完整对白 |
| 9 | 象征暗线 | ❌ | 母题递进 + 副线布置 |
| 10 | 节奏控制 | ❌ | 张力曲线 + 转场策略 |
| 11 | 结局设计 | ✅ | 2-3个结局方案 |
| 12 | 最终输出 | ❌ | 完整小说（3-30万字） |

### 用户交互点

系统仅在3个节点需要用户确认：

**1. Step 1: 概念选择**
- 展示3-6个故事概念
- 用户选择一个或要求修改

**2. Step 2: 锚点确认**
- 展示一页提要
- 用户确认锁定（成为全文锚点）

**3. Step 11: 结局选择**
- 提供A/B/C三种结局方案
- 用户选择一个或要求融合

---

## 项目输出

### 目录结构

```
novel-20260312-153045/
├── README.md           # 项目总览
├── metadata.json       # 创作元数据
├── state.json          # 状态文件（断点续传）
└── steps/              # 12步骤文档
    ├── step1.md        # 创意生成
    ├── step2.md        # 一页提要（锚点）
    ├── step3.md        # 角色设计
    ├── step4.md        # 主题确立
    ├── step5.md        # 结构节拍
    ├── step6.md        # 场景大纲
    ├── step7.md        # 关键场面
    ├── step8.md        # 对白创作
    ├── step9.md        # 象征暗线
    ├── step10.md       # 节奏控制
    ├── step11.md       # 结局设计
    └── step12.md       # 完整小说
```

### 代码仓集成

- **自动提交**: 每完成一步自动Git commit
- **分支策略**: `auto-novel-YYYYMMDD-HHMMSS`
- **推送**: 自动推送到配置的远程仓库
- **回滚**: 随时可以回滚到任意步骤

---

## 配置选项

### 全局配置

在 `auto_novel_creator.py` 中修改 `CONFIG` 变量：

```python
CONFIG = {
    "default_word_count": 50000,  # 默认字数
    "auto_commit": True,          # 自动提交
    "branch_prefix": "auto-novel-",  # 分支前缀
    "backup_enabled": True,       # 启用备份
    "max_retries": 3,             # 最大重试次数
    "repo_remote": "https://github.com/.../My-novels-.git"  # 远程仓库
}
```

### 步骤配置

每个步骤都有独立的参数配置，在代码中的 `prompt` 生成函数里可以调整。

---

## 命令行使用

也可以直接通过 Python 脚本运行：

```bash
cd /home/z/.openclaw/workspace/skills/auto-novel-creator

# 基础用法
python auto_novel_creator.py "重生1980年代发家致富"

# 带参数
python auto_novel_creator.py "重生1980年代发家致富" \
  --genre 年代爽文 \
  --style 男频 \
  --word-count 50000 \
  --mood 爽快、打脸、复仇 \
  --ending 开放悬念
```

---

## 技术实现

### 架构设计

```
AutoNovelCreator (主任务)
    ├── init_repo()          # 初始化Git
    ├── execute_step(1-12)   # 执行12步骤
    │   ├── generate_prompt() # 生成提示词
    │   ├── call_ai()        # 调用AI生成（实际使用）
    │   ├── save_output()    # 保存输出
    │   └── commit_step()    # Git提交
    ├── finalize_project()   # 完成项目
    └── push_to_remote()     # 推送远程
```

### 在OpenClaw中的使用

实际在OpenClaw中运行时，会使用 `sessions_spawn` 为每个步骤创建子任务：

```python
# 执行Step 1
step1_task = sessions_spawn(
    task=prompt_step1,
    label="auto-novel-step1",
    runtime="subagent",
    timeoutSeconds=300
)

# 获取输出
output = step1_task.result

# 用户确认
if user_confirms(output):
    # 继续 Step 2
    ...
```

---

## 示例输出

### Step 1 输出示例

```markdown
# Step 1: 创意生成

生成3个故事概念：

---

## 概念 1

**标题：** 《重生1980：断亲致富》
**logline：** 重生回1980，断亲反击，利用信息差发财。

**核心概念：**
林建国死于贫困和背叛，重生回1980年大年初三...
（200字）

**类型：** 年代重生/男频爽文
**核心冲突：** 主角 vs 原生家庭
**潜在反转：** 父母背后有更大的仇家

---

[概念2、3略...]

---
**推荐：概念1**
```

### Step 2 输出示例（锚点）

```markdown
# Step 2: 一页提要（锚点）

## 标题与logline
**标题：** 《重生1980：断亲致富》
**logline：** 重生回1980，断亲反击，利用信息差发财。

## 主要角色阵列
- **林建国**: 主角，从烂泥人生逆袭成带头大哥
- **林福贵**: 父亲，势利眼的偏心爹
...

## 故事提要（800字）
**开端日常**：林建国死在1989年，重生回1980大年初三...
**激励事件**：父亲宣布压榨他，他掀桌子分家...
...

## 主题与反题
**主题：** 只有断绝原生家庭吸血，才能翻身致富
**反题：** 割裂亲情会失去更重要的东西

---

🔒 **已锁定为全文锚点**
```

### Step 12 输出示例（最终小说）

```markdown
# 《重生1980：断亲致富》

## 第一章：死亡与重生

林建国死在1989年的病床上，喉咙里火烧火燎。

父母站在床边，分遗产给他一碗白米饭。"建国，你就吃这个吧。"

他恨，恨咽不下最后一口气。

...

（完整的小说，5万字）
```

---

## 断点续传

如果创作过程中被中断：

```bash
# 重新运行，系统会自动加载state.json
python auto_novel_creator.py "继续上次的项目"
```

或直接删除 `state.json` 重新开始。

---

## 高级功能

### 批量创作

一次启动多个小说项目：

```python
ideas = ["重生1980", "穿越唐朝", "未来世界"]
for idea in ideas:
    creator = AutoNovelCreator(idea)
    creator.run()
```

### 风格迁移

将完成的故事转换风格：

```python
# 重新生成Steps 8-12，改变风格
new_params["style"] = "幽默"
creator.generate_novel_with_new_params(new_params)
```

---

## 故障排除

### 常见问题

**Q: Step 2 锚点不满意怎么办？**
A: 直接删除 `steps/step2.md`，重新运行，系统会重新生成。

**Q: 想修改某个步骤？**
A: 编辑对应的 `stepN.md`，然后手动 `git commit`。

**Q: 推送到远程失败？**
A: 检查远程仓库权限和网络连接，或手动执行 `git push`。

---

## 参考资源

- Save the Cat 框架: https://savethecat.com/
- 故事节拍模板: 参考 `reborn-1980-rich-village` 项目
- OpenClaw 技能开发: https://docs.openclaw.ai

---

## 版本历史

- **v1.0** (2026-03-12)
  - 初始版本
  - 12步自动化框架
  - Git集成
  - 代码仓推送

---

## 作者

AutoNovel Creator
基于 `novel-writing-framework` 框架的自动化实现

## 许可

MIT License
