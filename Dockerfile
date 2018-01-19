FROM ubuntu:16.04


RUN apt-get update && \
	apt-get install -y apache2 apt-utils && \
	apt-get install -y php php-mysql php-mcrypt php-zip php-curl php-gd php-mbstring php-xml && \
	apt-get install -y libapache2-mod-php


RUN apt-get install -y curl  && \
	apt-get install -y vim

RUN /usr/sbin/a2enmod rewrite

EXPOSE 80

ADD apache.conf /etc/apache2/sites-enabled/000-default.conf

RUN service apache2 restart

CMD /usr/sbin/apache2ctl -D FOREGROUND


ENV APP_HOME /var/www/html
ENV APP_COMPOSER  /opt/data

RUN mkdir -p  /opt/data/public && \
  rm -rf  /var/www/html && \
  ln -s /opt/data/public $APP_HOME

WORKDIR $APP_COMPOSER /usr/bin/php composer.phar install 

WORKDIR $APP_HOME
