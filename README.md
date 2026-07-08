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

* *(More cloud projects coming soon...)*

---

## Prerequisites
To run the projects in this repository, you will need:
* [Terraform](https://www.terraform.io/downloads) installed locally.
* An active **AWS Account**.
* [AWS CLI](https://aws.amazon.com/cli/) configured with the necessary IAM permissions.

## How to Use
1. Clone the repository:
   ```bash
   git clone [https://github.com/satya136/AWS_Projects.git](https://github.com/satya136/AWS_Projects.git)