# Deployment of a FortiAIOps-VM(BYOL) on Azure

## Introduction

A Terraform script to deploy a FortiAIOps-VM(BYOL) on Azure

## Requirements

* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= 0.12.0
* Terraform Provider AzureRM >= 2.38.0
* Terraform Provider Template >= 2.2.2
* Terraform Provider Random >= 3.0.0

## Deployment overview

Terraform deploys the following components:

* Azure Virtual Network with 1 subnets
* One FortiAIOps-VM instances with 1 NIC
* One firewall rules: for external

## Deployment

To deploy the FortiAIOps-VM to Azure:

1. Clone the repository.
2. Customize variables in the `terraform.tfvars.example` and `variables.tf` file as needed.  And rename `terraform.tfvars.example` to `terraform.tfvars`.
3. Initialize the providers and modules:

   ```sh
   cd XXXXX
   terraform init
    ```

4. Submit the Terraform plan:

   ```sh
   terraform plan
   ```

5. Verify output.
6. Confirm and apply the plan:

   ```sh
   terraform apply
   ```

7. If output is satisfactory, type `yes`.

Output will include the information necessary to log in to the FortiAIOps-VM instances:

```sh
FortiAIOpsPublicIP = <FortiAIOps Public IP>
ResourceGroup = <Resource Group>
```

## Destroy the instance

To destroy the instance, use the command:

```sh
terraform destroy
```

## Requirements and limitations

The terms for the FortiAIOps BYOL image in the Azure Marketplace needs to be accepted once before usage. This is done automatically during deployment via the Azure Portal. For the Azure CLI the commands below need to be run before the first deployment in a subscription.

```sh
BYOL az vm image terms accept --publisher fortinet --offer fortinet-fortiaiops --plan fortinet_fortiaiops-vm
```

## Support

Fortinet-provided scripts in this and other GitHub projects do not fall under the regular Fortinet technical support scope and are not supported by FortiCare Support Services.
For direct issues, please refer to the [Issues](https://github.com/fortinet/fortiaiops-terraform-deploy/issues) tab of this GitHub project.
For other questions related to this project, contact [github@fortinet.com](mailto:github@fortinet.com).

## License

[License](https://github.com/fortinet/fortiaiops-terraform-deploy/blob/main/LICENSE) © Fortinet Technologies. All rights reserved.
