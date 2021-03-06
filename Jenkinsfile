pipeline {
  environment {
    registry = 'registry.hub.docker.com'
    registryCredential = 'docker-hub'
    repository = 'your_repo_here/jenkins-demo'
    imageLine = 'your_repo_here/jenkins-demo:latest'
  }
  agent any
  stages {
    stage('Checkout SCM') {
      steps {
        checkout scm
      }
    }
    stage('Build image and push to registry') {
      steps {
        sh 'docker --version'
        script {
          docker.withRegistry('https://' + registry, registryCredential) {
            def image = docker.build(repository)
            image.push()
          }
        }
      }
    }
    stage('Analyze with Anchore plugin') {
      steps {
        writeFile file: 'anchore_images', text: imageLine
        anchore name: 'anchore_images'
      }
    }
    stage('Build and push stable image to registry') {
      steps {
        script {
          docker.withRegistry('https://' + registry, registryCredential) {
            def image = docker.build(repository + ':prod')
            image.push()  
          }
        }
      }
    }
  }
}
