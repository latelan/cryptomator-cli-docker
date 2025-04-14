# 使用 Debian Bullseye Slim 作为基础镜像
FROM debian:bullseye-slim

# 设置构建参数
ARG TARGETARCH
ARG RELEASE_TAG

# 设置工作目录
WORKDIR /app

# 安装必要的依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    unzip \
    libfuse3-3 \
    fuse3 \
    libglib2.0-0 \
    procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 根据目标架构设置不同的变量
RUN case "${TARGETARCH}" in \
        "amd64") ARCH_SUFFIX="linux-x64" && NATIVE_ACCESS_PACKAGE="org.cryptomator.jfuse.linux.amd64" ;; \
        "arm64") ARCH_SUFFIX="linux-aarch64" && NATIVE_ACCESS_PACKAGE="org.cryptomator.jfuse.linux.aarch64" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac \
    && echo "Building for architecture: ${TARGETARCH}, suffix: ${ARCH_SUFFIX}, native package: ${NATIVE_ACCESS_PACKAGE}" \
    && wget -O /tmp/cryptomator-cli.zip "https://github.com/cryptomator/cli/releases/download/${RELEASE_TAG}/cryptomator-cli-${RELEASE_TAG}-${ARCH_SUFFIX}.zip" \
    && unzip /tmp/cryptomator-cli.zip -d /app \
    && rm /tmp/cryptomator-cli.zip \
    && chmod +x /app/cryptomator-cli/bin/cryptomator-cli

# # 为 ARM64 架构添加额外的库
# RUN if [ "${TARGETARCH}" = "arm64" ]; then \
#         apt-get update && apt-get install -y --no-install-recommends \
#         libc6 \
#         libgcc-s1 \
#         && apt-get clean \
#         && rm -rf /var/lib/apt/lists/*; \
#     fi

# 设置环境变量
ENV PATH="/app/cryptomator-cli/bin:${PATH}"

# 创建挂载点目录
RUN mkdir -p /mnt/vault

# 设置入口点
ENTRYPOINT ["/app/cryptomator-cli/bin/cryptomator-cli"]

# 默认命令
CMD ["--help"]
