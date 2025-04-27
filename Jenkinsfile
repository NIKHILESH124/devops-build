pipeline {
    agent any

    environment {
        GITHUB_CREDENTIALS = credentials('github-credentials')   // GitHub credentials
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')  // DockerHub credentials
        DEV_IMAGE = 'niikiki/my-static-site-dev'
        PROD_IMAGE = 'niikiki/my-static-site-prod'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Use GitHub credentials to check out code from the repo
                git branch: "${env.BRANCH_NAME}", 
                    credentialsId: "${GITHUB_CREDENTIALS}", 
                    url: 'https://github.com/NIKHILESH124/devops-build.git'
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    // Use docker.withRegistry to login securely using DockerHub credentials
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        echo "Successfully logged into DockerHub"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    dockerImage = docker.build("my-app-image")
                    echo "Docker image built successfully"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push to the respective DockerHub repository based on the branch
                    if (env.BRANCH_NAME == 'dev') {
                        // Tag and push to the dev repository
                        dockerImage.tag("${DEV_IMAGE}:latest")
                        dockerImage.push("${DEV_IMAGE}:latest")
                        echo "Pushed to dev repository: ${DEV_IMAGE}:latest"
                    } else if (env.BRANCH_NAME == 'master') {
                        // Tag and push to the prod repository
                        dockerImage.tag("${PROD_IMAGE}:latest")
                        dockerImage.push("${PROD_IMAGE}:latest")
                        echo "Pushed to prod repository: ${PROD_IMAGE}:latest"
                    } else {
                        echo "Branch ${env.BRANCH_NAME} not configured to push images."
                    }
                }
            }
        }
    }

    post {
        always {
            // Logout of DockerHub after the pipeline finishes
            sh 'docker logout'
        }
    }
}
