output "region" {
    value = var.region
} 
output "project_name" {
    value = var.project_name
} 
output "cidr_block_id" {
    value = aws_vpc.vpc.id
} 
# Public subnet
output "public_subnet_az2_id" {
    value = aws_subnet.public_subnet_az2.id
} 
output "public_subnet_az1_id" {
    value = aws_subnet.public_subnet_az1.id
} 
# Private subnet
output "private_subnet_az1_id" {
    value = aws_subnet.private_subnet_az1.id
} 
output "private_subnet_az2_id" {
    value = aws_subnet.private_subnet_az2.id
} 
output "private_data_subnet_az1_id" {
    value = aws_subnet.private_data_subnet_az1.id
}
output "private_data_subnet_az2_id" {
    value = aws_subnet.private_data_subnet_az2.id
} 

output "igw" {
  value = aws_internet_gateway.igw
}