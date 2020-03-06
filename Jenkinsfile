pipeline {
    /* The agent directive, which is required, instructs Jenkins to allocate an executor and workspace for the Pipeline. */
    /* It ensures that the source repository is checked out and made available for steps in the subsequent stages */
    agent any
    environment {
        DISABLE_AUTH = 'true'
        DB_ENGINE    = 'sqlite'
        VIYA_LAB10_SIRO_CREDS = credentials('viya-lab10-siro')
    }
    stages {
        stage('Build') {
            steps {
                echo "####################################"
                echo "Workspace= ${env.WORKSPACE}"
                echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
                echo "VIYA_LAB10_SIRO_CREDS_USR= ${VIYA_LAB10_SIRO_CREDS_USR}"
                echo "VIYA_LAB10_SIRO_CREDS_PWD= ${VIYA_LAB10_SIRO_CREDS_PSW}"
                echo "####################################"
                sh "${env.WORKSPACE}/viyaci/scripts/sas_admin_profile.sh"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            when {
								expression {
								   currentBuild.result == null || currentBuild.result == 'SUCCESS' 
						     }
						}
            steps {
                echo 'Deploying....'
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}