resource "aws_ecs_cluster" "project_ecs_cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = var.ecs_container_insights_settings
  }
}