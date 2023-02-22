##Make sure following plugins are installed
0. Create a user ansibleadmin in the jenkins and generate public and private. Replace key contents with your own key in my case Laptopkey
1. AWS Steps
2. Blue Ocean
3. You need GitHub Token
4. sudo apt update && sudo apt install software-properties-common -y && sudo add-apt-repository --yes --update ppa:ansible/ansible && sudo apt install ansible -y && ansible --version
5. Terraform
6. Packer
7. Docker

##If you are updating the Worker or Master Count, following chanages needed.
0. Make sure you have changed PACKER_ACTION to NO before pushing the code to remote repo.
1. Add the additional worker or master in the ec2.tf.
2. Update details.tpl file and update docker_servers group and as well as docker_managers or docker_workers.
4. Update localfile.tf depending on master or worker.
5. Update the PRODEFAULTAMI & DEVDEFAULTAMI as AMI is already created.

#For Destroying The Environment
1. Create a new branch dev-destroy or prod-destroy.
2. Change PACKER, TERRAFORM_APPLY & ANSIBLE_ACTION to NO and Change TERRAFORM_DESTROY to YES.
3. Update when expression for branch to dev-destroy or prod-destroy commit.
4. Push to remote repo and pipeline will run and perform destroy.