![GitHub language count](https://img.shields.io/github/languages/count/ckummari/ck)

![GitHub language count](https://img.shields.io/github/languages/count/sede-x/terraform-aws-rds)

### Terraform gitHub documentation [link](https://github.com/terraform-aws-modules)

### Badges
[![regression testing](https://github.com/sede-x/terraform-aws-rds/actions/workflows/regression-testing.yml/badge.svg)](https://github.com/sede-x/terraform-aws-rds/actions/workflows/regression-testing.yml)

### Usage
<!--- BEGIN_USAGE --->
## Usage example
```hcl
module "vpc" {

# CONSUME VPC MODULE FROM INNERSOURCE IAC FOR TESTING
  source = "git@github.com:sede-x/terraform-aws-vpc.git?ref=main"

  environment                = "regression-testing"
  vpc_name                   = "regression-testing-vpc-rds"
  cidr_block                 = "10.0.0.0/16"
  create_private_subnets     = true
  private_subnets_name       = "regression-testing-subnet"
  availability_zone_private  = ["us-east-1a", "us-east-1b"]
  private_subnets            = ["10.0.0.128/26", "10.0.0.192/26"]
}

module "rds" {
  
  # CONSUME RDS MODULE FROM INNERSOURCE IAC FOR TESTING
  source = "../"
  
  engine_name = "mysql"
  db_option_group_name = "regression-testing-option-group-name"
  major_engine_version = "8.0"
  db_option_group_tags = {
    Environment = "regression-testing"
  }

  #db_param_group
  family     = "mysql8.0"
  db_param_group_name  = "regression-testing-param-group-name"
  db_param_group_tags  = {
    Environment = "regression-testing"
  }

  # db_subnet_group
  subnets = [module.vpc.private_subnets_id[0], module.vpc.private_subnets_id[1]]
  db_subnet_group_name = "regression-testing-subnet-group-name"
  db_subnet_group_tags = {
    Environment = "regression-testing"
  }

  #db_instance
  vpc_security_group_ids = [module.vpc.default_security_group_id[0]]
  availability_zone = "us-east-1a"
  db_instance_name = "regressiontesting1"
  identifier = "regression-testing-terraform"
  engine = {
    name = "mysql"
    version = "8.0.20"
    }
  engine_version = "8.0.20"
  instance_class = "db.m5.large"
  allocated_storage = {
   allocated = 100
   }
  username = "user"
  password = "Test1234"
  db_instance_tags = {
    Environment  = "regression-testing"
  }
}

 

```
<!--- END_USAGE --->

<!--- BEGIN_TF_DOCS --->

<details>
  <summary> Requirements</summary>

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| aws | 3.36.0 |

</details>
  
<details>
<summary> Providers </summary>

No provider.
</details>

<details>
<summary> Modules </summary>

| Name | Source | Version |
|------|--------|---------|
| db_instance | ./modules/db-instance |  |
| db_option_group | ./modules/db-option-group |  |
| db_param_group | ./modules/db-param-group |  |
| db_subnet_group | ./modules/db-subnet-group |  |

</details>

<details>
<summary> Inputs </summary>

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allocated\_storage | n/a | `map(string)` | <pre>{<br>  "allocated": null,<br>  "encrypted": false,<br>  "iops": null,<br>  "type": null<br>}</pre> | no |
| allow\_major\_version\_upgrade | n/a | `bool` | `false` | no |
| apply\_immediately | n/a | `bool` | `false` | no |
| auto\_minor\_version\_upgrade | n/a | `bool` | `false` | no |
| availability\_zone | n/a | `string` | `null` | no |
| backup\_retention\_period | n/a | `number` | `1` | no |
| copy\_tags\_to\_snapshot | n/a | `bool` | `false` | no |
| db\_instance\_name | name of the database instance | `string` | `""` | no |
| db\_instance\_tags | tags | `map(string)` | `null` | no |
| db\_option\_group\_name | descripThe name of the option group. If omitted, Terraform will assign a random, unique name. Must be lowercasetion | `string` | `""` | no |
| db\_option\_group\_tags | tags | `map(string)` | `null` | no |
| db\_param\_group\_name | The name of the DB parameter group. | `string` | `""` | no |
| db\_param\_group\_tags | tags | `map(string)` | `null` | no |
| db\_snapshot\_identifier | name of the snapshot | `string` | `""` | no |
| db\_subnet\_group\_name | name of db subnet group | `string` | `""` | no |
| db\_subnet\_group\_tags | tags | `map(string)` | `null` | no |
| deletion\_protection | n/a | `bool` | `false` | no |
| enabled\_cloudwatch\_logs\_exports | n/a | `list(string)` | `[]` | no |
| engine | n/a | `map(string)` | <pre>{<br>  "name": "",<br>  "version": ""<br>}</pre> | no |
| engine\_name | description | `string` | `""` | no |
| engine\_version | description | `string` | `""` | no |
| enhanced\_monitoring | n/a | `bool` | `false` | no |
| family | description | `string` | `""` | no |
| final\_snapshot\_identifier | n/a | `string` | `null` | no |
| iam\_database\_authentication\_enabled | n/a | `bool` | `false` | no |
| identifier | the name of the RDS instance | `string` | `null` | no |
| instance\_class | The RDS instance class | `string` | `""` | no |
| kms\_key\_id | n/a | `string` | `""` | no |
| major\_engine\_version | n/a | `string` | `null` | no |
| max\_allocated\_storage | n/a | `number` | `0` | no |
| monitoring\_interval | n/a | `number` | `0` | no |
| monitoring\_role\_arn | n/a | `string` | `""` | no |
| multi\_az | n/a | `bool` | `false` | no |
| name | description | `string` | `""` | no |
| options | description | `list(map(string))` | `[]` | no |
| parameters | description | `list(map(string))` | `[]` | no |
| password | Database password | `string` | `""` | no |
| performance\_insights\_enabled | n/a | `bool` | `false` | no |
| performance\_insights\_retention\_period | n/a | `number` | `7` | no |
| port | rds server port number | `string` | `5432` | no |
| skip\_final\_snapshot | n/a | `bool` | `true` | no |
| snapshot\_identifier | n/a | `string` | `null` | no |
| storage\_type | description | `string` | `""` | no |
| subnets | description | `list` | `[]` | no |
| timeouts | time taken to create update and delete database | `map(string)` | <pre>{<br>  "create": "40",<br>  "delete": "60",<br>  "update": "80"<br>}</pre> | no |
| username | database username | `string` | `"admin"` | no |
| vpc\_security\_group\_ids | List of vpc security group to associate | `list(string)` | `[]` | no |

</details>

<details>
<summary> Outputs </summary>

| Name | Description |
|------|-------------|
| db\_address | address of the rds |
| db\_endpoint | rds endpoint |
| db\_subnet\_group\_arn | arn of db subnet group |
| db\_subnet\_group\_name | subnet Group name |
| option\_group\_arn | arn of the option group |
| option\_group\_name | Name of the option group |
| param\_group\_arn | param group arn |
| param\_group\_name | param group Name |
| password | database password |
| username | database username |

</details>

<!--- END_TF_DOCS --->

<!--- START_FOOTER --->
## Additional Documentation
- [CONTRIBUTING.md](https://github.com/sede-x/innersource-iac-doc/blob/main/CONTRIBUTING.md)
- [SECURITY.md](https://github.com/sede-x/innersource-iac-doc/blob/main/SECURITY.md)
- [ISSUE_TEMPLATE.md](https://github.com/sede-x/innersource-iac-doc/blob/main/ISSUE_TEMPLATE.md)
- [TF_MODULE_STRUCTURE.md](https://github.com/sede-x/innersource-iac-doc/blob/main/TF_MODULE_STRUCTURE.md)
- [PULL_REQUEST_CHECKLIST.md](https://github.com/sede-x/innersource-iac-doc/blob/main/PULL_REQUEST_CHECKLIST.md)
- [EACH_STEP.md](https://github.com/sede-x/innersource-iac-doc/blob/main/EACH_STEP.md)
- [PLAYBOOK.md](https://github.com/sede-x/innersource-iac-doc/blob/main/PLAYBOOK.md)
- [IIaC_Flow.svg](https://github.com/sede-x/innersource-iac-doc/blob/main/IIaC_Flow.svg)
- [TERRAFORMBESTPRACTICE.md](https://github.com/sede-x/innersource-iac-doc/blob/main/TERRAFORMBESTPRACTICE.md)

<!--- END_FOOTER --->

