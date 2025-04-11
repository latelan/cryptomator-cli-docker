# 使用 Eclipse Temurin 作为基础镜像
FROM eclipse-temurin:21-jre-jammy

# 设置工作目录
WORKDIR /app

# 复制下载的 cryptomator-cli.jar 文件到镜像中
COPY cryptomator-cli.jar /app/

# 设置入口点
ENTRYPOINT ["java", "-jar", "cryptomator-cli.jar"]

# 设置默认命令
CMD ["--help"]
