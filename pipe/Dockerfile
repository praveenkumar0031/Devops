FROM ubuntu:latest
RUN apt update 
RUN apt install apache2 -y
COPY index.html /var/www/html
RUN apt install systemctl -y
RUN systemctl start apache2
RUN systemctl enable apache2
ENTRYPOINT apachectl -D FOREGROUND

