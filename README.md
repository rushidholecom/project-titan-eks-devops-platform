# 🚀 Project Titan - EKS DevOps Platform

## 📌 Overview

This project demonstrates a **production-grade 3-tier cloud-native architecture** deployed on AWS using modern DevOps practices.

The application is based on the EasyCRUD project (Node.js + Spring Boot) and is fully containerized, automated, and deployed using Kubernetes (EKS) with a complete CI/CD pipeline.

---

## 🏗️ Architecture
             ┌──────────────────────────┐
             │        Internet          │
             └────────────┬─────────────┘
                          │
                    ┌─────▼─────┐
                    │   ALB     │
                    └─────┬─────┘
                          │
                  ┌───────▼────────┐
                  │  Ingress (EKS) │
                  └───────┬────────┘
                          │
    ┌─────────────────────┼─────────────────────┐
    │                     │                     │
┌──────▼──────┐ ┌──────▼──────┐ ┌────────▼───────┐
│ Frontend Pod│ │ Backend Pod │ │ HPA Autoscale   │
│ (Node/React)│ │ (SpringBoot)│ │ │
└─────────────┘ └──────┬──────┘ └────────────────┘
│
┌──────▼──────┐
│ RDS │
│ (PostgreSQL)│
└─────────────┘

CI/CD Flow:
GitHub → Jenkins → Docker → ECR → EKS

---

## 🧱 Tech Stack

| Category        | Technology |
|----------------|-----------|
| Cloud           | AWS |
| IaC             | Terraform |
| Container       | Docker |
| Orchestration   | Amazon EKS (Kubernetes) |
| CI/CD           | Jenkins |
| Database        | Amazon RDS (PostgreSQL/MySQL) |
| Storage         | Amazon S3 |
| Monitoring      | Prometheus + Grafana |
| Logging         | EFK Stack (Optional) |

---

## 🌐 Infrastructure Design

### 🔹 VPC
- Custom VPC (`10.0.0.0/16`)
- Public & Private subnets
- Internet Gateway + NAT Gateway

### 🔹 EKS
- Cluster deployed in private subnets
- Managed node groups
- ALB Ingress Controller

### 🔹 RDS
- Private subnet deployment
- Secure access via Security Groups
- Automated backups enabled

### 🔹 S3
- Terraform remote backend
- Versioning enabled

---

## ⚙️ CI/CD Pipeline (Jenkins)

### Pipeline Stages:

1. **Checkout Code**
2. **Build Application**
3. **Docker Build**
4. **Security Scan (Trivy)**
5. **Push to ECR**
6. **Deploy to EKS (kubectl/Helm)**

---

## 🐳 Dockerization

- Backend → Spring Boot container
- Frontend → Node.js / Nginx container

---

## ☸️ Kubernetes Components

- Deployment
- Service (ClusterIP)
- Ingress (ALB)
- ConfigMaps & Secrets
- Horizontal Pod Autoscaler (HPA)

---

## 🔐 Security Best Practices

- IAM Roles with least privilege
- No hardcoded credentials
- Secrets managed via:
  - Kubernetes Secrets / AWS Secrets Manager
- Private subnet isolation

---

## 📊 Monitoring & Logging

### Monitoring:
- Prometheus → Metrics collection
- Grafana → Visualization dashboards

### Logging:
- Fluentd → Log collection
- Elasticsearch → Storage
- Kibana → Visualization

---

## 📂 Project Structure

project-root/
│
├── terraform/
│ ├── modules/
│ │ ├── vpc/
│ │ ├── eks/
│ │ ├── rds/
│ │ ├── s3/
│ │
│ ├── env/
│ │ ├── dev/
│ │ ├── prod/
│
├── app/
│ ├── frontend/
│ ├── backend/
│
├── docker/
├── kubernetes/
├── jenkins/
├── monitoring/
└── README.md


---

## 🚀 Deployment Guide (High-Level)

### Step 1: Setup Terraform Backend
- Create S3 bucket
- Enable DynamoDB locking

### Step 2: Provision Infrastructure
```bash
terraform init
terraform plan
terraform apply
