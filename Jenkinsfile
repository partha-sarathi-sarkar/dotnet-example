pipeline {
    agent any

    stages {
        stage('publish Project') {
            steps {
                bat label: '', script: 'dotnet publish DockerDemo -c Release -o out'
            }
        }
        stage('Octopus Create release') {
            steps {
                bat label: '', script: 'Octo.exe pack --id DockerWebAppDemo --version %BUILD_NUMBER%.0.0'
            }
        }
        stage('octo push package') {
            steps {
                bat label: '', script: 'octo push --package DockerWebAppDemo.%BUILD_NUMBER%.0.0.nupkg --replace-existing  --server http://172.16.23.148:8088/ --apiKey API-FUKR9IQUIXVAHT58AKK0DYNF1Q'
            }
        }
         stage('octo Create Release') {
            steps {
                bat label: '', script: 'octo create-release --project "Demo_Docker_Octo" --version %BUILD_NUMBER%.0.0 --server http://172.16.23.148:8088/ --apiKey API-FUKR9IQUIXVAHT58AKK0DYNF1Q'
            }
        }
        stage('octo Deploy Release') {
            steps {
                bat label: '', script: 'octo deploy-release --project Demo_Docker_Octo --releaseNumber %BUILD_NUMBER%.0.0 --deployto Develop --server http://172.16.23.148:8088/ --apiKey API-FUKR9IQUIXVAHT58AKK0DYNF1Q'
            }
        }
    }
    post { 
        success { 
             echo "Triggered post-success"
             mail bcc: 'partha.sarkar@cygnetinfotech.com', body: "<b>Pipeline Succeed</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: 'partha.sarkar@cygnetinfotech.com', subject: "CI: Project name -> ${env.JOB_NAME}", to: "sarathi1995@gmail.com,partha.sarathi.sarkar95@gmail.com"; 
         }  
         failure { 
             echo "Triggered post-failure" 
             mail bcc: 'partha.sarkar@cygnetinfotech.com', body: "<b>Pipeline Failed</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: 'partha.sarkar@cygnetinfotech.com', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "sarathi1995@gmail.com,partha.sarathi.sarkar95@gmail.com";  
         } 
        always { 
            cleanWs()
        }
    }
}


