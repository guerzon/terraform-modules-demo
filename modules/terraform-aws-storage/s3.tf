
resource "aws_s3_bucket" "files" {
  bucket = lower("${var.customer}-${var.environment}-files")
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-files")
  })
}

resource "aws_s3_bucket_acl" "files_acl" {
  bucket =  aws_s3_bucket.files.id
  acl    =  "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "files_enc" {
  bucket = aws_s3_bucket.files.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "files_block_public" {
  bucket                  = aws_s3_bucket.files.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_metric" "files_metric" {
  bucket = aws_s3_bucket.files.id
  name   = "Files-bucket-metrics"
}

resource "aws_s3_bucket_versioning" "files_vers" {
  bucket = aws_s3_bucket.files.id
  versioning_configuration {
    status = "Enabled"
  }
}

# In this demo, we wanted to add versioning and logging, but for the first iteration, we will instead
# keep the module simple and add those later.

## To avoid cycling dependency between the storage and security modules,
## manage the IAM policy for the s3 bucket.

resource "aws_iam_policy" "files_iampolicy" {
  name  =  lower("${var.customer}-${var.environment}-files-iampolicy")
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-files-iampolicy")
  })
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutAnalyticsConfiguration",
                "s3:PutAccessPointConfigurationForObjectLambda",
                "s3:GetObjectVersionTagging",
                "s3:DeleteAccessPoint",
                "s3:CreateBucket",
                "s3:DeleteAccessPointForObjectLambda",
                "s3:GetStorageLensConfigurationTagging",
                "s3:ReplicateObject",
                "s3:GetObjectAcl",
                "s3:GetBucketObjectLockConfiguration",
                "s3:DeleteBucketWebsite",
                "s3:GetIntelligentTieringConfiguration",
                "s3:PutLifecycleConfiguration",
                "s3:GetObjectVersionAcl",
                "s3:DeleteObject",
                "s3:CreateMultiRegionAccessPoint",
                "s3:GetBucketPolicyStatus",
                "s3:GetObjectRetention",
                "s3:GetBucketWebsite",
                "s3:GetJobTagging",
                "s3:GetMultiRegionAccessPoint",
                "s3:PutReplicationConfiguration",
                "s3:GetObjectAttributes",
                "s3:PutObjectLegalHold",
                "s3:InitiateReplication",
                "s3:GetObjectLegalHold",
                "s3:GetBucketNotification",
                "s3:PutBucketCORS",
                "s3:DescribeMultiRegionAccessPointOperation",
                "s3:GetReplicationConfiguration",
                "s3:ListMultipartUploadParts",
                "s3:PutObject",
                "s3:GetObject",
                "s3:PutBucketNotification",
                "s3:DescribeJob",
                "s3:PutBucketLogging",
                "s3:GetAnalyticsConfiguration",
                "s3:PutBucketObjectLockConfiguration",
                "s3:GetObjectVersionForReplication",
                "s3:GetAccessPointForObjectLambda",
                "s3:GetStorageLensDashboard",
                "s3:CreateAccessPoint",
                "s3:GetLifecycleConfiguration",
                "s3:GetInventoryConfiguration",
                "s3:GetBucketTagging",
                "s3:PutAccelerateConfiguration",
                "s3:GetAccessPointPolicyForObjectLambda",
                "s3:DeleteObjectVersion",
                "s3:GetBucketLogging",
                "s3:ListBucketVersions",
                "s3:RestoreObject",
                "s3:ListBucket",
                "s3:GetAccelerateConfiguration",
                "s3:GetObjectVersionAttributes",
                "s3:GetBucketPolicy",
                "s3:PutEncryptionConfiguration",
                "s3:GetEncryptionConfiguration",
                "s3:GetObjectVersionTorrent",
                "s3:AbortMultipartUpload",
                "s3:GetBucketRequestPayment",
                "s3:GetAccessPointPolicyStatus",
                "s3:UpdateJobPriority",
                "s3:GetObjectTagging",
                "s3:GetMetricsConfiguration",
                "s3:GetBucketOwnershipControls",
                "s3:DeleteBucket",
                "s3:PutBucketVersioning",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetMultiRegionAccessPointPolicyStatus",
                "s3:ListBucketMultipartUploads",
                "s3:PutIntelligentTieringConfiguration",
                "s3:GetMultiRegionAccessPointPolicy",
                "s3:GetAccessPointPolicyStatusForObjectLambda",
                "s3:PutMetricsConfiguration",
                "s3:PutBucketOwnershipControls",
                "s3:DeleteMultiRegionAccessPoint",
                "s3:UpdateJobStatus",
                "s3:GetBucketVersioning",
                "s3:GetBucketAcl",
                "s3:GetAccessPointConfigurationForObjectLambda",
                "s3:PutInventoryConfiguration",
                "s3:GetObjectTorrent",
                "s3:GetStorageLensConfiguration",
                "s3:DeleteStorageLensConfiguration",
                "s3:PutBucketWebsite",
                "s3:PutBucketRequestPayment",
                "s3:PutObjectRetention",
                "s3:CreateAccessPointForObjectLambda",
                "s3:GetBucketCORS",
                "s3:GetBucketLocation",
                "s3:GetAccessPointPolicy",
                "s3:ReplicateDelete",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "${aws_s3_bucket.files.arn}",
                "${aws_s3_bucket.files.arn}/*",
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:ListStorageLensConfigurations",
                "s3:ListAccessPointsForObjectLambda",
                "s3:GetAccessPoint",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "s3:ListAccessPoints",
                "s3:ListJobs",
                "s3:PutStorageLensConfiguration",
                "s3:ListMultiRegionAccessPoints",
                "s3:CreateJob"
            ],
            "Resource": "*"
        }
    ]
  })
}

resource "aws_iam_role" "files_iamrole" {
  name = lower("${var.customer}-${var.environment}-files-iamrole")
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-files-iamrole")
  })
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
  })
}

resource "aws_iam_instance_profile" "files_instanceprofile" {
  name = lower("${var.customer}-${var.environment}-files-instanceprofile")
  role = aws_iam_role.files_iamrole.name
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-files-instanceprofile")
  })
}

resource "aws_iam_role_policy_attachment" "files_iampolicy_attachment" {
  role       = aws_iam_role.files_iamrole.name
  policy_arn = aws_iam_policy.files_iampolicy.arn
}

### Logging bucket ###

resource "aws_s3_bucket" "files_logging_bucket" {
  bucket = lower("${var.customer}-${var.environment}-files-logs")
  force_destroy = local.is_production
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-files-logs")
  })
}

resource "aws_s3_bucket_acl" "files_logging_acl" {
  bucket =  aws_s3_bucket.files_logging_bucket.id
  acl    =  "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "files_logging_enc" {
  bucket = aws_s3_bucket.files_logging_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "files_logging_vers" {
  bucket = aws_s3_bucket.files_logging_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}
