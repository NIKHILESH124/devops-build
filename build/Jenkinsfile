pipeline {
    agent any

    environment {
        GITHUB_CREDENTIALS = credentials('github-credentials')
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DEV_IMAGE = 'niikiki/my-static-site-dev'
        PROD_IMAGE = 'niikiki/my-static-site-prod'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: "${env.BRANCH_NAME}", 
                    credentialsId: "${GITHUB_CREDENTIALS}", 
                    url: 'https://github.com/NIKHILESH124/devops-build.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build('my-app-image')
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        sh "docker tag my-app-image ${DEV_IMAGE}:latest"
                        sh "docker push ${DEV_IMAGE}:latest"
                    } else if (env.BRANCH_NAME == 'master') {
                        sh "docker tag my-app-image ${PROD_IMAGE}:latest"
                        sh "docker push ${PROD_IMAGE}:latest"
                    } else {
                        echo "Branch ${env.BRANCH_NAME} not configured to push images."
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
    }
}
