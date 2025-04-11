# 使用 Eclipse Temurin 作为基础镜像
FROM eclipse-temurin:21-jre-jammy

# 构建参数
ARG BUILD_DATE
ARG VERSION

# 添加标签信息
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.authors="latelan"
LABEL org.opencontainers.image.url="https://github.com/latelan/cryptomator-cli-docker"
LABEL org.opencontainers.image.source="https://github.com/latelan/cryptomator-cli-docker"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.revision="${VERSION}"
LABEL org.opencontainers.image.vendor="latelan"
LABEL org.opencontainers.image.title="Cryptomator CLI Docker"
LABEL org.opencontainers.image.description="Docker image for Cryptomator CLI"
LABEL org.opencontainers.image.licenses="MIT"

# 设置工作目录
WORKDIR /app

# 复制 JAR 文件
COPY cryptomator-cli/target/cryptomator-cli.jar /app/

# 设置入口点
ENTRYPOINT ["java", "-jar", "cryptomator-cli.jar"]

# 设置默认命令
CMD ["--help"]
