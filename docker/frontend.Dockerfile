FROM node:16-alpine AS builder

RUN apk add --no-cache git

RUN git clone https://github.com/rushidholecom/EasyCRUD.git 

WORKDIR /EasyCRUD/frontend

RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi

RUN npm run build && \
    mkdir -p /out && \
    if [ -d build ]; then cp -r build/. /out/; \
    elif [ -d dist ]; then cp -r dist/. /out/; \
    else echo "No frontend build output found" && exit 1; fi

FROM nginx:alpine

COPY --from=builder /out/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
