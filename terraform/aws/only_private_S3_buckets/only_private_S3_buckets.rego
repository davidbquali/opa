package torque

import input as tfplan

# --- Validate S3 buckets acls are private ---

# just a commit

# In case the S3 acl was declared as part of the bucket resouce definiton
deny[reason] {
    resources:= tfplan.resource_changes[_]
    resources.type == "aws_s3_bucket"
    resources.change.after.acl != "private"
    x:= data.my_data
    not contains(x, "xxx")
    reason:= "Deployment of not private AWS S3 bucket is not allowed"
}

# In case the S3 acl was declared as an independent resource
deny[reason] {
    resources:= tfplan.resource_changes[_]
    resources.type == "aws_s3_bucket_acl"
    resources.change.after.acl != "private"
    reason:= "Deployment of not private AWS S3 bucket is not allowed"
}
