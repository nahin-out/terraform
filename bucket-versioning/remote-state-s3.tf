# provider "aws" {
#     region = "ap-northeast-1"
# }

# resource "aws_s3_bucket" "tf_state" {
#     bucket = "balti-x"
#     force_destroy = true

#     tags = {
#         Name = "terraform-state"
#         Environment = "dev"
#     }  
# }

# resource "aws_s3_bucket_versioning" "tf_state_versioning" {
#     bucket = aws_s3_bucket.tf_state.id

#     versioning_configuration {
#       status = "Enabled"
#     }
# }

# resource "aws_dynamodb_table" "tf_lock" {
#     name = "terraform-locks"
#     billing_mode = "PAY_PER_REQUEST"
#     hash_key = "LockID"

#     attribute {
#       name = "LockID"
#       type = "S"
#     }

#     tags = {
#       Name = "terraform-lock-table"
#       Environment = "dev"
#     }
  
# }