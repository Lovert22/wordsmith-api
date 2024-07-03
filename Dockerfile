FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml /app
COPY src /app/src

# Build the project
RUN mvn clean package

# Stage 2: Create the final image
FROM openjdk:17-jdk-alpine
WORKDIR /app

# Copy the built JAR file from the first stage
COPY --from=build /app/target/words.jar /app/words.jar

# Expose the port
EXPOSE 8000
