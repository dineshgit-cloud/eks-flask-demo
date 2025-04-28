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

  vpc_id     = "vpc-0c6a4bcbe019bd0b3"
  subnet_ids = [
    "subnet-05be2fee0a8c9c8f2",
    "subnet-0f472ebd63e2e5455"
    ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}