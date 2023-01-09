
# Server module

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
| [aws_instance.appsrv1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.appsrv2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.runner1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.runner2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appsrv_instancesize"></a> [appsrv\_instancesize](#input\_appsrv\_instancesize) | Instance size of the application servers. | `string` | n/a | yes |
| <a name="input_appsrv_storage"></a> [appsrv\_storage](#input\_appsrv\_storage) | Storage details for the app server. | <pre>object({<br>    size = number<br>    delete_on_termination = bool<br>  })</pre> | n/a | yes |
| <a name="input_centos7_ami"></a> [centos7\_ami](#input\_centos7\_ami) | CentOS 7 AMI ID | `string` | `"ami-0c1f3a8058fde8814"` | no |
| <a name="input_customer"></a> [customer](#input\_customer) | Name of the customer | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_iam_instanceprofile"></a> [iam\_instanceprofile](#input\_iam\_instanceprofile) | Instance profile for S3 bucket access. | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Existing SSH key name. | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Technical owner | `string` | n/a | yes |
| <a name="input_runner_instancesize"></a> [runner\_instancesize](#input\_runner\_instancesize) | Instance size for the runners. | `string` | n/a | yes |
| <a name="input_runner_storage"></a> [runner\_storage](#input\_runner\_storage) | Storage details for the runners. | <pre>object({<br>    size = number<br>    delete_on_termination = bool<br>  })</pre> | <pre>{<br>  "delete_on_termination": true,<br>  "size": 50<br>}</pre> | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group IDs | <pre>object({<br>    management_sg = string<br>    appservers_sg = string<br>    runners_sg = string<br>  })</pre> | n/a | yes |
| <a name="input_server_subnets"></a> [server\_subnets](#input\_server\_subnets) | Database subnets. | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appsrv1_ip"></a> [appsrv1\_ip](#output\_appsrv1\_ip) | Private IPv4 address for appsrv1 |
| <a name="output_appsrv2_ip"></a> [appsrv2\_ip](#output\_appsrv2\_ip) | Private IPv4 address for appsrv2 |
| <a name="output_runner1_ip"></a> [runner1\_ip](#output\_runner1\_ip) | Private IPv4 address for runner1 |
| <a name="output_runner2_ip"></a> [runner2\_ip](#output\_runner2\_ip) | Private IPv4 address for runner2 |
<!-- END_TF_DOCS -->