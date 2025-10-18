# ===== Build stage =====
FROM gradle:8.7-jdk17 AS build
WORKDIR /app

# Copy Gradle wrapper and build files first
COPY gradlew ./
COPY gradle ./gradle
COPY build.gradle settings.gradle ./

# Give execute permission to the Gradle wrapper
RUN chmod +x ./gradlew

# Copy the source code
COPY src ./src

# Build the project (skip tests for faster builds)
RUN ./gradlew build -x test

# ===== Run stage =====
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
