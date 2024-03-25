output "alb_security_group_ids" {
  value = aws_security_group.alb_security_group.id
}

output "ecs_security_groups" {
  value = aws_security_group.ecs_security_groups.id
}