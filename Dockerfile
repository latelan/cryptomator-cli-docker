# 使用 Eclipse Temurin 作为基础镜像
FROM eclipse-temurin:21-jre-jammy

# 声明构建参数
ARG RELEASE_TAG
ARG TARGETARCH

# 安装依赖并下载对应架构的CLI
RUN apt-get update && apt-get install -y wget unzip && \
    ARCH_SUFFIX=$(case "$TARGETARCH" in \
      "amd64") echo "linux-x64" ;; \
      "arm64") echo "linux-aarch64" ;; \
      *) echo "unsupported-arch" ;; \
    esac) && \
    wget -O /tmp/cli.zip \
      "https://github.com/cryptomator/cli/download/${RELEASE_TAG}/cryptomator-cli-${RELEASE_TAG}-${ARCH_SUFFIX}.zip" && \
    unzip /tmp/cli.zip -d /app && \
    rm /tmp/cli.zip && \
    apt-get purge -y wget unzip && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录和入口点
WORKDIR /app
ENTRYPOINT ["/app/cryptomator-cli/bin/cryptomator-cli"]
CMD ["--help"]