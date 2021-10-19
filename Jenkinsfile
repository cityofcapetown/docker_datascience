podTemplate(yaml: """
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: docker-buildkit
        image: moby/buildkit:master-rootless
        imagePullPolicy: IfNotPresent
        command:
        - cat
        tty: true
        securityContext:
          privileged: true
    """,
    slaveConnectTimeout: 3600
  ) {
    node(POD_LABEL) {
        stage('setup') {
            git 'https://ds1.capetown.gov.za/ds_gitlab/OPM/docker_datascience.git'
        }
        stage('base-image') {
            container('docker-buildkit') {
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
            container('docker-buildkit') {
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
            container('docker-buildkit') {
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
            container('docker-buildkit') {
                withCredentials([usernamePassword(credentialsId: 'opm-data-proxy-user', passwordVariable: 'OPM_DATA_PASSWORD', usernameVariable: 'OPM_DATA_USER'),
                                 usernamePassword(credentialsId: 'docker-user', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh '''
                    ./bin/buildkit-docker.sh ${OPM_DATA_USER} ${OPM_DATA_PASSWORD} \\
                                             ${DOCKER_USER} ${DOCKER_PASS} \\
                                             "${PWD}/base/drivers/python_minimal/python" \\
                                             "docker.io/cityofcapetown/datascience:python"
                    '''
                }
                updateGitlabCommitStatus name: 'python_minimal', state: 'success'
            }
        }
    }
}