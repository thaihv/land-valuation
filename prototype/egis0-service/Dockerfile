FROM eclipse-temurin:17-jdk
MAINTAINER JungdoUIT-VN
ARG JAR_FILE=target/*.jar
ADD ${JAR_FILE} egis0-service-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/egis0-service-0.0.1-SNAPSHOT.jar"]
