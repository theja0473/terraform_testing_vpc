variable "region" {
  description = "AWS region"
}

variable "model_name" {
  description = "Name of the SageMaker model"
}

variable "role_arn" {
  description = "ARN of the IAM role for SageMaker"
}

variable "image_uri" {
  description = "URI of the Docker image containing the GenAI application"
}

variable "model_data_url" {
  description = "S3 URL of the trained model data"
}

variable "endpoint_config_name" {
  description = "Name of the SageMaker endpoint configuration"
}

variable "instance_count" {
  description = "Number of instances in the SageMaker endpoint"
}

variable "instance_type" {
  description = "Instance type for the SageMaker endpoint"
}

variable "endpoint_name" {
  description = "Name of the SageMaker endpoint"
}
