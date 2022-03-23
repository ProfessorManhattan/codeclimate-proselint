FROM alpine:latest AS codeclimate

WORKDIR /work

COPY local/engine.json engine.json
COPY local/bin /usr/local/bin/

RUN apk add --no-cache \
    bash \
    jq \
    python3 \
    && apk --no-cache add --virtual build-deps \
    py3-pip \
    && pip3 install proselint python-frontmatter \
    && generate-checks > /checks.json \
    && VERSION=$(pip3 show proselint | grep Version | cut -d " " -f2) \
    && cat ./engine.json | jq ".version = \"$version\"" > /engine.json \
    && adduser --uid 9000 --gecos "" --disabled-password app \
    && apk del build-deps \
    && rm -rf /tmp/*

USER app

WORKDIR /code
VOLUME /code

CMD ["codeclimate-proselint"]

ARG BUILD_DATE
ARG REVISION
ARG VERSION

LABEL maintainer="Megabyte Labs <help@megabyte.space>"
LABEL org.opencontainers.image.authors="Brian Zalewski <brian@megabyte.space>"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.description="A slim Proselint standalone linter / CodeClimate engine for GitLab CI"
LABEL org.opencontainers.image.documentation="https://github.com/megabyte-labs/codeclimate-proselint/blob/master/README.md"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision=$REVISION
LABEL org.opencontainers.image.source="https://gitlab.com/megabyte-labs/docker/codeclimate/hadolint.git"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="codeclimate"

FROM alpine:latest AS proselint

USER root

RUN apk add --no-cache \
    python3 \
    && apk --no-cache add --virtual build-deps \
    py3-pip \
    && pip3 install proselint \
    && apk del build-deps

ENTRYPOINT ["proselint"]
CMD ["--version"]

ARG BUILD_DATE
ARG REVISION
ARG VERSION

LABEL maintainer="Megabyte Labs <help@megabyte.space>"
LABEL org.opencontainers.image.authors="Brian Zalewski <brian@megabyte.space>"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.description="A slim Proselint standalone linter / CodeClimate engine for GitLab CI"
LABEL org.opencontainers.image.documentation="https://github.com/megabyte-labs/codeclimate-proselint/blob/master/README.md"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision=$REVISION
LABEL org.opencontainers.image.source="https://gitlab.com/megabyte-labs/docker/codeclimate/hadolint.git"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="linter"
