# ===== Build stage =====
FROM eclipse-temurin:21-jdk-alpine AS build

# Set working directory
WORKDIR /app

# Copy Gradle wrapper and build files
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle .
COPY settings.gradle .

# Copy source code
COPY src ./src

# Give execute permission to Gradle wrapper
RUN chmod +x gradlew

# Build the jar (skip tests for faster build)
RUN gradlew clean build -x test

# ===== Run stage =====
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copy the jar from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose port (optional, adjust if your app uses a different port)
EXPOSE 8080

# Run the Spring Boot jar
ENTRYPOINT ["java", "-jar", "app.jar"]
