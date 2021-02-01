FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install git nano vim expect -y
RUN apt-get install apache2 libappconfig-perl libdate-calc-perl libtemplate-perl libmime-perl build-essential libdatetime-timezone-perl libdatetime-perl libemail-sender-perl libemail-mime-perl libemail-mime-modifier-perl libdbi-perl libdbd-mysql-perl libcgi-pm-perl libmath-random-isaac-perl libmath-random-isaac-xs-perl apache2-mpm-prefork libapache2-mod-perl2 libapache2-mod-perl2-dev libchart-perl libxml-perl libxml-twig-perl perlmagick libgd-graph-perl libtemplate-plugin-gd-perl libsoap-lite-perl libhtml-scrubber-perl libjson-rpc-perl libdaemon-generic-perl libtheschwartz-perl libtest-taint-perl libauthen-radius-perl libfile-slurp-perl libencode-detect-perl libmodule-build-perl libnet-ldap-perl libauthen-sasl-perl libtemplate-perl-doc libfile-mimeinfo-perl libhtml-formattext-withlinks-perl libgd-dev libmysqlclient-dev lynx-cur graphviz python-sphinx -y

WORKDIR /var/www/html
RUN git clone --branch release-5.0-stable https://github.com/bugzilla/bugzilla bugzilla

# config apache
COPY bugzilla.conf /etc/apache2/sites-available/bugzilla.conf
RUN a2ensite bugzilla
RUN a2enmod cgi headers expires
RUN service apache2 restart

# to check Setup
WORKDIR /var/www/html/bugzilla
RUN ./checksetup.pl;exit 0
RUN /usr/bin/perl install-module.pl --all
RUN ./checksetup.pl
COPY cfg.sh /var/www/html/bugzilla
 


