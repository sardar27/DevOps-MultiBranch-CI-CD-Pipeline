//Declarative Pipeline
pipeline {
    agent none
    environment {
        PROJECT = "WELCOME TO DEVOPS"
    }
    stages {
        stage('Deploy To Development') {
            agent { label 'DEV' }
            environment {
            DEVDEFAULTAMI = "ami-08fc1abadb05b6ecc"
            PACKER_ACTION = "NO" //YES or NO
            TERRAFORM_APPLY = "YES" //YES or NO
            TERRAFORM_DESTROY = "NO" //YES or NO
            ANSIBLE_ACTION = "NO" //YES or NO
            }
            when {
                branch 'development'
            }
            stages {
                stage('Perform Packer Build') {
                    when {
                        expression {
                            "${env.PACKER_ACTION}" == 'YES'
                        }
                    }
                    steps { //Assume Role in SreeMasterAccount AWS Account
                        withAWS(role:'DevOpsJenkinsAssumeRole', roleAccount:'764136601315', duration: 900, roleSessionName: 'jenkins-session') {
                            sh 'pwd'
                            sh 'rm -f prod-backend.tf'
                            sh 'ls -al'
                            sh 'packer build -var-file packer-vars-dev.json packer.json | tee output.txt'
                            sh "tail -2 output.txt | head -2 | awk 'match(\$0, /ami-.*/) { print substr(\$0, RSTART, RLENGTH) }' > ami.txt"
                            sh "echo \$(cat ami.txt) > ami.txt"
                            script {
                                def AMIID = readFile('ami.txt').trim()
                                sh 'echo "" >> variables.tf'
                                sh "echo variable \\\"imagename\\\" { default = \\\"$AMIID\\\" } >> variables.tf"
                            }
                        }
                    }
                }
                stage('No Packer Build') {
                    when {
                        expression {
                            "${env.PACKER_ACTION}" == 'NO'
                        }
                    }
                    steps {
                        sh 'pwd'
                        sh 'ls -al'
                        sh 'echo "" >> variables.tf'
                        sh "echo variable \\\"imagename\\\" { default = \\\"${env.DEVDEFAULTAMI}\\\" } >> variables.tf"
                    }
                }
                stage('Terraform Plan') {
                    when {
                        expression {
                            "${env.TERRAFORM_APPLY}" == 'YES'
                        }
                    }
                    steps {
                        withAWS(role:'DevOpsJenkinsAssumeRole', roleAccount:'764136601315', duration: 900, roleSessionName: 'jenkins-session') {
                            sh 'rm -rf .terraform'
                            sh 'rm -f prod-backend.tf'
                            sh 'terraform init'
                            sh 'terraform validate'
                            sh 'terraform plan --var-file dev-terraform.tfvars'
                        }
                    }
                }
                stage('Terraform Apply') {
                    when {
                        expression {
                            "${env.TERRAFORM_APPLY}" == 'YES'
                        }
                    }
                    steps {
                        withAWS(role:'DevOpsJenkinsAssumeRole', roleAccount:'764136601315', duration: 900, roleSessionName: 'jenkins-session') {
                            sh 'rm -rf .terraform'
                            sh 'terraform init'
                            sh 'terraform apply --var-file dev-terraform.tfvars --auto-approve'
                        }
                    }
                }
                stage('Validate Ansible Playbook & Dry Run') {
                    when {
                        expression {
                            "${env.ANSIBLE_ACTION}" == 'YES'
                        }
                    }
                    steps {
                        sh 'sleep 15'
                        sh 'ansible-playbook -i invfile docker-swarm.yml --syntax-check'
                        //Used withCredentials for dry-run as ansible plugin dont have --check option.
                        withCredentials([file(credentialsId: 'newkey', variable: 'ansiblepvtkey')]) {
                        sh "sudo cp \$ansiblepvtkey $WORKSPACE"
                        sh "ls -al"
                        sh "ansible-playbook -i invfile docker-swarm.yml -u ansibleadmin --private-key /newkey.pem --check"
                        }  
                    }
                }
                stage('Run Ansible Playbook') {
                    when {
                        expression {
                            "${env.ANSIBLE_ACTION}" == 'YES'
                        }
                    }
                    steps {
                        //sh 'ansible-playbook -i invfile docker-swarm.yml -u ansibleadmin --private-key=/home/jenkins/ansibleadminkey -vv'
                        ansiblePlaybook credentialsId: 'ansibleadmin', disableHostKeyChecking: true, installation: 'Ansible', inventory: 'invfile', playbook: 'docker-swarm.yml'  
                    }
                }
                stage('Terraform Destroy') {
                    when {
                        expression {
                            "${env.TERRAFORM_DESTROY}" == 'YES'
                        }
                    }
                    steps {
                        withAWS(role:'DevOpsJenkinsAssumeRole', roleAccount:'764136601315', duration: 900, roleSessionName: 'jenkins-session') {
                            sh 'rm -f prod-backend.tf'
                            sh 'terraform init -reconfigure'
                            sh 'terraform destroy --var-file prod-terraform.tfvars --auto-approve'
                        }
                    }
                }
            }
        }
        stage('Deploy To Production') {
            agent { label 'PROD' }
            environment {
            DEVDEFAULTAMI = "ami-082131272807d3a72"
            PACKER_ACTION = "NO" //YES or NO
            TERRAFORM_APPLY = "NO" //YES or NO
            TERRAFORM_DESTROY = "YES" //YES or NO
            ANSIBLE_ACTION = "NO" //YES or NO
            }
            when {
                branch 'production'
            }
            stages {
                stage('Perform Packer Build') {
                    when {
                        expression {
                            "${env.PACKER_ACTION}" == 'YES'
                        }
                    }
                    steps { //Assume Role in SreeMasterAccount AWS Account
                        withAWS(role:'DevOpsJenkinsAssumeRole', roleAccount:'178392090456', duration: 900, roleSessionName: 'jenkins-session') {
                            sh 'pwd'
                            sh 'rm -f prod-backend.tf'
                            sh 'ls -al'
                            sh 'packer build -var-file packer-vars-prod.json packer.json | tee output.txt'
                            sh "tail -2 output.txt | head -2 | awk 'match(\$0, /ami-.*/) { print substr(\$0, RSTART, RLENGTH) }' > ami.txt"
                            sh "echo \$(cat ami.txt) > ami.txt"
                            script {
                                def AMIID = readFile('ami.txt').trim()
                                sh 'echo "" >> variables.tf'
                                sh "echo variable \\\"imagename\\\" { default = \\\"$AMIID\\\" } >> variables.tf"
                            }
                        }
                    }
                }
                stage('No Packer Build') {
                    when {
                        expression {
                            "${env.PACKER_ACTION}" == 'NO'
                        }
                    }
                    steps {
                        sh 'pwd'
                        sh 'ls -al'
                        sh 'echo "" >> variables.tf'
                        sh "echo variable \\\"imagename\\\" { default = \\\"${env.DEVDEFAULTAMI}\\\" } >> variables.tf"
                    }
                }
                stage('Terraform Plan') {
                    when {
                        expression {
                            "${env.TERRAFORM_APPLY}" == 'YES'
                        }
                    }
                    steps {
                        withAWS(role:'DevOpsJenkinsAssumeRole', roleAccount:'178392090456', duration: 900, roleSessionName: 'jenkins-session') {
                            sh 'rm -rf .terraform'
                            sh 'rm -f dev-backend.tf'
                            sh 'terraform init'
                            sh 'terraform validate'
                            sh 'terraform plan --var-file prod-terraform.tfvars'
                        }
                    }
                }
                stage('Terraform Apply') {
                    when {
                        expression {
                            "${env.TERRAFORM_APPLY}" == 'YES'
                        }
                    }
                    steps {
                        withAWS(role:'DevOpsJenkinsAssumeRole', roleAccount:'178392090456', duration: 900, roleSessionName: 'jenkins-session') {
                            sh 'rm -rf .terraform'
                            sh 'terraform init'
                            sh 'terraform apply --var-file prod-terraform.tfvars --auto-approve'
                        }
                    }
                }
                stage('Validate Ansible Playbook & Dry Run') {
                    when {
                        expression {
                            "${env.ANSIBLE_ACTION}" == 'YES'
                        }
                    }
                    steps {
                        sh 'sleep 15'
                        sh 'ansible-playbook -i invfile docker-swarm.yml --syntax-check'
                        sh 'ansible-playbook -i invfile docker-swarm.yml -u ansibleadmin --private-key=/home/ubuntu/ansibleadminkey --check'
                          
                    }
                }
                stage('Run Ansible Playbook') {
                    when {
                        expression {
                            "${env.ANSIBLE_ACTION}" == 'YES'
                        }
                    }
                    steps {
                        //sh 'ansible-playbook -i invfile docker-swarm.yml -u ansibleadmin --private-key=/home/jenkins/ansibleadminkey -vv'
                        ansiblePlaybook credentialsId: 'ansibleadmin', disableHostKeyChecking: true, installation: 'Ansible', inventory: 'invfile', playbook: 'docker-swarm.yml'  
                    }
                }
                stage('Terraform Destroy') {
                    when {
                        expression {
                            "${env.TERRAFORM_DESTROY}" == 'YES'
                        }
                    }
                    steps {
                        withAWS(role:'DevOpsJenkinsAssumeRole', roleAccount:'178392090456', duration: 900, roleSessionName: 'jenkins-session') {
                            sh 'rm -f dev-backend.tf'
                            sh 'terraform init'
                            sh 'terraform destroy --var-file prod-terraform.tfvars --auto-approve'
                        }
                    }
                }
            }
        }


    }
}
