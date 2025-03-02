# 使用轻量级 JDK 镜像运行应用
FROM openjdk:17-jdk-slim

# 更换 APK 源为阿里云的源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 设置时区为 Asia/Shanghai
ENV TZ=Asia/Shanghai

# 安装 tzdata

RUN apk add --no-cache curl unzip bash

RUN apk add --no-cache tzdata

# 设置工作目录
WORKDIR /app

# 将本地的打包好的 JAR 文件复制到容器中
COPY target/wxapp-backend-0.0.1-SNAPSHOT.jar /app/wxapp-backend.jar

# 暴露 Spring Boot 端口
EXPOSE 8080

# 启动 Spring Boot 应用
ENTRYPOINT ["java", "-Duser.timezone=Asia/Shanghai","-jar","wxapp-backend.jar"]
