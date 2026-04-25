FROM alpine:3.14
LABEL name="Rushidhole"
SHELL [ "/bin/bash" ]
USER root

RUN apt update && apt install openjdk-17-jdk git maven -y

RUN git clone https://github.com/rushidholecom/EasyCRUD.git

WORKDIR /EASYCRUD/backend

COPY application.properties /EASYCRUD/backend/src/main/resources/application.properties

RUN mvn clean package -DskipTests

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "target/student-registration-backend-0.0.1-SNAPSHOT.jar"]





