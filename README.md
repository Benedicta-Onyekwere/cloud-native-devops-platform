# Cloud Native DevOps Platform

A production-inspired **multi-cloud cloud-native DevOps platform** demonstrating containerization, Kubernetes orchestration, Infrastructure as Code, CI/CD automation, cloud IAM, persistent storage, observability, configuration management, and deployment across **Microsoft Azure and Amazon Web Services (AWS)**.

The project evolved from an Azure Kubernetes deployment into a broader multi-cloud DevOps platform. An existing **Azure Kubernetes Service (AKS)** environment was retained as the Azure deployment target, while **Terraform was used to provision the AWS infrastructure**, including an Amazon Elastic Kubernetes Service (EKS) environment.

The platform uses a Flask-based auction application as the workload and PostgreSQL as its persistent database. The application is containerized with Docker, deployed through Kubernetes, automated through GitHub Actions, monitored with Prometheus and Grafana, and backed by persistent Kubernetes storage on AWS.

---

## Table of Contents

* [Project Overview](#project-overview)
* [Project Objectives](#project-objectives)
* [Architecture](#architecture)
* [Multi-Cloud Strategy](#multi-cloud-strategy)
* [Technology Stack](#technology-stack)
* [Application](#application)
* [Containerization](#containerization)
* [Kubernetes Architecture](#kubernetes-architecture)
* [Azure Deployment](#azure-deployment)
* [AWS Deployment](#aws-deployment)
* [Terraform and Infrastructure as Code](#terraform-and-infrastructure-as-code)
* [AWS Networking and Infrastructure](#aws-networking-and-infrastructure)
* [IAM and Security](#iam-and-security)
* [GitHub Actions CI/CD](#github-actions-cicd)
* [GitHub Actions OIDC](#github-actions-oidc)
* [Docker Hub](#docker-hub)
* [PostgreSQL](#postgresql)
* [Persistent Storage](#persistent-storage)
* [Prometheus Monitoring](#prometheus-monitoring)
* [Grafana](#grafana)
* [Ansible](#ansible)
* [Deployment Verification](#deployment-verification)
* [Persistent Storage Verification](#persistent-storage-verification)
* [Troubleshooting and Engineering Decisions](#troubleshooting-and-engineering-decisions)
* [Cost Management and AWS Teardown](#cost-management-and-aws-teardown)
* [Repository Structure](#repository-structure)
* [Evidence and Documentation](#evidence-and-documentation)
* [DevOps Skills Demonstrated](#devops-skills-demonstrated)
* [Lessons Learned](#lessons-learned)
* [Future Improvements](#future-improvements)
* [Conclusion](#conclusion)

---

# Project Overview

The **Cloud Native DevOps Platform** was created as a practical DevOps engineering project to demonstrate how a containerized application can be developed, packaged, deployed, automated, monitored, and managed using modern cloud-native technologies.

Rather than focusing only on application development, the project focuses on the complete operational lifecycle:

```text
Application
     ↓
Containerization
     ↓
Docker Image
     ↓
Docker Hub
     ↓
GitHub
     ↓
GitHub Actions
     ↓
Cloud Infrastructure
     ↓
Kubernetes
     ↓
Application + PostgreSQL
     ↓
Persistent Storage
     ↓
Prometheus
     ↓
Grafana
```

The project was subsequently extended into a **multi-cloud architecture**, using Azure and AWS as two separate cloud environments.

---

# Project Objectives

The main objectives of the project were to demonstrate practical experience with:

* Cloud infrastructure
* Multi-cloud architecture
* Docker containerization
* Kubernetes orchestration
* Amazon EKS
* Azure AKS
* Infrastructure as Code
* Terraform
* Ansible
* GitHub Actions
* CI/CD automation
* Docker Hub
* IAM and cloud security
* GitHub Actions OIDC authentication
* Kubernetes Secrets and ConfigMaps
* PostgreSQL
* Kubernetes StatefulSets
* PersistentVolumeClaims
* PersistentVolumes
* AWS EBS storage
* Prometheus
* Grafana
* Application and infrastructure monitoring
* Deployment verification
* Troubleshooting
* Cloud resource lifecycle management
* Cost-conscious cloud operations

The project was also designed to reinforce practical DevOps concepts such as:

* Stateless versus stateful workloads
* Kubernetes Services
* Rolling deployments
* Replica management
* Persistent storage
* Secure credential handling
* Infrastructure automation
* CI/CD
* Observability
* Cloud IAM
* Failure/recovery testing

---

# Architecture

The final platform consists of two cloud environments.

```text
                         ┌──────────────────────┐
                         │       GitHub         │
                         │ Source Code + CI/CD  │
                         └──────────┬───────────┘
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │   GitHub Actions     │
                         │ Build / Test / Deploy │
                         └──────────┬───────────┘
                                    │
                       ┌────────────┴────────────┐
                       │                         │
                       ▼                         ▼
                ┌──────────────┐          ┌──────────────┐
                │    Azure     │          │     AWS      │
                │     AKS      │          │     EKS      │
                └──────┬───────┘          └──────┬───────┘
                       │                         │
                 ┌─────┴─────┐             ┌────┴────────┐
                 │           │             │             │
                 ▼           ▼             ▼             ▼
              Auction    PostgreSQL     Auction      PostgreSQL
                 │           │             │             │
                 │           │             │          EBS/PV/PVC
                 │           │             │
                 └─────┬─────┘             └─────┬───────┘
                       │                           │
                       ▼                           ▼
                 Prometheus                 Prometheus
                       │                           │
                       ▼                           ▼
                    Grafana                    Grafana
```

The architecture separates:

* Application workloads
* Database workloads
* Infrastructure
* CI/CD
* Storage
* Monitoring
* Security

---

# Multi-Cloud Strategy

The project demonstrates a practical rather than artificial multi-cloud design.

## Azure

Azure was the initial cloud environment.

An existing Azure Kubernetes Service cluster was used as the Azure deployment environment:

```text
Azure
└── cloud-native-devops-rg
    └── cloud-native-devops-aks
        └── Kubernetes workloads
            ├── Auction Application
            ├── PostgreSQL
            └── Monitoring
```

The existing AKS environment was deliberately retained rather than recreated with Terraform.

This was an engineering decision intended to avoid unnecessarily modifying or replacing an already functioning Kubernetes environment.

## AWS

AWS was subsequently introduced as the second cloud environment.

Terraform was used for the AWS infrastructure and an EKS cluster was created:

```text
AWS
└── Terraform-managed infrastructure
    ├── Networking
    ├── IAM
    ├── EKS
    ├── Worker Nodes
    └── Supporting infrastructure
        │
        └── Kubernetes
            ├── Auction Application
            ├── PostgreSQL
            ├── EBS Storage
            └── Monitoring
```

This approach demonstrates that a multi-cloud architecture does not require every resource in every cloud to be managed identically.

Instead:

* Azure demonstrates AKS/Kubernetes
* AWS demonstrates Terraform + EKS
* GitHub provides the central source-control and CI/CD layer
* Kubernetes provides a consistent application orchestration model
* Prometheus/Grafana provide observability
* Docker provides consistent application packaging

---

# Technology Stack

| Category                 | Technologies                                        |
| ------------------------ | --------------------------------------------------- |
| Application              | Python, Flask                                       |
| Containerization         | Docker, Docker Compose                              |
| Container Registry       | Docker Hub                                          |
| Orchestration            | Kubernetes                                          |
| Azure                    | Azure Kubernetes Service (AKS)                      |
| AWS                      | Amazon EKS                                          |
| Infrastructure as Code   | Terraform                                           |
| Configuration Automation | Ansible                                             |
| CI/CD                    | GitHub Actions                                      |
| Cloud Authentication     | GitHub Actions OIDC                                 |
| Database                 | PostgreSQL 16                                       |
| Persistent Storage       | Kubernetes PVC/PV, AWS EBS                          |
| Monitoring               | Prometheus                                          |
| Visualization            | Grafana                                             |
| Cloud IAM                | AWS IAM                                             |
| Source Control           | Git/GitHub                                          |
| Networking               | Kubernetes Services, AWS Load Balancer, VPC/Subnets |

---

# Application

The workload used for the project is a lightweight Flask-based auction application.

The application exposes HTTP endpoints that allow Kubernetes and external clients to interact with the service.

A simplified application structure includes:

```text
app/
├── app.py
├── requirements.txt
└── Dockerfile
```

The application includes a root endpoint and a health endpoint.

The health endpoint is particularly important from a DevOps perspective because application health should be observable by the infrastructure running it.

For example:

```text
/
```

provides the application response, while:

```text
/health
```

provides an application health indication.

The application listens on:

```text
Port 5000
```

and is configured to listen on:

```text
0.0.0.0
```

so that it can receive traffic from outside the container.

---

# Containerization

Docker was used to package the Flask application into a portable container image.

The containerization process follows:

```text
Python Application
       ↓
requirements.txt
       ↓
Dockerfile
       ↓
Docker Build
       ↓
Docker Image
       ↓
Docker Hub
       ↓
Kubernetes
```

The Docker image used for the AWS deployment was:

```text
bennieo/cloud-native-auction-app:latest
```

This demonstrates separation between:

* Application development
* Image creation
* Image distribution
* Runtime deployment

Docker Compose was also used during the development stage to work with the application and supporting services locally.

---

# Kubernetes Architecture

Kubernetes is the central orchestration layer of the project.

The AWS environment ultimately contained:

```text
Kubernetes Cluster
│
├── Auction Application Deployment
│   ├── Replica 1
│   └── Replica 2
│
├── Auction Service
│   └── LoadBalancer
│
├── PostgreSQL StatefulSet
│   └── postgres-0
│
├── PostgreSQL Service
│   └── ClusterIP
│
├── ConfigMaps
│
├── Secrets
│
└── Persistent Storage
    ├── PVC
    └── PV
```

---

# Application Deployment

The application was deployed as a Kubernetes Deployment with two replicas.

The final AWS deployment showed:

```text
auction-app-59db979f78-c79gb
auction-app-59db979f78-rzpz2
```

Both replicas were running:

```text
READY   STATUS
1/1     Running
1/1     Running
```

The replicas were scheduled across two worker nodes:

```text
ip-10-20-37-240.ec2.internal
ip-10-20-48-55.ec2.internal
```

This demonstrated basic workload distribution and improved availability compared with running a single application pod.

The Deployment used the Kubernetes `RollingUpdate` strategy.

---

# Kubernetes Services

Two important Services were used.

## Auction Service

The application was exposed through a Kubernetes `LoadBalancer` Service:

```text
auction-service
```

The Service exposed:

```text
80:30574/TCP
```

AWS provisioned an external load balancer for the Kubernetes Service.

This allowed the application to be accessed externally rather than only from inside the Kubernetes cluster.

## PostgreSQL Service

PostgreSQL was exposed internally using a:

```text
ClusterIP
```

Service:

```text
postgres
```

on:

```text
5432
```

This meant the database was accessible to workloads inside the Kubernetes cluster without being directly exposed to the public internet.

---

# PostgreSQL

PostgreSQL 16 was used as the persistent database.

The database configuration was:

```text
Database: auctiondb
User:     auctionuser
Port:     5432
```

The PostgreSQL workload was implemented as a Kubernetes `StatefulSet` rather than a normal Deployment.

This was important because PostgreSQL is a **stateful workload** and requires persistent storage.

The StatefulSet created:

```text
postgres-0
```

and mounted persistent storage at:

```text
/var/lib/postgresql/data
```

The PostgreSQL password was stored in a Kubernetes Secret rather than being directly embedded in the application configuration.

---

# Kubernetes Secrets and ConfigMaps

Sensitive credentials were separated from application configuration.

The PostgreSQL deployment used:

```text
postgres-secret
```

to store the PostgreSQL password.

The application consumed database credentials through a separate Kubernetes Secret:

```text
postgres-credentials
```

containing:

```text
DB_USER
DB_PASSWORD
```

The database username was configured as:

```text
auctionuser
```

This allowed the application and database to use consistent credentials while avoiding hard-coding the password directly into the application Deployment.

Non-sensitive application configuration was handled through a Kubernetes ConfigMap:

```text
auction-config
```

This demonstrates the separation of:

* Configuration
* Credentials
* Application code

---

# Azure Deployment

The Azure environment provided the first Kubernetes deployment target.

The existing infrastructure included:

```text
Azure
└── cloud-native-devops-rg
    └── cloud-native-devops-aks
```

The AKS environment was used to demonstrate:

* Kubernetes deployment
* Application containerization
* PostgreSQL deployment
* Kubernetes configuration
* Monitoring
* Cloud-native application management

The Azure environment was intentionally kept separate from the AWS infrastructure.

---

# Terraform and Infrastructure as Code

Terraform was used as the Infrastructure as Code layer for the AWS environment.

The project originally explored using Terraform to manage the Azure AKS environment. However, the existing Azure AKS cluster was already functioning.

Rather than recreate or replace an operational cluster, the project was restructured so that:

```text
Azure
└── Existing AKS

AWS
└── Terraform-managed infrastructure
```

This allowed Terraform to be demonstrated without unnecessarily risking the Azure environment.

The Terraform approach provides:

* Reproducible infrastructure
* Declarative configuration
* Version-controlled infrastructure
* Consistent provisioning
* Easier infrastructure review
* Reduced reliance on manual cloud-console configuration

The Terraform layer formed the foundation for the AWS environment, including the EKS infrastructure and supporting AWS resources.

---

# AWS Networking and Infrastructure

The AWS environment included the networking required to operate the EKS cluster.

The infrastructure included resources such as:

* VPC
* Subnets
* Routing
* Internet connectivity
* NAT Gateway
* EKS cluster
* EKS worker nodes
* IAM roles
* Load Balancer integration
* EBS-backed storage

The AWS EKS cluster was deployed in:

```text
us-east-1
```

The cluster was named:

```text
cloud-native-devops-eks
```

The worker node group was:

```text
cloud-native-devops-workers
```

The worker nodes used:

```text
t3.small
```

instances.

The cluster used Kubernetes:

```text
1.36
```

---

# AWS EKS

The final AWS Kubernetes environment was verified using:

```bash
kubectl get nodes
```

The cluster contained two Ready worker nodes.

The application pods were distributed across the nodes.

The final environment showed:

```text
NAME                           READY   STATUS
auction-app-...                1/1     Running
auction-app-...                1/1     Running
postgres-0                     1/1     Running
```

This verified that:

* EKS was operational
* Worker nodes were healthy
* Kubernetes workloads were scheduled successfully
* The application was running
* PostgreSQL was running

---

# IAM and Security

AWS IAM was used to control access to AWS resources.

Separate roles were used for different purposes, including:

* EKS node operations
* EBS CSI storage operations
* GitHub Actions automation

This follows the principle of assigning permissions according to workload responsibility.

The project also avoided embedding long-lived AWS access keys directly into GitHub Actions.

Instead, GitHub Actions authentication was integrated using OIDC.

---

# GitHub Actions OIDC

One of the important security components of the project was configuring **GitHub Actions OIDC authentication with AWS**.

The GitHub Actions workflow could authenticate to AWS without storing a permanent AWS access key and secret key as repository credentials.

The trust relationship used:

```text
token.actions.githubusercontent.com
```

An AWS IAM role was created for GitHub Actions:

```text
GitHubActions-CloudNativeDevOps
```

The project verified the AWS OIDC provider and associated IAM configuration.

This approach improves security because credentials do not need to be permanently stored in the GitHub repository.

The authentication flow is:

```text
GitHub Actions
      │
      │ OIDC token
      ▼
GitHub OIDC Provider
      │
      ▼
AWS IAM Trust Policy
      │
      ▼
Temporary AWS Credentials
      │
      ▼
AWS Resources
```

The GitHub Actions role was later deliberately removed during the AWS teardown to avoid leaving unnecessary IAM resources behind.

---

# GitHub Actions CI/CD

GitHub Actions was used to automate the software delivery process.

The workflow was designed around the following process:

```text
Developer
   │
   ▼
Git Commit
   │
   ▼
GitHub
   │
   ▼
GitHub Actions
   │
   ├── Checkout
   ├── Build
   ├── Container validation
   └── Deployment automation
           │
           ▼
      Kubernetes
```

The project verified that pushing changes to GitHub triggered the configured CI workflow.

This demonstrates the fundamental CI/CD relationship:

```text
Code change
    ↓
Git push
    ↓
Automated workflow
    ↓
Build
    ↓
Container
    ↓
Deployment
    ↓
Verification
```

---

# Docker Hub

Docker Hub was used as the container image registry.

The application image was published as:

```text
bennieo/cloud-native-auction-app
```

Kubernetes could then pull the image from the registry during deployment.

This separates the:

* Source repository
* Container build process
* Container registry
* Kubernetes runtime

---

# Persistent Storage

Persistent storage was one of the most important parts of the AWS implementation.

PostgreSQL used a Kubernetes PersistentVolumeClaim:

```text
postgres-storage
```

The PVC was backed by an AWS EBS volume.

The final PVC showed:

```text
NAME               STATUS   CAPACITY   ACCESS MODES   STORAGECLASS
postgres-storage   Bound    1Gi        RWO            gp2
```

The corresponding PersistentVolume was also:

```text
Bound
```

and was provisioned through:

```text
ebs.csi.aws.com
```

The storage architecture was:

```text
PostgreSQL
     │
     ▼
StatefulSet
     │
     ▼
PersistentVolumeClaim
     │
     ▼
PersistentVolume
     │
     ▼
AWS EBS
```

This means that the database data was not dependent on the lifecycle of an individual PostgreSQL pod.

---

# AWS EBS CSI Driver

The AWS EBS Container Storage Interface (CSI) driver was configured to allow Kubernetes to provision and manage EBS-backed storage.

The project included:

* EKS OIDC integration
* IAM permissions for EBS
* EBS CSI driver
* Kubernetes PVC
* EBS-backed PersistentVolume

The EBS CSI driver allowed Kubernetes to dynamically provision storage for PostgreSQL.

This was an important step in making the PostgreSQL deployment suitable for a stateful Kubernetes workload.

---

# Persistent Storage Verification

The storage implementation was not accepted merely because Kubernetes showed the PVC as `Bound`.

It was explicitly tested.

First, a test table was created:

```sql
CREATE TABLE persistence_test (
    id SERIAL PRIMARY KEY,
    message TEXT
);
```

A test record was inserted:

```sql
INSERT INTO persistence_test
(message)
VALUES
('EKS persistent storage test');
```

The record was then queried successfully:

```text
id | message
---+-----------------------------
1  | EKS persistent storage test
```

The PostgreSQL pod was deliberately deleted:

```bash
kubectl delete pod postgres-0
```

Because PostgreSQL was managed by a StatefulSet, Kubernetes recreated:

```text
postgres-0
```

The record was queried again:

```sql
SELECT * FROM persistence_test;
```

and the same record remained:

```text
1 | EKS persistent storage test
```

This demonstrated that the data survived the deletion and recreation of the PostgreSQL pod.

### Why this matters

This test demonstrates the difference between:

```text
Pod storage
```

and:

```text
Persistent storage
```

The pod was disposable.

The database data was not.

---

# Prometheus Monitoring

Prometheus was used as the metrics collection component of the platform.

The monitoring layer was designed to provide visibility into the Kubernetes environment and application infrastructure.

The architecture follows:

```text
Kubernetes
    │
    ├── Nodes
    ├── Pods
    ├── Services
    └── Application
           │
           ▼
       Prometheus
           │
           ▼
        Metrics
```

Prometheus provides time-series metrics that can be queried and visualized.

This supports operational questions such as:

* Are the application pods healthy?
* How much CPU is being consumed?
* How much memory is being used?
* Are workloads available?
* Are pods restarting?
* Is the cluster behaving normally?

Monitoring was treated as an integral part of the deployment rather than an optional addition.

---

# Grafana

Grafana was used as the visualization layer for the monitoring system.

The relationship between Prometheus and Grafana is:

```text
Kubernetes
     │
     ▼
 Prometheus
     │
     │ metrics
     ▼
  Grafana
     │
     ▼
Dashboards
```

Prometheus collects and stores metrics while Grafana provides dashboards and visualizations.

This makes operational information easier to interpret than raw command-line output.

The monitoring stack therefore demonstrated:

```text
Metrics collection
       +
Metrics storage
       +
Visualization
       =
Observability
```

---

# Ansible

Ansible was included as the configuration-management and automation component of the DevOps toolchain.

The project demonstrates the distinction between:

```text
Terraform
```

for infrastructure provisioning and:

```text
Ansible
```

for configuration and operational automation.

Conceptually:

```text
Terraform
   │
   ▼
Infrastructure

Ansible
   │
   ▼
Configuration / Automation

Kubernetes
   │
   ▼
Application Orchestration
```

This separation reflects common DevOps practices where infrastructure provisioning, machine configuration, application orchestration, and CI/CD are treated as related but distinct concerns.

---

# Deployment Verification

The AWS environment was systematically verified after deployment.

The following Kubernetes resources were inspected:

```bash
kubectl get nodes
kubectl get pods -o wide
kubectl get svc
kubectl get deployments
kubectl get statefulsets
kubectl get pvc
```

The final state confirmed:

### Nodes

```text
2 Ready worker nodes
```

### Application

```text
2/2 replicas available
```

### PostgreSQL

```text
1/1 StatefulSet replica available
```

### Services

```text
auction-service     LoadBalancer
postgres             ClusterIP
```

### Storage

```text
postgres-storage     Bound
```

These checks provided evidence that the platform was functioning at multiple infrastructure layers.

---

# Application Availability Verification

The application was exposed through an AWS LoadBalancer-backed Kubernetes Service.

The Service was:

```text
auction-service
```

with:

```text
TYPE: LoadBalancer
PORT: 80
```

AWS provisioned an external load balancer with an AWS DNS endpoint.

This demonstrated the complete traffic path:

```text
Internet
   │
   ▼
AWS Load Balancer
   │
   ▼
Kubernetes Service
   │
   ▼
Auction Application Pods
   │
   ▼
Flask Application
```

---

# Troubleshooting and Engineering Decisions

The project involved several practical troubleshooting scenarios.

## Database credentials

The application initially expected:

```text
DB_USER
DB_PASSWORD
```

while PostgreSQL was configured using:

```text
POSTGRES_USER
POSTGRES_PASSWORD
```

The configuration was inspected rather than guessed.

The PostgreSQL configuration was verified to use:

```text
POSTGRES_DB=auctiondb
POSTGRES_USER=auctionuser
```

A compatible application Secret was then created.

This reinforced the importance of tracing configuration dependencies across Kubernetes resources.

---

## Terraform and Azure AKS

Terraform initially identified an Azure AKS resource that would have resulted in another cluster being created.

Rather than blindly applying the plan, the Terraform configuration was reconsidered.

The decision was made to:

* Leave the existing AKS untouched
* Avoid unnecessary infrastructure duplication
* Use Terraform for the AWS infrastructure
* Preserve the existing Azure environment

This prevented unnecessary infrastructure changes and produced a cleaner multi-cloud architecture.

---

## Kubernetes persistent storage

The PostgreSQL deployment required persistent storage.

The project therefore investigated:

* PVC status
* PV status
* StorageClass
* EBS CSI provisioning
* IAM permissions
* OIDC
* Pod storage mounts

The final storage configuration successfully produced:

```text
PVC → PV → AWS EBS
```

and was validated through an actual pod deletion/recovery test.

---

# Cost Management and AWS Teardown

Because this was a learning and portfolio project rather than a permanently running production system, cloud cost management was treated as part of the project.

After completing the AWS deployment and collecting the required evidence, AWS resources were deliberately removed.

The teardown included resources such as:

* EKS worker node group
* EKS add-on
* EKS cluster
* AWS Load Balancer
* NAT Gateway
* Unattached EBS volume
* Elastic IP
* GitHub Actions IAM role
* Associated IAM policy

The EKS node group was deleted and verified:

```text
nodegroups: []
```

The EBS CSI add-on was removed:

```text
addons: []
```

The EKS cluster was subsequently removed and verified through AWS:

```text
ResourceNotFoundException
No cluster found
```

The AWS Load Balancer was deleted and verified.

The NAT Gateway transitioned through:

```text
available
    ↓
deleting
    ↓
deleted
```

The unused EBS volume was also deleted.

The Elastic IP was released.

The GitHub Actions IAM policy was detached and deleted, followed by deletion of the associated IAM role.

This ensured that unnecessary billable resources were not left running after the demonstration.

---

# Repository Structure

The repository is organized to separate application code, infrastructure, Kubernetes manifests, automation, and documentation.

```text
cloud-native-devops-platform/
│
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── ansible/
│   └── ...
│
├── infrastructure/
│   └── terraform/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── ...
│
├── kubernetes/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── postgres-statefulset.yaml
│   ├── postgres-service.yaml
│   ├── configmap.yaml
│   ├── secrets.yaml
│   ├── storage.yaml
│   └── ...
│
├── monitoring/
│   ├── prometheus/
│   └── grafana/
│
├── docs/
│   ├── architecture/
│   ├── evidence/
│   ├── screenshots/
│   └── ...
│
├── .github/
│   └── workflows/
│       └── ...
│
├── docker-compose.yml
│
└── README.md
```

> The exact filenames may vary depending on the final state of the repository. The structure above represents the logical organization of the project components.

---

# Evidence and Documentation

Because the project contains a significant amount of practical evidence, screenshots should be kept separately from the main README.

Recommended structure:

```text
docs/
└── evidence/
    │
    ├── 01-github/
    │   ├── repository.png
    │   └── commits.png
    │
    ├── 02-docker/
    │   ├── docker-build.png
    │   └── dockerhub-image.png
    │
    ├── 03-azure/
    │   ├── aks-cluster.png
    │   └── azure-workloads.png
    │
    ├── 04-terraform/
    │   ├── terraform-plan.png
    │   ├── terraform-apply.png
    │   └── terraform-output.png
    │
    ├── 05-aws/
    │   ├── eks-cluster.png
    │   ├── eks-nodes.png
    │   └── aws-resources.png
    │
    ├── 06-kubernetes/
    │   ├── pods.png
    │   ├── services.png
    │   └── deployments.png
    │
    ├── 07-storage/
    │   ├── pvc.png
    │   ├── pv.png
    │   └── persistence-test.png
    │
    ├── 08-cicd/
    │   ├── github-actions.png
    │   └── workflow-success.png
    │
    ├── 09-monitoring/
    │   ├── prometheus.png
    │   └── grafana.png
    │
    └── 10-cleanup/
        ├── resources-before-cleanup.png
        └── resources-after-cleanup.png
```

The README can then link to individual evidence files without becoming overloaded with screenshots.

---

# DevOps Skills Demonstrated

This project demonstrates practical experience across multiple areas of DevOps engineering.

## Cloud

* Microsoft Azure
* Azure Kubernetes Service
* AWS
* Amazon EKS
* AWS networking
* AWS Load Balancing
* AWS EBS
* AWS IAM

## Infrastructure as Code

* Terraform
* Declarative infrastructure
* Version-controlled infrastructure
* Reproducible provisioning

## Containers

* Docker
* Dockerfile
* Docker Compose
* Container image creation
* Container registry
* Docker Hub

## Kubernetes

* Deployments
* StatefulSets
* Services
* LoadBalancer
* ClusterIP
* ConfigMaps
* Secrets
* PVCs
* PVs
* StorageClasses
* Replica management
* Pod scheduling
* Persistent workloads

## CI/CD

* Git
* GitHub
* GitHub Actions
* Automated builds
* Container workflows
* Deployment automation
* OIDC-based cloud authentication

## Security

* AWS IAM
* IAM policies
* IAM roles
* OIDC
* Kubernetes Secrets
* Separation of configuration and credentials
* Avoidance of long-lived cloud credentials

## Observability

* Prometheus
* Grafana
* Kubernetes metrics
* Application monitoring
* Infrastructure visibility
* Dashboard-based monitoring

## Configuration Management

* Ansible
* Automated configuration
* Separation of infrastructure and configuration management

## Database Operations

* PostgreSQL
* StatefulSets
* Persistent storage
* Database credentials
* Storage recovery testing

---

# Lessons Learned

The project provided practical experience with several important DevOps concepts.

### 1. Stateless and stateful workloads are different

The Flask application can be replicated freely because it is primarily stateless.

PostgreSQL cannot be treated in exactly the same way because its data must persist independently of an individual pod.

This led to the use of:

```text
Deployment → Application
StatefulSet → PostgreSQL
```

---

### 2. Kubernetes storage is more than a mounted directory

Persistent storage requires understanding the relationship between:

```text
PVC
 ↓
PV
 ↓
StorageClass
 ↓
CSI Driver
 ↓
Cloud Storage
```

The project demonstrated this using AWS EBS.

---

### 3. Infrastructure should be changed deliberately

The Terraform/Azure experience demonstrated why engineers should inspect:

```bash
terraform plan
```

before applying infrastructure changes.

A plan that says:

```text
1 to add
```

is not automatically safe simply because nothing is being destroyed.

Understanding **what** will be created is just as important as understanding how many resources will change.

---

### 4. Cloud credentials should not be hard-coded

GitHub Actions OIDC provided a better model:

```text
GitHub
 ↓
OIDC
 ↓
AWS IAM
 ↓
Temporary credentials
```

rather than storing permanent AWS credentials inside GitHub.

---

### 5. Monitoring should be part of the architecture

Prometheus and Grafana were incorporated as part of the platform rather than treated as an afterthought.

A deployment is not truly operationally complete if there is no visibility into its health and resource consumption.

---

### 6. Testing should prove the infrastructure actually works

The PostgreSQL persistence test was particularly valuable.

Rather than simply showing:

```text
PVC = Bound
```

the project tested the real behavior:

```text
Write data
 ↓
Delete database pod
 ↓
Recreate pod
 ↓
Read data
 ↓
Data still exists
```

This is much stronger evidence of a functioning persistent-storage implementation.

---

### 7. Cost management is part of cloud engineering

The final AWS teardown demonstrated that cloud engineers must think about resource lifecycle, not just deployment.

Resources such as:

* NAT Gateways
* EBS volumes
* Elastic IPs
* Load Balancers
* EKS clusters
* Worker nodes

can continue generating costs if they are not properly removed.

---

# Future Improvements

Possible future extensions include:

* Automated multi-cloud deployment from a single GitHub Actions pipeline
* Terraform modules for reusable infrastructure
* Terraform remote state management
* Terraform state locking
* Separate development, staging, and production environments
* Kubernetes Helm charts
* Argo CD / GitOps deployment
* Kubernetes Horizontal Pod Autoscaling
* Ingress Controller
* TLS/HTTPS
* External Secrets management
* AWS Secrets Manager integration
* Azure Key Vault integration
* Network policies
* Pod security standards
* Container image vulnerability scanning
* Trivy integration
* SonarQube or code-quality analysis
* Automated application tests
* Automated infrastructure testing
* Prometheus Alertmanager
* Grafana alerting
* Centralized logging with ELK/OpenSearch
* Disaster recovery testing
* Database backups and restoration
* Multi-region deployment
* High-availability PostgreSQL architecture
* Infrastructure cost monitoring

---

# Key Project Workflow

The complete project lifecycle can be summarized as:

```text
                    SOURCE CODE
                         │
                         ▼
                      GitHub
                         │
                         ▼
                  GitHub Actions
                         │
             ┌───────────┴───────────┐
             │                       │
             ▼                       ▼
        Docker Build            CI Validation
             │
             ▼
         Docker Hub
             │
             ▼
      Cloud Infrastructure
             │
       ┌─────┴─────┐
       │           │
       ▼           ▼
     Azure         AWS
      AKS          EKS
       │           │
       └─────┬─────┘
             │
         Kubernetes
             │
      ┌──────┴──────┐
      │             │
      ▼             ▼
 Application     PostgreSQL
      │             │
      │          Persistent
      │           Storage
      │             │
      └──────┬──────┘
             │
             ▼
       Observability
             │
       ┌─────┴─────┐
       ▼           ▼
  Prometheus     Grafana
```

---

# Final Outcome

The completed project demonstrates a practical cloud-native DevOps workflow rather than a single isolated deployment.

It combines:

```text
Azure
+
AWS
+
Terraform
+
Docker
+
Kubernetes
+
EKS
+
AKS
+
GitHub Actions
+
OIDC
+
IAM
+
Ansible
+
PostgreSQL
+
Persistent Storage
+
Prometheus
+
Grafana
```

The AWS implementation was also validated at multiple levels:

```text
Infrastructure
     ↓
EKS Cluster
     ↓
Worker Nodes
     ↓
Kubernetes
     ↓
Application
     ↓
LoadBalancer
     ↓
PostgreSQL
     ↓
Persistent Storage
     ↓
Persistence Test
```

Most importantly, the project demonstrates the ability to reason about the complete DevOps lifecycle:

**build → package → provision → deploy → secure → monitor → verify → troubleshoot → recover → clean up.**

---

## Conclusion

The Cloud Native DevOps Platform represents a hands-on demonstration of modern DevOps engineering principles across multiple cloud environments.

The project goes beyond simply deploying a container. It demonstrates how application code can be transformed into a production-inspired platform through:

* Containerization
* Infrastructure as Code
* Cloud provisioning
* Kubernetes orchestration
* CI/CD
* Secure cloud authentication
* Database deployment
* Persistent storage
* Monitoring
* Visualization
* Configuration automation
* Operational verification
* Cost-conscious infrastructure management

The resulting architecture provides a strong foundation for further development into a fully automated multi-cloud platform with GitOps, advanced security, automated testing, autoscaling, centralized logging, and disaster recovery.
