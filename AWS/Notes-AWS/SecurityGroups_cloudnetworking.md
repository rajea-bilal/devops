AWS Security Groups and Cloud Networking — Revision Notes
1. Core Structure
Q: Where does an EC2 instance live?

An EC2 instance is created inside this structure:

AWS Region → VPC → Subnet → EC2 instance → Security group

Region: The AWS geographical location.
VPC: Your private network inside AWS.
Subnet: A smaller section of the VPC.
EC2: Your virtual computer.
Security group: Controls allowed traffic to and from the EC2 instance.
2. Security Groups
Q: What is a security group?

A security group is a collection of firewall rules attached to an EC2 instance or another supported AWS resource.

It controls:

Inbound traffic: Traffic entering the resource.
Outbound traffic: Traffic leaving the resource.
Q: What does a security-group rule contain?

A rule normally specifies:

Protocol: TCP, UDP, etc.
Port: Which service can be reached.
Source or destination: Which IP address or security group is allowed.
Q: What is the difference between an IP address and a port?
IP address: Identifies the computer or resource.
Port: Identifies the service running on that computer.

Example:

EC2 public IP: 18.10.20.30
SSH port: 22

Together, they mean: connect to the SSH service on that EC2 instance.

Q: Do security groups have allow and deny rules?

No. Security groups only contain allow rules.

Anything that is not explicitly allowed is automatically blocked.

Q: What are the default security-group rules?
Inbound: All traffic is blocked by default.
Outbound: All traffic is normally allowed by default.

To restrict outbound traffic, remove the “allow all” rule and add only the traffic required.

Q: What does “stateful” mean?

Security groups remember permitted connections.

If an inbound request is allowed, its response is automatically allowed out.
If an outbound request is allowed, its response is automatically allowed back in.

You do not need a separate rule for the response.

Q: Where does a security group operate?

It operates outside the EC2 operating system.

If the security group blocks traffic, that traffic never reaches the instance or application.

Q: How many security groups can be used?
One security group can be attached to multiple resources.
One EC2 instance can have multiple security groups.
When several security groups are attached, their allow rules are combined.
Every EC2 instance must have at least one security group.
Q: Can a security group be used anywhere in AWS?

No. A security group belongs to a particular VPC, which is in a particular Region.

It cannot simply be attached to a resource in another VPC or Region.

3. Inbound and Outbound Traffic
Q: What is inbound traffic?

Traffic coming into an EC2 instance.

Examples:

A user opening your website.
You connecting through SSH.
An application connecting to a database.
Q: What is outbound traffic?

Traffic leaving an EC2 instance.

Examples:

Downloading software updates.
Calling an external API.
Connecting to a database or another service.
Q: What does 0.0.0.0/0 mean?

It means every IPv4 address.

A rule with this source is open to the entire IPv4 internet.

Q: What does ::/0 mean?

It means every IPv6 address.

It is the IPv6 equivalent of 0.0.0.0/0.

Q: What does /32 mean in an IPv4 rule?

It means one specific IPv4 address.

Example:

122.149.196.85/32

Only that IP address is allowed.

4. Important Ports
Service	Port	Purpose
SSH	22	Log in to Linux securely
SFTP	22	Transfer files securely through SSH
FTP	21	Older, insecure file transfer
HTTP	80	Unencrypted website traffic
HTTPS	443	Encrypted website traffic using TLS
DNS	53	Convert domain names into IP addresses
RDP	3389	Log in to Windows remotely
SMTP	25	Send email between mail servers
MySQL	3306	Connect to MySQL
PostgreSQL	5432	Connect to PostgreSQL
Q: Which ports should be open to the internet?

For a public website:

Port 80 for HTTP.
Port 443 for HTTPS.

Sensitive ports should normally be restricted:

SSH 22
RDP 3389
MySQL 3306
PostgreSQL 5432
Q: Does adding a security-group rule start the application?

No.

A rule only allows traffic to reach the port. The application must also be:

Running.
Listening on that port.
Correctly configured.

For a connection to work, you need both:

A security-group rule allowing the traffic.
A running application listening on that port.
5. Referencing Security Groups
Q: Can a security-group rule reference another security group?

Yes. A rule can allow traffic from resources attached to another security group instead of using their IP addresses.

Q: Why reference a security group instead of an IP address?

EC2 instances can be created, removed or given new IP addresses during Auto Scaling.

Security-group references continue working even when the individual instances and IP addresses change.

Q: What are Application-SG and Database-SG?

They are names given to two different security groups:

Application-SG: Attached to application EC2 instances.
Database-SG: Attached to the database.

They are collections of rules—not individual rules.

Q: How would an application be allowed to reach PostgreSQL?

The database uses Database-SG.

Its inbound rule could say:

Protocol: TCP
Port: 5432
Source: Application-SG

This means resources attached to Application-SG may connect to the database on port 5432.

It does not check whether a particular application is installed. It checks which security group is attached to the source resource.

The database must still be running, listening on port 5432 and require valid login credentials.

Q: Does referencing another security group allow every port?

No. It permits only the protocol and port stated in the rule.

6. Troubleshooting Connections
Q: What usually causes a connection timeout?

A timeout means traffic may not be reaching the application.

Check:

Security-group rules.
Correct port.
Allowed source IP.
Network routes.
Whether the resource is reachable from that network.
Q: What usually causes “connection refused”?

It usually means the traffic reached the instance, but nothing accepted it.

Possible causes:

The application is not running.
It is listening on a different port.
It is listening only on localhost.
An operating-system firewall is blocking it.
Q: What should I check when an EC2 website does not work?
Is the application running?
Which port is it listening on?
Does the security group allow that port?
Is the correct source IP allowed?
Does the EC2 instance have the required public networking and routes?
7. VPC Basics
Q: What is a VPC?

VPC means Virtual Private Cloud.

It is your private network inside AWS where resources such as EC2 instances and databases are placed.

Q: What does a VPC control?

A VPC controls:

Available private IP addresses.
Subnets.
Network routes.
Communication between resources.
Connections to the internet and other networks.
Q: What is a subnet?

A subnet is a smaller network inside a VPC.

Resources such as EC2 instances are launched into a subnet.

Q: What is a public subnet?

A public subnet has a route to an Internet Gateway.

An EC2 instance also needs a public IP address to communicate directly with the internet over IPv4.

Q: What is a private subnet?

A private subnet does not provide resources with direct inbound access from the internet.

Its resources can use a NAT Gateway when they need outbound internet access.

8. IPv4 and IPv6
Q: What is IPv4?

Example: 10.160.10.240

Four numbers separated by dots.
Each number ranges from 0 to 255.
Uses 32 bits.
Provides about 4.3 billion total addresses.
Older and still widely used.
Q: What is IPv6?

Example:

2001:0db8:85a3:0000:0000:8a2e:0370:7334

Uses hexadecimal numbers separated by colons.
Uses 128 bits.
Provides vastly more addresses.
Created because available IPv4 addresses were running out.
9. Private and Public IP Addresses
Q: What is a private IP address?

A private IP is used for communication inside a private network.

Examples:

10.0.0.5
192.168.1.10

Private IP addresses:

Are not routed directly across the public internet.
Can be reused in different private networks.
Q: What is a public IP address?

A public IP is used for communication over the internet.

It must be globally unique, although many devices inside one private network can share a public IP through NAT.

Q: What happens when you visit a website from home?
Your device sends a request using its private IP.
Your router sends it to the internet using your network’s public IP.
The website returns the response to the public IP.
The router forwards it to the correct private device.
Q: What is NAT?

NAT means Network Address Translation.

It translates between private and public IP addresses.

Q: What is an Internet Gateway in AWS?

An Internet Gateway connects a VPC to the internet.

For direct IPv4 internet access, a resource normally needs:

A public IP address.
A route to the Internet Gateway.
Suitable security-group rules.
Q: What is a NAT Gateway?

A NAT Gateway allows resources in a private subnet to initiate connections to the internet without accepting connections initiated from the internet.

It is commonly used for:

Downloading updates.
Installing packages.
Calling external APIs.
10. Elastic IP Addresses
Q: What happens to a normal EC2 public IP after stopping and starting the instance?

The instance will usually receive a different public IPv4 address.

A reboot does not normally change it, but a full argumento stop and start can.

Q: What is an Elastic IP?

An Elastic IP is a fixed public IPv4 address allocated to your AWS account.

It remains yours until you release it.

Q: What can you do with an Elastic IP?

You can:

Attach it to an EC2 instance.
Keep the same public IP after stopping and starting EC2.
Move it to another instance during failover.

One Elastic IP can be associated with only one resource at a time.

Q: When is an Elastic IP useful?

Use one when an external system genuinely requires a fixed public IP, such as:

IP eingel allowlisting.
A legacy system expecting one fixed address.
Manually moving traffic to a replacement instance.
Q: Does AWS charge for Elastic IPs?

Yes. AWS currently charges for public IPv4 addresses whether they are being used or are idle.

Release unused Elastic IPs to avoid unnecessary charges.

Q: Why should Elastic IPs not be the default design?

They:

Tie traffic to individual resources.
Require manual failover.
Do not automatically distribute traffic.
Do not perform health checks.
Cost money.
Are less suitable for applications that scale.
Q: What is usually better than an Elastic IP?

For a scalable web application, use:

A domain name through DNS.
A load balancer.
Multiple EC2 instances where necessary.

A load balancer:

Provides a stable DNS name.
Distributes requests.
Performs health checks.
Stops sending traffic to unhealthy instances.
Allows instances to be added, removed or replaced.
60-Second Review
VPC: Your private network inside AWS.
Subnet: A smaller network inside a VPC.
EC2: A virtual computer inside a subnet.
Security group: A collection of allow rules attached to resources.
IP address: Identifies a computer or resource.
Port: Identifies a service on that resource.
Inbound: Traffic entering a resource.
Outbound: Traffic leaving a resource.
Default inbound: Blocked.
Default outbound: Allowed.
Stateful: Responses to permitted connections are automatically allowed.
0.0.0.0/0: Every IPv4 address.
/32: One IPv4 address.
Private IP: Used inside a private network.
Public IP: Used across the internet.
NAT: Translates between private and public IPs.
Internet Gateway: Connects a VPC to the internet.
NAT Gateway: Gives private resources outbound internet access.
Elastic IP: A fixed public IPv4 address.
Best practice: Open only the required ports to the smallest necessary source.
Remember: The security group must allow the port, and the application must be running and listening on it.