FROM ruby:3.1.3

RUN echo "\
\n\
[openssl_init]\n\
ssl_conf = ssl_sect\n\
[ssl_sect]\n\
system_default = system_default_sect\n\
[system_default_sect]\n\
CipherString = DEFAULT@SECLEVEL=1" >> /etc/ssl/openssl.cnf

# RUN apt-get update && apt-get install -y redis-server

WORKDIR /app