terraform {
  backend "remote" {
    organization = "tres-comas"
    workspaces {
      name = "cloud-infraterraf"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0b6b51e397faf2316"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}