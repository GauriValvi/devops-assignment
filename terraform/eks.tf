module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"

  cluster_name    = var.cluster_name
  cluster_version = "1.34"

  # Keep this fix to avoid the kubectl 401 error once the nodes deploy!
  enable_cluster_creator_admin_permissions = true

  cluster_endpoint_public_access = true

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  eks_managed_node_groups = {
    worker_group = {
      desired_size = 2
      min_size     = 2
      max_size     = 4

      # CHANGED from t3.medium to t3.micro to allow deployment on your Free Tier account
      instance_types = ["t3.micro"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Environment = "dev"
  }
}