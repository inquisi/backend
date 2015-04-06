FROM nginx:1.7.11

RUN apt-get update && apt-get install git -y

WORKDIR /opt

RUN echo "no-caching" && git clone https://a74199cc68e71ae2598eb5cb080261815dcd48b1@github.com/inquisi/backend.git

WORKDIR backend

RUN git pull

RUN cp ./production-nginx/nginx.conf /etc/nginx/nginx.conf

