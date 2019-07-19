pipeline {
  agent { label 'slave' }

  stages {
    stage('Prepare Python ENV') {
      steps {
        script {
          SetBuildStatus('pending')

          // Clean & Prepare new python environment
          sh 'rm -rf ENV'
          sh 'python3 -m venv ENV'

          sh 'ENV/bin/pip install --upgrade pip'
          sh "ENV/bin/pip install -r ${WORKSPACE}/PythonHelloWorld/requirements.txt"
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
  post {
    success {
      script {
        SetBuildStatus('success')
      }
    }

    failure {
      script {
        SetBuildStatus('failure')
      }
    }
  }
}

def SetBuildStatus(String status) {
  sh "curl -H 'Authorization: token \"0ce9abc63086905feaae064f6fe2b005deae95c3\"' \
       -H 'Content-Type: application/json' \
       -X POST 'https://api.GitHub.com/repos/davidleonm/jenkins-test/statuses/${GIT_COMMIT}' \
       -d '{\"state\": \"${status}\",\"context\": \"continuous-integration/jenkins\", \"description\": \"Jenkins\", \"target_url\": \"${BUILD_URL}\"}'"
}