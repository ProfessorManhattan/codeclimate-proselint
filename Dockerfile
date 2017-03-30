FROM alpine:3.5

LABEL maintainer "Devon Blandin <dblandin@gmail.com>"

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
