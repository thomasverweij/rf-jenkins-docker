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
                    export PATH="/home/pwuser/.venv/bin:$PATH"
                    robot --outputdir results test.robot
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
            junit 'results/output.xml'
        }
    }
}