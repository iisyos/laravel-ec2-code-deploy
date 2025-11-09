resource "aws_s3_bucket" "artifact" {
  bucket = "${var.app_name}-artifact"
}
