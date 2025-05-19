pipeline {
    agent { 
        dockerfile { 
            args '--user robot'
        }
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh '''
                echo $PATH
                ls -al
                pip install -r requirements.txt
                '''
            }
        }

        stage('Run Robot Framework Tests') {
            steps {
                sh '''

                    robot --outputdir results --xunit xunit.xml test.robot
                '''
            }
        }

        stage('Archive Results') {
            steps {
                archiveArtifacts artifacts: 'results/**/*', allowEmptyArchive: true
            }
        }
    }

    post {
        always {
            junit 'results/xunit.xml'
        }
    }
}