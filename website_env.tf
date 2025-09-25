resource "local_file" "s3_env" {
  filename        = "${path.module}/s3-js-service/.env"
  content         = <<-EOT
    PORT=3000
    BUCKET_NAME=${aws_s3_bucket.demo.bucket}
    S3_ENDPOINT=http://localhost:4566
    AWS_REGION=us-east-1
    AWS_ACCESS_KEY_ID=test
    AWS_SECRET_ACCESS_KEY=test
    FORCE_PATH_STYLE=true
  EOT
  file_permission = "0644"
}
