**🖼️ Serverless Image Processing Application 
**
A complete DevOps project that implements a serverless image processing application using AWS services, Terraform for IaC, and GitHub Actions for CI/CD.
The application automatically processes uploaded images by resizing them and adding watermarks.

**🏗️ AWS Architecture Overview
**
![AWS Serverless Image Processing Architecture](AWS-Arch.png)

This diagram shows the serverless image processing workflow using
Amazon S3, AWS Lambda, IAM, and CloudWatch.

**☁️ AWS Services Used
**
🪣 Amazon S3
<span style="color:green;">✔ Stores original and processed images</span>
<span style="color:green;">✔ Triggers Lambda functions on upload</span>
<span style="color:green;">✔ Encryption + versioning enabled</span>

⚡ AWS Lambda
<span style="color:blue;">✔ Resizes images (320px, 640px, 1024px)</span>
<span style="color:blue;">✔ Adds watermarks</span>
<span style="color:blue;">✔ Runs on Node.js 18.x runtime</span>

🔐 AWS IAM
<span style="color:purple;">✔ Manages least-privilege permissions</span>
<span style="color:purple;">✔ Grants Lambda access to S3</span>

📊 Amazon CloudWatch
<span style="color:orange;">✔ Logs Lambda executions</span>
<span style="color:orange;">✔ Provides monitoring & debugging</span>

**⚙️ GitHub Actions Workflows
**🚀 Deploy Workflow

Trigger: Manual dispatch

Purpose: Deploy or update infrastructure

Steps: Checkout → AWS credentials → Node.js setup → Install Lambda deps → Terraform init → Plan → Apply

**💥 Destroy Workflow
**
Trigger: Manual dispatch

Purpose: Remove all deployed resources

Steps: Checkout → AWS credentials → Node.js setup → Terraform init → Destroy

**🔑 Prerequisites
**
AWS account with required permissions

Terraform installed locally

GitHub account

Created an S3 bucket for Terraform state storage:
aws s3api create-bucket \
  --bucket mahmoud011-terraform-tfstate-bucket \
  --region us-east-1

Enable versioning:

aws s3api put-bucket-versioning \
  --bucket mahmoud011-terraform-tfstate-bucket \
  --versioning-configuration Status=Enabled

📌 Usage Instructions
Upload Images

Upload to: uploads/ folder in the original S3 bucket

Example:

my-original-images-mahmoudh20/uploads/sample.jpg

Retrieve Processed Images

Available in processed S3 bucket

Organized by size:

processed/imagename_320px.jpg

processed/imagename_640px.jpg

processed/imagename_1024px.jpg

Customize Processing

Update image_sizes in terraform.tfvars

Change watermark_text for custom watermark

**🛠️ Troubleshooting
**
Lambda Function Not Triggered
✅ Ensure upload goes to uploads/ folder
✅ Verify S3 event notifications

Lambda Function Errors
🔎 Check CloudWatch logs
🔎 Verify dependencies

Permission Errors
🔐 Confirm IAM roles & AWS credentials
