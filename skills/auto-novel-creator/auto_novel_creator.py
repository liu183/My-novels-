#!/usr/bin/env python3
"""
Auto Novel Creator - 自动化12步小说创作引擎
基于 Save the Cat 框架，从用户输入到完整小说的全流程自动化
"""

import json
import os
import subprocess
import sys
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Any

# 项目配置
CONFIG = {
    "default_word_count": 50000,
    "auto_commit": True,
    "branch_prefix": "auto-novel-",
    "backup_enabled": True,
    "max_retries": 3,
    "workspace": "/home/z/.openclaw/workspace",
    "output_base": "/home/z/.openclaw/workspace/novels",
    "repo_remote": "https://github.com/liu183/My-novels-.git"
}

# 12步骤定义
STEPS = [
    {"id": 1, "name": "创意生成", "key": "ideation", "requires_confirm": True},
    {"id": 2, "name": "一页提要", "key": "synopsis", "requires_confirm": True, "anchor": True},
    {"id": 3, "name": "角色设计", "key": "characters", "requires_confirm": False},
    {"id": 4, "name": "主题确立", "key": "theme", "requires_confirm": False},
    {"id": 5, "name": "结构节拍", "key": "structure", "requires_confirm": False},
    {"id": 6, "name": "场景大纲", "key": "scenes", "requires_confirm": False},
    {"id": 7, "name": "关键场面", "key": "setpieces", "requires_confirm": False},
    {"id": 8, "name": "对白创作", "key": "dialogue", "requires_confirm": False},
    {"id": 9, "name": "象征暗线", "key": "symbolism", "requires_confirm": False},
    {"id": 10, "name": "节奏控制", "key": "pacing", "requires_confirm": False},
    {"id": 11, "name": "结局设计", "key": "endings", "requires_confirm": True},
    {"id": 12, "name": "最终输出", "key": "final", "requires_confirm": False},
]


class AutoNovelCreator:
    """
    自动化小说创作引擎
    """

    def __init__(self, user_input: str, **kwargs):
        """
        初始化创作引擎

        Args:
            user_input: 用户提供的创意或参考
            **kwargs: 其他可选参数
                - genre: 类型偏好
                - style: 风格偏好
                - word_count: 目标字数
                - taboos: 禁忌元素
                - reference: 参考素材
        """
        self.user_input = user_input
        self.params = kwargs
        self.timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
        self.project_name = f"novel-{self.timestamp}"
        self.project_dir = Path(CONFIG["output_base"]) / self.project_name
        self.state = {
            "created_at": datetime.now().isoformat(),
            "steps_completed": [],
            "current_step": 0,
            "user_input": user_input,
            "params": kwargs,
            "data": {}
        }

        # 创建项目目录
        self.project_dir.mkdir(parents=True, exist_ok=True)
        (self.project_dir / "steps").mkdir(exist_ok=True)

        # 初始化代码仓
        self.init_repo()

    def init_repo(self):
        """初始化Git仓库"""
        os.chdir(self.project_dir)
        subprocess.run(["git", "init"], capture_output=True)
        subprocess.run(["git", "config", "user.email", "autonovel@openclaw.ai"], capture_output=True)
        subprocess.run(["git", "config", "user.name", "AutoNovel Creator"], capture_output=True)

    def save_state(self):
        """保存当前状态"""
        state_file = self.project_dir / "state.json"
        with open(state_file, 'w', encoding='utf-8') as f:
            json.dump(self.state, f, ensure_ascii=False, indent=2)
        print(f"💾 状态已保存: {state_file}")

    def load_state(self):
        """加载状态（用于断点续传）"""
        state_file = self.project_dir / "state.json"
        if state_file.exists():
            with open(state_file, 'r', encoding='utf-8') as f:
                self.state = json.load(f)
            print(f"📂 加载状态: {state_file}")
            return True
        return False

    def commit_step(self, step_num: int, message: str):
        """提交当前步骤到Git"""
        os.chdir(self.project_dir)
        branch_name = f"{CONFIG['branch_prefix']}{self.timestamp}"
        subprocess.run(["git", "checkout", "-B", branch_name], capture_output=True)
        subprocess.run(["git", "add", "."], capture_output=True)
        subprocess.run(["git", "commit", "-m", f"[Step {step_num}] {message}"], capture_output=True)
        print(f"✅ Step {step_num} 已提交: {message}")

    def push_to_remote(self):
        """推送到远程仓库"""
        os.chdir(self.project_dir)
        branch_name = f"{CONFIG['branch_prefix']}{self.timestamp}"
        result = subprocess.run(
            ["git", "push", "-u", CONFIG["repo_remote"], branch_name],
            capture_output=True,
            text=True
        )
        if result.returncode == 0:
            print(f"🚀 已推送到远程: {CONFIG['repo_remote']} (分支: {branch_name})")
        else:
            print(f"⚠️ 推送失败: {result.stderr}")

    def generate_step_prompt(self, step_num: int) -> str:
        """
        生成指定步骤的提示词

        Args:
            step_num: 步骤编号

        Returns:
            该步骤的系统提示词
        """
        step_key = STEPS[step_num - 1]["key"]

        prompts = {
            "ideation": f"""你现在是一个故事创意生成专家。

基于以下用户输入，生成3个200字的故事概念：

用户输入：{self.user_input}
类型偏好：{self.params.get('genre', '未指定')}
风格偏好：{self.params.get('style', '未指定')}
禁忌元素：{self.params.get('taboos', '无')}

要求：
1. 每个概念要有清晰的logline（≤50字）
2. 核心描述150-220字
3. 明确类型和核心冲突
4. 每个概念提供1-2个潜在反转点

输出格式：Markdown，每个概念用分隔线分开。
最后用一句话总结推荐哪个概念。""",

            "synopsis": f"""你现在是一个故事大纲专家。

基于选定的故事概念，扩展为一篇≤1000字的一页提要（锚点）。

选定概念：{self.state.get('data', {}).get('step1', {}).get('selected', '')}
用户偏好结局：{self.params.get('ending', '未指定')}
氛围关键词：{self.params.get('mood', '爽文、打脸、复仇')}

要求：
1. 标题和logline（≤50字）
2. 主要角色阵列（3-5人，每人一句话）
3. 故事提要600-1000字，包含：开端日常、激励事件、中段复杂化、黑暗时刻、终局抉择、余韵
4. 主题和反题（各一句）
5. 主要卖点2-3点
6. 开放问题2-3项

这是全文锚点，一旦确立不可随意更改。""",

            "characters": f"""你现在是一个角色设计专家。

基于锚点提要，设计8-12个核心角色卡。

锚点提要：{self._read_step_file(2)}

要求：
1. 每个角色卡≤180字
2. 包含：名字、故事功能、核心动机、致命软肋、角色弧光
3. 覆盖主角、反派、盟友、对手、导师、搞笑担当等原型
4. 生成角色关系网络图

输出格式：Markdown表格。""",

            "theme": f"""你现在是一个主题分析专家。

基于锚点提要，确立故事主题和象征体系。

锚点提要：{self._read_step_file(2)}

要求：
1. 主题命题（一句话）
2. 反题（相反观点）
3. 论证路径（如何通过故事证明主题）
4. 5个母题（每个母题将在故事中递进式重复3次）
5. 场景锚点（哪些场景最能体现主题）

输出格式：Markdown。""",

            "structure": f"""你现在是一个故事结构专家。

使用15节拍模板（Save the Cat），为故事设计完整结构。

锚点提要：{self._read_step_file(2)}
角色信息：{self._read_step_file(3)}
主题信息：{self._read_step_file(4)}

要求：
1. 15个节拍，每个≤40字描述
2. 三幕结构清晰
3. 标注每个节拍的爽点/反转点
4. 角色状态变化表（开始→中点→结束）
5. 伏笔分布表

输出格式：Markdown表格 + 文字说明。""",

            "scenes": f"""你现在是一个场景规划专家。

基于15节拍结构，设计详细的场景大纲。

节拍结构：{self._read_step_file(5)}
目标字数：{self.params.get('word_count', CONFIG['default_word_count'])}

要求：
1. 计算场景数量（约每万字12场）
2. 每个场景包含：场景编号、所在节拍、地点、人物、目标、冲突、转折、信息收获
3. 场景目标多样化（行动/情感/信息/关系）
4. 确保因果链完整

输出格式：Markdown表格。""",

            "setpieces": f"""你现在是一个场面设计专家。

从场景大纲中识别8-12个关键场面，进行深度设计。

场景大纲：{self._read_step_file(6)}

要求：
1. 选择最具戏剧性的场景（约15%）
2. 每个场面卡片包含：编号、对应场景、地点、人物数量、核心动作爆点、视觉冲击点、情绪目标
3. 分类：开场/高潮/反转/情感/动作

输出格式：Markdown表格。""",

            "dialogue": f"""你现在是一个对白写作专家。

从关键场面中选择5-8个，编写完整的对白脚本。

关键场面：{self._read_step_file(7)}
角色信息：{self._read_step_file(3)}

要求：
1. 每个对白场景250-350字
2. 包含潜台词和动作提示
3. 保持角色声音一致
4. 添加表演说明

输出格式：Markdown剧本格式。""",

            "symbolism": f"""你现在是一个象征设计专家。

基于主题和母题，设计象征体系和副线暗线。

主题信息：{self._read_step_file(4)}
场景大纲：{self._read_step_file(6)}

要求：
1. 5个母题的完整出现计划（3次递进式重复）
2. 3-5条副线
3. 信息释放时序表
4. 伏笔回收表

输出格式：Markdown表格。""",

            "pacing": f"""你现在是一个节奏控制专家。

分析场景大纲，设计节奏和张力曲线。

场景大纲：{self._read_step_file(6)}
节拍结构：{self._read_step_file(5)}

要求：
1. 场景节奏分类（铺垫/上升/高潮/回落/悬念）
2. 张力峰值识别（每幕2-3个）
3. 情绪波形图
4. 转场策略
5. 爽感密度评估

输出格式：Markdown + ASCII图表。""",

            "endings": f"""你现在是一个结局设计专家。

基于故事发展和主题，设计2-3个结局方案。

锚点提要：{self._read_step_file(2)}
结构信息：{self._read_step_file(5)}
主题信息：{self._read_step_file(4)}

要求：
1. A型：开放悬念（为续作留钩子）
2. B型：圆满收尾（角色成长完成）
3. C型：反转收尾（意料之外）

每个方案包含：权力终局、角色命运、世界余波、续作伏笔

输出格式：Markdown表格。""",

            "final": f"""你现在是一个小说写作专家。

基于前面11步的所有资料，撰写完整小说。

目标字数：{self.params.get('word_count', CONFIG['default_word_count'])}

要求：
1. 遍历Step 6的所有场景，逐一扩写成小说文本
2. 每个场景200-600字（根据重要性调整）
3. 嵌入Step 7的关键场面设计
4. 使用Step 8的对白（有对白的直接使用）
5. 贯穿Step 9的母题和象征
6. 控制Step 10的节奏和张力

输出格式：完整小说文本，按场景分段。
保持连贯流畅，像真正出版的小说。"""
        }

        return prompts.get(step_key, "")

    def _read_step_file(self, step_num: int) -> str:
        """读取之前步骤的输出文件"""
        step_file = self.project_dir / "steps" / f"step{step_num}.md"
        if step_file.exists():
            with open(step_file, 'r', encoding='utf-8') as f:
                return f.read()
        return ""

    def execute_step(self, step_num: int) -> bool:
        """
        执行指定步骤

        Args:
            step_num: 步骤编号

        Returns:
            执行是否成功
        """
        step_info = STEPS[step_num - 1]
        print(f"\n{'='*60}")
        print(f"📝 Step {step_num}: {step_info['name']}")
        print(f"{'='*60}\n")

        # 生成提示词
        prompt = self.generate_step_prompt(step_num)

        # 模拟子任务执行（实际使用时替换为 sessions_spawn）
        # 这里为了演示，我们使用文件模板

        step_file = self.project_dir / "steps" / f"step{step_num}.md"

        # 检查是否需要用户确认
        if step_info["requires_confirm"]:
            print("⚠️ 此步骤需要用户确认后再继续")
            # 实际使用时，这里会返回给用户等待确认
            # 现在我们模拟自动生成

        # 生成输出
        output = self._generate_mock_output(step_num, prompt)

        # 保存输出
        with open(step_file, 'w', encoding='utf-8') as f:
            f.write(output)

        print(f"✅ Step {step_num} 输出已保存")

        # 更新状态
        self.state["steps_completed"].append(step_num)
        self.state["current_step"] = step_num
        self.state["data"][f"step{step_num}"] = {
            "timestamp": datetime.now().isoformat(),
            "key": step_info["key"],
            "requires_confirm": step_info["requires_confirm"]
        }

        # 提交到Git
        if CONFIG["auto_commit"]:
            self.commit_step(step_num, step_info["name"])

        # 保存状态
        self.save_state()

        return True

    def _generate_mock_output(self, step_num: int, prompt: str) -> str:
        """
        生成模拟输出（实际使用时应替换为AI生成）

        Args:
            step_num: 步骤编号
            prompt: 提示词

        Returns:
            模拟的输出内容
        """
        # 实际使用时，这里应该调用AI模型生成内容
        # 现在返回占位符

        step_name = STEPS[step_num - 1]["name"]
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        output = f"""# Step {step_num}: {step_name}

生成时间：{timestamp}

---

**注意：这是示例输出。实际使用时，将使用AI模型生成真实内容。**

**当前提示词：**
```
{prompt[:500]}...
```

---

## 待生成的实际内容

此文件应包含该步骤的完整输出，具体格式请参考：
- `/home/z/.openclaw/workspace/temp-repo/skills/novel-writing-framework/references/step{step_num}-{STEPS[step_num-1]['key']}.md`

---

**创作者：** AutoNovel Creator
**生成时间：** {timestamp}
"""
        return output

    def run(self):
        """
        执行完整的12步创作流程
        """
        print("\n" + "="*60)
        print("🚀 Auto Novel Creator 启动")
        print("="*60 + "\n")

        print(f"📖 用户输入: {self.user_input}")
        print(f"📁 项目目录: {self.project_dir}")
        print(f"🎯 目标字数: {self.params.get('word_count', CONFIG['default_word_count']):,} 字")
        print()

        # 执行Steps 1-12
        for i in range(1, 13):
            step_info = STEPS[i - 1]

            # 如果需要确认，模拟等待用户输入
            if step_info["requires_confirm"] and i > 1:
                print(f"\n⏸️ Step {i} 需要用户确认...")
                # 实际使用时，这里会等待用户确认
                # print(f"   用户确认: 继续")
                print()

            # 执行步骤
            success = self.execute_step(i)
            if not success:
                print(f"❌ Step {i} 执行失败")
                return False

            # 如果是锚点步骤（Step 2），特别提示
            if step_info.get("anchor"):
                print(f"\n🔒 Step 2 已锁定为全文锚点\n")

        # 完成所有步骤
        self.finalize_project()

        return True

    def finalize_project(self):
        """
        完成项目，生成最终文档
        """
        print("\n" + "="*60)
        print("🎉 12步创作流程完成！")
        print("="*60 + "\n")

        # 生成README
        readme_content = self._generate_readme()
        readme_file = self.project_dir / "README.md"
        with open(readme_file, 'w', encoding='utf-8') as f:
            f.write(readme_content)

        # 生成元数据
        metadata = self._generate_metadata()
        metadata_file = self.project_dir / "metadata.json"
        with open(metadata_file, 'w', encoding='utf-8') as f:
            json.dump(metadata, f, ensure_ascii=False, indent=2)

        # 提交
        os.chdir(self.project_dir)
        subprocess.run(["git", "add", "README.md", "metadata.json"], capture_output=True)
        subprocess.run(["git", "commit", "-m", "Add project README and metadata"], capture_output=True)

        # 尝试推送到远程
        if CONFIG["repo_remote"]:
            self.push_to_remote()

        # 显示完成信息
        print("\n" + "="*60)
        print("📊 项目统计")
        print("="*60)
        print(f"完成步骤: {len(self.state['steps_completed'])}/12")
        print(f"项目目录: {self.project_dir}")
        print(f"代码仓: {CONFIG['repo_remote']}" if CONFIG["repo_remote"] else f"代码仓: 未配置")
        print()
        print("📁 查看项目文件:")
        print(f"   - README.md: 项目总览")
        print(f"   - metadata.json: 创作数据")
        print(f"   - steps/: 12步骤文档")
        print(f"   - state.json: 状态文件")
        print()

    def _generate_readme(self) -> str:
        """生成项目README"""
        return f"""# 小说项目自动生成

由 Auto Novel Creator 自动生成的小说项目。

## 项目信息

- **项目名称**: {self.project_name}
- **创建时间**: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
- **用户输入**: {self.user_input}
- **目标字数**: {self.params.get('word_count', CONFIG['default_word_count']):,} 字
- **类型**: {self.params.get('genre', '未指定')}
- **风格**: {self.params.get('style', '未指定')}

## 创作流程

本项目采用12步自动化创作框架：

| 步骤 | 名称 | 状态 |
|------|------|------|
{' | '.join([f"| {s['id']} | {s['name']} | ✅ |" for s in STEPS])}

## 文件结构

```
{self.project_name}/
├── README.md           # 本文件
├── metadata.json       # 创作元数据
├── state.json          # 项目状态（用于断点续传）
└── steps/              # 12步骤文档
''')

## 下一步

1. 查看 `steps/step12.md` 查看生成的小说
2. 根据需要进行编辑和重写
3. 提交修改到代码仓

---

由 [Auto Novel Creator](https://github.com/liu183/My-novels-) 自动生成
"""

    def _generate_metadata(self) -> Dict[str, Any]:
        """生成项目元数据"""
        return {
            "project": {
                "name": self.project_name,
                "created_at": self.state["created_at"],
                "updated_at": datetime.now().isoformat()
            },
            "input": {
                "user_input": self.user_input,
                "params": self.params
            },
            "output": {
                "target_word_count": self.params.get('word_count', CONFIG['default_word_count']),
                "steps_completed": self.state["steps_completed"],
                "branch": f"{CONFIG['branch_prefix']}{self.timestamp}"
            },
            "config": CONFIG
        }


def main():
    """主函数"""
    # 检查命令行参数
    if len(sys.argv) < 2:
        print("用法: python auto_novel_creator.py \"用户创意\" [--genre 类型] [--style 风格] [--word-count 字数]")
        print("\n示例:")
        print('  python auto_novel_creator.py "重生1980年代发家致富" --genre 年代爽文 --style 男频 --word-count 50000')
        sys.exit(1)

    # 解析参数
    user_input = sys.argv[1]
    kwargs = {
        "genre": None,
        "style": None,
        "word_count": None,
        "mood": None,
        "ending": None,
        "taboos": None
    }

    i = 2
    while i < len(sys.argv):
        arg = sys.argv[i]
        if arg == "--genre" and i + 1 < len(sys.argv):
            kwargs["genre"] = sys.argv[i + 1]
            i += 2
        elif arg == "--style" and i + 1 < len(sys.argv):
            kwargs["style"] = sys.argv[i + 1]
            i += 2
        elif arg == "--word-count" and i + 1 < len(sys.argv):
            kwargs["word_count"] = int(sys.argv[i + 1])
            i += 2
        elif arg == "--mood" and i + 1 < len(sys.argv):
            kwargs["mood"] = sys.argv[i + 1]
            i += 2
        elif arg == "--ending" and i + 1 < len(sys.argv):
            kwargs["ending"] = sys.argv[i + 1]
            i += 2
        elif arg == "--taboos" and i + 1 < len(sys.argv):
            kwargs["taboos"] = sys.argv[i + 1]
            i += 2
        else:
            i += 1

    # 创建创作引擎
    creator = AutoNovelCreator(user_input, **kwargs)

    # 执行创作流程
    try:
        success = creator.run()
        if success:
            print("\n✅ 创作完成！\n")
            sys.exit(0)
        else:
            print("\n❌ 创作失败\n")
            sys.exit(1)
    except KeyboardInterrupt:
        print("\n\n⏸️ 用户中断创作")
        creator.save_state()
        print(f"💾 状态已保存，可稍后继续")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ 错误: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
