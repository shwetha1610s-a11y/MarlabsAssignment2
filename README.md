Step-by-Step Guide: Azure Self-Service Dev Environment Provisioning

This guide provides a detailed, step-by-step process with exact configuration for building a secure, automated self-service developer environment
provisioning solution on Azure using Terraform and Azure DevOps.

 Architecture Diagram
 

--------------------------------------------------------------------------------------
1. Prerequisites
- Azure Subscription with Owner/Contributor rights
- Azure DevOps Project
- Service Principal with sufficient permissions (for Terraform and pipeline)
- Azure Storage Account for Terraform state
- Registered VM image (e.g., Windows 10 or Ubuntu)
----------------------------------------------------------------------------------------------
2. Create Terraform Modules
Directory Structure
infra/
  main.tf
  variables.tf
  outputs.tf
  modules/
    dev_env/
      main.tf
      variables.tf
      outputs.tf
---------------------------------------------------------------------------------------------
infra/modules/dev_env/variables.tf

---------------------------------------------------------------------------------------------
infra/modules/dev_env/main.tf

--------------------------------------------------------------------------------------------
 3. Root Terraform Configuration
 infra/main.tf
-----------------------------------------------------------------------------------
infra/variables.tf

-----------------------------------------------------------------------------------
4. Azure DevOps Pipeline Configuration
 Azure DevOps Pipeline Configuration/azure-ci-pipeline.yaml
-------------------------------------------------------------------------------------
 5. Security & Best Practices
- RBAC: Assign only required roles to the developer
- Key Vault: Store all secrets, restrict access
- Private networking: No public IPs, NSG rules
- Logging: Enable Log Analytics
- Teardown: Add a destroy pipeline/job
- Tags: owner, cost center, expiration
--------------------------------------------------------------------------------------------------------
6. Cost, Monitoring, and Access Controls
- Set Azure Budgets and cost alerts
- Enable auto-shutdown for VMs
- Use Log Analytics for monitoring
- Use Azure AD groups for access
-------------------------------------------------------------------------------------------------------
7. Teardown (Destroy) Pipeline
To safely remove all provisioned resources, add a dedicated destroy pipeline. This ensures environments are not left running and costs are controlled.
 Teardown (Destroy) Pipeline/destroy-dev-env-pipeline.yaml
----------------------------------------------------------------------------------------------------------------
How to use:
- Trigger this pipeline with the same parameters as the provisioning pipeline.
- Approval is required before destruction.
- All resources created by Terraform will be destroyed, and the state file will be updated.
------------------------------------------------------------------------------------------------------
8. Validation
- Test the pipeline end-to-end
- Validate RBAC, Key Vault, and network restrictions
- Check logs and cost alerts


*Prepared by: Shwetha s
*Date: August 23, 2025*


