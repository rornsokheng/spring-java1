# ===== Build stage =====
FROM gradle:8.4.1-jdk21 AS build  # Uses Gradle 8 + Java 21

WORKDIR /app

# Copy project files
COPY build.gradle settings.gradle ./
COPY src ./src

# Build the jar (skip tests)
RUN gradle clean build -x test --no-daemon

# ===== Run stage =====
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copy the jar from build stage (auto-detect versioned jar)
COPY --from=build /app/build/libs/*.jar app.jar

# Expose port
EXPOSE 8080

# Run the Spring Boot jar
ENTRYPOINT ["java", "-jar", "app.jar"]
