FROM golang:1.23rc2-alpine
## MaJ des listes de packages et ajout via apk
RUN apk update \
    && apk add apache2 atop libcap bash jq \
    && apk cache clean

## Changement du dir courant dans l'image
WORKDIR /src

## Ajout des modules Go
COPY go.mod go.sum ./
RUN go mod download

## Copie des fichiers GO
COPY *.go ./
## Compilation du binaire go
RUN CGO_ENABLED=0 GOOS=linux go build -o /hello-world

## (essai de) nettoyage du code src
RUN rm -fR /src

RUN addgroup -S nonroot \
    && adduser -S nonroot -G nonroot
USER nonroot

CMD [ "/hello-world" ]
