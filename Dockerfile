# Use official OpenJDK image
FROM eclipse-temurin:21-jdk-alpine

# Set working directory
WORKDIR /app

# Copy everything into the container
COPY . .

# Give Gradle wrapper execute permission (important on Linux)
RUN chmod +x ./gradlew

# Build the project
RUN ./gradlew build -x test --no-daemon

# Run the JAR
CMD ["java", "-jar", "build/libs/coffee-shop-telegram-bot-0.0.1-SNAPSHOT.jar"]