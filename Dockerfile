FROM ubuntu:20.04

LABEL maintainer="Yavuzlar Web Security Team <iletisim@siberyavuzlar.com>" \
      description="Web Vulnerability Lab by Yavuzlar." \
      license="Mozilla Public License Version 2.0" \
      usage="docker run -d -p [HOST PORT NUMBER]:80 yavuzlar/vulnlab" \
      version="1.0"

ENV TZ=Asia/Turkey
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && \
    apt install -y tzdata zip unzip \
                   php php-cgi php-cli php-common php-curl php-dev php-json php-mbstring php-mysql php-odbc php-phpdbg php-sqlite3 \
                   apache2 libapache2-mod-php \
                   mariadb-common mariadb-server mariadb-client \
                   dos2unix \
                   netcat-traditional \
                   iputils-ping \
                   wget \
                   net-tools && \
    rm -rf /var/www/html/index.html

COPY ./app/ /var/www/html
COPY run.sh /usr/sbin/

RUN a2enmod rewrite && \
    chmod +x /usr/sbin/run.sh && \
    chown -R www-data:www-data /var/www/html && \
    dos2unix /usr/sbin/run.sh

EXPOSE 80

CMD ["/usr/sbin/run.sh"]
