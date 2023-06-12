FROM alpine:3.14
RUN apk update
RUN apk add apache2
RUN apk add atop
RUN apk add libcap
RUN apk add bash
RUN apk add jq

RUN addgroup -S nonroot \
    && adduser -S nonroot -G nonroot

USER nonroot

ENTRYPOINT [ "echo" ]
CMD [ "hello world v75" ]
