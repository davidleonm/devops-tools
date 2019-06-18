pipeline {
  agent { label 'slave' }

  stages {
    stage('Checkout Code') {
      steps {
        script {
          checkout([$class: 'GitSCM', branches: [[name: "${GIT_BRANCH}"]], doGenerateSubmoduleConfigurations: false,
            extensions: [[$class: 'SubmoduleOption', disableSubmodules: false, parentCredentials: true, recursiveSubmodules: true, reference: '', trackingSubmodules: false]],
            userRemoteConfigs: [[credentialsId: '96cd6524-291a-42e2-aa4f-38e219a36698', url: "${GIT_URL}"]]])
        }
      }
    }

    stage('Update Library page') {
      steps {
        script {
          sh 'python PythonHelloWorld/tests/app_unit_tests.py'
        }
      }
    }
  }
}
