FROM node:20-alpine AS builder

ARG EASYCRUD_REPO=https://github.com/rushidholecom/EasyCRUD.git
ARG EASYCRUD_REF=main

RUN apk add --no-cache git

RUN git clone --depth 1 --branch "${EASYCRUD_REF}" "${EASYCRUD_REPO}" /src

WORKDIR /src/frontend

RUN npm install && \
     npm cache clean --force

RUN npm run build && \
    mkdir -p /out && \
    if [ -d build ]; then cp -r build/. /out/; \
    elif [ -d dist ]; then cp -r dist/. /out/; \
    else echo "No frontend build output found" && exit 1; fi

FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /out/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
