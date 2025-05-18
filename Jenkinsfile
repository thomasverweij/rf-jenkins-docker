pipeline {
    agent { 
        dockerfile { 
            args '-u pwuser:sudo'
        }
    }

    stages {
        // stage('Install Dependencies') {
        //     steps {
        //         sh 'pip install --upgrade pip && pip install robotframework'
        //     }
        // }

        stage('Run Robot Framework Tests') {
            steps {
                sh '''
                    robot --outputdir results --xunit xunit.xml test.robot
                '''
            }
        }

        stage('Archive Results') {
            steps {
                archiveArtifacts artifacts: 'results/*', allowEmptyArchive: true
            }
        }
    }

    post {
        always {
            junit 'results/xunit.xml'
        }
    }
}