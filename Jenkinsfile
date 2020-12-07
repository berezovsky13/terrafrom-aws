pipeline {
    agent any

    stages {
        stage('sudo') {
            steps {
                sh "sudo su -"
            }
        }

        stage('scm'){
            steps {
                sh "git clone https://github.com/berezovsky13/sela-group.git"

            }
        }

        stage('cd'){
            steps{
                sh "cd sela-group"
            }
        }

        stage('build'){
            steps{
                sh "sudo docker build -t berezovsky8/python ."

            }
        }

        stage('push'){
            steps{
                sh "sudo docker push berezovsky8/python"
            }
        }

        

        
    
    }

}
