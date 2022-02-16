pipeline {  
    agent any

    stages {
        stage('build') {
            steps {
                echo 'Building the app'
                sh 'docker build . -f mkdocs.Dockerfile -t mkdocs_test:0.0.0.1'
            }
        }
        stage('test') {
            steps {
                echo 'Testing the app'
                echo 'Create a new project'
                sh 'pip install mkdocs'
                sh 'mkdocs new test'
                
            }
        }
    }
    post {
        always {
            sh 'docker images |grep mkdocs|awk '{print $3}'|xargs docker image rm --force'
            echo 'Removed the created local dockerfile'
        }
        success {
            echo 'Build & test succeeded'
        }
}

# Declaritive approach
# Code checkout is automated in the Declaritive approach
# We start a pipeline to service Pipeline as Code
# Run on any agent, which can be a node or an executor , support all entities of a multiOS Jenkins cluster