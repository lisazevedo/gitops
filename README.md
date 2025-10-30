# GitOps & Infrastructure as Code for "Hello World"

This repository is a collection of projects demonstrating various approaches to deploying a simple "Hello World" Node.js application using Infrastructure as Code (IaC) and modern deployment practices on AWS.

## 🚀 Project Overview
The primary goal of this project is to demonstrate a modern DevOps workflow where the application's desired state in the cluster is declaratively defined and version-controlled in Git. A GitOps operator (like Argo CD or Flux) running in the cluster automatically syncs the state defined in this repository.

## Repositories
This project is split into two distinct repositories:

- Application Repository ([hello-world-node](https://github.com/lisazevedo/hello-world-node)): Contains the source code for a basic web server built with Node.js and Express. It is containerized using a Dockerfile.

- GitOps Repository (this-repo): Contains all the Kubernetes YAML manifests (Deployment, Service, etc.) required to run the application. Changes to the application's deployment (e.g., updating the image tag) are made here via pull requests.

## ⚙️ How It Works
The Node.js application code is pushed to its own repository.

A CI pipeline (e.g., GitHub Actions) builds a Docker image and pushes it to a container registry.

A developer creates a pull request in this repository to update the Kubernetes Deployment manifest with the new image tag.

Once the PR is merged, the GitOps tool detects the change in the main branch.

The GitOps tool automatically applies the new manifest to the Kubernetes cluster, updating the application to the new version.