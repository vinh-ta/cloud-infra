terraform {
  backend "remote" {
    organization = "tres-comas"
    workspaces {
      name = "cloud-infra"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.32.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 3.59.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

provider "google" {
  project     = "cloud-infra-306917"
  region      = "europe-west2"
}

resource "aws_instance" "example" {
  ami           = "ami-0b6b51e397faf2316"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}

resource "google_storage_bucket" "static-site" {
  name          = "image-store-vinh1234"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true
}