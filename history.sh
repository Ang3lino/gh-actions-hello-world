# Docker Setup
# ------------------------------------------------------------------------

brew install pipreqs
pipreqs app/  
docker images

# Remove a Docker image (uncomment the following line to remove an image)
# docker rmi <image_id>

alias d='docker'
CONT_NAME="hello-actions"
d build -t $CONT_NAME .
d run -p 8080:8080 $CONT_NAME

# AWS Setup on macOS
# ------------------------------------------------------------------------

curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"  # Download AWS CLI installer
sudo installer -pkg AWSCLIV2.pkg -target /  # Install AWS CLI
aws configure


# Terraform Setup
# ------------------------------------------------------------------------

alias t="terraform"
t init
t plan

# AWS ECR (Elastic Container Registry) Setup
# ------------------------------------------------------------------------

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 343218182633.dkr.ecr.us-east-1.amazonaws.com
docker build -t hello-actions-ecr-repo . --platform=linux/amd64
docker tag hello-actions-ecr-repo:latest 343218182633.dkr.ecr.us-east-1.amazonaws.com/hello-actions-ecr-repo:latest
docker push 343218182633.dkr.ecr.us-east-1.amazonaws.com/hello-actions-ecr-repo:latest

# Clean Up and Destroy Resources
# ------------------------------------------------------------------------

# Delete all images from the ECR repository
aws ecr list-images --repository-name hello-actions-ecr-repo --query "imageIds[].imageDigest" --output text \
  | tr '\t' '\n' \
  | while read imageDigest; do
      aws ecr batch-delete-image --repository-name hello-actions-ecr-repo --image-ids imageDigest=$imageDigest
    done

terraform destroy -auto-approve
./deploy.sh


# ECS (Elastic Container Service) Service Update
# ------------------------------------------------------------------------

CLUSTER_NAME='hello-actions-cluster'
SERVICE_NAME='cc-hello-actions-service'
# Force new deployment for the ECS service
aws ecs update-service --cluster $CLUSTER_NAME --service $SERVICE_NAME --force-new-deployment


# Verify ECR Images
# ------------------------------------------------------------------------
ECR_REPO_NAME='hello-actions-ecr-repo'
aws ecr describe-images --repository-name $ECR_REPO_NAME
