module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "eks-demo-poc-v1"
  cluster_version = "1.31"

  # Optional
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = "vpc-xxxxxxx"
  subnet_ids = [
    "subnet-xxxxxxxxxx",
    "subnet-xxxxxxxxxxxx"
    ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
