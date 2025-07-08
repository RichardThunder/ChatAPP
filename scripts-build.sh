#!/bin/bash

echo "=== 详细调试构建脚本 ==="

# 清理环境
echo "🧹 清理环境..."
docker-compose down -v
docker system prune -af --volumes

# 设置构建参数以显示详细输出
export BUILDKIT_PROGRESS=plain
export DOCKER_BUILDKIT=1

# 检查文件系统
echo "📁 检查项目文件结构..."
echo "项目根目录:"
ls -la
echo ""
echo "后端目录:"
ls -la backend/
echo ""
echo "前端目录:"
ls -la frontend/

# 构建后端镜像并显示详细日志
echo "🐳 构建后端镜像（详细模式）..."
docker build --no-cache --progress=plain -t chatapp-backend-debug ./backend 2>&1 | tee backend-build.log

echo ""
echo "📊 后端构建日志已保存到 backend-build.log"

# 检查后端镜像
if docker images | grep -q chatapp-backend-debug; then
    echo "✅ 后端镜像构建成功"

    # 运行容器并检查内部文件
    echo "🔍 检查后端容器内部文件..."
    docker run --rm chatapp-backend-debug sh -c "
        echo '=== 容器内部检查 ===';
        echo '当前用户: \$(whoami)';
        echo '工作目录: \$(pwd)';
        echo '/app 目录内容:';
        ls -la /app/;
        echo '';
        echo '文件权限详细信息:';
        ls -la /app/app.jar 2>/dev/null || echo 'app.jar 不存在';
        echo '';
        echo '测试 Java 命令:';
        java -version;
        echo '';
        echo '测试 JAR 文件:';
        if [ -f /app/app.jar ]; then
            echo 'JAR 文件大小: \$(du -h /app/app.jar)';
            echo 'JAR 文件类型: \$(file /app/app.jar)';
        else
            echo 'JAR 文件不存在';
        fi
    "
else
    echo "❌ 后端镜像构建失败"
    echo "检查构建日志: backend-build.log"
fi

# 构建前端镜像并显示详细日志
echo ""
echo "🐳 构建前端镜像（详细模式）..."
docker build --no-cache --progress=plain -t chatapp-frontend-debug ./frontend 2>&1 | tee frontend-build.log

echo ""
echo "📊 前端构建日志已保存到 frontend-build.log"

# 检查前端镜像
if docker images | grep -q chatapp-frontend-debug; then
    echo "✅ 前端镜像构建成功"

    # 运行容器并检查内部文件
    echo "🔍 检查前端容器内部文件..."
    docker run --rm chatapp-frontend-debug sh -c "
        echo '=== 容器内部检查 ===';
        echo '当前用户: \$(whoami)';
        echo 'Nginx 配置:';
        cat /etc/nginx/conf.d/default.conf;
        echo '';
        echo '网站目录内容:';
        ls -la /usr/share/nginx/html/;
        echo '';
        echo '主要文件检查:';
        test -f /usr/share/nginx/html/index.html && echo '✅ index.html 存在' || echo '❌ index.html 不存在';
        echo '';
        echo 'Nginx 配置测试:';
        nginx -t;
    "
else
    echo "❌ 前端镜像构建失败"
    echo "检查构建日志: frontend-build.log"
fi

# 显示镜像信息
echo ""
echo "📋 构建的镜像信息:"
docker images | grep chatapp

echo ""
echo "=== 调试构建完成 ==="
echo "📄 检查构建日志:"
echo "   - 后端: backend-build.log"
echo "   - 前端: frontend-build.log"