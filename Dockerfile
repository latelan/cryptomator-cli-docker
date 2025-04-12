# 使用 Debian Slim 作为基础镜像
FROM debian:bullseye-slim

# 声明构建参数
ARG RELEASE_TAG
ARG TARGETARCH

# 安装依赖并安装 OpenJDK
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates wget unzip && \
    ARCH_SUFFIX=$(case "$TARGETARCH" in \
      "amd64") echo "linux-x64" ;; \
      "arm64") echo "linux-aarch64" ;; \
      *) echo "unsupported-arch" ;; \
    esac) && \
    # 下载 Cryptomator-CLI
    wget -O /tmp/cli.zip \
      "https://github.com/cryptomator/cli/releases/download/${RELEASE_TAG}/cryptomator-cli-${RELEASE_TAG}-${ARCH_SUFFIX}.zip" && \
    unzip /tmp/cli.zip -d /app && \
    rm /tmp/cli.zip && \
    apt-get remove -y wget unzip && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录和入口点
WORKDIR /app
ENTRYPOINT ["/app/cryptomator-cli/bin/cryptomator-cli"]
CMD ["--help"]
