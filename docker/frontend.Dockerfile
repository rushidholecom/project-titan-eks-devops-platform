FROM node:16-alpine

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nginx &&\
    rm -rf /var/lib/apt/list/*

RUN git clone https://github.com/EasyCRUD/frontend.git

WORKDIR /EasyCRUD/frontend

RUN npm install

COPY env .env

EXPOSE 3000
ENTRYPOINT [ "npm", "run", "build" ]

RUN systemctl start nginx && systemctl enable nginx

COPY dist/* /var/www/html/