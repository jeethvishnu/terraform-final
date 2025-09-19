pipeline {
    agent {
        label 'agent-33'
    }

    options {
        timeout(time:11, unit:'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')

}

parameters {
    string(name: 'appversion', defaultValue: '1.0.0', description: 'what is the version of the app?')
}

environment {
    appVersion = ''
    nexusurl = 'nexus.vjeeth.site:8081'
}

stages {
    stage ('init') {
        steps {
            sh """
                cd frontend
                terraform init
            """

        }
    }
    stage ('plan') {
        steps {
            sh """
            cd frontend
            terraform plan -var="appVersion=${params.appversion}"
            """
        }
    }
    stage ('deploy') {
        steps {
            sh """
            cd frontend
            terraform apply -auto-approve -var="appVersion=${params.appversion}"
            """
        }
    }
}
post {
    always {
        echo 'will run always'
        //deleteDir()
    }
    success {
        echo 'will run when it is successful'
    }
    failure {
        echo 'will run when it is failed'
    }
}
}

