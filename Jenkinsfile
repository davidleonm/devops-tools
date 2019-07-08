pipeline {
  agent { label 'slave' }

  stages {
    stage('Execute unit tests') {
      steps {
        script {
          sh "python -m unittest discover ${WORKSPACE}/PythonHelloWorld -v"
        }
      }
    }
  }
}
