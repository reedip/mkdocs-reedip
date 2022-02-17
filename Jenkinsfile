pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                echo 'Building the app'
                sh 'docker build . -f mkdocs.Dockerfile -t mkdocs_test:$BUILD_NUMBER'
            }
        }
        stage('test') {
            steps {
                echo 'Testing the app'
                echo 'Create a new project'
                sh 'pip install mkdocs'
                sh 'mkdocs new test'
                sh 'docker run -v $PWD:/opt mkdocs_test:$BUILD_NUMBER produce test'
                sh 'find . -name "mkdocs*.tar.gz" | xargs docker run -d -p 8000:8081 -v $PWD:/opt mkdocs_test:$BUILD_NUMBER serve'
                sh 'docker ps'

            }
        }
    }
    post {
        always {
            echo'Remove all existing images and containers after testinng for cleanup'
            sh "docker ps |grep mkdocs_test|awk '{ print \$1}'|xargs docker kill"
            sh "docker images |grep mkdocs|awk '{print \$3}'|xargs docker image rm --force"
            echo 'Removed the created local docker image'
        }
        success {
            echo 'Build & test succeeded'
        }
    }
}
