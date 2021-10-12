locals {
  ecs_service_name = "ecs-service"
}

resource "aws_ecs_cluster" "instance" {
  name = "ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "instance" {
  name                               = local.ecs_service_name
  cluster                            = aws_ecs_cluster.instance.id
  task_definition                    = aws_ecs_task_definition.instance.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    assign_public_ip = true
    security_groups  = ["sg-11972e50"]
    subnets = [
      "subnet-24cdfd6f",
      "subnet-6a5e4813"
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.instance.arn
    container_name   = "container-defintion"
    container_port   = 8400
  }

  // Ignored because the autoscaling might change this value once the service is running
  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
}

resource "aws_ecs_task_definition" "instance" {
  family                   = "ecs-task-definition-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  container_definitions = jsonencode([{
    name  = "container-defintion"
    image = join("@", [aws_ecr_repository.instance.repository_url, data.aws_ecr_image.instance.image_digest])
  }])
}

resource "template_dir" "task_definition" {
  source_dir      = "${path.module}/templates"
  destination_dir = "${path.module}/rendered"

  vars = {
    awslogs_group         = aws_cloudwatch_log_group.instance.name
    awslogs_stream_prefix = "application"
    execution_role_arn    = aws_iam_role.ecs_execution_role.arn
    region                = "us-west-2"
  }
}

resource "aws_cloudwatch_log_group" "instance" {
  name              = "/aws/ecs/${local.ecs_service_name}"
  retention_in_days = 1
}

resource "aws_appautoscaling_target" "instance" {
  max_capacity       = 5
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.instance.name}/${aws_ecs_service.instance.name}"
  service_namespace  = "ecs"
  scalable_dimension = "ecs:service:DesiredCount"
}

resource "aws_appautoscaling_policy" "instance" {
  name               = "ecs-cpu-auto-scaling"
  policy_type        = "TargetTrackingScaling"
  service_namespace  = aws_appautoscaling_target.instance.service_namespace
  scalable_dimension = aws_appautoscaling_target.instance.scalable_dimension
  resource_id        = aws_appautoscaling_target.instance.resource_id

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 80
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}
