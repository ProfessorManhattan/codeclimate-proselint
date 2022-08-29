FROM alpine:latest AS codeclimate

WORKDIR /work

COPY local/engine.json engine.json
COPY local/bin /usr/local/bin/

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache \
  bash=~5 \
  jq=~1 \
  python3=~3 \
  && apk --no-cache add --virtual build-deps \
  py3-pip=~20 \
  && pip3 install --no-cache-dir \
  proselint==0.13.0 \
  python-frontmatter==1.0.0 \
  && ln -sf "$(which python3)" /usr/bin/python \
  && generate-checks > /checks.json \
  && VERSION=$(pip3 show proselint | grep Version | cut -d " " -f2) \
  && cat ./engine.json | jq ".version = \"$VERSION\"" > /engine.json \
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
LABEL org.opencontainers.image.source="https://github.com/megabyte-labs/codeclimate-proselint.git"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="codeclimate"

FROM alpine:latest AS proselint

# hadolint ignore=DL3002
USER root

WORKDIR /work

RUN apk add --no-cache \
  python3=~3 \
  && apk --no-cache add --virtual build-deps \
  py3-pip=~20 \
  && pip3 install --no-cache-dir \
  proselint==0.13.0 \
  && apk del build-deps \
  && rm -rf /tmp/*

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
LABEL org.opencontainers.image.source="https://github.com/megabyte-labs/codeclimate-proselint.git"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="linter"
