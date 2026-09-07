Scalability and High Availability

Q: What is scalability?
A: Scalability means changing your system so it can handle more or less demand.

Q: What are the two main types of scaling?
A: Vertical scaling and horizontal scaling.

Q: What is vertical scaling?
A: Vertical scaling means giving one machine more CPU, memory or storage.

Q: How do you vertically scale an EC2 instance?
A: You change it to a larger, more powerful instance type.

Q: When is vertical scaling useful?
A: It is useful for systems that mainly run on one machine, including some databases such as RDS and ElastiCache.

Q: What is the main limitation of vertical scaling?
A: There is always a maximum machine size. Once you reach it, you cannot continue scaling vertically.

Q: What is horizontal scaling?
A: Horizontal scaling means adding more machines or instances to share the work.

Q: What do “scale out” and “scale in” mean?
A:

Scale out: Add more instances.
Scale in: Remove unnecessary instances.

Q: Why is horizontal scaling useful for unpredictable traffic?
A: You can add instances when traffic increases and remove them when traffic decreases.

Q: What is elasticity?
A: Elasticity means automatically scaling out and in as demand changes.

Q: How is vertical scaling different from horizontal scaling?
A: Vertical scaling makes one instance more powerful. Horizontal scaling adds more instances.

Q: What is a distributed system?
A: It is a system where several machines share the workload instead of relying on one machine.

Q: How does horizontal scaling improve resilience?
A: If one instance fails, other instances can continue handling requests.

Q: What is High Availability?
A: High Availability, or HA, means keeping an application available even when part of the infrastructure fails.

Q: How is scalability different from High Availability?
A: Scalability handles changing demand. High Availability handles failures and reduces downtime.

Q: Can a system be highly available but not scale well?
A: Yes. It can survive failures but still struggle when traffic becomes very high.

Q: How is High Availability normally achieved in AWS?
A: Run resources across at least two Availability Zones.

Q: What is an Availability Zone?
A: An Availability Zone, or AZ, is an independent AWS data-centre location inside a Region.

Q: Why should an application use multiple Availability Zones?
A: If one AZ fails, resources in another AZ can continue serving users.

Q: What is passive High Availability?
A: A primary resource handles the work while a backup waits in another location. If the primary fails, the backup takes over.

Q: What is an example of passive High Availability?
A: RDS Multi-AZ, where AWS maintains a secondary database and can switch to it if the primary fails.

Q: What is active High Availability?
A: Multiple resources actively handle traffic across different instances or AZs.

Q: How do scaling and HA work together for EC2?
A: An Auto Scaling Group provides multiple instances, while a load balancer distributes traffic across them and across different AZs.

Networking and DNS Basics

Q: What is HTTP?
A: HTTP is a protocol used to send web requests and responses.

Q: What is HTTPS?
A: HTTPS is HTTP protected by TLS encryption.

Q: What does TCP do?
A: TCP creates a reliable connection and makes sure data arrives correctly and in the correct order.

Q: What does UDP do?
A: UDP sends data without creating the same reliable connection. It prioritises speed but does not guarantee delivery.

Q: What is Layer 4?
A: Layer 4 is the transport layer. TCP and UDP operate here.

Q: What is Layer 7?
A: Layer 7 is the application layer. Protocols such as HTTP and HTTPS operate here.

Q: What is a hostname?
A: A hostname is a name that identifies a website or network service, such as shop.example.com.

Q: What is DNS?
A: DNS is the system that finds the network destination connected to a domain or hostname.

Q: Is DNS an IP address or web address?
A: No. DNS is the system that connects names to their destinations.

Q: What is a DNS record?
A: A DNS record stores information about where a domain or hostname should send users.

Q: Where are DNS records stored?
A: They are stored with an authoritative DNS provider, such as Route 53.

Q: What starts a DNS lookup?
A: When a user enters a domain, the browser and operating system begin the process of finding its destination through DNS.

Q: What hostname does AWS give an Application Load Balancer?
A: AWS provides a fixed load-balancer hostname ending in elb.amazonaws.com.

Q: Does an ALB have permanently fixed public IP addresses?
A: You normally connect through its AWS hostname because the underlying IP addresses can change.

Q: How can you use your own domain with an ALB?
A: Create a DNS record, such as a Route 53 alias record, that points your domain to the ALB.

Q: Can subdomains represent different websites or services?
A: Yes. Names such as blog.example.com and shop.example.com can be routed to different applications.

Load Balancer Basics

Q: What is a load balancer?
A: A load balancer receives incoming traffic and distributes it across multiple servers or targets.

Q: Why distribute traffic across several instances?
A: It prevents one instance from becoming overloaded and increases the system’s capacity.

Q: What is the basic request path through a load balancer?
A: The user connects to the load balancer. The load balancer then forwards the request to a healthy backend target.

Q: Why does a load balancer provide one point of access?
A: Users connect to the load balancer’s DNS name. They do not need the addresses of individual EC2 instances.

Q: What happens if an instance fails?
A: The load balancer stops sending traffic to it and uses the remaining healthy instances.

Q: What is a reverse proxy?
A: A reverse proxy receives requests before they reach backend servers and forwards them to the correct destination.

Q: How is a reverse proxy different from basic load balancing?
A: Load balancing focuses on spreading traffic. A reverse proxy can also perform tasks such as content-based routing and TLS handling.

Q: Is an Application Load Balancer also acting as a reverse proxy?
A: Yes. It sits in front of applications, receives requests and routes them to backend targets.

Q: How does a load balancer support High Availability?
A: It can distribute traffic across healthy instances in multiple Availability Zones.

Q: What is an internet-facing load balancer?
A: It accepts traffic from users on the public internet.

Q: What is an internal load balancer?
A: It handles private traffic inside your AWS network rather than accepting direct internet traffic.

Q: Can public and private traffic use separate load balancers?
A: Yes. An external load balancer can handle public traffic, while an internal one handles communication between private services.

Elastic Load Balancing

Q: What does ELB mean?
A: Elastic Load Balancing is the overall name for AWS’s managed load-balancing service.

Q: Is ELB a separate load-balancer type?
A: No. ELB is the service containing CLB, ALB, NLB and Gateway Load Balancer.

Q: What are the four AWS load-balancer types discussed?
A:

Classic Load Balancer — CLB
Application Load Balancer — ALB
Network Load Balancer — NLB
Gateway Load Balancer — GWLB

Q: What does “managed load balancer” mean?
A: AWS operates, maintains, upgrades and scales the load-balancing infrastructure.

Q: Why use an AWS-managed load balancer?
A: It reduces the maintenance, monitoring, scaling and fault-tolerance work you must do yourself.

Q: Can you operate your own load balancer?
A: Yes. Tools such as Nginx, HAProxy and Traefik can provide load balancing, but you must manage them yourself.

Q: What is a disadvantage of an AWS-managed load balancer?
A: It can cost more than operating one yourself and gives you fewer low-level configuration options.

Q: Which AWS services can ELB integrate with?
A: Services discussed include:

EC2 and Auto Scaling Groups
AWS Certificate Manager
CloudWatch
Route 53
AWS WAF
Global Accelerator

Q: How does ELB work with an Auto Scaling Group?
A: New instances can be registered automatically, and removed instances can be deregistered.

Health Checks

Q: What is a load-balancer health check?
A: It is an automatic test that checks whether a backend target can respond correctly.

Q: How does an HTTP health check work?
A: The load balancer sends a request to a configured port and path, such as port 4567 and /health.

Q: What usually shows that a target is healthy?
A: A successful response such as HTTP status 200 OK.

Q: What happens when a health check fails?
A: The load balancer marks the target as unhealthy and stops sending normal traffic to it.

Q: What happens after the target recovers?
A: When it passes the required health checks again, the load balancer can begin sending traffic to it.

Q: Why are health checks important?
A: They prevent users from being sent to instances that are unavailable or unable to process requests.

Q: Does removing traffic from an unhealthy instance repair it?
A: No. The load balancer only stops routing traffic to it. An Auto Scaling Group can replace the instance when health-based replacement is configured.

Q: At what level does an ALB configure health checks?
A: Health checks are configured for target groups.

Security Groups

Q: What is a security group?
A: A security group is a virtual firewall that controls inbound and outbound traffic for AWS resources.

Q: What traffic can a public load balancer’s security group allow?
A: It can allow:

HTTP on port 80
HTTPS on port 443

Q: What does 0.0.0.0/0 mean in a security-group rule?
A: It means traffic is allowed from any IPv4 address.

Q: Should a public load balancer always accept traffic from everywhere?
A: Only if the application is intended to be publicly accessible. Its rules should match the application’s actual requirements.

Q: How should the EC2 security group behind a load balancer be configured?
A: It should allow application traffic from the load balancer’s security group.

Q: Why use the load balancer’s security group as the EC2 rule source?
A: It prevents internet users from connecting directly to the EC2 instances. Requests must pass through the load balancer.

Q: What is the secure two-level traffic flow?
A: Users connect to the load balancer, and the load balancer connects to the protected EC2 instances.

Choosing a Load Balancer

Q: What is a Classic Load Balancer?
A: CLB is the older AWS load balancer. It supports basic HTTP, HTTPS, TCP and SSL/TLS traffic but lacks newer routing features.

Q: Should CLB normally be chosen for a new application?
A: Usually not. The newer load balancers provide more flexibility and features.

Q: What is an Application Load Balancer best for?
A: Modern applications using HTTP, HTTPS or WebSockets, especially when content-based routing is needed.

Q: What is a Network Load Balancer best for?
A: High-performance TCP or UDP traffic requiring very low latency.

Q: What is a Gateway Load Balancer best for?
A: Deploying and scaling network appliances such as firewalls, intrusion-detection systems and traffic analysers.

Q: At which layers do the newer load balancers operate?
A:

ALB: Layer 7
NLB: Layer 4
GWLB: Layer 3

Q: Can AWS load balancers be public or private?
A: Yes. Depending on the type and configuration, they can be internet-facing or internal.

Application Load Balancer

Q: What is an Application Load Balancer?
A: An ALB is a Layer 7 load balancer designed for HTTP and HTTPS applications.

Q: What information can an ALB understand?
A: It can examine HTTP information such as hostnames, URL paths, headers, query strings and cookies.

Q: Why is an ALB called a smart load balancer?
A: It can choose a destination based on the contents of the HTTP request, not only its protocol and port.

Q: What protocols and features does ALB support?
A: It supports HTTP, HTTPS, HTTP/2 and WebSockets.

Q: Why is HTTP/2 useful?
A: It can handle web communication more efficiently than older HTTP versions.

Q: Why are WebSockets useful?
A: They support ongoing, real-time communication for applications such as chat systems and live dashboards.

Q: Can one ALB serve multiple applications?
A: Yes. Its routing rules can send requests to different applications and target groups.

Q: Can an ALB route to several applications on one EC2 instance?
A: Yes. The applications can listen on different ports.

ALB Routing

Q: What is path-based routing?
A: It routes requests according to the URL path.

Q: What is an example of path-based routing?
A:

/users → user service
/posts → posts service
/comments → comments service

Q: What is host-based routing?
A: It routes traffic according to the requested hostname.

Q: What is an example of host-based routing?
A:

blog.example.com → blog service
news.example.com → news service

Q: What is query-string routing?
A: It routes requests using values in the URL query string, such as ?id=123.

Q: What is header-based routing?
A: It routes requests using HTTP header information, such as whether a request came from a mobile or desktop client.

Q: Why is ALB useful for microservices?
A: One ALB can route different requests to different services using hosts, paths, headers or query strings.

Q: Why can one ALB be more efficient than using several Classic Load Balancers?
A: One ALB can serve several applications using routing rules. With CLB, separate applications often require separate load balancers.

Target Groups

Q: What is an ALB target group?
A: A target group is a collection of backend resources that receive traffic from the ALB.

Q: What resources can an ALB target group contain?
A: The chat discussed:

EC2 instances
ECS tasks or containers
Lambda functions
Private IP addresses

Q: What happens when Lambda is an ALB target?
A: The ALB converts the HTTP request into a JSON event that the Lambda function can process.

Q: What kind of IP addresses can be registered directly as targets?
A: The IP targets discussed must be private IP addresses.

Q: Why use several target groups?
A: Each application or service can have its own targets, health checks and scaling.

Q: Can services behind different target groups scale independently?
A: Yes. For example, the search service can scale without scaling the user-profile service.

Q: How does ALB work with ECS port mapping?
A: It can route traffic to containers running on different dynamically assigned ports.

Q: What is the basic ALB request flow?
A:

The ALB receives an HTTP or HTTPS request.
It checks its listener rules.
It chooses a target group.
It forwards the request to a healthy target.
Client Information

Q: Does an EC2 instance behind an ALB directly see the client’s IP address?
A: The connection to EC2 comes from the ALB, so the instance normally sees the ALB’s private address.

Q: How does the application find the user’s original IP address?
A: It reads the X-Forwarded-For HTTP header.

Q: What does X-Forwarded-Port contain?
A: It records the port used by the client.

Q: What does X-Forwarded-Proto contain?
A: It records the client’s original protocol, such as HTTP or HTTPS.

Q: Why might an application need these forwarded headers?
A: They can be used for logging, security auditing, rate limiting, geolocation and protocol-aware behaviour.

Network Load Balancer

Q: What is a Network Load Balancer?
A: An NLB is a high-performance Layer 4 load balancer.

Q: Which main protocols does NLB handle?
A: TCP and UDP.

Q: How does NLB route traffic?
A: It forwards network connections using information such as protocol and port.

Q: Does NLB inspect HTTP paths or headers?
A: No. It does not make routing decisions using paths such as /users or HTTP headers.

Q: Can HTTP traffic pass through an NLB?
A: Yes. HTTP normally travels over TCP, but the NLB treats it as network traffic and does not inspect its HTTP content.

Q: Why is NLB fast?
A: It performs less application-level inspection and is designed for very high throughput and low latency.

Q: How much traffic can an NLB handle?
A: It is designed for extremely high traffic, including millions of requests or connections per second.

Q: What applications may benefit from NLB?
A: Examples discussed include gaming, trading systems, VoIP, DNS, streaming and real-time communication.

Q: Does an NLB provide static IP addresses?
A: Yes. It can provide one static IP address for each enabled Availability Zone.

Q: Can Elastic IP addresses be assigned to an internet-facing NLB?
A: Yes. This provides predictable public IP addresses.

Q: Why are static IP addresses useful?
A: Some clients and firewall allowlists require a stable IP address.

Q: Is NLB part of the AWS Free Tier?
A: The course material stated that NLB was not included in the Free Tier, so its cost should be checked before use.

Q: Does an NLB support TLS termination?
A: Yes, when it uses a TLS listener. The earlier statement that NLB never terminates TLS was too broad.

Q: What happens when an NLB uses a TCP listener instead?
A: It forwards the connection without decrypting or inspecting the application data.

Q: When should you choose ALB instead of NLB?
A: Choose ALB when you need HTTP features such as path, hostname or header-based routing.

Q: When should you choose NLB instead of ALB?
A: Choose NLB when raw TCP or UDP performance, low latency or static IP addresses are more important.

TLS and Certificates

Q: What does TLS do?
A: TLS encrypts information while it travels between systems.

Q: Why is encryption in transit important?
A: It prevents other people from reading sensitive information such as passwords and payment details while it crosses a network.

Q: What does the “S” in HTTPS mean?
A: It means HTTP is protected using TLS.

Q: What is SSL?
A: SSL is the older technology that TLS replaced.

Q: Why do people still say “SSL certificate”?
A: The older name is still commonly used, although modern secure connections use TLS.

Q: What is a TLS certificate?
A: It proves the identity of a hostname and helps the browser establish an encrypted connection.

Q: What is an X.509 certificate?
A: X.509 is the technical standard used for common SSL/TLS certificates.

Q: What is a Certificate Authority?
A: A Certificate Authority, or CA, is a trusted organisation that issues and validates certificates.

Q: Which Certificate Authorities were mentioned?
A: DigiCert, Let’s Encrypt, GlobalSign, GoDaddy, Comodo and Symantec were discussed.

Q: Do TLS certificates expire?
A: Yes. They must be renewed before their expiration date.

Q: What happens when a website’s certificate expires?
A: Browsers may show a security warning and users may not trust or access the website normally.

AWS Certificate Manager

Q: What is AWS Certificate Manager?
A: AWS Certificate Manager, or ACM, is an AWS service for obtaining, storing and managing certificates.

Q: What can ACM do?
A: It can:

Issue certificates for your domains.
Store them.
Attach them to supported AWS services.
Automatically renew many AWS-issued certificates.

Q: Can you use your own certificate instead of an ACM-issued certificate?
A: Yes. You can import a compatible custom certificate.

Q: Does ACM receive website requests?
A: No. ACM manages the certificate; the load balancer uses it when handling connections.

HTTPS Listeners

Q: What is a load-balancer listener?
A: A listener waits for connections using a configured protocol and port.

Q: Which port normally receives HTTPS traffic?
A: Port 443.

Q: What must an HTTPS listener have?
A: It must have at least one TLS certificate.

Q: Why does the load balancer need the website’s certificate?
A: The user connects to the load balancer first, so the load balancer must prove the hostname’s identity and establish the secure connection.

Q: What is the default certificate?
A: It is the certificate the listener uses when no additional certificate matches the requested hostname.

Q: Can one listener use certificates for several domains?
A: ALB HTTPS listeners and NLB TLS listeners can hold multiple certificates and use SNI to choose between them.

Q: Can one certificate cover several hostnames?
A: Yes. One certificate can be created to cover several listed hostnames.

SNI

Q: What does SNI mean?
A: Server Name Indication.

Q: What problem does SNI solve?
A: It allows one server or load-balancer listener to use different certificates for different hostnames.

Q: How does SNI work?
A: During the TLS connection, the client sends the hostname it wants. The load balancer uses it to select the matching certificate.

Q: What happens if SNI does not match an additional certificate?
A: The listener uses its default certificate.

Q: Does SNI decide which application receives the request?
A: No. SNI selects the certificate. ALB listener rules then select the target group.

Q: Which services discussed support SNI?
A: ALB, NLB and CloudFront.

Q: Does Classic Load Balancer support SNI?
A: No.

Certificates on Different Load Balancers

Q: How many certificates can a Classic Load Balancer secure listener use?
A: One certificate per secure listener.

Q: Can one CLB certificate still cover multiple hostnames?
A: Yes. It remains one certificate, but that certificate can include several hostnames.

Q: What may be required if a CLB needs separate certificates?
A: Separate Classic Load Balancers may be needed.

Q: How does ALB handle multiple certificates?
A: An ALB HTTPS listener can hold several certificates and use SNI to select the correct one.

Q: How does NLB handle multiple certificates?
A: An NLB TLS listener can hold several certificates and use SNI to select the correct one.

Q: Do ordinary UDP listeners use TLS certificates?
A: No. Certificates apply to TLS connections, not ordinary UDP traffic.

TLS Policies and Termination

Q: What is a TLS security policy?
A: It defines which TLS versions and encryption methods the load balancer accepts.

Q: Why use a modern TLS security policy?
A: It blocks old, weaker security methods.

Q: Why might an older TLS policy be selected?
A: It may be needed for legacy clients that cannot use modern TLS, but this can reduce security.

Q: What is TLS termination?
A: It means the encrypted connection from the user ends at the load balancer, where the request is decrypted.

Q: What can happen after TLS terminates at the load balancer?
A: The load balancer can forward the request to EC2 using HTTP or create a new HTTPS connection.

Q: Can traffic from the load balancer to EC2 remain encrypted?
A: Yes. Configure the target connection to use HTTPS and configure EC2 to support it.

Q: What is the fully encrypted request path?
A:

User connects to the load balancer using HTTPS.
The load balancer decrypts that connection.
The load balancer creates a new HTTPS connection to EC2.

Q: What is the main benefit of terminating TLS at the load balancer?
A: The load balancer manages the public certificate and performs the encryption work instead of every EC2 instance handling the client connection directly.

Sticky Sessions

Q: What is a sticky session?
A: A sticky session keeps sending the same client to the same backend instance for a period of time.

Q: What is another name for a sticky session?
A: Session affinity or session persistence.

Q: Why might an application need sticky sessions?
A: The application may store a user’s session data only on the instance currently serving that user.

Q: What example of session data was discussed?
A: An online shopping cart stored on one instance.

Q: How can a load balancer remember a sticky session?
A: The cookie-based method discussed stores information that links the client to a particular instance.

Q: Can the stickiness duration be controlled?
A: Yes. The cookie’s expiration setting controls how long the association lasts.

Q: What is the disadvantage of sticky sessions?
A: Some instances may receive more users than others, causing uneven load distribution.

Q: When should sticky sessions be enabled?
A: Only when the application needs the same user to return to the same instance.

Connection Draining

Q: What is connection draining?
A: It allows active requests to finish before an instance is removed from a load balancer.

Q: What is connection draining called for ALB and NLB?
A: Deregistration delay.

Q: What happens while an instance is draining?
A: The load balancer stops sending new requests to it but allows existing requests to complete.

Q: Why is deregistration delay useful?
A: It prevents active users and long-running requests from being cut off during scaling or maintenance.

Q: What deregistration-delay range was discussed?
A: From 0 to 3,600 seconds, with 300 seconds—or five minutes—as the default.

Q: When might you use a shorter delay?
A: When requests finish quickly and you want instances removed sooner.

Q: When might you use a longer delay?
A: When the application has long-running requests or connections.

Q: What does a delay of zero do?
A: It removes the waiting period and ends deregistration immediately.

Auto Scaling Groups

Q: What is an Auto Scaling Group?
A: An Auto Scaling Group, or ASG, manages a group of EC2 instances and adjusts how many are running.

Q: What is the main purpose of an ASG?
A: To provide enough instances for current demand without keeping unnecessary instances running.

Q: What does an ASG do when demand increases?
A: It scales out by launching more EC2 instances.

Q: What does an ASG do when demand decreases?
A: It scales in by terminating unnecessary instances.

Q: What is minimum capacity?
A: The smallest number of instances the ASG is allowed to run.

Q: What is desired capacity?
A: The number of instances the ASG currently aims to run.

Q: What is maximum capacity?
A: The largest number of instances the ASG is allowed to run.

Q: What does minimum 2, desired 3 and maximum 10 mean?
A: The ASG aims for three instances, cannot go below two and cannot go above ten.

Q: What happens when an ASG-managed instance fails?
A: The ASG can terminate it and launch a replacement to restore the desired capacity.

Q: Can an ASG register new instances with a load balancer?
A: Yes. New instances can be registered automatically.

Q: Does an ASG itself have an additional charge?
A: The ASG service has no separate charge. You pay for the EC2 instances and other resources it uses.

ASG and Load Balancer Together

Q: What does the load balancer do in an ASG architecture?
A: It distributes user traffic across healthy EC2 instances.

Q: What does the ASG do in the same architecture?
A: It launches, removes and replaces EC2 instances.

Q: What happens during a traffic increase?
A:

Demand rises.
The ASG launches more instances.
The instances register with the load balancer.
The load balancer distributes traffic across them.

Q: What happens when traffic decreases?
A: The ASG removes unnecessary instances while respecting its minimum capacity.

Q: How can this architecture provide High Availability?
A: The ASG runs instances in several AZs, and the load balancer sends traffic to healthy instances across those AZs.

Launch Templates

Q: What is an EC2 launch template?
A: It is the configuration the ASG follows when creating new EC2 instances.

Q: Why does an ASG need a launch template?
A: It ensures that new instances are created with a consistent configuration.

Q: What are launch configurations?
A: They are the older method of defining instances for an ASG. Launch templates are now preferred.

Q: Does the launch template control how many instances run?
A: No. It controls how each instance is built. The ASG settings control how many run.

Q: What is the difference between an AMI and an instance type?
A: The AMI defines the operating system and installed software. The instance type defines the machine’s CPU, memory, networking and other capacity.

Q: What launch-template settings were discussed?
A:

AMI
Instance type
User data
EBS volumes
Security groups
SSH key pair
IAM role

Q: What does EC2 user data do?
A: It contains optional startup commands, such as installing packages or configuring software when an instance launches.

Q: What are EBS volumes used for?
A: They provide block storage for EC2 instances.

Q: Why include security groups in the launch template?
A: Every new instance then receives the required firewall rules.

Q: Why include an SSH key pair?
A: It allows secure administrator access when SSH access is required.

Q: Why attach an IAM role to EC2 instances?
A: It gives the instances permission to use other AWS services without storing AWS access keys in the application code.

Q: Where does the ASG decide to launch instances?
A: Its network settings specify the VPC and subnets.

Q: How can a custom AMI help an ASG?
A: New instances can launch with the required operating system, application and configuration already prepared.

CloudWatch and Automatic Scaling

Q: What is CloudWatch’s role in Auto Scaling?
A: CloudWatch monitors system metrics and can activate alarms when chosen conditions are met.

Q: What is a CloudWatch metric?
A: It is a measured value, such as CPU usage.

Q: What is a CloudWatch alarm?
A: It watches a metric and changes state when the metric crosses a configured limit.

Q: Does CloudWatch collect EC2 CPU usage automatically?
A: Yes. CPU usage is one of the standard EC2 metrics.

Q: Does CloudWatch collect EC2 memory usage automatically?
A: Not by default. The CloudWatch Agent is normally required to send memory usage as a custom metric.

Q: What happens after a scaling alarm activates?
A: The alarm can trigger a scaling policy, which tells the ASG to add or remove instances.

Q: What is a scale-out policy?
A: It increases the number of instances when demand is high.

Q: What is a scale-in policy?
A: It decreases the number of instances when demand is low.

Q: Why is automatic scaling cost-effective?
A: It reduces unnecessary EC2 capacity when demand is low.

Scaling Policies

Q: What is a scaling policy?
A: It tells an ASG when and how to change its desired capacity.

Q: What is target-tracking scaling?
A: You choose a target value, and AWS adds or removes instances to keep the metric near that value.

Q: What is an example of target tracking?
A: Configure the ASG to keep average CPU usage near 40%.

Q: Why is target tracking commonly used?
A: It is simple to configure and automatically handles both scale-out and scale-in decisions.

Q: What is step scaling?
A: It performs different-sized scaling actions depending on how far a metric has crossed its limit.

Q: What is an example of step scaling?
A:

CPU above 70% → add two instances.
CPU above 90% → add four instances.
CPU below 30% → remove one instance.

Q: What is simple scaling?
A: It performs one scaling action when an associated alarm activates.

Q: How is step scaling different from simple scaling?
A: Simple scaling has one response. Step scaling can have several responses based on the size of the change.

Q: What is scheduled scaling?
A: It changes capacity at a planned date or time.

Q: When is scheduled scaling useful?
A: It is useful when demand is predictable, such as a weekly peak or planned sale.

Q: Is scheduled scaling a dynamic scaling policy?
A: No. Dynamic scaling reacts to live metrics. Scheduled scaling follows a timetable.

Q: What is the difference between target tracking, step scaling and scheduled scaling?
A:

Target tracking: Maintain a chosen metric value.
Step scaling: Take different actions at different metric levels.
Scheduled scaling: Change capacity at planned times.

Q: Can a scaling policy exceed the ASG’s minimum or maximum capacity?
A: No. Scaling actions must stay within the ASG’s configured minimum and maximum.