resource "aws_instance" "this" {
  ami                     = local.ami
instance_type             = var.instance_type
 
}

# resource "aws_instance" "import" {
#   ami                     = local.ami
# instance_type             = var.instance_type
# tags = {
#   Name = "terraform-import"
# }
 
# }