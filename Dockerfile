FROM --platform=$BUILDPLATFORM buildpack-deps:bookworm-curl AS download
ARG TARGETARCH
ARG CLIVERSION=v3.0.182

RUN curl -L https://github.com/aliyun/aliyun-cli/releases/download/v${CLIVERSION}/aliyun-cli-linux-${CLIVERSION}-${TARGETARCH}.tgz | \
    tar -xzv -C /

FROM debian:bookworm
COPY --link --from=download /aliyun /usr/local/bin/aliyun
ENTRYPOINT ["/usr/local/bin/aliyun"]
