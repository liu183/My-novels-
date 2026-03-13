#!/bin/bash
# create-novel.sh - 快速创建新小说项目

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查参数
if [ $# -eq 0 ]; then
    echo -e "${RED}错误：缺少小说项目名称${NC}"
    echo "用法: ./create-novel.sh <项目名称> [小说标题] [作者名]"
    echo ""
    echo "示例:"
    echo "  ./create-novel.sh reborn-1978-factory \"重生一九七八工厂\" \"作者名\""
    exit 1
fi

PROJECT_NAME=$1
NOVEL_TITLE=${2:-"$PROJECT_NAME"}
AUTHOR_NAME=${3:-"作者"}

echo -e "${GREEN}🚀 创建新小说项目：${PROJECT_NAME}${NC}"
echo ""

# 检查目录是否已存在
if [ -d "projects/$PROJECT_NAME" ]; then
    echo -e "${RED}错误：projects/$PROJECT_NAME 已存在${NC}"
    exit 1
fi

# 复制模板
echo -e "📋 复制项目模板..."
cp -r templates/novel-template projects/$PROJECT_NAME

# 更新 README.md 中的占位符
echo -e "✏️  更新项目配置..."
sed -i "s/小说标题/$NOVEL_TITLE/g" projects/$PROJECT_NAME/README.md
sed -i "s/小说标题/$NOVEL_TITLE/g" projects/$PROJECT_NAME/step2/README.md
sed -i "s/\[作者名\]/$AUTHOR_NAME/g" projects/$PROJECT_NAME/README.md
sed -i "s/\[日期\]/$(date +%Y-%m-%d)/g" projects/$PROJECT_NAME/README.md

# 创建初始概念文件（可选）
echo -e "📝 创建初始文件..."

# 显示项目结构
echo ""
echo -e "${GREEN}✅ 项目创建成功！${NC}"
echo ""
echo -e "项目位置: ${YELLOW}projects/$PROJECT_NAME${NC}"
echo ""
echo -e "下一步:"
echo -e "  1. 编辑 projects/$PROJECT_NAME/README.md 完善项目信息"
echo -e "  2. 开始创作：从 step1 创意生成开始"
echo -e "  3. 创建 Git 分支: git checkout -b feature/$PROJECT_NAME-init"
echo -e "  4. 提交项目: git add projects/$PROJECT_NAME && git commit -m 'Init $PROJECT_NAME - 创建项目'"
echo ""

# 可选：立即创建分支
read -p "是否立即创建 Git 分支？(y/n): " create_branch
if [ "$create_branch" = "y" ]; then
    git checkout -b feature/$PROJECT_NAME-init
    git add projects/$PROJECT_NAME
    git commit -m "Init $PROJECT_NAME - 创建项目模板"
    echo -e "${GREEN}✅ Git 分支已创建并提交${NC}"
else
    echo -e "提醒：记得稍后创建分支并提交项目"
fi

echo ""
echo -e "${GREEN}🎉 准备就绪，开始创作吧！${NC}"
