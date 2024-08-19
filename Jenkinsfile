pipeline {
    agent any
    tools{
        nodejs 'nodejs-22'
    }
    environment {
        DOCKER_REGISTRY_CREDENTIALS = '3a7807de-0f7c-41d9-b0cc-9b5b0e43e194'
        DOCKER_IMAGE_NAME = 'waldriss/nodejs'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/waldriss/simple-node-js-app.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh "npm install"
            }
        }
        stage('Test') {  
            steps {
                sh "npm test" 
            }
            post {
                    always {
                        junit '**/test-results.xml' 
                    }
            }
        }
         stage('Dependency Check') {
                    steps {
                            dependencyCheck additionalArguments: '--scan ./ --format XML', odcInstallation: 'DP'
                            dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
                    }
        }
        stage('Docker Build & push') {
                    steps {
                        script{
                            withDockerRegistry(credentialsId: '3a7807de-0f7c-41d9-b0cc-9b5b0e43e194', toolName: 'docker') {
                                sh "docker build -t simplenodejs ."
                                sh "docker tag simplenodejs ${DOCKER_IMAGE_NAME}:latest"
                                sh "docker push ${DOCKER_IMAGE_NAME}:latest"
                                
                            }   
                        }
                    }
        }
        stage('Docker Deploy') {
                    steps {
                        script{
                            withDockerRegistry(credentialsId:DOCKER_REGISTRY_CREDENTIALS, toolName: 'docker') {
                                sh "docker run -d --name demo-nodejs -p 8085:3000 ${DOCKER_IMAGE_NAME}:latest"
                                
                            }   
                        }
                    }
        }
     
        
       
    }
    post {
            success {
                sh "docker rmi simplenodejs"
            }
    }
}
