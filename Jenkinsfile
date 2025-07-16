pipeline {
    agent {
        label 'agent-22'
    }

    options {
        timeout(time:11, unit:'MINUTES')
        ansiColor('xterm')
    }

    stages {
        stage('init') {
            steps {
                sh '''
                    echo initialsing
                '''
            }
        }
        stage('build') {
            steps {
                sh '''
                    echo building
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
            echo ' will run always'
        }

        success {
            echo ' will run when its success'
        }
    }

}

