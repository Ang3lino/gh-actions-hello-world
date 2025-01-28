# Output the DNS name of the Application Load Balancer (ALB)
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_alb.application_load_balancer.dns_name
}

# Output the ALB ARN for reference in other modules or services
output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_alb.application_load_balancer.arn
}

# Output the ECS Cluster Name
output "ecs_cluster_name" {
  description = "The name of the ECS Cluster"
  value       = aws_ecs_cluster.demo_app_cluster.name
}

# Output the ECS Service Name
output "ecs_service_name" {
  description = "The name of the ECS Service"
  value       = aws_ecs_service.demo_app_service.name
}

# Output the ECS Task Definition ARN
output "ecs_task_definition_arn" {
  description = "The ARN of the ECS Task Definition"
  value       = aws_ecs_task_definition.demo_app_task.arn
}

# Output the ECS Task Execution Role ARN
output "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

# Output the Target Group ARN
output "target_group_arn" {
  description = "The ARN of the Target Group for the ALB"
  value       = aws_lb_target_group.target_group.arn
}

# Output the ECS Service Security Group ID
output "ecs_service_security_group_id" {
  description = "The security group ID of the ECS service"
  value       = aws_security_group.service_security_group.id
}

# Output the Load Balancer Security Group ID
output "load_balancer_security_group_id" {
  description = "The security group ID for the ALB"
  value       = aws_security_group.load_balancer_security_group.id
}

# Output the ECS Service Desired Count
output "ecs_service_desired_count" {
  description = "The desired count of tasks in the ECS Service"
  value       = aws_ecs_service.demo_app_service.desired_count
}

# Output the VPC ID for reference
output "vpc_id" {
  description = "The ID of the VPC where resources are deployed"
  value       = aws_default_vpc.default_vpc.id
}

# Output the Subnet IDs for reference
output "subnet_ids" {
  description = "The IDs of the subnets used by the ECS service"
  value       = [
    aws_default_subnet.default_subnet_a.id,
    aws_default_subnet.default_subnet_b.id,
    aws_default_subnet.default_subnet_c.id
  ]
}
