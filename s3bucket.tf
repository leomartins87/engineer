#Create a S3 bucket

resource "aws_s3_bucket" "mybucket" {
        bucket = "mybucket-2023-leonardolm"
        tags   = {
                Description = "Temporary bucket for a test"
        }
}

#Create test file for the bucket

resource "aws_s3_object" "test-file-4-bucket" {
        content = "/root/testfile.txt"
        key     = "testfile.txt"
        bucket  = aws_s3_bucket.mybucket.id
        }
