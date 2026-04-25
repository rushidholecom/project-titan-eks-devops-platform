FROM alpine:3.14
LABEL name="Rushidhole"
SHELL ["/bin/sh", "-c"]
USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-17-jdk git maven &&\
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/rushidholecom/EasyCRUD.git

WORKDIR /EASYCRUD/backend

COPY application.properties /EASYCRUD/backend/src/main/resources/application.properties

RUN mvn clean package -DskipTests

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "target/student-registration-backend-0.0.1-SNAPSHOT.jar"]





