
#!/bin/bash


# Default Variables (Can be overridden by arguments)
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="343218182633"
ECR_REPO_NAME="hello-actions-ecr-repo"
DOCKER_IMAGE_TAG="latest"
DOCKERFILE_PATH="." # Adjust if Dockerfile is in a different directory


# Error Handling Function
function check_error() {
    local exit_code=$1
    local action=$2

    if [[ $exit_code -ne 0 ]]; then
        echo "Error: Failed to $action."
        exit 1
    fi
}

# Functions
function docker_login() {
    local aws_region=$1
    local account_id=$2

    echo "Logging in to AWS ECR in region $aws_region..."
    aws ecr get-login-password --region "$aws_region" | docker login --username AWS --password-stdin "${account_id}.dkr.ecr.${aws_region}.amazonaws.com"
    check_error $? "log in to AWS ECR"
}

function build_docker_image() {
    local image_name=$1
    local dockerfile_path=$2

    echo "Building Docker image: $image_name..."
    docker build -t "$image_name" "$dockerfile_path" --platform=linux/amd64
    check_error $? "build Docker image"
}

function tag_docker_image() {
    local image_name=$1
    local repo_uri=$2

    echo "Tagging Docker image: $image_name as $repo_uri..."
    docker tag "$image_name" "$repo_uri"
    check_error $? "tag Docker image"
}

function push_docker_image() {
    local repo_uri=$1

    echo "Pushing Docker image to AWS ECR: $repo_uri..."
    docker push "$repo_uri"
    check_error $? "push Docker image to AWS ECR"
}


# Script Execution
ECR_REPO_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${DOCKER_IMAGE_TAG}"

# docker_login "$AWS_REGION" "$AWS_ACCOUNT_ID" # for local dev
build_docker_image "${ECR_REPO_NAME}:${DOCKER_IMAGE_TAG}" "$DOCKERFILE_PATH"
tag_docker_image "${ECR_REPO_NAME}:${DOCKER_IMAGE_TAG}" "$ECR_REPO_URI"
push_docker_image "$ECR_REPO_URI"

echo "Docker image pushed successfully to: ${ECR_REPO_URI}"
