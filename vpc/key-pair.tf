resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "ssh_key" {
  public_key = tls_private_key.key.public_key_openssh
  key_name = "ssh_key"
}

resource "local_file" "private_file" {
  content = tls_private_key.key.private_key_pem
  file_permission = 0400
  filename = "${path.module}/ssh_key.pem"

}