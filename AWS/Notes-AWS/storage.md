EC2 Storage and AMIs 
EBS

Q: What is EBS?
A virtual storage drive attached to an EC2 instance.

Q: Does its data survive?
Yes, when the instance is stopped. On termination, it depends on the Delete on Termination setting.

Q: Where can it be used?
Within one Availability Zone. Use a snapshot to create a copy in another AZ.

Remember: EBS = persistent storage for an EC2 instance.

AMI

Q: What is an AMI?
A blueprint used to create EC2 instances.

Q: What can it contain?
The operating system, software and configuration.

Q: Why use one?
To quickly launch multiple EC2 instances with the same setup.

Q: Can it be used in another Region?
Yes, but it must first be copied to that Region.

Remember: AMI = EC2 blueprint.

EFS

Q: What is EFS?
A shared file system that multiple EC2 instances can access simultaneously.

Q: Does it scale automatically?
Yes. It grows and shrinks with the amount of data stored.

Q: Is it highly available?
Standard EFS stores data across multiple Availability Zones.

Q: When should it be used?
When several EC2 instances need access to the same files.

Q: What is the disadvantage?
It can be more expensive than EBS.

Remember: EFS = shared storage for multiple EC2 instances.

Final Comparison
Service	Main purpose
EBS	Persistent drive for an EC2 instance
AMI	Blueprint for creating identical EC2 instances
EFS	Shared files for multiple EC2 instances