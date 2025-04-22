pipeline {
    agent any

    environment {
        IMAGE_NAME = "niikiki"  // Replace with your DockerHub username and app name
        CREDENTIALS_ID = 'dockerhub'  // Replace with your Jenkins DockerHub credentials ID
    }

    stages {
        stage('Clone') {
            steps {
                // Clone the GitHub repository based on the branch being built
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/NIKHILESH124/devops-build.git'  // Replace with your GitHub repo URL
            }
        }

        stage('Build') {
            steps {
                script {
                    // Set Docker image tag based on branch (dev for non-master, prod for master)
                    def tag = env.BRANCH_NAME == 'main' ? 'prod' : 'dev'
                    // Build the Docker image using the Dockerfile in the current directory
                    sh "docker build -t $IMAGE_NAME:$tag ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Set Docker image tag again, depending on the branch
                    def tag = env.BRANCH_NAME == 'main' ? 'prod' : 'dev'
                    // Use credentials to log into DockerHub and push the image
                    withCredentials([usernamePassword(credentialsId: "dockerhub", 
                        usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                            sh """
                                echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin
                                docker push $IMAGE_NAME:$tag
                            """
                    }
                }
            }
        }
    }

    // Trigger the build whenever a push is made to GitHub
    triggers {
        githubPush()  // This triggers the build whenever a push is made to GitHub
    }
}
