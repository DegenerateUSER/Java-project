# syntax=docker/dockerfile:1.7

FROM maven:3.9.11-eclipse-temurin-17 AS build
WORKDIR /workspace

COPY pom.xml ./
COPY src ./src
RUN mvn -DskipTests clean package

FROM tomcat:10.1-jre17-temurin

# Deploy app as ROOT for simpler routing behind cloud ingress.
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /workspace/target/distributed-ecommerce-1.0.0.war /usr/local/tomcat/webapps/ROOT.war

# Application HTTP port for Azure/App Service container routing.
EXPOSE 8080
# Internal RMI payment mock port used by the app startup listener.
EXPOSE 1099

# Override these at runtime with secure values.
ENV DB_URL=jdbc:postgresql://host.docker.internal:5432/ecommerce_db
ENV DB_USERNAME=postgres
ENV DB_PASSWORD=postgres

CMD ["catalina.sh", "run"]
