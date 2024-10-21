cidr_block          = "17.0.0.0/16"
project_name        = "swiggy"
project_environment = "development"
region              = "us-east-2"
access_key          = "add access key"
secret_key          = "add secret key"
owner               = "Anitta"
bits                = 4
frontend_ports      = ["80", "443"]
backend_ports       = ["80", "443"]
bastion_ports       = ["22"]
ssh_port            = "22"
instance_type = { "production" = "t2.small"
"development" = "t2.micro" }
ami_id_map = {
  "ap-south-1" = "ami-078264b8ba71bc45e"
  "us-east-1"  = "ami-0fff1b9a61dec8a5f"
  "us-east-2"  = "ami-09da212cf18033880"
}
troubleshooting          = true
desired_size             = 2
max_size                 = 4
min_size                 = 1
enable_elb_health_checks = { "production" = true, "development" = false }
domain_name              = "anitta.cloud"
