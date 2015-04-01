FROM mysql:5.6

WORKDIR /opt

RUN echo "no-caching" && git clone https://a74199cc68e71ae2598eb5cb080261815dcd48b1@github.com/inquisi/backend.git

WORKDIR backend

RUN git pull

RUN cp ./production-mysql/production.cnf /etc/mysql/conf.d/production.cnf