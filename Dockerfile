#---------Stage1------------------

# Pull base image so that we can use maven to build jar files
FROM maven:3.8.3-openjdk-17 AS builder

MAINTAINER faizanshaikh0001b@gmail.com
#creating directory in container for copying src code
WORKDIR /app

#copying all the code from host to container
COPY pom.xml /app
COPY . /app

# Build the app to generate jar file
RUN mvn clean install -DskipTests=true

#----------Stage2-------------------

FROM openjdk:17-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/bankapp.jar

#expose the port so that the port can be mapped with the host
EXPOSE 8080

#execute the JAR file using java command and -jar for (to specify we are executing a jar file)
ENTRYPOINT ["java", "-jar", "/app/target/bankapp.jar"]
