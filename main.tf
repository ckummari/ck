# Authentication to AWS from Terraform code 
provider "aws" {
    region = "us-east-1"
    profile = "default"
}

#Provide Required Module for Testing

# Setup for Terraform & AWS Provider
terraform {
  required_version = ">=0.14.5"
}

# Source code to test 

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
