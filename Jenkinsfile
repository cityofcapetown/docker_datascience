#!/usr/bin/env groovy

def label = "docker-datascience-${UUID.randomUUID().toString()}"
podTemplate(label: label, yaml: """
    apiVersion: v1
    kind: Pod
    metadata:
        name: ${label}
        annotations:
            container.apparmor.security.beta.kubernetes.io/${label}: unconfined
    labels:
        app: ${label}
    spec:
      containers:
      - name: ${label}
        image: moby/buildkit:v0.9.2-rootless
        imagePullPolicy: IfNotPresent
        command:
        - cat
        tty: true
      nodeSelector:
        workload: batch
    """,
    slaveConnectTimeout: 3600
  ) {
    node(label) {
        stage('setup') {
            git url: 'https://ds1.capetown.gov.za/ds_gitlab/OPM/docker_datascience.git', branch: env.BRANCH_NAME
        }
        stage('base-image') {
            retry(10) {
                container(label) {
                    withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                     usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        sh '''
                        # guardrail to stop push to docker hub
                        PUSH=$([ $BRANCH_NAME == "master" ] && echo true || echo false)

                        ./bin/buildkit-docker.sh "${OPM_DATA_USER}" "${OPM_DATA_PASSWORD}" \\
                                                 "${DOCKER_USER}" "${DOCKER_PASS}" \\
                                                 "${PWD}/base" \\
                                                 "docker.io/cityofcapetown/datascience:base" \\
                                                 "${PUSH}"
                        sleep 60
                        '''
                    }
                    updateGitlabCommitStatus name: 'base', state: 'success'
                }
            }
        }
        stage('drivers-image') {
            retry(10) {
                container(label) {
                    withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                     usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        sh '''
                        # guardrail to stop push to docker hub
                        PUSH=$([ $BRANCH_NAME == "master" ] && echo true || echo false)

                        ./bin/buildkit-docker.sh "${OPM_DATA_USER}" "${OPM_DATA_PASSWORD}" \\
                                                 "${DOCKER_USER}" "${DOCKER_PASS}" \\
                                                 "${PWD}/base/drivers" \\
                                                 "docker.io/cityofcapetown/datascience:drivers" \\
                                                 "${PUSH}"
                        sleep 60
                        '''
                    }
                    updateGitlabCommitStatus name: 'drivers', state: 'success'
                }
            }
        }
        stage('python_minimal-image') {
            retry(10) {
                container(label) {
                    withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                     usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        sh '''
                        # guardrail to stop push to docker hub
                        PUSH=$([ $BRANCH_NAME == "master" ] && echo true || echo false)

                        ./bin/buildkit-docker.sh "${OPM_DATA_USER}" "${OPM_DATA_PASSWORD}" \\
                                                 "${DOCKER_USER}" "${DOCKER_PASS}" \\
                                                 "${PWD}/base/drivers/python_minimal" \\
                                                 "docker.io/cityofcapetown/datascience:python_minimal" \\
                                                 "${PUSH}"
                        sleep 60
                        '''
                    }
                    updateGitlabCommitStatus name: 'python_minimal', state: 'success'
                }
            }
        }
        stage('jupyter-ide-image') {
            retry(10){
                container(label) {
                    withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                     usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        sh '''
                        # guardrail to stop push to docker hub
                        # ToDo change to "master" after dev
                        PUSH=$([ $BRANCH_NAME == "wip/jupyter-ides" ] && echo true || echo false)

                        ./bin/buildkit-docker.sh "${OPM_DATA_USER}" "${OPM_DATA_PASSWORD}" \\
                                                 "${DOCKER_USER}" "${DOCKER_PASS}" \\
                                                 "${PWD}/base/drivers/python_minimal/jupyter-ide" \\
                                                 "docker.io/cityofcapetown/datascience:jupyter-ide" \\
                                                 "${PUSH}"
                        sleep 60
                        '''
                    }
                    updateGitlabCommitStatus name: 'jupyter-ide', state: 'success'
                }
            }
        }
        stage('python-image') {
            retry(10){
                container(label) {
                    withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                     usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        sh '''
                        # guardrail to stop push to docker hub
                        PUSH=$([ $BRANCH_NAME == "master" ] && echo true || echo false)

                        ./bin/buildkit-docker.sh "${OPM_DATA_USER}" "${OPM_DATA_PASSWORD}" \\
                                                 "${DOCKER_USER}" "${DOCKER_PASS}" \\
                                                 "${PWD}/base/drivers/python_minimal/python" \\
                                                 "docker.io/cityofcapetown/datascience:python" \\
                                                 "${PUSH}"
                        sleep 60
                        '''
                    }
                    updateGitlabCommitStatus name: 'python', state: 'success'
                }
            }
        }
        stage('jupyter-k8s-image') {
            retry(10){
                container(label) {
                    withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                     usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        sh '''
                        # guardrail to stop push to docker hub
                        PUSH=$([ $BRANCH_NAME == "master" ] && echo true || echo false)

                        ./bin/buildkit-docker.sh "${OPM_DATA_USER}" "${OPM_DATA_PASSWORD}" \\
                                                 "${DOCKER_USER}" "${DOCKER_PASS}" \\
                                                 "${PWD}/base/drivers/python_minimal/python/jupyter-k8s" \\
                                                 "docker.io/cityofcapetown/datascience:jupyter-k8s" \\
                                                 "${PUSH}"
                        sleep 60
                        '''
                    }
                    updateGitlabCommitStatus name: 'jupyter-k8s', state: 'success'
                }
            }
        }
    }
}