resource "aws_iam_role" "sagemaker_role" {
  name = var.sagemaker_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sagemaker.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "sagemaker_policy_attachment" {
  policy_arn = var.sagemaker_policy_arn
  role       = aws_iam_role.sagemaker_role.name
}
