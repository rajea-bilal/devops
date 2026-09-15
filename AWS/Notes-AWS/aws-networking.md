AWS Networking — Complete Q&A Revision

1. AWS networking: the main services

Q1. What does networking mean?
Networking is how computers and resources connect and send data to each other. In AWS, this includes communication inside a VPC, between networks and over the internet.

Q2. What are the main jobs of VPC, Route 53 and CloudFront?

Service Main job
VPC Provides your own network inside AWS.
Route 53 Helps a domain name point to the correct destination through DNS.
CloudFront Delivers content through locations around the world to help it load faster.

Q3. What is DNS?
DNS stands for Domain Name System.

It helps turn a name such as myapp.com into the address needed to reach the app. Route 53 is AWS’s DNS service.

Route 53 does not handle every website’s DNS. It answers for domains configured to use it.

Q4. Does website traffic pass through Route 53?
No. Route 53 provides DNS answers telling the browser where to connect.

It can give different answers to direct users towards suitable destinations, including destinations chosen to improve performance.

Q5. How does CloudFront work?
CloudFront is a Content Delivery Network—CDN.

It can keep copies of website files, images and videos at edge locations around the world. Keeping copies is called caching.

Users can receive content from a nearby location. If the content is not available there, CloudFront retrieves it from its original source.

2. IP addresses and CIDR

Q6. Why does an EC2 instance need an IP address?
An EC2 instance is a computer. Its IP address tells other computers where to send data to communicate with it.

Q7. What is the difference between a private and public IPv4 address?

Private IPv4 Public IPv4
Used inside private or privately connected networks. Can be reached from the internet if the network and security settings allow it.
Cannot be accessed directly over the public internet. Does not automatically allow everyone to connect.

Q8. Why can one EC2 instance have both addresses?
They support different connections to the same computer.

Another resource inside the VPC can use its private IP.
An internet user can use its public IP, if access is allowed.

An instance that only needs private communication does not need its own public IP.

Q9. Can separate private networks use the same IP addresses?
Yes. Two separate home networks could both contain 192.168.1.10.

This becomes a problem when you need to connect networks whose address ranges overlap.

Q10. Which IPv4 ranges are private?

CIDR Full range
10.0.0.0/8 10.0.0.0 to 10.255.255.255
172.16.0.0/12 172.16.0.0 to 172.31.255.255
192.168.0.0/16 192.168.0.0 to 192.168.255.255

Only 172.16 through 172.31 belong to the second range.

IANA stands for Internet Assigned Numbers Authority, the organisation mentioned in the lesson about address allocation.

Q11. Is every address outside those ranges public?
No. Some addresses have special purposes, including loopback, link-local communication and multicast.

Q12. What does 127.0.0.1 mean?
It means this computer itself. It is a loopback address.

For example, http://127.0.0.1:3000 connects to an app on your own computer.

localhost normally resolves to a loopback address. The whole 127.0.0.0/8 range is reserved for loopback.

Q13. What does “traffic is routed” mean?
It means traffic is directed towards its destination.

Routers pass data between networks so it can reach the destination address.

Q14. What is CIDR?
CIDR stands for Classless Inter-Domain Routing.

It describes a range of IP addresses using a short expression such as:

192.168.0.0/24

You use CIDRs when choosing VPC and subnet ranges, and when writing some network rules.

Q15. What do the two parts of a CIDR mean?
In 192.168.0.0/24:

192.168.0.0 is the starting address of this block.
/24 tells you how many bits stay fixed.

The slash number is called the prefix length. It is a way to express the subnet mask.

Q16. What is an octet?
An octet is one of the four parts separated by dots in an IPv4 address.

For 192.168.0.1, the octets are 192, 168, 0 and 1.

Each contains 8 bits and can have a value from 0 to 255—256 possible values, because zero counts.

An IPv4 address therefore contains 32 bits.

Q17. How does the slash number determine the number of addresses?
Subtract the slash number from 32 to find how many bits can change.

Then calculate:

Total addresses = 2 raised to the number of changeable bits.

For /26:

32 − 26 = 6.
2⁶ = 64 addresses.

Q18. What happens when the slash number decreases by one?
The number of addresses doubles.

Prefix Total addresses
/32 1
/31 2
/30 4
/29 8
/28 16
/27 32
/26 64
/25 128
/24 256

Smaller slash number = larger range.

Increasing the slash number by one halves the range.

Q19. Which octets can change with common prefixes?

Prefix What can change?
/0 All four octets
/8 Last three octets
/16 Last two octets
/24 Last octet
/32 Nothing

Prefixes such as /26 fix part of an octet too. /26 leaves only six bits of the last octet free to change.

Q20. What ranges do these examples represent?

CIDR Range Total
192.168.0.0/30 192.168.0.0–192.168.0.3 4
192.168.0.0/26 192.168.0.0–192.168.0.63 64
192.168.0.0/24 192.168.0.0–192.168.0.255 256
192.168.0.0/16 192.168.0.0–192.168.255.255 65,536
10.0.0.0/8 10.0.0.0–10.255.255.255 16,777,216
134.56.78.123/32 Only 134.56.78.123 1

Q21. Why does /16 give 256 × 256 addresses, rather than 256 + 256?
For each value of the third octet, the fourth octet can have all 256 values.

Third octet 0: 256 addresses.
Third octet 1: another 256.
This continues through third octet 255.

That is 256 groups of 256 = 65,536 addresses.

Adding 256 + 256 counts only two groups.

Q22. What does 0.0.0.0/0 mean?
It matches all IPv4 addresses—about 4.3 billion.

Its meaning depends on where you use it:

Where? Meaning
Security group inbound source Allow connections from any IPv4 address for the specified ports and protocols.
Route-table destination Use this route when no more specific route matches.

It does not automatically open every port.

Q23. Why do 10.0.0.0/16 and 10.0.1.0/24 overlap?
The /16 includes everything from 10.0.0.0 to 10.0.255.255.

That already contains the entire /24 range: 10.0.1.0 to 10.0.1.255.

For example, 10.0.1.20 belongs to both.

Overlapping means the ranges share addresses, even when their starting addresses differ.

3. VPCs, subnets and available addresses

Q24. What is a VPC?
VPC stands for Virtual Private Cloud.

It is your own separate network inside AWS. You choose its address ranges, subnets, routes and access settings.

“Private” does not mean it can never connect to the internet.

Q25. How many VPCs can you create?
The default quota covered is five VPCs per Region, per account.

It is an adjustable quota: you can request an increase.

Q26. How large can one IPv4 block assigned to a VPC be?
Between:

/28: 16 total addresses.
/16: 65,536 total addresses.

A VPC can have additional CIDR blocks, subject to AWS restrictions. /16 is the maximum size of one block, not necessarily the VPC’s total address space.

Q27. Must a VPC use only the standard private IPv4 ranges?
AWS recommends them, but other permitted ranges exist.

For example, choose 10.0.0.0/16 from within 10.0.0.0/8. The whole /8 is too large to assign as one VPC block.

Q28. What is the default VPC?
AWS normally provides a default VPC in each Region so you can start using resources without building a network first.

It has:

An internet gateway.
Default subnets.
IPv4 routes to the internet gateway.
Usual default subnet settings that give new instances public IPv4 addresses.

These settings can be changed. Security rules still determine which connections are allowed.

Q29. What are an instance’s public and private DNS names?
They are names used to find its addresses.

Under the usual default setup, an instance has a private DNS name. A suitably configured instance with a public IPv4 address can also have a public DNS name.

Q30. What is a subnet?
A subnet is a section of your VPC with its own address range.

Each subnet belongs to one Availability Zone. Subnets within a VPC must not have overlapping ranges.

Q31. Why put resources in different AZs?
If one AZ fails, resources in another can keep the application running—if the application is configured for this.

Redundancy: additional resources are available if others fail.
High availability: the application stays available despite failures.

Creating subnets alone does not copy your application into them.

Q32. What makes a subnet public?
Its route table has a direct route to an internet gateway.

That route alone does not make every instance accessible. Addresses, security rules and application settings also matter.

Q33. Can a private subnet still have internet access?
Its instances can have outgoing internet access through an appropriate setup:

NAT for the IPv4 example.
An egress-only internet gateway for outbound-only IPv6.

They do not need a direct route to a normal internet gateway.

Q34. What does “AWS reserves five addresses” mean?
In the normal IPv4 subnet setup, AWS keeps the first four addresses and the last address for networking purposes.

You cannot give them to your instances.

They are not five entry points. They simply reduce the number of available addresses.

Q35. Which addresses are reserved in 10.0.0.0/24?

Address Purpose
10.0.0.0 Network address
10.0.0.1 VPC router
10.0.0.2 Reserved for AWS DNS purposes
10.0.0.3 Future use
10.0.0.255 Broadcast address, reserved even though VPCs do not support broadcast

Broadcast means sending traffic to all devices on a network at once.

The VPC’s DNS address is its primary range’s starting address plus two. Reserving the third address in every subnet does not create a separate DNS server in each subnet.

Q36. How many usable addresses do these subnets have?
Use total addresses − five.

Subnet Total Usable
/28 16 11
/27 32 27
/26 64 59
/24 256 251

A /27 cannot hold 29 instances needing one address each. A /26 provides enough.

Other resources may also consume addresses.

Q37. What if a dual-stack subnet runs out of IPv4 addresses?
Launching another instance can fail because the instance still needs a private IPv4 address in that setup.

Spare IPv6 addresses do not replace the required IPv4 address.

Q38. How do you add more usable IPv4 space?
Use another subnet with free addresses, or create a new subnet from an unused range.

You cannot simply enlarge an existing subnet’s IPv4 range.

If the VPC has no unused space, you may need to add another IPv4 CIDR block to the VPC first.

Q39. What does adding another CIDR block to the VPC do?
It gives the VPC another range from which you can create subnets.

It does not automatically make existing subnets bigger.

4. Internet access, routes and load balancers

Q40. Where is the internet gateway?
It is attached to the VPC. Draw it on the VPC boundary.

It is not inside a subnet like an EC2 instance.

Q41. What does an internet gateway do?
It connects the VPC to the internet and supports IPv4 and IPv6.

AWS manages its scaling and redundancy. You do not create extra internet gateways just because traffic increases.

One VPC can have one internet gateway attached at a time. A gateway can be attached to one VPC at a time.

Q42. Is an internet gateway always created automatically?
No. For a manually created VPC, you normally create and attach it separately.

The default VPC already has one. Some setup wizards create one for you.

Q43. What is a route?
An instruction telling AWS where to send traffic.

For example:

0.0.0.0/0 → internet gateway

means: use the internet gateway when no more specific route matches the destination.

Q44. What does a local route do?
It keeps traffic for the VPC’s own address ranges inside the VPC.

A more specific local route takes priority over a general internet route.

Q45. Does a route give traffic permission?
No.

Route table: where should traffic go?
Security rules: is the traffic allowed?

A connection needs the correct route and permission.

Q46. What address does the website visitor enter?
Usually a domain name.

Direct EC2 access: DNS points to the instance’s public address.
ALB access: DNS points to the load balancer.

The visitor does not enter the subnet’s address or the internet gateway’s address.

Q47. What is required for direct HTTPS access to EC2 over IPv4?

Internet gateway attached to the VPC.
Subnet route to that gateway.
Public IPv4 address for the instance.
Security rules allowing the connection on TCP port 443.
A server configured to receive HTTPS on port 443, including a certificate.

Q48. How does an ALB change this setup?
The user connects to the internet-facing Application Load Balancer.

The ALB forwards the request to EC2 using its private IP. EC2 does not need a public IP to receive requests this way.

For example, the ALB receives HTTPS on 443 and forwards requests to the app on 3000.

Q49. Where are the ALB and EC2 instances placed?
A normal regional internet-facing ALB uses public subnets in at least two AZs.

Its EC2 targets can be in private subnets.

The ALB security group allows users to connect. EC2’s group can allow port 3000 from the ALB’s security group.

5. Security groups and NACLs

Q50. What do inbound, outbound and source mean?

Inbound: coming into the resource or subnet.
Outbound: leaving the resource or subnet.
Source: where the traffic comes from.

Q51. What does “allow TCP port 22 from my public IP” mean?
Allow SSH connections to that instance only from the public IP you listed.

TCP: rules for sending data reliably and in order.
Port 22: normally receives SSH connections.
SSH: lets you securely log into another computer and run commands.

You still need valid login credentials.

Q52. Does a security group control both directions?
Yes. It has inbound and outbound rules.

Security groups contain allow rules. Traffic not allowed by the applicable rules is blocked, except replies to allowed connections.

Q53. What does “stateful” mean for security groups?
They remember allowed connections.

Allowed incoming connection → replies automatically allowed out.
Allowed outgoing connection → replies automatically allowed in.

This does not allow unrelated new connections.

Q54. What does referencing another security group mean?
A rule can say:

“Allow this traffic from resources with that security group attached.”

It identifies the allowed resources. It does not copy the other group’s rules.

Q55. What is a NACL?
A Network Access Control List allows or denies traffic crossing a subnet’s boundary.

It does not check traffic between two instances inside the same subnet.

Q56. How many NACLs can a subnet have?
Exactly one at a time.

The same NACL can be associated with several subnets.

A subnet uses the VPC’s default NACL unless another is selected.

Q57. How do default and custom NACLs start?

Default NACL New custom NACL
Initially allows incoming and outgoing traffic. Initially blocks traffic until you add allow rules.

Q58. What does “stateless” mean for NACLs?
They do not remember connections.

Rules must allow the request and the reply separately. Allowing a request in does not automatically allow the reply out.

Q59. How are NACL rules evaluated?
Rules are numbered 1–32,766.

AWS checks the lowest number first and stops at the first matching rule.

If rule 100 allows traffic and rule 200 denies the same traffic, rule 100 wins.

Q60. What is the final \* rule?
It blocks anything not matched by an earlier rule.

You cannot delete it.

A new custom NACL initially blocks traffic because it has no earlier allow rules.

Q61. Why use rule numbers such as 100, 200 and 300?
The gaps let you insert new rules later.

For example, rule 150 can go between 100 and 200 without renumbering everything.

To block traffic, place its deny rule before any broader allow rule that would also match.

Q62. What happens when a user requests a page from EC2?
Request coming in:

NACL inbound rules must allow it into the subnet.
Security group inbound rules must allow it to the instance.

Reply going out:

The security group automatically allows the reply.
NACL outbound rules must allow it out.

Q63. What happens when EC2 starts a request to another service?
Request going out:

Security group outbound rules must allow it.
NACL outbound rules must allow it to leave the subnet.

Reply coming in:

NACL inbound rules must allow it into the subnet.
The security group automatically allows the reply.

Correct routes and gateways are also required.

Q64. Why might a reply need a different port in the NACL rules?
The computer starting the connection chooses a temporary port, called an ephemeral port.

A request might go to server port 443. The reply goes to the client’s temporary port.

Allowing port 443 in both directions is therefore not necessarily enough.

Q65. Can a security group override a NACL block?
No. Both applicable checks must allow the traffic.

A subnet-wide deny rule can block an IP even if an instance’s security group would otherwise allow it.

6. Bastion hosts, NAT and Elastic IPs

Q66. What is a bastion host?
An EC2 instance used to log into private instances.

You SSH to the bastion’s public address.
From the bastion, you SSH to the private instance’s private address.

The second connection stays inside the VPC.

Q67. Which rules allow those two connections?

Resource Incoming SSH rule
Bastion Port 22 from your approved public IP or office range.
Private instance Port 22 from the bastion’s private IP or security group.

The bastion’s outbound rules must allow its connection. You also need valid credentials.

Q68. Does a bastion provide internet access for the private instance?
No. It lets you log in.

For the instance to download updates from the internet, it needs another path, such as NAT.

Q69. What does a public NAT gateway do?
It lets private instances start IPv4 internet connections and receive replies, without their own public IPv4 addresses.

Internet users cannot start new connections through it to those instances.

Q70. Where does NAT go, and what routes are needed?
In the course’s zonal setup, NAT is in a public subnet.

Subnet Internet route
Private instance’s subnet To NAT gateway
NAT gateway’s public subnet To internet gateway

The request travels:

Private instance → NAT → internet gateway → internet.

In this setup, NAT serves instances in other subnets.

Q71. What is an Elastic IP?
A fixed public IPv4 address allocated until you release it.

A public NAT gateway uses one. An EC2 instance can also have its own Elastic IP for direct internet access.

The NAT gateway and EC2 instance cannot share one Elastic IP simultaneously.

Q72. What does NAT’s address translation mean?
Your private instance sends a request.

Before that request reaches the internet service, its visible source becomes the NAT gateway’s public IP.

The service replies to that public address. The gateways track the connection and return the reply to the correct private instance.

The instance keeps its private IP. The address information on its traffic changes.

Q73. Does the NAT gateway have a security group?
No. You cannot attach one.

Your EC2 instance still has its security group. Applicable NACLs also still matter.

The absence of a NAT security group does not remove the other security checks.

Q74. What performance, availability and costs were covered?

Zonal NAT bandwidth starts at 5 Gbps, automatically scaling up to 100 Gbps.
AWS handles the underlying maintenance.
Zonal NAT has redundancy within its AZ.
For zone-independent access, use NAT in each AZ with resources using their own AZ’s gateway.
AWS also offers regional NAT gateways that can automatically expand across AZs.
Charges include time available and data processed, with other applicable network and address charges.

Hourly charges can continue while you are not actively using it.

Q75. How does a NAT instance differ?

NAT gateway NAT instance
AWS-managed service. EC2 instance configured for NAT.
AWS maintains the underlying system. You patch, update and maintain it.
Automatically scales within service limits. Capacity depends on instance size.
No attached security group. Has a security group.
Cannot be a bastion. Can also act as a bastion if configured.
Gateway time and data-processing charges. EC2, storage and applicable network charges.

For a NAT instance, you arrange failover to another instance if needed. Neither option is automatically cheaper in every situation.

Q76. Why disable the source/destination check on a NAT instance?
A normal EC2 instance is expected to send or receive its own traffic.

A NAT instance forwards traffic for other instances. Turning off this check allows it to perform that job.

7. Peering and transit gateways

Q77. What is VPC peering?
A private connection between two VPCs through AWS’s network.

They remain separate networks, but their resources can communicate when permitted.

The VPCs can belong to different accounts and different Regions.

Q78. What must be configured for peering to work?

Active peering connection.
Non-overlapping IPv4 ranges.
Routes in both directions for the relevant subnets.
Security rules allowing the traffic.

Creating the connection alone does not grant access.

Q79. What does “non-transitive” mean?
If A connects to B, and B connects to C, A cannot use B to reach C through peering.

A and C need their own direct peering connection.

This makes managing many peered VPCs more work.

Q80. Can a rule reference a security group in another account’s peered VPC?
Yes, when peering is active and both VPCs are in the same Region.

In the destination resource’s security group, specify:

Source AWS account ID + source security group ID

Example: 123456789012/sg-1a2b3c4d.

Across Regions, use suitable IP addresses or CIDR ranges instead.

Q81. Does this allow the whole source account into the other VPC?
No. It allows the specified traffic from resources with the referenced group attached.

It is not a security rule attached to the whole VPC.

Q82. Why reference the security group rather than list IPs?
You do not have to list every approved instance’s IP address.

A replacement instance can be covered when the same referenced group is attached to it.

Only attach that group to resources that should receive the permission.

Q83. What is a transit gateway?
A central routing service connecting multiple networks.

It can connect VPCs and company networks through VPN or Direct Connect, using the required attachments.

It supports transitive connectivity, so networks can communicate through it without direct peering for every pair.

Routes and security settings still decide which communication is allowed.

8. VPC endpoints and PrivateLink

Q84. What does a VPC endpoint do?
It gives resources in your VPC private access to a supported service, without NAT or an internet gateway for that connection.

An S3 endpoint does not also provide access to arbitrary websites.

Q85. Does a public AWS service address make your data public?
No. It provides a way to reach the service.

Permissions still decide whether you can read a file or perform another action.

An endpoint changes the connection path. It does not automatically grant access.

Q86. What is an interface endpoint?
An endpoint powered by AWS PrivateLink.

AWS creates an ENI—Elastic Network Interface—in each selected subnet. This is a virtual network connection with an address.

Your instance connects to the endpoint’s private address to reach the service.

Q87. What do DNS and security groups do for interface endpoints?
Private DNS can make the normal service name point to the endpoint’s private IP.

For HTTPS:

EC2’s security group allows outgoing port 443.
The endpoint’s group allows incoming port 443 from the approved source.
Applicable NACL rules allow traffic crossing subnet boundaries.

Q88. Which services and charges apply to interface endpoints?
Many services support them, including SNS and SQS. Check the particular service.

Charges include hourly usage per AZ and data processed. An unused endpoint can still have hourly charges.

Q89. What is a gateway endpoint?
An endpoint for S3 or DynamoDB that uses route tables.

It has:

No endpoint ENI.
No endpoint security group.
No PrivateLink requirement.
No additional endpoint charge.

AWS adds a service route to the route tables you select.

Normal service charges and access permissions still apply.

Q90. How do the request and reply work through an endpoint?
For example, EC2 requests an S3 file:

The network setup sends the request through the endpoint.
S3 checks permission.
If permitted, the file comes back through the endpoint connection.

S3 has not moved into your subnet. The endpoint provides a private way to reach it.

Q91. What is different about the NAT path to S3?
Using NAT, private IPv4 requests pass through NAT and the internet gateway to S3’s public service address.

Using a gateway endpoint, the route sends S3 traffic through the endpoint instead.

S3 traffic using its public service address can still remain inside AWS’s network. The endpoint removes the need for the gateway route.

Q92. What is an endpoint service?
A way to offer your own service privately to customers in other VPCs.

In the application setup covered:

Provider: endpoint service backed by a Network Load Balancer.
Customer: interface endpoint with ENIs.

No VPC peering, NAT or public internet connection is required for that access.

It shares the service, rather than connecting the whole networks.

9. IPv6 and dual stack

Q93. Why was IPv6 created?
IPv4 has about 4.3 billion addresses.

IPv6 uses 128 bits and provides about 3.4 × 10³⁸ addresses, giving much more room for growth.

IPv4 and IPv6 are both still used.

Q94. What does an IPv6 address look like?
Its full form has eight groups of four hexadecimal digits, separated by colons.

Example:

2001:0db8:1234:5678:0000:0000:0000:0001

Hexadecimal uses 0–9 and A–F. Letters A–F represent values 10–15.

Uppercase and lowercase letters mean the same thing.

Q95. How can you shorten IPv6 addresses?

Remove leading zeros in a group: 0001 becomes 1.
Replace consecutive all-zero groups with ::, once per address.

Example:

2001:db8:1234:5678::1

is the shortened form of the address above.

You cannot remove zeros arbitrarily: 1000 cannot become 1.

Q96. How many groups does :: replace?
Count the groups shown and subtract from eight.

2001:db8::1234:5678 shows four groups, so :: replaces four zero groups.

It can appear at the beginning, middle or end. It can only appear once, or the address would be ambiguous.

:: alone represents all eight zero groups. It is the special unspecified address.

Q97. Are all IPv6 addresses in AWS public?
No. The usual Amazon-provided IPv6 addresses are public, but AWS also supports private IPv6 through IPAM.

A public address does not automatically make a resource reachable. Routes and security rules still control access.

Q98. What does “IPv4 connection” or “IPv6 connection” mean?
A connection using that address type.

An ordinary IPv4 connection uses IPv4 at both ends. An ordinary IPv6 connection uses IPv6 at both ends.

The other computer or service needs an address too.

Q99. What does dual stack mean?
The same resource supports both IPv4 and IPv6.

It can use the version supported by the other side. Each individual connection uses one version.

It does not mean two EC2 instances, and it does not automatically translate IPv4 into IPv6.

Q100. Why is dual stack useful?
It lets you introduce IPv6 while keeping existing IPv4 connections working.

You do not have to switch everything at once.

Each version still needs appropriate addresses, routes, security rules and application support.

Q101. Must every subnet keep IPv4?
No. The VPC retains an IPv4 CIDR block, but subnets can be IPv4-only, dual stack or IPv6-only.

Adding IPv6 does not turn a private IPv4 address into a public one.

10. Egress-only gateways and dual-stack routing

Q102. What does “egress-only” mean?
Egress means outgoing.

An egress-only internet gateway lets an instance start IPv6 internet connections and receive replies.

It prevents internet users from starting new connections through that gateway to the instance.

Q103. Where is the egress-only internet gateway?
It is attached to the VPC.

It does not sit inside a subnet and does not require a NAT gateway or separate internet gateway for that IPv6 connection.

Q104. Does it use an Elastic IP or change the instance’s address?
No.

The instance uses its own public IPv6 address. The gateway does not perform NAT for this IPv6-to-IPv6 traffic.

Its protection comes from preventing new connections started from outside.

Q105. Does it replace security groups and NACLs?
No.

The instance’s security group must allow the outgoing connection.
Its reply is automatically allowed by the security group.
NACL rules must allow both directions across the subnet boundary.

The egress-only gateway itself does not have an attached security group.

Q106. Which paths are used in the dual-stack architecture?

Instance and connection Path to the internet
Public instance using IPv4 Internet gateway
Public instance using IPv6 Internet gateway
Private instance using IPv4 NAT gateway, then internet gateway
Instance using outbound-only IPv6 Egress-only internet gateway

Q107. What addresses do the instances have in that example?

Public subnet instance Private subnet instance
Private IPv4 Private IPv4
Its own public IPv4/Elastic IP No public IPv4 of its own
Public IPv6 Public IPv6 used through the egress-only gateway

The NAT gateway has its own separate Elastic IP.

Q108. What internet routes do the two subnets use?

Subnet IPv4 route IPv6 route
Public 0.0.0.0/0 → internet gateway ::/0 → internet gateway
Outbound-only private setup 0.0.0.0/0 → NAT gateway ::/0 → egress-only internet gateway

Local routes keep traffic for the VPC’s own ranges inside the VPC.

::/0 is the IPv6 equivalent of a general default route. An IPv4 route or rule does not automatically cover IPv6.

Q109. Why was the course’s IPv6 diagram confusing?
It contained mistakes:

The subnets were shown with overlapping ranges.
The private subnet’s IPv6 default route pointed to NAT.
The lower gateway was labelled as a normal internet gateway rather than an egress-only one.
The NAT gateway and public EC2 instance shared the same Elastic IP.

For the intended outbound-only setup: private IPv4 uses NAT; IPv6 uses the egress-only gateway.

11. Bringing the concepts together

Q110. Which component should I think of for each need?

I need to… Component
Connect a VPC to the internet Internet gateway
Let private instances make IPv4 internet requests Public NAT gateway
Allow outgoing IPv6 connections and replies only Egress-only internet gateway
Log into private instances through another instance Bastion
Privately connect two VPCs VPC peering
Centrally connect multiple networks Transit gateway
Privately access a supported AWS service VPC endpoint
Privately offer my service to another VPC Endpoint service / PrivateLink

Q111. What are the three separate questions when accessing a service?

Route: where should the traffic go?
Network security: is the connection allowed?
Service permission: may this request perform the action?

Reaching S3 does not automatically give permission to read its files.

Q112. What should I check if a connection fails?

Correct destination address and IP version.
Suitable routes for requests and replies.
Required gateway or endpoint.
Security group rules allowing the new connection.
NACL rules allowing both directions.
An application running and accepting connections on the correct port.
Correct login or service permissions.
DNS settings, particularly when using interface endpoints.

Q113. What should I remember after practical exercises?
Some resources keep generating charges while available, even when you are not using them.

Check and remove resources you no longer need, especially NAT gateways, EC2 instances, public IPv4 addresses and interface endpoints.
