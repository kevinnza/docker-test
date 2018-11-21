FROM nginx:alpine

# by default include a self-signed localhost certificate for use for development locally
COPY ./certs/localhost/sitecert.pem /etc/ssl/certs/sitecert.pem
COPY ./certs/localhost/sitecert.key /etc/ssl/private/sitecert.key

COPY nginx.conf /etc/nginx/nginx.conf
COPY ssl-cert.conf /etc/nginx/ssl-cert.conf

COPY init.sh /init.sh

# remove weird characters if building on Windows machine - watch out for this!
# see: https://www.liquidweb.com/kb/dos2unix-removing-hidden-windows-characters-from-files/
RUN dos2unix /init.sh

RUN chmod +x /init.sh

CMD ["/init.sh"]
