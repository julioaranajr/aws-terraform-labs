# Terraform Labs
Exercise with Terraform: 
- Setup provider
- Create S3 bucket for backend. 
- Create a DynamoDB table.
- Pre Deploy infrastructure.
- Create a .gitignore file. 
- Push the changes.

# Terraform

> **Steps**:
Make sure to execute this exercise by following the steps in the right order:
> - [Step 1: Provider](#step1)
> - [Step 2: Create S3 bucket for backend](#step2)
> - [Step 3: Initialize to get ready for a Plan](#step3)
> - [Step 4: Deploy your infrastructure](#step4)
> - [Step 5: Create backend configuration](#step5)
> - [Step 6: Relaunch the initialization](#step6)
> - [Step 7: Create a DynamoDB for concurrency lock](#step7)
> - [Step 8: Deploy infrastructure](#step8)
> - [Step 9: Add lock to backend configuration](#step9)
> - [Step 10: relaunch the initialization](#step10)
> - [Step 11: Create a .gitignore](#step11)
> - [Step 12: Push your changes](#step12)

## <a name="step1"></a>Step 1: Provider

- Start by exporting the right profile and region to start working with terraform:
```sh
export AWS_PROFILE="talent-academy"
export AWS_DEFAULT_REGION="eu-central-1"
```

- Clone or Create a new working folder to start your backend creation:

```sh
git clone github.com/test/new-project-folder
cd new-project-folder
```

- Start by setting up your provider to define which cloud plugins our project will require to deploy the resources.

> **Create a new file:** `provider.tf`

```sh
provider "aws" {
  region = "eu-central-1"
}
```

## <a name="step2"></a>Step 2: Create S3 bucket for backend

> **Create a new file:** `main.tf`
- `main.tf` file define all the resources we are about to create, which is an S3 bucket named for example: `talent-academy-account_id-tfstates-aws.your.account.ID`

- Fine more about the resource `aws_s3_bucket` from the [terraform documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

```sh
resource "aws_s3_bucket" "ta_backend_bucket" {
    bucket = "ta-terraform-tfstates-talent-academy-account_id-tfstates-aws.your.account.ID"

    lifecycle {
      prevent_destroy = true
    }

    tags = {
        Name = "ta-terraform-tfstates-talent-academy-account_id-tfstates-aws.your.account.ID"
        Environment = "Test"
        Team        = "Talent-Academy"
        Owner       = "yourname"
    }
}

resource "aws_s3_bucket_versioning" "version_my_bucket" {
  bucket = 

  versioning_configuration {
    status = "Enabled"
  }
}

```

## <a name="step3"></a>Step 3: Initialize to get ready for a Plan

That should be enough to get started and verify that everything is setup properly.

```sh
# Start initialization
terraform init

# Run a plan to check your code
terraform plan
```

## <a name="step4"></a>Step 4: Deploy your infrastructure

When you are satisfied with the `plan`, you can deploy your changes with the `apply` command, and type in `yes` to execute:

```sh
terraform apply
```

## <a name="step5"></a>Step 5: Create backend configuration

The creation of the S3 bucket allows us to use it as our backend to store our `terraform.tfstates`.

> **Create a new file:**  `backend.tf` 
This will configure the s3 bucket for the backend.

```sh
terraform {
  backend "s3" {
    bucket = "talent-academy-account_id-tfstates-aws.your.account.ID"
    key    = "sprint1/week2/training-terraform/terraform.tfstates"
  }
}
```

Make sure to use the same `bucket name` as the one you have deployed before. The `key` is the location of the file where the `terraform.tfstates` needs to be stored inside the bucket.

## <a name="step6"></a>Step 6: Relaunch the initialization

Relaunch the initialization to allow terraform to apply the changes of the backend.

```sh
terraform init -reconfigure
```

## <a name="step7"></a>Step 7: Create a DynamoDB for concurrency lock

To avoid concurrent `apply` against the same infrastructure, it's best practice to use a `dynamodb table` to manage a lock file that will prevent multiple parallel deployment.

In the `main.tf` file, create a new resource for the `aws_dymanodb_table`.

```sh
resource "aws_dynamodb_table" "terraform_lock_tbl" {
  name           = "terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags           = {
    Name = "terraform-lock"
  }
}
```

## <a name="step8"></a>Step 8: Deploy infrastructure

Again, run another `terraform plan and apply`.

## <a name="step9"></a>Step 9: Add lock to backend configuration

Modify the `backend.tf` file again to add the new dynamo db table lock

```sh
terraform {
  backend "s3" {
    bucket = "talent-academy-account_id-tfstates-aws.your.account.ID"
    key    = "sprint1/week2/training-terraform/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}
```

## <a name="step10"></a>Step 10: Relunch the initialization

With the new configuration within the `backend.tf` file, let's reconfigure the
project to make sure all changes are applied:

```sh
terraform init -reconfigure
```

## <a name="step11"></a>Step 11: Create a .gitignore

> **Create a new file:** `.gitignore`
Before pushing your work, we need to make sure that certain files and folders are not part of the repository, for example binaries or temporary files. The `tfstates` should never be saved locally or in your source control tool. You can let git knows to ignore these files using a `.gitignore` hidden file.

In the `.gitignore file`, add the following list of files and folders

```sh
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# lock file
.terraform.lock.hcl
```

## <a name="step12"></a>Step 12: Push your changes

Your `git status` should now ignore the file listed above. You can now add, commit and push your new codes:
```sh
git add .
git commit -m "Setting up backend to work with terraform"
git push
```
