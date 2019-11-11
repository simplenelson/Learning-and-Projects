provider "aws" {
  region  = "us-east-1"
  profile = "nelson-ong"
}

resource "aws_iam_user" "test" {
  name = "testuser"

}

resource "aws_iam_access_key" "test" {
  user = "${aws_iam_user.test.name}"
}


#keybase account and installation is required on local machine to decrypt password output
#keys will be stored on local machine
#keybase:username of keybase account
resource "aws_iam_user_login_profile" "test" {
  user    = "${aws_iam_user.test.name}"
  pgp_key = "keybase:simeplenelson"
  password_reset_required = "false"
}

#terraform output password | base64 --decode | keybase pgp decrypt
#use git bash cli, will not work on cmd or powershell
output "password" {
  value = "${aws_iam_user_login_profile.test.encrypted_password}"
}

resource "aws_iam_user_policy" "test_policy" {
  name = "test_policy"
  user = "${aws_iam_user.test.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1573498230886",
      "Action": [
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::test-bucket-11111111/*"
    },
    {
      "Sid": "Stmt1573498256130",
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::test-bucket-11111111"
    },
    {
      "Sid": "Stmt1573498308381",
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*"
    }
  ]
}
EOF
}
