FROM alpine:3.5


WORKDIR /usr/src/app

COPY engine.json requirements.txt ./

RUN apk add --no-cache \
    bash \
    jq \
    python \
    py2-pip && \
    pip --disable-pip-version-check \
        --no-cache-dir install \
        -r requirements.txt

COPY bin/ ./bin/

RUN bin/generate-checks > /checks.json && \
    version=$(pip show proselint | grep Version | cut -d " " -f2) && \
    cat ./engine.json | jq ".version = \"$version\"" > /tmp/engine.json && \
    mv /tmp/engine.json /engine.json

RUN adduser -u 9000 -D app
COPY . ./
RUN chown -R app:app ./

USER app

WORKDIR /code
VOLUME /code

CMD ["/usr/src/app/bin/codeclimate-proselint"]


ARG BUILD_DATE
ARG REVISION
ARG VERSION

LABEL maintainer="Megabyte Labs <help@megabyte.space>"
LABEL org.opencontainers.image.authors="Brian Zalewski <brian@megabyte.space>"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.description="Code Climate engine for Proselint"
LABEL org.opencontainers.image.documentation="https://gitlab.com/megabyte-labs/docker/codeclimate/proselint/-/blob/master/README.md"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision=$REVISION
LABEL org.opencontainers.image.source="https://gitlab.com/megabyte-labs/docker/codeclimate/proselint.git"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="code-climate"