output "hello_world_dangamboa_api_endpoint" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}

output "custom_domain_url" {
  value = var.custom_domain
}