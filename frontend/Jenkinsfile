pipeline {
    agent { label 'agent-33' }

    options {
        timeout(time: 11, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }

    environment {
        appVersion = ''
        nexusurl  = 'nexus.vjeeth.site:8081'
    }

    stages {
        stage('read version') {
            steps {
                script {
                    def jsonData = readJSON file: 'package.json'
                    appVersion = jsonData.version
                    echo "versionNumber: $appVersion"
                }
            }
        }


        stage('build') {
            steps {
                sh """
                    zip -q -r frontend-${appVersion}.zip . -x Jenkinsfile -x frontend-${appVersion}.zip
                    ls -ltr
                """
            }
        }

        stage('nexus upload artifact') {
            steps {
                script {
                    nexusArtifactUploader(
                        nexusVersion: 'nexus3',
                        protocol: 'http',
                        nexusUrl: "${nexusurl}",
                        groupId: 'com.expense',
                        version: "${appVersion}",
                        repository: "frontend-j",
                        credentialsId: 'nexus',
                        artifacts: [[
                            artifactId: "frontend-j",
                            classifier: '',
                            file: "frontend-${appVersion}.zip",
                            type: 'zip'
                        ]]
                    )
                }
            }
        }

        // stage('downstream job deploy') {
        //     steps {
        //         script {
        //             def params = [
        //                 string(name: 'appversion', value: "${appVersion}")
        //             ]
        //             build job: 'frontend-deploy', parameters: params, wait: false
        //         }
        //     }
        // }
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