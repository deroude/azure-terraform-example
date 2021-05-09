FROM azul/zulu-openjdk-alpine:11-jre
COPY target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar","--spring.config.location=classpath:/application.yaml,file:/config/application.yaml"]