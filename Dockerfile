# Use lightweight Java runtime
FROM eclipse-temurin:17-jre

# Create app directory
WORKDIR /app

# Copy your built JAR file into the image
COPY coffee-shop-telegram-bot-0.0.1-SNAPSHOT.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
