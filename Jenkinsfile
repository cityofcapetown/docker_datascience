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
    """,
    slaveConnectTimeout: 3600
  ) {
    node(label) {
        stage('setup') {
            git 'https://ds1.capetown.gov.za/ds_gitlab/OPM/docker_datascience.git'
        }
        stage('base-image') {
            container(label) {
                withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                 usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh '''
                    ./bin/buildkit-docker.sh ${OPM_DATA_USER} ${OPM_DATA_PASSWORD} \\
                                             ${DOCKER_USER} ${DOCKER_PASS} \\
                                             "${PWD}/base" \\
                                             "docker.io/cityofcapetown/datascience:base"
                    '''
                }
                updateGitlabCommitStatus name: 'base', state: 'success'
            }
        }
        stage('drivers-image') {
            container(label) {
                withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                 usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh '''
                    ./bin/buildkit-docker.sh ${OPM_DATA_USER} ${OPM_DATA_PASSWORD} \\
                                             ${DOCKER_USER} ${DOCKER_PASS} \\
                                             "${PWD}/base/drivers" \\
                                             "docker.io/cityofcapetown/datascience:drivers"
                    '''
                }
                updateGitlabCommitStatus name: 'drivers', state: 'success'
            }
        }
        stage('python_minimal-image') {
            container(label) {
                withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                 usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh '''
                    ./bin/buildkit-docker.sh ${OPM_DATA_USER} ${OPM_DATA_PASSWORD} \\
                                             ${DOCKER_USER} ${DOCKER_PASS} \\
                                             "${PWD}/base/drivers/python_minimal" \\
                                             "docker.io/cityofcapetown/datascience:python_minimal"
                    '''
                }
                updateGitlabCommitStatus name: 'python_minimal', state: 'success'
            }
        }
        stage('python-image') {
            container(label) {
                withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                 usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh '''
                    ./bin/buildkit-docker.sh ${OPM_DATA_USER} ${OPM_DATA_PASSWORD} \\
                                             ${DOCKER_USER} ${DOCKER_PASS} \\
                                             "${PWD}/base/drivers/python_minimal/python" \\
                                             "docker.io/cityofcapetown/datascience:python"
                    '''
                }
                updateGitlabCommitStatus name: 'python', state: 'success'
            }
        }
        stage('jupyter-k8s-image') {
            container(label) {
                withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                 usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh '''
                    ./bin/buildkit-docker.sh ${OPM_DATA_USER} ${OPM_DATA_PASSWORD} \\
                                             ${DOCKER_USER} ${DOCKER_PASS} \\
                                             "${PWD}/base/drivers/python_minimal/python/jupyter-k8s" \\
                                             "docker.io/cityofcapetown/datascience:jupyter-k8s"
                    '''
                }
                updateGitlabCommitStatus name: 'jupyter-k8s', state: 'success'
            }
        }
    }
}