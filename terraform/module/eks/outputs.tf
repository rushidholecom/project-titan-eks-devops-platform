output "cluster_name" {
  description = "EKS cluster name."
  value       = aws_eks_cluster.titan_eks.name
}

output "aws_load_balancer_controller_role_arn" {
  description = "IAM role used by AWS Load Balancer Controller."
  value       = aws_iam_role.aws_load_balancer_controller.arn
}
