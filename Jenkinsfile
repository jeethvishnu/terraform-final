pipeline {
    agent {
        label 'agent-33'
    }

    options {
        timeout(time:11, unit:'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')

}

environment {
    appVersion = ''
}

stages {
    stage ('read version') {
        steps {
            script {
                def jsonData = readJSON file: 'package.json'
                appVersion = jsonData.version
                echo "versionNumber: $appVersion"
            }
            
        }
    }
    stage('install dependencies') {
        steps {
            sh '''
                npm install
                ls -ltr
                echo "versionNumber: $appVersion"
            '''
        }
    }

    stage('build') {
        steps {
            sh '''
                zip -q -r backend-${appVersion}.zip * -x Jenkinsfile -x backend-${appVersion}.zip
                ls -ltr
            '''
        }
    }
}

post {
    always {
        echo 'will run always'
        deleteDir()
    }
    success {
        echo 'will run when it is successful'
    }
    failure {
        echo 'will run when it is failed'
    }
}
}

