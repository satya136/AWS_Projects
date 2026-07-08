region        = "us-east-1"
http_port     = 80
ssh_port      = 22
env           = "dev"
instance_type = { dev = "t3.micro", prod = "m5.large" }
cidr          = "0.0.0.0/0"