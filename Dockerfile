FROM maven:3.8.3-openjdk-11-slim AS BUILD
WORKDIR /app
COPY . .
RUN mvn clean install


FROM tomcat:8.0.51-jre8-alpine
EXPOSE 8080
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
CMD ["catalina.sh","run"]