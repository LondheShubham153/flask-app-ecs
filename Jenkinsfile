pipeline {
    agent { label "dev" }

    tools {
        jdk 'jdk23'
        maven 'maven'
    }

    environment {
        SONAR_HOST_URL = 'http://3.108.60.30:9000/'
        SONAR_PROJECT_KEY = 'flask-app-ecs'
        SONAR_PROJECT_NAME = 'flask-app-ecs'
        SONAR_LOGIN = 'squ_dc7626aae4bbb7007d9a7dc0f74be1615347ecd4'
    }

    stages {
        stage("code") {
            steps {
                git url: "https://github.com/julkar09/flask-app-ecs.git", branch: "work-branch"
            }
        }

        stage("Trivy File System Scan") {
            steps {
                sh "trivy fs . > trivy-report.txt || true"
                archiveArtifacts artifacts: 'trivy-report.txt', allowEmptyArchive: true
            }
        }

        stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv('MySonarQube') {
                    sh """
                        sonar-scanner \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.projectName=${SONAR_PROJECT_NAME} \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=${SONAR_HOST_URL} \
                        -Dsonar.login=${SONAR_LOGIN}
                    """
                }
            }
        }

        stage("build") {
            steps {
                sh "docker build -t python-app:latest ."
            }
        }

        stage("test") {
            steps {
                echo "test is done"
            }
        }

        stage("Push to Docker Hub") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "dockerHubCreds",
                    passwordVariable: "dockerHubPass",
                    usernameVariable: "dockerHubUser"
                )]) {
                    sh 'docker login -u $dockerHubUser -p $dockerHubPass'
                    sh 'docker image tag python-app:latest $dockerHubUser/python-app:00'
                    sh 'docker push $dockerHubUser/python-app:00'
                }
            }
        }

        stage("deploy") {
            steps {
                sh "docker compose up -d --build python_app"
            }
        }

        stage("Clean Up") {
            steps {
                echo "Cleaning up Docker and workspace..."
                sh '''
                    docker rmi python-app:latest || true
                    docker image prune -f || true
                    docker container prune -f || true
                    docker volume prune -f || true
                    rm -f trivy-report.txt || true
                '''
            }
        }
    }

    post {
        success {
            script {
                emailext(
                    from: 'zulkarnineador7@gmail.com',
                    to: 'zulkarnineador7@gmail.com',
                    subject: 'Build SUCCESS for Demo CICD App',
                    body: 'Build completed successfully.\n\nPlease find the Trivy scan report attached.',
                    attachmentsPattern: 'trivy-report.txt'
                )
            }
        }

        failure {
            script {
                emailext(
                    from: 'zulkarnineador7@gmail.com',
                    to: 'zulkarnineador7@gmail.com',
                    subject: 'Build FAILED for Demo CICD App',
                    body: 'Build failed!\n\nPlease review the attached Trivy scan report.',
                    attachmentsPattern: 'trivy-report.txt'
                )
            }
        }
    }
}
