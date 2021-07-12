FROM quay.io/smileyfritz/ubi8:latest
COPY build/ /var/www/html/

#RUN yum update --disableplugin=subscription-manager -y && rm -rf /var/cache/yum
RUN yum install --disableplugin=subscription-manager httpd -y && rm -rf /var/cache/yum

COPY conf/httpd.conf /etc/httpd/conf/httpd.conf

RUN chgrp -R 0 /var/log/httpd /var/run/httpd /etc/httpd /var/www/html \
  && chmod -R g=u /var/log/httpd /var/run/httpd /etc/httpd /var/www/html 

EXPOSE 8080
USER 1001
CMD ["-D","FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
