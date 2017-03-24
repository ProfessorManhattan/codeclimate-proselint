FROM alpine:3.5

LABEL maintainer "Devon Blandin <dblandin@gmail.com>"

COPY requirements.txt ./

RUN apk add --no-cache \
    bash \
    jq \
    python \
    py2-pip && \
    pip --disable-pip-version-check \
        --no-cache-dir install \
        -r requirements.txt

WORKDIR /usr/src/app

RUN adduser -u 9000 -D app
COPY . ./
RUN chown -R app:app ./

USER app

WORKDIR /code
VOLUME /code

CMD ["/usr/src/app/bin/codeclimate-proselint"]
