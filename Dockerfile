
##Stage 1 - Build JAR using maven
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . .

#create jar file
RUN mvn clean install -DskipTests=true

## Stage 2 - Execute JAR files
#alpine type images are small in size
FROM openjdk:17-alpine

WORKDIR /app

# Copy build from stage 1 (builder)
COPY --from=builder /app/target/*.jar /app/expenseapp.jar


EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/target/expenseapp.jar"]
