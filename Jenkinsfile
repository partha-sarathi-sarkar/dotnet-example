pipeline {
    agent any

    stages {
        stage('publish Project') {
            steps {
                bat label: '', script: 'dotnet publish .\\dotnet-example.csproj -c Release'
            }
        }
        stage('Octopus Create release') {
            steps {
                bat label: '', script: 'Octo.exe pack --id DockerAppDemo --version 1.0.0'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}