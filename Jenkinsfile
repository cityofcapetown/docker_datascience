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
    """,
    slaveConnectTimeout: 3600
  ) {
    node(POD_LABEL) {
        stage('base-image') {
            container('docker-buildkit') {
                git 'https://ds1.capetown.gov.za/ds_gitlab/OPM/db-utils.git'

                container('cct-datascience-python') {
                    sh '''
                    ./buildctl-daemonless.sh build --frontend dockerfile.v0 \\
                                                   --local context=/home/jenkins/agent \\
                                                   --local dockerfile=/home/jenkins/agent
                    '''
                }
                updateGitlabCommitStatus name: 'base', state: 'success'
            }
        }
    }
}