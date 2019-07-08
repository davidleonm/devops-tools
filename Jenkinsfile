pipeline {
  agent { label 'slave' }

  stages {
    stage('Prepare Python ENV') {
      steps {
        script {
          // Clean & Prepare new python environment
          sh 'rm -rf ENV'
          sh '/usr/bin/virtualenv --no-site-packages ENV'

          sh 'ENV/bin/pip install --upgrade pip'
          sh 'ENV/bin/pip install -r ${WORKSPACE}/PythonHelloWorld/requirements.txt'
        }
      }
    }

    stage('Execute unit tests') {
      steps {
        script {
          sh "python -m unittest discover ${WORKSPACE}/PythonHelloWorld -v"
        }
      }
    }
  }
}
