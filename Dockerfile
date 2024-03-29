FROM ubuntu:18.04
LABEL maintainer="khazi Naseeruddin" \
      organization="Truth & Insurance Office" \
      github="https://github.com/bugzilla/bugzilla" \
      website="https://www.bugzilla.org"

# Install tzdata package to configure time zone
RUN apt-get update && \
    apt-get install -y tzdata && \
    rm -rf /var/lib/apt/lists/*

# Set the desired time zone (replace "Etc/UTC" with your desired time zone)
ENV TZ Etc/UTC

ADD https://github.com/bugzilla/bugzilla/archive/release-5.0.6.tar.gz /opt/bugzilla.tar.gz
COPY ./bugzilla.conf /opt/bugzilla.conf
COPY ./start-bugzilla /usr/local/bin/start-bugzilla
COPY ./check-bugzilla /usr/local/bin/check-bugzilla

RUN chmod +x /usr/local/bin/start-bugzilla && \
    chmod +x /usr/local/bin/check-bugzilla 

RUN apt update && \
    apt install -y gcc make apache2 libpq-dev curl && \
    mv /opt/bugzilla.conf /etc/apache2/sites-available/bugzilla.conf && \
    cd /opt && \
    tar zvxf bugzilla.tar.gz && \
    rm -rf bugzilla.tar.gz && \
    bugzilla_root_dir=$(ls) && \
    mv /opt/${bugzilla_root_dir} /var/www/html/bugzilla && \
    cd /var/www/html/bugzilla && \
    a2ensite bugzilla && \
    a2enmod cgi headers expires && \
    service apache2 restart && \
    perl install-module.pl --all && \
    ./checksetup.pl && \
    perl install-module.pl DBD::Pg && \
    apt remove -y gcc make 


WORKDIR /var/www/html/bugzilla

CMD 'start-bugzilla'

HEALTHCHECK --interval=10s --timeout=5s --retries=3 CMD check-bugzilla