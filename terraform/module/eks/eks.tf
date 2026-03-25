resource "aws_iam_role" "cluster_role" {
  name = "test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "var.env"
  }
}

resource "aws_iam_policy_attachment" "cluster_policy_attachment" {
  name = "cluster_policy_attachment"
  roles = [aws_iam_role.cluster_role]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  depends_on = [ aws_iam_role.cluster_role ]
}

resource "aws_eks_cluster" "titan_eks" {
  name = "${var.project_name}-eks"
  role_arn = aws_iam_role.cluster_role.arn
  vpc_config {
    subnet_ids =  var.subnet_ids.ids
  }
  depends_on = [ aws_iam_policy_attachment.cluster_policy_attachment ]
  timeouts {
    create = "20m"
  }
}