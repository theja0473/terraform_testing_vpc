## GitLab Repository Structure:
```
mlops-multi-cloud/
|-- .gitlab-ci.yml
|-- environments/
|   |-- dev/
|   |   |-- aws/
|   |   |   |-- main.tf
|   |   |   |-- variables.tf
|   |   |   |-- outputs.tf
|   |   |-- azure/
|   |       |-- main.tf
|   |       |-- variables.tf
|   |       |-- outputs.tf
|-- modules/
|   |-- aws/
|   |   |-- vpc/
|   |   |   |-- main.tf
|   |   |   |-- variables.tf
|   |   |   |-- outputs.tf
|   |   |-- ec2/
|   |       |-- main.tf
|   |       |-- variables.tf
|   |       |-- outputs.tf
|   |-- azure/
|       |-- vnet/
|       |   |-- main.tf
|       |   |-- variables.tf
|       |   |-- outputs.tf
|       |-- vm/
|           |-- main.tf
|           |-- variables.tf
|           |-- outputs.tf
|-- scripts/
|   |-- deploy.sh
|   |-- destroy.sh
|-- README.md
```
Terraform Modules:
AWS Module - VPC (modules/aws/vpc/):

### main.tf
```
provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}
```

### variables.tf
```
variable "region" {
  description = "AWS region"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
}
```
### outputs.tf
```
output "vpc_id" {
  value = aws_vpc.main.id
}
```
## AWS Module - EC2 (modules/aws/ec2/):

### main.tf
```
resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
}
```
### variables.tf
```
variable "ami" {
  description = "AMI for the EC2 instance"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
}

variable "security_group_id" {
  description = "Security group ID"
}
```
### outputs.tf
```
output "instance_id" {
  value = aws_instance.example.id
}
```
## Azure Module - VNET (modules/azure/vnet/):

### main.tf
```
provider "azurerm" {
  features = {}
}

resource "azurerm_virtual_network" "main" {
  name                = var.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}
```
### variables.tf
```
variable "name" {
  description = "Name of the virtual network"
}

variable "address_space" {
  description = "Address space for the virtual network"
}

variable "location" {
  description = "Azure region"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
}
```
### outputs.tf
```
output "vnet_id" {
  value = azurerm_virtual_network.main.id
}
```
## Azure Module - VM (modules/azure/vm/):

### main.tf
```
resource "azurerm_virtual_machine" "main" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [var.network_interface_id]
}
```
### variables.tf
```
variable "name" {
  description = "Name of the virtual machine"
}

variable "location" {
  description = "Azure region"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
}

variable "network_interface_id" {
  description = "ID of the network interface associated with the VM"
}
```
### outputs.tf
```
output "vm_id" {
  value = azurerm_virtual_machine.main.id
}
```
### GitLab CI/CD Pipeline (.gitlab-ci.yml):
```
stages:
  - plan
  - apply
  - destroy

variables:
  AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY
  AZURE_CLIENT_ID: $AZURE_CLIENT_ID
  AZURE_CLIENT_SECRET: $AZURE_CLIENT_SECRET
  AZURE_SUBSCRIPTION_ID: $AZURE_SUBSCRIPTION_ID
  AZURE_TENANT_ID: $AZURE_TENANT_ID

before_script:
  - terraform --version
  - terraform init

plan:
  stage: plan
  script:
    - terraform plan -var-file=environments/dev/aws/terraform.tfvars
    - terraform plan -var-file=environments/dev/azure/terraform.tfvars

apply:
  stage: apply
  script:
    - terraform apply -var-file=environments/dev/aws/terraform.tfvars -auto-approve
    - terraform apply -var-file=environments/dev/azure/terraform.tfvars -auto-approve

destroy:
  stage: destroy
  script:
    - terraform destroy -var-file=environments/dev/aws/terraform.tfvars -auto-approve
    - terraform destroy -var-file=environments/dev/azure/terraform.tfvars -auto-approve
```
### NOTE:

Replace placeholders like $AWS_ACCESS_KEY_ID and $AZURE_CLIENT_ID with your actual credentials.
Make sure to configure GitLab CI/CD variables for sensitive information like credentials.
Adjust the Terraform module configurations based on your specific requirements.
This is a basic example, and you may need to customize it further based on your specific use case and requirements. Additionally, ensure that your IAM roles and permissions are set up correctly for your CI/CD pipeline to interact with AWS and Azure services.
