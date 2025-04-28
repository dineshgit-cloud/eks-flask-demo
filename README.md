# Hello World Kubernetes Deployment — Infrastructure + Automation

This project sets up a production-grade CI/CD pipeline using GitHub Actions-selfhosted runner to manage: Terraform Infrastructure (EKS cluster, ECR repo), Docker Build and Push to Amazon ECR, Security Scanning with Trivy, Deployment to Kubernetes (EKS) using Helm.

##Project Structure
.
.github/workflows/ci-cd.yml   # GitHub Actions workflow file
flask-app/                    # Simple Flask app source code
helm/hello-world/             # Helm chart for Kubernetes deployment
hello-world-sa.yaml           # ServiceAccount IAM role binding
infra/                        # Terraform Infrastructure Code
  main.tf
  variables.tf
   outputs.tf
   provider.tf
   backend.tf
README.md                     # This file

## Prerequites 
###Prepare the github action with Self-hoster runner by creating AWS EC2 Amazon linux instance 

- Login to AWS Console
- Go to EC2 > Instances > Launch Instance
- Select Amazon Linux 2 AMI
- Choose an instance type: t2.micro
- Configure:
- Allow inbound ports 22 (SSH) from your IP.
- Allow HTTPS (443) and HTTP (80) if you need Docker, Git access.
- Attach an IAM Role with permissions like AmazonEC2FullAccess, AmazonECRReadOnly, EKS Access.
- Create/Select a Key Pair for SSH access.
Launch the instance.
### Install Required Packages in the EC2 runner instance 
Update system and install essential tools:
```bash 
   sudo yum update -y
   curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
   curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin
   sudo yum install -y git curl wget unzip gcc-c++ make nodejs git docker --allowerasing
   sudo systemctl start docker
   sudo systemctl enable docker
   sudo usermod -aG docker ec2-user
   newgrp docker
   sudo chmod 666 /var/run/docker.sock
   trivy --version
```
### Install GitHub Runner in EC runner instance 
### Register the Runner with GitHub
1. Get GitHub Registration Token -> Go to your GitHub repository -> Settings → Actions → Runners → New self-hosted runner → Linux -> Follow the steps givn in that window. Ensure to Start the Runner as a Service. 
2. Confirm Runner is Active. GitHub repository → Settings → Actions → Runners. You should see the new runner listed as Idle and Ready.

### Now lets initate the EKS cluster provisioning and deploy application 

1. Download this repo "Eks-flask-demo" in your local and push dummy commit to trigger the github action deployment.
2. Go to Actions tab and select the workflow to monitor the build section and deploy section
3. Get the external IP or DNS of the load balancer from the EC-runner using below command
```bash
kubectl get svc hello-world-service
``` 
4. The EXTERNAL-IP column will show the URL or IP. Access your app via: http://<EXTERNAL-IP>
5. For quick local testing
```bash 
kubectl port-forward svc/hello-world-service 8080:80
```
Then access your app at: http://localhost:8080
