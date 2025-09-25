locals {
  index_content = templatefile("${path.module}/website/index.tpl", {
    bucket   = try(aws_s3_bucket.demo.bucket, "N/A")
    ec2id    = try(aws_instance.web.id, "N/A")
    vpcid    = try(aws_vpc.main.id, "N/A")
    subnetid = try(aws_subnet.public_a.id, "N/A")
  })
}

resource "local_file" "index" {
  filename = "${path.module}/website/index.html"
  content = local.index_content
  file_permission = 0644
}