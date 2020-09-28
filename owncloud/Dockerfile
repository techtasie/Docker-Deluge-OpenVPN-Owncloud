FROM owncloud:10

RUN apt update && apt install -y cron && \
	rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*

RUN crontab -l -u www-data; printf '%s\n' '*/1 * * * * /usr/local/bin/php /var/www/html/occ files:scan --all >/dev/null 2>&1' | crontab -u www-data -

CMD service cron start ; apache2-foreground
