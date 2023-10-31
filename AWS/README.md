# AWS Packer AMI Examples

- Ensure the AWS CLI is installed and `aws configure` has been ran for the desired profile.
- Update the desired variables file under `variables` and the template under `templates`.
- Validate the build: `packer validate -var-file="variables/<var file>.pkrvars.hcl" ./templates/<template file>.pkr.hcl`
- Run the build: `packer build -var-file="variables/<var file>.pkrvars.hcl" ./templates/<template file>.pkr.hcl`
- Deregister and delete, where appropriate, the AMI and its snapshot(s) in the AWS Console to save money.
