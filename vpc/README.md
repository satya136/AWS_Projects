# AWS VPC & Security Groups Project

## Project Description
This project demonstrates foundational AWS networking and security concepts through a custom VPC environment. It highlights the use of stateful **Security Groups** to manage traffic flow between isolated EC2 workloads and validates connectivity patterns using HTTP, SSH, and ICMP protocols.

## What This Project Does
* **Network Isolation:** Creates a custom VPC environment with public subnets and auto-assigned IPv4 addresses for external accessibility.
* **Automated Web Server Deployment:** Launches EC2 instances pre-configured with **Apache HTTP Server** via automated User Data scripts, ensuring the instances are ready to serve web traffic upon startup.
* **Granular Security Controls:** Implements two distinct Security Groups (**SGA** and **SGB**). These groups are configured to:
    * Allow public access for HTTP (port 80) and SSH (port 22) traffic from the internet (`0.0.0.0/0`).
    * Enable private, secure internal communication between instances using ICMP rules.
* **Connectivity Validation:** Establishes a framework for verifying network rules, including browser-based web access, SSH connectivity, cross-instance ping tests, and internal data retrieval via `curl`.

## Key Components
* **Compute:** Two EC2 instances, each acting as an independent web server.
* **Networking:** Custom VPC architecture with specific ingress/egress rules designed to restrict and allow traffic based on source.
* **Access Management:** Uses SSH key pairs (`.pem` format) for secure administrative access, with support for legacy tools like PuTTY via `.ppk` conversion.

## Validation Outcomes
This project confirms the following connectivity scenarios:
1. **Web Hosting:** Each instance successfully serves the default Apache test page, verifying inbound HTTP traffic rules.
2. **SSH Access:** Secure administrative login is confirmed via EC2 Instance Connect or PuTTY (using converted keys).
3. **Internal Networking:** Stateful security groups correctly allow bidirectional ICMP traffic between SGA and SGB instances.
4. **Inter-instance Communication:** The ability for one instance to retrieve resources from another using `curl` confirms that internal security policies are functioning as intended.