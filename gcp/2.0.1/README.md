# Deployment of a single FortiAIOps-VM on the Google Cloud Platform (GCP)
## Introduction
A Terraform script to deploy a single FortiAIOps-VM on GCP.

## Requirements
* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= 0.12.0
* Terraform Provider for Google Cloud Platform >=2.11.0
* Terraform Provider for Google Cloud Platform Beta >=2.13
* A [GCP OAuth2 access token](https://developers.google.com/identity/protocols/OAuth2)

## Deployment overview
Terraform deploys the following :
   - A Virtual Private Cloud (VPC) with one public subnet
   - A FortiAIOps-VM instance with one NIC
   - One firewall rule: one for the external

## Deployment
To deploy the FortiAIOps-VM to GCP:
1. Clone the repository.
2. Obtain a GCP OAuth2 token and input it in the vars.tf file.
   ```sh
   $ gcloud auth print-access-token
   ```
3. Customize variables in the `vars.tf` file as needed.
4. Initialize the providers and modules:
   ```sh
   $ cd XXXXX
   $ terraform init
    ```
5. Submit the Terraform plan:
   ```sh
   $ terraform plan
   ```
6. Verify output.
7. Confirm and apply the plan:
   ```sh
   $ terraform apply
   ```
8. If output is satisfactory, type `yes`.

Output will include the information necessary to log in to the FortiAIOps-VM instances:
```sh
FortiAIOps-InstanceName = fortiaiops-ebc
FortiAIOps-IP = <fortiaiops public IP>
FortiAIOps-Username = admin
```

## Destroy the instance
To destroy the instance, use the command:
```sh
$ terraform destroy
```

# Support
Fortinet-provided scripts in this and other GitHub projects do not fall under the regular Fortinet technical support scope and are not supported by FortiCare Support Services.
For direct issues, please refer to the [Issues](https://github.com/fortinet/fortiaiops-terraform-deploy/issues) tab of this GitHub project.
For other questions related to this project, contact [github@fortinet.com](mailto:github@fortinet.com).

## License
[License](https://github.com/fortinet/fortiaiops-terraform-deploy/blob/main/LICENSE) © Fortinet Technologies. All rights reserved.
