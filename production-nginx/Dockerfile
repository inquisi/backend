FROM nginx:1.7.11

RUN apt-get update && apt-get install git -y


WORKDIR /opt

RUN git clone https://a74199cc68e71ae2598eb5cb080261815dcd48b1@github.com/inquisi/backend.git

RUN ls -la

RUN cp ./backend/production-nginx/nginx.conf /etc/nginx/nginx.conf

