Hello Everyone !

That is a Terraform project with includes python simple "Hello World".

-In order for you to make it work you need to specify manually inbound rule for Jenkins on port 8080,
 also you will need to install Jenkins
 https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-20-04
 and K8s cluster
 https://www.server-world.info/en/note?os=Ubuntu_20.04&p=minikube&f=2


- The scrennshots of the kubectl get nodes -o wide and ‘kubectl get service -o wide are in the images folder

-This is the link to the image inside the docker registery
https://hub.docker.com/repository/docker/berezovsky8/python

And do not forget to use these commands for terraform:

-terraform init

-terraform plan

-terraform apply

***Please don't forget to Disassociate the Elastic IP in order to make the enviorment private***
