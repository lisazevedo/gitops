resource "aws_iam_role" "ec2_ssm_role" {
    name = "ec2_ssm_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = {
                    Service = ["ec2.amazonaws.com"]
                }
                Action = ["sts:AssumeRole"]
            }
        ]
    })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
    name = "ec2_instance_profile"
    role = aws_iam_role.ec2_ssm_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment"{
    role = aws_iam_role.ec2_ssm_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] 
}

resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Federated = aws_iam_openid_connect_provider.github.arn },
      Action    = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
          "token.actions.githubusercontent.com:sub" = "repo:${var.github_org}/${var.github_repo}:*"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "github_actions_policy" {
  name        = "github-actions-policy"
  description = "Allows running commands on EC2 via SSM and pulling from ECR"

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ssm:SendCommand",
          "ssm:GetCommandInvocation"
        ],
        Resource = [
          aws_instance.web_server.arn,
          "arn:aws:ssm:*:*:document/AWS-RunShellScript"
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_policy_attach" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}