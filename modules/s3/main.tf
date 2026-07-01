resource "aws_s3_bucket" "artifacts" {
  bucket = "devops-prod-artifacts"

  tags = {
    Environment = "prod"
  }
}