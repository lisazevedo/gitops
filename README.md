# GitOps & Infrastructure as Code for "Hello World"

This repository is a collection of projects demonstrating various approaches to deploying a simple "Hello World" Node.js application using Infrastructure as Code (IaC) and modern deployment practices on AWS.

## 🚀 Project Overview

The goal is to showcase an evolutionary path for application deployment, starting with a foundational setup and progressing towards more advanced, cloud-native architectures. Each project in this repository represents a step in that journey.

## 📂 Projects

This repository is structured as a monorepo containing distinct deployment projects.

### 1. `hello-world-node` (EC2 Deployment)

This is the foundational project. It demonstrates how to deploy a containerized Node.js application to a single EC2 instance.

*   **Infrastructure**: Provisioned using Terraform.
*   **Deployment Target**: AWS EC2 instance.
*   **Deployment Mechanism**: AWS Systems Manager (SSM) is used to send commands to the instance to pull and run the Docker container. This is a simple approach suitable for basic applications or initial setups.
*   **CI/CD**: An IAM role for GitHub Actions (using OIDC) is created, enabling a CI/CD pipeline to trigger deployments via SSM.

> **➡️ Go to the `hello-world-node` project README for detailed instructions.**

### 2. Fargate Deployment (Future Evolution)

The next planned project will deploy the same "Hello World" application to **AWS Fargate**. This represents an evolution towards a more robust, scalable, and managed container orchestration solution.

*   **Key Improvements**:
    *   **Serverless**: No EC2 instances to manage.
    *   **Scalability**: Easily scale containers up or down based on demand.
    *   **Enhanced CI/CD**: A more complete pipeline with stages for building, testing, and deploying to different environments.
    *   **Resilience**: Higher availability through managed services.

## 🛠️ Core Technologies

*   **Terraform**: For Infrastructure as Code.
*   **AWS**: EC2, VPC, IAM, SSM, and eventually Fargate & ECR.
*   **Docker**: For containerizing the application.
*   **LocalStack**: For local development and testing of AWS infrastructure.
*   **GitHub Actions**: For CI/CD and automation.

## 🏁 Local Development Environment

This repository includes a `docker-compose.yaml` file to easily spin up a LocalStack environment for local development and testing of the Terraform code without needing an actual AWS account.

To start the local environment, run:
```bash
docker-compose up -d
```