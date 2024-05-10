FROM ubuntu/apache2:2.4-22.04_beta
#
RUN a2enmod ssl && \
    a2enmod headers && \
    a2enmod proxy && \
    a2enmod proxy_http && \
    a2enmod proxy_ajp && \
    a2enmod rewrite && \
    a2enmod deflate && \
    a2enmod proxy_balancer && \
    a2enmod proxy_connect && \
    a2enmod proxy_html && \
    a2dissite 000-default.conf



### Create Apache log directories (optional, adapt paths if needed)
#RUN echo "Creating Apache directories" && \
#    sleep 1 && \
#    mkdir /var/log/apache2/api && \
#    chown www-data:www-data -R /var/log/apache2/api && \
#    touch /var/log/apache2/api/api-error.log && \
#    touch /var/log/apache2/api/api-access.log && \
#    echo "Directories already created"

COPY ./start /start
COPY ./setup.sh /setup.sh

RUN chmod +x /start
RUN chmod +x /setup.sh
RUN [ "sh", "-c", "./start"]

CMD ["apachectl", "-D", "FOREGROUND"]