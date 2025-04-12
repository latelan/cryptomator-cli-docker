# 使用 Alpine 作为基础镜像
FROM alpine:latest

# 声明构建参数
ARG RELEASE_TAG
ARG TARGETARCH

# 安装依赖并安装 OpenJDK
RUN apk add --no-cache openjdk21-jre wget unzip && \
    ARCH_SUFFIX=$(case "$TARGETARCH" in \
      "amd64") echo "linux-x64" ;; \
      "arm64") echo "linux-aarch64" ;; \
      *) echo "unsupported-arch" ;; \
    esac) && \
    # 精确拼接下载地址
    wget -O /tmp/cli.zip \
      "https://github.com/cryptomator/cli/releases/download/${RELEASE_TAG}/cryptomator-cli-${RELEASE_TAG}-${ARCH_SUFFIX}.zip" && \
    unzip /tmp/cli.zip -d /app && \
    rm /tmp/cli.zip && \
    apk del wget unzip && \
    rm -rf /var/cache/apk/*

# 设置工作目录和入口点
WORKDIR /app
ENTRYPOINT ["/app/cryptomator-cli/bin/cryptomator-cli"]
CMD ["--help"]