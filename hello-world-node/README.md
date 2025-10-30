# Hello World Node.js on EC2 with Terraform and SSM

This repository contains the infrastructure as code (IaC) for deploying a simple "Hello World" Node.js application onto an AWS EC2 instance. The deployment leverages Terraform for provisioning AWS resources and AWS Systems Manager (SSM) for remote command execution and application deployment.

This project serves as a foundational step, demonstrating a basic containerized application deployment on EC2. A future evolution of this project will involve deploying the same application to AWS Fargate with a more complete CI/CD pipeline.

## 🚀 Project Overview

The goal of this project is to:
*   Provision the necessary AWS infrastructure (VPC, subnets, EC2 instance, IAM roles) using Terraform.
*   Set up the EC2 instance with Docker and Docker Compose.
*   Enable remote management and deployment to the EC2 instance via AWS SSM.
*   Provide a basic setup for a Node.js application to run as a Docker container on the EC2 instance.

## ⚙️ Architecture

The infrastructure deployed by this project includes:

*   **VPC**: A dedicated Virtual Private Cloud for network isolation.
*   **Subnets**: Public and private subnets within the VPC. The EC2 instance resides in the public subnet.
*   **Internet Gateway**: Allows communication between the VPC and the internet.
*   **Route Table**: Configured for public internet access.
*   **Security Group**: Controls inbound and outbound traffic to the EC2 instance.
*   **EC2 Instance**: The virtual server where the Node.js application will run. The `initial_config.sh` script is executed as user data to install Docker and Docker Compose.
*   **IAM Roles**:
    *   `ec2_ssm_role`: Attached to the EC2 instance, granting it permissions to communicate with AWS SSM. This allows for remote management and command execution.
    *   `github_actions_role`: An OIDC-federated role for GitHub Actions, allowing it to assume this role and perform actions like sending SSM commands to the EC2 instance for application deployment.

The Node.js application itself is expected to be containerized (e.g., using Docker) and deployed to the EC2 instance.

## 🛠️ Technologies Used

*   **Terraform**: For infrastructure provisioning and management.
*   **AWS EC2**: Virtual servers for hosting the application.
*   **AWS Systems Manager (SSM)**: For remote instance management and command execution, facilitating application deployment.
*   **AWS IAM**: Identity and Access Management for secure access control.
*   **Docker & Docker Compose**: For containerizing and orchestrating the Node.js application on the EC2 instance.
*   **GitHub Actions (OIDC)**: (Implicitly configured via IAM) For potential CI/CD integration to automate application deployment via SSM.
*   **LocalStack**: For local development and testing of AWS resources without incurring cloud costs.

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

*   **Terraform CLI**
*   **AWS CLI** (configured with appropriate credentials if deploying to actual AWS)
*   **Docker** (for local development/testing)
*   A GitHub repository for your Node.js application and this infrastructure code.

### Local Development with LocalStack

This project is configured to work with LocalStack for local development and testing without incurring AWS costs.

1.  **Start LocalStack**:
    Navigate to the root of your `gitops` directory and start the LocalStack container:
    ```bash
    docker-compose up -d localstack
    ```
    This will start the LocalStack container, exposing AWS services on `localhost:4566`.

2.  **Configure Terraform for LocalStack**:
    The `terraform.tfvars` file in this directory sets `is_local = true`, which automatically configures the AWS provider to use LocalStack endpoints.

### Deployment Steps

1.  **Clone the Repository**:
    If you haven't already, clone this repository:
    ```bash
    git clone <your-repo-url>
    cd hello-world-node
    ```

2.  **Initialize Terraform**:
    ```bash
    terraform init
    ```

3.  **Review and Plan Changes**:
    Before applying, review the planned infrastructure changes. You'll need to provide your GitHub organization and repository names for the OIDC role.
    ```bash
    terraform plan -var="github_org=<your-github-org>" -var="github_repo=<your-github-repo>"
    ```
    Replace `<your-github-org>` and `<your-github-repo>` with your actual GitHub organization and repository names.

4.  **Apply Terraform Configuration**:
    ```bash
    terraform apply -var="github_org=<your-github-org>" -var="github_repo=<your-github-repo>"
    ```
    Type `yes` when prompted to confirm the deployment.

    This command will provision:
    *   A VPC and all necessary networking components (subnets, internet gateway, route table, security group).
    *   An EC2 instance configured with the `ec2_ssm_role`.
    *   The `initial_config.sh` script will run on the EC2 instance upon launch, installing Docker and Docker Compose.
    *   IAM roles for EC2 SSM and GitHub Actions OIDC.

5.  **Deploying the Node.js Application**:
    Once the EC2 instance is provisioned and `initial_config.sh` has completed (installing Docker/Docker Compose), you would typically use AWS SSM to deploy your Node.js application. This usually involves:
    *   Building your Node.js application's Docker image.
    *   Pushing the image to a container registry (e.g., AWS ECR).
    *   Using an SSM `SendCommand` (e.g., triggered by a GitHub Actions workflow) to pull the Docker image and run it on the EC2 instance. This could involve executing a `docker run` command or a `docker-compose up -d` command if you have a `docker-compose.yaml` for your application.

    The `aws_iam_policy.github_actions_policy` in `iam.tf` already grants the necessary `ssm:SendCommand` and `ssm:GetCommandInvocation` permissions, which aligns with this deployment strategy.

    *Example of a conceptual GitHub Actions workflow step (not included in this repository):*
    ```yaml
    - name: Deploy application via SSM
      # Assuming you have a step to get the EC2 instance ID, e.g., from Terraform outputs
      run: |
        # Replace with actual instance ID or a dynamic lookup
        INSTANCE_ID=$(terraform output -raw ec2_instance_id) 
        aws ssm send-command \
          --instance-ids "$INSTANCE_ID" \
          --document-name "AWS-RunShellScript" \
          --comment "Deploy Node.js app" \
          --parameters '{"commands":["cd /path/to/your/app && docker-compose pull && docker-compose up -d"]}' \
          --output text
    ```

### Cleanup

To destroy all the AWS resources provisioned by this Terraform configuration:

```bash
terraform destroy -var="github_org=<your-github-org>" -var="github_repo=<your-github-repo>"
```
Type `yes` when prompted to confirm the destruction.

## ⏭️ Next Steps / Future Evolution

This project successfully lays the groundwork for deploying a containerized application to an EC2 instance using IaC and SSM for deployment. The next phase of development will focus on evolving this deployment to a more robust, scalable, and cloud-native solution using AWS Fargate. This will involve integrating a more comprehensive CI/CD pipeline for automated deployments, rollbacks, and advanced monitoring, moving towards a fully managed container orchestration approach.