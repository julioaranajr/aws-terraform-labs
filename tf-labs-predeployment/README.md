# Step 1: Provider

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

```javascript
provider "aws" {
  region = "eu-central-1"
}
```
# Step 2: Create S3 bucket for backend

> **Create a new file:** `main.tf`
- `main.tf` file define all the resources we are about to create, which is an S3 bucket named for example: `talent-academy-account_id-tfstates-aws.your.account.ID`

- Fine more about the resource `aws_s3_bucket` from the [terraform documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

```javascript
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
# Step 3: Initialize to get ready for a Plan

That should be enough to get started and verify that everything is setup properly.

```sh
# Start initialization
terraform init

# Run a plan to check your code
terraform plan
```

# Step 4: Deploy your infrastructure

When you are satisfied with the `plan`, you can deploy your changes with the `apply` command, and type in `yes` to execute:

```sh
terraform apply
```

# Step 5: Create backend configuration

The creation of the S3 bucket allows us to use it as our backend to store our `terraform.tfstates`.

> **Create a new file:**  `backend.tf` 
This will configure the s3 bucket for the backend.

```javascript
terraform {
  backend "s3" {
    bucket = "talent-academy-account_id-tfstates-aws.your.account.ID"
    key    = "sprint1/week2/training-terraform/terraform.tfstates"
  }
}
```

Make sure to use the same `bucket name` as the one you have deployed before. The `key` is the location of the file where the `terraform.tfstates` needs to be stored inside the bucket.

# Step 6: Relaunch the initialization

Relaunch the initialization to allow terraform to apply the changes of the backend.

```sh
terraform init 

terraform init -reconfigure

terraform plan

terraform apply

```

# Step 8: Create a .gitignore

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

# Step 912: Push your changes

Your `git status` should now ignore the file listed above. You can now add, commit and push your new codes:
```sh
git add .
git commit -m "Setting up backend to work with terraform"
git push
```