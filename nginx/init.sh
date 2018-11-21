#!/bin/sh -e
if [[ "${SETUP_LETS_ENCRYPT_YN}" == "Y" ]]
then

    apk add py-urllib3 openssl certbot curl bash --no-cache --repository http://dl-3.alpinelinux.org/alpine/v3.7/community/ --repository http://dl-3.alpinelinux.org/alpine/v3.7/main/ \
    && rm -rf /var/cache/apk/*

    if [ -e /etc/letsencrypt/live ]
    then
        certbot -n -q certonly --expand --standalone --email ${SETUP_LETS_ENCRYPT_EMAIL} --agree-tos --rsa-key-size 4096 --domains ${SETUP_LETS_ENCRYPT_DOMAINS} --cert-path /etc/ssl/certs/sitecert.pem --key-path /etc/ssl/private/sitecert.key
    else
        # see https://security.stackexchange.com/a/95184/26281
        openssl dhparam -dsaparam -out /etc/letsencrypt/dhparam.pem 4096 > /dev/null 2>&1 &
        certbot -n -q certonly --standalone --email ${SETUP_LETS_ENCRYPT_EMAIL} --agree-tos --rsa-key-size 4096 --domains ${SETUP_LETS_ENCRYPT_DOMAINS} --cert-path /etc/ssl/certs/sitecert.pem --key-path /etc/ssl/private/sitecert.key
        wait
    fi
    
    echo "      ssl_certificate     /etc/letsencrypt/live/${SETUP_LETS_ENCRYPT_DOMAINS}/fullchain.pem;" > /etc/nginx/ssl-cert.conf
    echo "      ssl_certificate_key /etc/letsencrypt/live/${SETUP_LETS_ENCRYPT_DOMAINS}/privkey.pem;" >> /etc/nginx/ssl-cert.conf
fi

exec nginx -g "daemon off;"

