pipeline {
  agent { label 'slave' }

  environment {
      GITHUB_CREDENTIALS = credentials('08e8a270-f348-468e-8017-c1eaef642cd7')
  }

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
  sh "curl -H 'Content-Type: application/json' \
      'https://\"${GITHUB_CREDENTIALS_USR}\":\"${GITHUB_CREDENTIALS_PSW}\"@api.github.com/repos/davidleonm/jenkins-test/statuses/\"${GIT_COMMIT}\""' \
       -d '{\"state\": \"${status}\",\"context\": \"continuous-integration/jenkins\", \"description\": \"Jenkins\", \"target_url\": \"${BUILD_URL}\"}'"
}