pipeline {
  agent { label 'slave' }

  stages {
    stage('Prepare Python ENV') {
      steps {
        script {
          // Clean & Prepare new python environment
          sh 'rm -rf ENV'
          sh 'python3 -m venv ENV'

          sh 'ENV/bin/pip install --upgrade pip'
          sh 'ENV/bin/pip install -r ${WORKSPACE}/PythonHelloWorld/requirements.txt'
        }
      }
    }

    stage('Execute unit tests') {
      steps {
        script {
          sh "ENV/bin/python -m unittest discover ${WORKSPACE}/PythonHelloWorld -v"
        }
      }
    }
  }
}
