pipeline {
    /* The agent directive, which is required, instructs Jenkins to allocate an executor and workspace for the Pipeline. */
    /* It ensures that the source repository is checked out and made available for steps in the subsequent stages */
    agent any
    environment {
        SAS_CLI_PROFILE = "lab13-viya35"
        SAS_ADMIN_CREDS = credentials('viya-lab13-siro')
        SAS_CLI_DEFAULT_CAS_SERVER = "cas-shared-default"
    }
    stages {
        stage('caslibs') {
            steps {
                sh "${env.WORKSPACE}/viyaci/scripts/sas_admin_login.sh ${SAS_ADMIN_CREDS_USR} ${SAS_ADMIN_CREDS_PSW}"
                sh "${env.WORKSPACE}/viyaci/scripts/create_caslibs.sh"
            }
        }
        stage('folders') {
            steps {
                sh "${env.WORKSPACE}/viyaci/scripts/import_folders.sh"
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