
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.ecsCluster.alb_dns_name
}
