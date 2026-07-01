resource "aws_s3_bucket" "logs_bucket" {
  bucket = "devops-logs-storage-bucket-12345"

  tags = {
    Name = "logs-bucket"
  }
}