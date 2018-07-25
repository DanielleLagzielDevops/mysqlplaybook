#!groovy

pipeline {

	stage('Deploy') {

        	withEnv(["PATH+ANSIBLE=${tool '2.4.2.0'}"]) {

      		sh 'echo $PATH'
        	sh 'ls -l'
        	sh 'ansible --version'
        	sh 'which ansible'

        	ansiblePlaybook(
                	inventory: '${WORKSPACE}/inventory/hosts',
			credentialsId: 'ssh-jenkins',
                	limit: '${HOSTS}',
			installation: ansible,
                	playbook: '/etc/ansible/playbook/MySqlCluster',
                	colorized: true,
			sudo: true,
			sudoUser: 'jenkins',
                	extras: -vvv
        		)
    		}
	}
}
