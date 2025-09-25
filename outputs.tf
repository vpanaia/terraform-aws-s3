output "bucket_name" {
  description = "Nome del bucket"
  value       = aws_s3_bucket.demo.bucket
}

output "vpc_id" {
  description = "ID della VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID della Subnet"
  value       = aws_subnet.public_a.id
}

output "security_group_id" {
  description = "ID della Security Group"
  value       = aws_security_group.web_sg.id
}

output "ec2_id" {
  description = "ID dell'istanza EC2"
  value       = aws_instance.web.id
}

output "website_path" {
  description = "Percorso del file index.html"
  value       = "${path.module}/website/index.html"
}