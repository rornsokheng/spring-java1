# ===== Build stage =====
FROM gradle:8.4.1-jdk21 AS build

# Set working directory
WORKDIR /app

# Copy Gradle build files first (for caching)
COPY build.gradle settings.gradle ./

# Copy source code
COPY src ./src

# Build the jar (skip tests for faster builds)
RUN gradle clean build -x test --no-daemon

# ===== Run stage =====
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copy the jar from build stage (auto-detect any versioned jar)
COPY --from=build /app/build/libs/*.jar app.jar

# Expose port (adjust if your Spring Boot app uses another port)
EXPOSE 8080

# Run the Spring Boot jar
ENTRYPOINT ["java", "-jar", "app.jar"]
