FROM scratch AS build
LABEL maintainer="diego.saberdl@gmail.com"
# Copie os arquivos do código-fonte para /app
COPY portfolio_simples-main/* /app/
WORKDIR /app
ENV APP_VERSION=2.0

FROM alpine:3.20.2
RUN apk update && \
    apk upgrade && \
    apk add apache2 && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /run/apache2   && \
    echo "ServerName localhost" >> /etc/apache2/conf.d/servername.conf
# Copiar os arquivos do código-fonte da etapa de build para o diretório do Apache
COPY --from=build /app /var/www/localhost/htdocs
EXPOSE 80
CMD ["httpd", "-D", "FOREGROUND"]
