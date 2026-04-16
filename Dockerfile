# Utilisation de Eclipse Temurin (le successeur officiel d'OpenJDK)
# Cette version supporte parfaitement les Mac M1/M2/M3 (ARM64)
FROM eclipse-temurin:17-jre

# Dossier de travail
WORKDIR /app

# Copie du JAR généré par Maven
COPY target/*.jar app.jar

# Port d'écoute
EXPOSE 8080

# Lancement
ENTRYPOINT ["java", "-jar", "app.jar"]
