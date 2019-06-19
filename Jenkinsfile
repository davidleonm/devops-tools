pipeline {
  agent { label 'slave' }

  stages {
    stage('Execute unit tests') {
      steps {
        script {
          sh 'python PythonHelloWorld/tests/app_unit_tests.py'
        }
      }
    }
  }
}
