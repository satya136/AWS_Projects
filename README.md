# AWS Cloud Projects with Terraform

Welcome to my cloud projects repository! This repository serves as a centralized collection of various **AWS cloud infrastructure projects**, fully provisioned and managed using Infrastructure as Code (IaC) with **Terraform**. 

As I build and deploy new cloud projects, this README will be updated accordingly.

## Repository Purpose
The goal of this repository is to document practical cloud architectures, automated infrastructure deployments, and DevOps best practices. 

## Projects Included

* **[EC2_with_TF](./EC2_with_TF/)**
  * **Description:** Provisions an AWS EC2 instance using Terraform.
  * **Automation:** Automatically deploys and configures a static website using an `httpd` (Apache) web server via user data scripts.
  * **Access:** The static site can be accessed publicly over the internet using the EC2 instance's Public IP address.

* **[aws-advanced-request-routing](./aws-advanced-request-routing/)**
  * **Description:** Deploys a highly available web architecture where EC2 instances are placed behind an Application Load Balancer (ALB).
  * **Routing Configuration:** Configures **Path-based routing** (forwarding requests based on URL paths like `/red*` or `/blue*`).
  * **Automation:** EC2 instances automatically retrieve custom website code securely from an S3 bucket on boot using assigned IAM Roles. It also handles the automated creation of Target Groups, ALB Listeners.

* **[custom_vpc](./vpc/)**
  * **Description:** Demonstrates foundational AWS networking and security concepts by deploying a custom VPC with isolated EC2 workloads.
  * **Automation:** Uses Terraform to provision the VPC, configure granular Security Groups, and automate Apache web server deployment via User Data.
  * **Validation:** Implements rules for HTTP, SSH, and ICMP to verify secure external access and internal inter-instance communication.

* *(More cloud projects coming soon...)*

---

## Prerequisites
To run the projects in this repository, you will need:
* [Terraform](https://www.terraform.io/downloads) installed locally.
* An active **AWS Free Tier Account**.
* [AWS CLI](https://aws.amazon.com/cli/) configured with the necessary IAM permissions.

## How to Use
1. Clone the repository:
   ```bash
   git clone https://github.com/satya136/AWS_Projects.git
   ```
2. Navigate into the specific project directory you wish to deploy (e.g., `cd aws-advanced-request-routing`).
3. Initialize the Terraform environment:
   ```bash
   terraform init
   ```
4. Review the deployment plan:
   ```bash
   terraform plan
   ```
5. Apply the configuration to build the infrastructure:
   ```bash
   terraform apply
   ```
6. **Cleanup**: To avoid unexpected charges, always destroy the infrastructure when you are done testing:
   ```bash
   terraform destroy
   ```