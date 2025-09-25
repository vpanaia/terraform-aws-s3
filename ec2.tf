#chiave per ec2

resource "aws_key_pair" "lab_key" {
  key_name   = "lab-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKk4MVCITHDFTE+fUJzrkwAoaHfIlVUsxDW/PCU5Z5r94hiIOOcggonrq2a0W72YGxD8EjKelphg+vYmJz7UQrF0csY3NTGAZcB+xS9dIRWM/rRXfNl+ttiWFODdTbtAOgviR917jRzqq0P5Y0+Ah6kQEhloPFakav10JTOT0cdDMGlTI58HRCFe/OX+A9UT6goJpm/FRv0KznB8v2zVqzuXg5/0o0AMfPNzGJ7OGevMQP4yY7so/K9TkMsadTdS93+aZrbGWFtTB/9NRWkt9UhZxY02CZ5uoy1UnXb5E/lC+4QaFos2tBhg3Yt/10wATlfkqrwvvA2ufBhW75CE59 user@local"
}

#istanza ec2 finta

resource "aws_instance" "web" {
  ami                         = "ami-12345678"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_a.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = aws_key_pair.lab_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "lab-web-ec2"
    Env  = "local"
  }
}
