pipeline {
    agent any

    environment {
        GITHUB_CREDENTIALS = credentials('github-credentials')   // GitHub credentials ID
        DOCKERHUB_CREDENTIALS = credentials('h')  // DockerHub credentials ID, updated to 'h'
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
                    // You can skip this if you are using an existing image
                    dockerImage = docker.build('my-app-image')
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'h', usernameVariable: 'DOCKERHUB_USR', passwordVariable: 'DOCKERHUB_PSW')]) {  // Updated here to 'h'
                        sh "echo ${DOCKERHUB_PSW} | docker login -u ${DOCKERHUB_USR} --password-stdin"
                    }
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
