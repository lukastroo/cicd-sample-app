// GitHub kan infra010 (172.16.0.10, host-only netwerk) niet bereiken voor een webhook,
// dus Jenkins kijkt zelf om de 2 minuten of er nieuwe commits op main zijn
properties([pipelineTriggers([pollSCM('H/2 * * * *')])])

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
