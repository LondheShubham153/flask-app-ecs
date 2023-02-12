pipeline {
    agent any
    
    stages {
        stage('Code'){
            steps{
               git 'https://github.com/iamjkr/flask-app-ecs.git'
            
            }
            
        }
        stage('Buid'){
             steps{
                 sh 'docker build . -t iamjkr/flask:latest'
            }
            
        }
        stage('Push'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerHub',usernameVariable: 'docker_username', passwordVariable: 'docker_password')])
                {
                    sh 'docker login -u $docker_username -p $docker_password'
                    sh 'docker push iamjkr/ecom-web:latest'
                }
            }
        }
  
  
        stage('Test'){
            steps{
                echo "Testing code"
            }
            
        }
        stage('Deploy'){
            steps{
                sh 'docker-compose down && docker-compose up -d --no-deps'
            }
            
        }
    }
}
