FROM debian:buster

RUN apt-get update
RUN apt-get install -y nginx openssl

EXPOSE 443

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/key.pem \
        -keyout /etc/nginx/ssl/key.key \
        -subj "/C=CH/ST=Switzerland/L=Lausanne/O=42 School/OU=afavre/CN=afavre/"

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
