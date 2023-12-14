FROM --platform=$BUILDPLATFORM buildpack-deps:bookworm-curl AS download
ARG TARGETARCH
ARG CLIVERSION=3.0.182

RUN curl -L https://github.com/aliyun/aliyun-cli/releases/download/v${CLIVERSION}/aliyun-cli-linux-${CLIVERSION}-${TARGETARCH}.tgz | \
    tar -xzv -C /

FROM debian:bookworm
RUN apt-get update && apt-get install -y \
    jq \
    && rm -rf /var/lib/apt/lists/*
COPY --link --from=download /aliyun /usr/local/bin/aliyun
ENTRYPOINT ["/usr/local/bin/aliyun"]
