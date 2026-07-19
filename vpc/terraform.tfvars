region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
subnet_cidr = {subnet_1 = "10.0.0.0/28",subnet_2= "10.0.0.16/28"}
subnet_names = ["us-east-1a","us-east-1b"]
sg_names = ["SG_A","SG_B"]
sg_cidr = "0.0.0.0/0"
ports = {http_port = 80, ssh_port = 22}
sg_to_subnet = {SG_A = "subnet_1",SG_B = "subnet_2"}