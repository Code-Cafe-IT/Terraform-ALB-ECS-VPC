output "cmc_alb_tgroup_arn" {
  value = aws_alb_target_group.cmc_alb_tgroup.arn
}

output "cmc_alb_dns-name" {
  value = aws_alb.cmc_alb.dns_name
}

output "cmc_alb_zoneid" {
  value = aws_alb.cmc_alb.zone_id
}