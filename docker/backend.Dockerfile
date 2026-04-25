FROM maven:3.9.9-eclipse-temurin-17 AS builder

ARG EASYCRUD_REPO=https://github.com/rushidholecom/EasyCRUD.git
ARG EASYCRUD_REF=main

RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch "${EASYCRUD_REF}" "${EASYCRUD_REPO}" /src

WORKDIR /src/backend

COPY application.properties /src/backend/src/main/resources/application.properties

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=builder /src/backend/target/student-registration-backend-0.0.1-SNAPSHOT.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
