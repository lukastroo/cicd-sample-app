// De repo staat nu in Gitea op infra010 zelf. Bij een push roept Gitea via een webhook
// /git/notifyCommit aan, en dan pas kijkt Jenkins of er iets nieuws is.
// Lege spec = polling staat aan (nodig voor notifyCommit), maar zonder schema.
properties([pipelineTriggers([pollSCM('')])])

node {
    stage('Preparation') {
        // checkout zodat Jenkins weet welke repo hij moet pollen
        checkout scm
        catchError(buildResult: 'SUCCESS') {
            sh 'docker stop samplerunning'
            sh 'docker rm samplerunning'
        }
    }
    stage('Build') {
        build 'BuildSampleApp'
    }
    stage('Results') {
        build 'TestSampleApp'
    }
}
