# On change l'image de base pour une version compatible ARM64 (Mac M1/M2/M3)
FROM openjdk:17-jdk-slim

# On définit le dossier de travail
WORKDIR /app

# On copie le fichier JAR généré
COPY target/*.jar app.jar

# On expose le port 8080
EXPOSE 8080

# On lance l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
