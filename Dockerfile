FROM openjdk:17-oracle
EXPOSE 9001

COPY ./target/execute-code-0.0.1-SNAPSHOT.jar /usr/app/

WORKDIR /usr/app

ENTRYPOINT ["java","-jar","execute-code-0.0.1-SNAPSHOT.jar"]
