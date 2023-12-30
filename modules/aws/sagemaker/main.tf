provider "aws" {
  region = var.region
}

resource "aws_sagemaker_model" "genai_model" {
  name             = var.model_name
  role_arn         = var.role_arn
  primary_container {
    image = var.image_uri
    model_data_url = var.model_data_url
  }
}

resource "aws_sagemaker_endpoint_configuration" "genai_endpoint_config" {
  name = var.endpoint_config_name
  production_variants {
    variant_name   = "production"
    model_name     = aws_sagemaker_model.genai_model.name
    initial_instance_count = var.instance_count
    instance_type  = var.instance_type
  }
}

resource "aws_sagemaker_endpoint" "genai_endpoint" {
  name               = var.endpoint_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.genai_endpoint_config.name
}
