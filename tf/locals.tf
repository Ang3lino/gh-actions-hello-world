locals {
  # General App Name for Reuse
  app_name   = "hello-actions"
  app_prefix = local.app_name # Consistent prefix for all resources

  # ECR Repository
  ecr_repo_name = "${local.app_prefix}-ecr-repo"

  # ECS Cluster and Task
  demo_app_cluster_name        = "${local.app_prefix}-cluster"
  demo_app_task_famliy         = "${local.app_prefix}-task"
  demo_app_task_name           = "${local.app_prefix}-task"
  container_port               = 8080
  ecs_task_execution_role_name = "${local.app_prefix}-task-execution-role"

  # Load Balancer and Target Group
  application_load_balancer_name = "cc-${local.app_prefix}-alb"
  target_group_name              = "cc-${local.app_prefix}-alb-tg"

  # ECS Service
  demo_app_service_name = "cc-${local.app_prefix}-service"

  # Networking
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
