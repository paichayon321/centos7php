FROM centos:7
RUN yum -y update && yum clean all
RUN yum -y install httpd && yum clean all
RUN yum -y install gcc php-pear php-devel make openssl-devel && yum clean all
RUN yum install -y psmisc httpd postfix php php-common php-dba php-gd php-intl php-ldap php-mbstring \
	php-mysqlnd php-odbc php-pdo php-pecl-memcache php-pgsql php-pspell php-recode php-snmp \
	php-soap php-xml php-xmlrpc ImageMagick ImageMagick-devel
RUN sh -c 'printf "\n" | pecl install mongo imagick'
RUN sh -c 'echo short_open_tag=On >> /etc/php.ini'
RUN sh -c 'echo extension=mongo.so >> /etc/php.ini'
RUN sh -c 'echo extension=imagick.so >> /etc/php.ini'
ENV LOG_STDOUT **Boolean**
ENV LOG_STDERR **Boolean**
ENV LOG_LEVEL warn
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE UTC
COPY run-lap.sh /usr/sbin/
# Begin Add Code
ADD index.php /var/www/html/index.php
ADD phpinfo.php /var/www/html/phpinfo.php
RUN chmod a+rx /var/www/html/phpinfo.php
RUN chmod a+rx /var/www/html/index.php
# End Add Code
RUN chmod +x /usr/sbin/run-lap.sh
RUN chown -R apache:apache /var/www/html
VOLUME /var/www/html
VOLUME /var/log/httpd
EXPOSE 80
CMD ["/usr/sbin/run-lap.sh"]

