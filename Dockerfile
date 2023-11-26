FROM golang:1.19-alpine
## MaJ des listes de packages et ajout via apk
RUN apk update \
    && apk add apache2 atop libcap bash jq

#RUN mkdir /app
## Changement du dir courant dans l'image
WORKDIR /src
## Ajout des modules
COPY go.mod go.sum ./
RUN go mod download

## Copie des fichiers GO
COPY *.go ./
## Compilation du binaire go
RUN CGO_ENABLED=0 GOOS=linux go build -o /hello-world

## (essai de) nettoyage
RUN rm -fR /src

RUN addgroup -S nonroot \
    && adduser -S nonroot -G nonroot
USER nonroot

CMD [ "/hello-world" ]
