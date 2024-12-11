#---------Stage1------------------

FROM maven:3.8.3-openjdk-17 AS builder
MAINTAINER faizanshaikh0001b@gmail.com

WORKDIR /app

# Copy only necessary files
COPY pom.xml /app/
RUN mvn dependency:resolve

# Copy source code
COPY src /app/src

# Build the app to generate jar file
RUN mvn clean install -DskipTests=true

#----------Stage2-------------------

FROM openjdk:17-alpine
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar /app/target/bankapp.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/target/bankapp.jar"]
