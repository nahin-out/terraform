resource "random_string" "suffix" {
    length = 6
    upper = false
    special = false
}

#Bucket-name-pattern
resource "aws_s3_bucket" "nahin" {
    bucket = "${terraform.workspace}-nahin-demo-${random_string.suffix.result}"
    force_destroy = true 
}

#Block public access for safety
resource "aws_s3_bucket_public_access_block" "name" {
    bucket = aws_s3_bucket.nahin.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
      
}

output "bucket_name" {
    value =aws_s3_bucket.nahin.bucket
  
}