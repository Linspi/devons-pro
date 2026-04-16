pipeline {
    agent any

    tools {
        // Assure-toi que ce nom est EXACTEMENT le même dans 
        // Administrer Jenkins -> Global Tool Configuration -> Maven
        maven 'maven 3.6.3'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Jenkins récupère le code depuis ton repo GitHub
                git branch: 'main', url: 'https://github.com/Linspi/devons-pro.git'
            }
        }

        stage('Build & Test') {
            steps {
                echo "Compilation du projet et génération du JAR..."
                // On saute les tests pour aller plus vite, comme dans ton script
                sh "mvn clean package -Dmaven.test.skip=true"
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo "Envoi de l'analyse vers SonarQube..."
                // Utilisation de tes paramètres (vérifie bien l'IP si elle a changé)
                sh "mvn sonar:sonar -Dsonar.host.url=http://192.168.33.10:9000 -Dsonar.login=admin -Dsonar.password=admin123"
            }
        }

        stage('Docker Build Local') {
            steps {
                echo "Construction de l'image Docker (format ARM64)..."
                // On construit l'image localement sur ton Mac
                sh "docker build -t mon-app-spring:local ."
                
                echo "Chargement de l'image dans Minikube..."
                // TRÈS IMPORTANT : rend l'image visible par le cluster Kubernetes
                sh "minikube image load mon-app-spring:local"
            }
        }

        stage('Déploiement MySQL') {
            steps {
                echo 'Déploiement de la base de données...'
                sh '/usr/local/bin/kubectl apply -f mysql-all.yaml -n devops'
            }
        }

        stage('Configuration K8s') {
            steps {
                echo 'Envoi des ConfigMaps et Secrets...'
                sh '/usr/local/bin/kubectl apply -f spring-config.yaml -n devops'
            }
        }

        stage('Déploiement Spring Boot') {
            steps {
                echo "Lancement de l'application sur Kubernetes..."
                sh '/usr/local/bin/kubectl apply -f spring-app.yaml -n devops'
            }
        }

        stage('Vérification') {
            steps {
                echo 'Statut des ressources dans le namespace devops :'
                sh '/usr/local/bin/kubectl get pods -n devops'
                sh '/usr/local/bin/kubectl get services -n devops'
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline terminé avec succès ! L'application est déployée."
        }
        failure {
            echo "❌ Le pipeline a échoué. Vérifiez les logs de la console."
        }
    }
}
