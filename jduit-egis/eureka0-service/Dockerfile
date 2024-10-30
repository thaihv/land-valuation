FROM openjdk:8-jdk-alpine
MAINTAINER JungdoUIT-VN
ARG JAR_FILE=target/*.jar
ADD ${JAR_FILE} eureka0-service-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/eureka0-service-0.0.1-SNAPSHOT.jar"]
