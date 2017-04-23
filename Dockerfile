FROM openjdk:8-alpine
MAINTAINER u6k.apps@gmail.com

VOLUME /opt
COPY target/ceron-analyze.jar /opt/ceron-analyze.jar

EXPOSE 8080

CMD ["java", "-jar", "/opt/ceron-analyze.jar"]
