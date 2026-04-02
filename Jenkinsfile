pipeline { 
    agent any 
    tools { 
        maven "maven" 
        jdk "JAVA_17" 
    } 
    stages { 
        // L'étape Git a été retirée : Jenkins a déjà téléchargé le code à ce stade !
        
        stage('Build') { 
            steps { 
                echo "Compilation du projet..."
                sh "mvn clean package -Dmaven.test.skip=true" 
            } 
        }
        
        stage('SonarQube') {
            steps {
                echo "Envoi de l'analyse vers SonarQube..."
                // Remplacez VOTRE_MOT_DE_PASSE par celui de l'admin SonarQube
                sh "mvn sonar:sonar -Dsonar.host.url=http://192.168.33.10:9000 -Dsonar.login=admin -Dsonar.password=admin123"
            }
        }
    } 
}
