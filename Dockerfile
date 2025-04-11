# 使用 Eclipse Temurin 作为基础镜像
FROM eclipse-temurin:21-jre-jammy

# 设置工作目录
WORKDIR /app

# 复制解压后的文件到镜像中
COPY cryptomator-cli /app/

# 设置入口点
ENTRYPOINT ["/app/cryptomator-cli/cryptomator-cli/bin/cryptomator-cli"]

# 设置默认命令
CMD ["--help"]
