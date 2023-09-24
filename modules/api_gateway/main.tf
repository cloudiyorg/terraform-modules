resource "aws_api_gateway_rest_api" "project-api" {
  name                         = var.api_gateway_rest_api_name
  disable_execute_api_endpoint = var.api_gateway_rest_api_disable_execute_api_endpoint
  endpoint_configuration {
    types = var.api_gateway_rest_api_endpoint_configuration_types
  }
}

resource "aws_api_gateway_resource" "project-resource" {
  parent_id   = aws_api_gateway_rest_api.project-api.root_resource_id
  path_part   = var.api_gateway_resource_path_part
  rest_api_id = aws_api_gateway_rest_api.project-api.id
}

resource "aws_api_gateway_method" "project-method" {
  rest_api_id   = aws_api_gateway_rest_api.project-api.id
  resource_id   = aws_api_gateway_resource.project-resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "project-integration" {
  rest_api_id             = aws_api_gateway_rest_api.project-api.id
  resource_id             = aws_api_gateway_resource.project-resource.id
  http_method             = aws_api_gateway_method.project-method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = var.api_gateway_integration_uri
}

resource "aws_api_gateway_deployment" "project_api_gateway_deployment" {
  depends_on    = [aws_api_gateway_integration.project-integration]
  rest_api_id   = aws_api_gateway_rest_api.project-api.id
  stage_name    = var.api_gateway_stage_stage_name
}
