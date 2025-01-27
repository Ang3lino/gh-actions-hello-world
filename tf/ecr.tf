resource "aws_ecr_repository" "hello_repo" {
  name = local.ecr_repo_name
}
