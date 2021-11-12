FROM python:alpine

MAINTAINER rsmnarts <rismanalkarim@gmail.com>

RUN apk add --no-cache postgresql-libs

RUN apk add --no-cache --virtual .build-deps \
        gcc \
        linux-headers \
        postgresql-dev\
        musl-dev \
    && pip3 install pg_activity psycopg2-binary \
    && apk del .build-deps

ENTRYPOINT ["pg_activity"]

