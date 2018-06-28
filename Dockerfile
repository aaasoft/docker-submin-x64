FROM debian:jessie
MAINTAINER aaaSoft <scbeta@qq.com>

ENV SUBMIN_VERSION 2.2.1-1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       python \
       subversion \
       python-subversion \
       apache2 \
       libapache2-svn \
       sendmail \
       curl \
       sqlite3 \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \
    && curl -fkSL "http://supermind.nl/submin/current/submin-${SUBMIN_VERSION}.tar.gz" -o submin.tar.gz \
    && tar -xf submin.tar.gz -C /opt/ \
    && rm submin.tar.gz \
    && cd /opt/submin-${SUBMIN_VERSION} \
    && python setup.py install \
    && cd / \
    && rm -rf /opt/submin-${SUBMIN_VERSION}

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["submin"]
