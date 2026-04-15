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
        stage('Checkout Code') {
            steps {
                // On récupère tes fichiers YAML depuis GitHub
                git 'https://github.com/Linspi/devons-pro.git'
            }
        }

        stage('Déploiement MySQL') {
            steps {
                echo 'Installation de la base de données...'
                // On applique le fichier qui est à la racine
                sh '/usr/local/bin/kubectl apply -f mysql-all.yaml -n devops'
            }
        }

        stage('Configuration Application') {
            steps {
                echo 'Envoi de la configuration et des secrets...'
                sh '/usr/local/bin/kubectl apply -f spring-config.yaml -n devops'
            }
        }

        stage('Déploiement Spring Boot') {
            steps {
                echo 'Lancement de l\'application...'
                sh '/usr/local/bin/kubectl apply -f spring-app.yaml -n devops'
            }
        }

        stage('Vérification') {
            steps {
                echo 'Attente du démarrage des pods...'
                sh '/usr/local/bin/kubectl get pods -n devops'
                sh '/usr/local/bin/kubectl get services -n devops'
            }
        }
    } 
}
