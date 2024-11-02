# Terraform GitHub Actions

This project automates AWS infrastructure deployment and testing using Terraform and GitHub Actions, leveraging OpenID Connect (OIDC) for secure authentication between GitHub and AWS.

> [!WARNING]  
> ## Important Disclaimer
>
> **This project is for testing and demonstration purposes only.**
>
>Please be aware of the following:
>
>- The infrastructure deployed by this project is not intended for production use.
>- Security measures may not be comprehensive or up to date.
>- Performance and reliability have not been thoroughly tested at scale.
>- The project may not comply with all best practices or organizational standards.
>
>Before using any part of this project in a production environment:
>
>1. Thoroughly review and understand all code and configurations.
>2. Conduct a comprehensive security audit.
>3. Test extensively in a safe, isolated environment.
>4. Adapt and modify the code to meet your specific requirements and security standards.
>5. Ensure compliance with your organization's policies and any relevant regulations.
>
>The maintainers of this project are not responsible for any issues that may arise from the use of this code in production environments.
---

## Overview

The terraformgithubactions repository demonstrates how to use GitHub Actions to manage AWS resources using Terraform. Key features include:

1. Secure AWS authentication using OpenID Connect
2. Terraform state management with S3 backend
3. Automated VPC deployment and destruction for testing purposes

## Workflow Details

The GitHub Actions workflow (`main.yml`) is designed to:

- Trigger on push events and manual workflow dispatch
- Use OpenID Connect for AWS authentication
- Deploy a test VPC in the specified AWS region
- Store Terraform state in an S3 bucket
- Clean up resources by destroying the infrastructure after testing

### Workflow Steps:

1. Repository checkout
2. AWS credentials configuration using OIDC
3. AWS identity verification
4. Terraform configuration application (VPC deployment)
5. Terraform-managed infrastructure destruction

## Prerequisites

To use this workflow, you need:

- An AWS account with appropriate permissions
- GitHub repository with the following configurations:

You need to create an "Production" environnement in your repo, and then configure the following Variables.

### OIDC "Production" Environment Variables:
  - `AWS_ACCOUNTID`: Your AWS account ID
  - `AWS_ROLE`: The IAM role ARN to assume via OIDC

### Terraform "Production" env Variables:
  - `AWS_REGION`: The AWS region for VPC deployment and testing
  - `TFSTATE_BUCKET`: S3 bucket name for storing Terraform state
  - `TFSTATE_KEY`: S3 object key for the Terraform state file
  - `TFSTATE_REGION`: AWS region where the S3 bucket for the Terraform state file is located

## OpenID Connect (OIDC) Configuration

This project uses OIDC to establish a trust relationship between GitHub and AWS, allowing for secure, short-lived credentials without the need for long-term access keys. To set this up:

1. Configure an OIDC provider in your AWS account for GitHub Actions
2. Create an IAM role with the necessary permissions and a trust policy for the OIDC provider
3. Use the role ARN in your GitHub Actions workflow

https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services

Example of Trusted Policy
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::[AWSAccountID]:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                },
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:octo-org/octo-repo:*"
                }
            }
        }
    ]
}
```

## Usage

To use the terraformgithubactions workflow:

1. Ensure all prerequisites and OIDC configuration are in place
2. Push changes to the repository or manually trigger the workflow
3. The workflow will deploy a test VPC, verify the deployment, and then destroy the resources


## Contributing

Contributions to improve the workflow or infrastructure code are welcome. Please follow these steps:

1. Fork the repository
2. Create a new branch for your feature or fix
3. Make your changes
4. Submit a pull request with a clear description of your changes

## License

This project is licensed under the terms of the [LICENSE](LICENSE) file included in this repository.


