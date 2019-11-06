provider "aws" {
    region = "us-east-1"
    profile = "training"
}

resource "aws_s3_bucket" "b" {
    bucket = "${var.s3_bucket}"
    acl = "private"

    website {
        index_document = "index.html"
        error_document = "index.html"
    }
}

resource "aws_cloudfront_origin_access_identity" "s3-cf-oai" {
  comment = "test origin access identity"
}

resource "aws_cloudfront_distribution" "s3-cf-test" {
    enabled = true
    origin{
        domain_name = "${var.s3_bucket}.s3.amazonaws.com"
        origin_id = "S3-${var.s3_bucket}"

        s3_origin_config {
            origin_access_identity = "${aws_cloudfront_origin_access_identity.s3-cf-oai.cloudfront_access_identity_path}"
        }
    }
    default_root_object = "index.html"

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "S3-${var.s3_bucket}"

        forwarded_values {
            query_string = false

             cookies {
                forward = "none"
            }
        }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
  }
    viewer_certificate {
    cloudfront_default_certificate = true
  }
    
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "${aws_s3_bucket.b.id}"

  policy = <<POLICY
{
  "Id": "Policy1572441608682",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "OAI-policy",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::training.bucket.nong/*",
      "Principal": {
        "AWS": [
          "${aws_cloudfront_origin_access_identity.s3-cf-oai.iam_arn}"
        ]
      }
    }
  ]
}
POLICY
}
