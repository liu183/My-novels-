# 《穿越荒年：官府分配媳妇》- 项目模板

## 基本信息

- **穿越荒年：官府分配媳妇：** 《穿越荒年：官府分配媳妇》
- **作者：** liu183
- **创建时间：** 2026-04-09
- **类型：** [类型：都市/玄幻/悬疑/科幻等]
- **风格：** [风格：爽文/虐文/正剧等]
- **预计字数：** [预计字数]
- **当前状态：** Step 1-12 准备中

---

## 项目结构

```
[项目名称]/
├── README.md              # 项目说明
├── step1-ideation/        # Step 1: 创意生成
├── step2-synopsis/        # Step 2: 一页提要（锚点）
├── step3-characters/      # Step 3: 角色设计
├── step4-theme/           # Step 4: 主题确立
├── step5-structure/       # Step 5: 结构节拍
├── step6-scenes/          # Step 6: 场景大纲
├── step7-setpieces/       # Step 7: 关键场面
├── step8-dialogue/        # Step 8: 对白与潜台词
├── step9-symbolism/       # Step 9: 象征与暗线
├── step10-pacing/         # Step 10: 节奏与张力
├── step11-endings/        # Step 11: 结局与余韵
├── step12-rewrite/        # Step 12: 重写与迭代
└── novel/                 # 小说正文
    ├── chapter01.md
    ├── chapter02.md
    └── ...
```

---

## 创作流程

### 准备阶段（Step 1-5）
1. **Step 1: 创意生成** - 生成3-6个故事概念
2. **Step 2: 一页提要** - 确定锚点（⚠️ 关键步骤）
3. **Step 3: 角色设计** - 创建核心角色卡
4. **Step 4: 主题确立** - 明确主题和反题
5. **Step 5: 结构节拍** - 设计15节拍结构

### 细化阶段（Step 6-8）
6. **Step 6: 场景大纲** - 逐场景规划（20-30场）
7. **Step 7: 关键场面** - 设计5-8个高光场面
8. **Step 8: 对白设计** - 编写关键对白脚本

### 精炼阶段（Step 9-11）
9. **Step 9: 象征暗线** - 布置母题和副线
10. **Step 10: 节奏张力** - 设计节奏曲线
11. **Step 11: 结局设计** - 多方案结局+续作伏笔

### 迭代阶段（Step 12）
12. **Step 12: 重写迭代** - 制定重写计划

---

## 创作检查项

### 章节创作前确认
- [ ] Step 2 锚点提要已锁定
- [ ] Step 5 结构节拍图已确认
- [ ] Step 6 场景大纲已列出
- [ ] Step 8 关键对白已编写

### 版本管理
- [ ] 每完成一个 Step，commit 并标记
- [ ] 重写时创建 refactor 分支
- [ ] 合并时版本号递增（v1.0 → v1.1 → v2.0）

---

## Git 工作流

### 创建新项目分支
```bash
git checkout -b feature/[项目名]-init
```

### 提交 Step 完成记录
```bash
git add step[数字]
git commit -m "[项目名]-step[数字]: Step X 完成"
git push origin feature/[项目名]-init
```

### 创建优化分支
```bash
git checkout -b refactor/[项目名]-v[版本号]
```

---

## 技能参考

使用仓库中的技能框架来辅助创作：

- `skills/novel-writing-framework/` - 12步写作框架
- `skills/male-web-novel/` - 男频网文创作指南
- `skills/auto-novel-creator/` - 全自动创作引擎

---

## 项目进度

| 步骤 | 状态 | 备注 |
|------|------|------|
| Step 1 | ⚪ 待完成 | 创意生成 |
| Step 2 | ⚪ 待完成 | 锚点提要 |
| Step 3 | ⚪ 待完成 | 角色设计 |
| Step 4 | ⚪ 待完成 | 主题确立 |
| Step 5 | ⚪ 待完成 | 结构节拍 |
| Step 6 | ⚪ 待完成 | 场景大纲 |
| Step 7 | ⚪ 待完成 | 关键场面 |
| Step 8 | ⚪ 待完成 | 对白设计 |
| Step 9 | ⚪ 待完成 | 象征暗线 |
| Step 10 | ⚪ 待完成 | 节奏张力 |
| Step 11 | ⚪ 待完成 | 结局设计 |
| Step 12 | ⚪ 待完成 | 重写迭代 |

---

**项目模板版本**: v1.0
**最后更新**: 2026-03-13
