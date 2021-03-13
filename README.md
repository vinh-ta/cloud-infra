# cloud-infra

## Getting started

#### CI/CD Pipeline
The CI/CD process is managed via CircleCI pipelines. 

- Sign up using your GitHub account
- Set the cloud-infra project and select 'Use Existing Config"

##### CircleCI Directory Sturcture
For reference, this project using Linux machines. The standard directory structure is shown below where the default working directory is `home/circleci/project/`.
```
├── home/
│   └── circleci/
│       └── project/<default working directory>
├── root/
└── <... other Linux directories>
```

#### Infrastructure as code
The state management and deployment of cloud resources is managed by Terraform and Terraform Cloud.

- Create a Terraform Cloud account
- Set up a workspace
- Update the Terraform configuration:
	- Go to `terraform/main.tf`
	- Replace the organisation and workspace name with your own settings -> `terraform` -> `backend remote`

#### Authentication

##### Authenticating Terraform Cloud
- Create a user API token from Terraform Cloud
- Create a `example_credentials.json` file with the following structure 
```
  {
    "credentials": {
      "app.terraform.io": {
        "token": "<TERRAFORM_API_KEY>"
      }
    }
  }
``` 
- Encode the credentials file to a string
  `cat example_credentials.json | base64`
- Store the encoded string as an environment variable on CircleCI with key: `ENCODED_TF_CREDENTIALS` 

##### Authenticating AWS
- Go to the AWS console and create an IAM admin user and save the access key id and secret access key generated
- Store the credentials as environment variables on Terraform Cloud with the keys `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

##### Authenticating GCP
- Update the Terraform configuration:
  - Go to `terraform/main.tf`
	- Replace the project id -> `provider google` -> `project id`
- Go to the GCP console and create a service account credentials file for your project
- Generate a string from your credentials file 
  `tr -d '\n\ ' < service_credentials.json`
- Store the string on Terraform Cloud with the key `GOOGLE_CREDENTIALS`
