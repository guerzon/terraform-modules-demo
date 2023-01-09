
# Security module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.appservers_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.database_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.loadbalancers_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.management_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.runners_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer"></a> [customer](#input\_customer) | Name of the customer | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Technical owner | `string` | n/a | yes |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | CIDR blocks for the private subnets | `list` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appservers_sg_id"></a> [appservers\_sg\_id](#output\_appservers\_sg\_id) | Security group ID for the app servers' security group |
| <a name="output_database_sg_id"></a> [database\_sg\_id](#output\_database\_sg\_id) | Security group ID for the database security group |
| <a name="output_loadbalancers_sg_ig"></a> [loadbalancers\_sg\_ig](#output\_loadbalancers\_sg\_ig) | Security group ID for the load balancers' security group |
| <a name="output_management_sg_id"></a> [management\_sg\_id](#output\_management\_sg\_id) | Security group ID for the Management security group |
| <a name="output_runners_sg_id"></a> [runners\_sg\_id](#output\_runners\_sg\_id) | Security group ID for the runners' security group |
<!-- END_TF_DOCS -->