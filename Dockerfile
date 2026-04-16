# On utilise une version légère de Java (JRE) pour l'exécution
FROM eclipse-temurin:17-jre-alpine

# On définit le dossier de travail
WORKDIR /app

# On copie le fichier JAR généré par l'étape Maven (Build & Test)
# Le fichier se trouve dans le dossier target/ après la compilation
COPY target/*.jar app.jar

# On expose le port sur lequel l'appli écoute
EXPOSE 8080

# On lance l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
