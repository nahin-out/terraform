terraform {        
        required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
    required_version = ">= 1.6.0"
    
    backend "s3" {
        bucket         = "balti-x"
        key            = "dev/terraform.tfstate"
        region         = "ap-northeast-1"
        dynamodb_table = "terraform-locks"
        encrypt        = true
    }
}

