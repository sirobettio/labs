pipeline {
    /* The agent directive, which is required, instructs Jenkins to allocate an executor and workspace for the Pipeline. */
    /* It ensures that the source repository is checked out and made available for steps in the subsequent stages */
    agent any
    environment {
        DISABLE_AUTH = 'true'
        DB_ENGINE    = 'sqlite'
        SAS_ADMIN_CREDS = credentials('viya-lab13-siro')
    }
    stages {
        stage('caslibs') {
            steps {
                echo "####################################"
                echo "Workspace= ${env.WORKSPACE}"
                echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
                echo "####################################"
                sh "${env.WORKSPACE}/viyaci/scripts/sas_admin_profile.sh ${SAS_ADMIN_CREDS_USR} ${SAS_ADMIN_CREDS_PSW}"
                /* sh "${env.WORKSPACE}/viyaci/scripts/create-caslibs.sh" */
            }
        }
        stage('folders') {
            steps {
                echo 'Importing Viya Folders...'
            }
        }
        stage('others') {
            steps {
                echo 'others ....'
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