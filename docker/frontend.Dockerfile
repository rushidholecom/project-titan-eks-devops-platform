FROM node:16-alpine

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nginx &&\
    rm -rf /var/lib/apt/list/*

RUN git clone https://github.com/EasyCRUD/frontend.git

WORKDIR /EasyCRUD/frontend

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "run", "build"] && npm start