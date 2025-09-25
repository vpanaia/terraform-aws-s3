resource "random_id" "suffix" {
  byte_length = 2
}

resource "aws_s3_bucket" "demo" {
  bucket        = "terraform-demo-unipol-academy-${random_id.suffix.hex}"
  force_destroy = true
}
