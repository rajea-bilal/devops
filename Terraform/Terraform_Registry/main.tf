module "ec2" {
  source = "./modules/ec2/" # this is the path to the ec2 module 
}

// these two addresses refer to the same instance. i moved its code
moved {
  from = aws_instance.this
  to = module.ec2.aws_instance.this
}