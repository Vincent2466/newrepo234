// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            // Rather than inline YAML, in a multibranch Pipeline you could use: yamlFile 'jenkins-pod.yaml'
            // Or, to avoid YAML:
            // containerTemplate {
            //     name 'shell'
            //     image 'ubuntu'
            //     command 'sleep'
            //     args 'infinity'
            // }
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: shell
    image: registry.glams.com/glams/jenkins-agent:latest
    command:
    - sleep
    args:
    - infinity
    tty: true
    resources:
      requests:
        memory: "2Gi"
    volumeMounts:
     - name: docker-sock
       mountPath: /var/run/docker.sock
  volumes:
    - name: docker-sock
      hostPath:
        path: /var/run/docker.sock       
'''
            // Can also wrap individual steps:
            // container('shell') {
            //     sh 'hostname'
            // }
            defaultContainer 'shell'
        }
    }
   stages {
        stage('docker build') {
            steps {
                sh 'docker build -t vincent53/myapp .'
       }
    }
   stage('docker login') {
       steps {
            sh 'docker login -u vincent53 -p vincentbabu'
        }
    }
    stage('docker push') {
        steps {
            sh 'docker push vincent53/myapp'
           } 
      }
       stage('deployement') {
           steps {
               sh 'kubectl apply -f deployement.yaml'
               sh 'kubectl apply -f service.yaml'
           }
       }
         }
        }
