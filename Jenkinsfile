pipeline {
    agent {
        label 'agent-22'
    }

    options {
        timeout(time:11, unit:'MINUTES')
        ansiColor('xterm')
        disableConcurrentBuilds()
    }

    stages {
        stage ('init') {
            steps {
                sh '''
                    echo hi
                '''
            }
        }

        stage('plan') {
            steps {
                sh '''
                    echo plan
                '''
            }
        }

        stage('deploy') {
            steps {
                sh '''
                    echo deploying
                '''
            }
        }
    }

    post {
        always {
            echo 'will run everytime'
        }
        success {
            echo 'will run if it is success'
        }
    }

}

