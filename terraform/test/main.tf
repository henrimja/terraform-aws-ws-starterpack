variable "s3_bucket_names" {
    type = list
    default = ["server-asset020297", "host020297"]
}

resource "aws_s3_bucket" "b" {
    count = length(var.s3_bucket_names)
  bucket = var.s3_bucket_names[count.index]

  tags = {
    Name        = "gruppe 12 bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "b" {
    for_each = aws_s3_bucket.b

  bucket = each.key

  policy = templatefile("${policy/public_bucket.json.tpl}", { bucket_arn = arn:aws:s3:::server-asset020297 })
}