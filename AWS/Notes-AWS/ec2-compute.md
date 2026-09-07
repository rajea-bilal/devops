AWS EC2 — Quick Revision
EC2 Basics
Q: What does compute mean?

Compute is the processing power used to run applications.

AWS provides three main compute options:

EC2: Virtual computers you manage.
ECS/EKS: Services for running containers.
Lambda: Runs your code without you managing servers.

Serverless does not mean no servers. It means AWS manages them.

Q: What is EC2?

EC2 stands for Elastic Compute Cloud.

It lets you rent virtual computers called EC2 instances.

AWS manages the physical hardware. You manage:

The operating system.
Installed software.
Server configuration.
Your application.

EC2 is therefore an example of Infrastructure as a Service (IaaS).

Q: What can you choose when creating an EC2 instance?

Remember:

OS → CPU → RAM → Storage → Network → Security → Setup

You choose:

Operating system: Linux, Windows or macOS.
CPU: Processing power.
RAM: Working memory.
Storage: Where files and data are kept.
Networking: Network speed and public IP settings.
Security group: Which traffic is allowed.
User data: Automatic setup instructions.

Too few resources can make the application slow. Too many resources waste money.

Services Used with EC2
Q: What is EBS?

EBS means Elastic Block Store.

It provides storage for an EC2 instance and works like a virtual hard drive.

Q: What is ELB?

ELB means Elastic Load Balancer.

It distributes incoming traffic across multiple EC2 instances so that one instance does not receive all the traffic.

Q: What is an Auto Scaling Group?

An Auto Scaling Group (ASG) automatically changes the number of EC2 instances:

Scale out: Add instances when demand increases.
Scale in: Remove instances when demand decreases.

This helps maintain performance and avoid paying for unnecessary instances.

EC2 = virtual computer
EBS = storage
ELB = distributes traffic
ASG = adds or removes instances

EC2 Storage
Q: What storage options can EC2 use?
Storage	Meaning
EBS	Virtual hard drive attached to EC2
EFS	Shared storage that multiple instances can access
Instance Store	Fast but temporary storage that can be lost when the instance stops or terminates
EC2 User Data
Q: What is EC2 user data?

User data is a script that automatically configures an EC2 instance when it launches for the first time.

This automatic setup is called bootstrapping.

It can:

Update the operating system.
Install software.
Download application code or configuration.
Start the application.
Q: What must you remember about user data?
It normally runs only during the first launch.
Stopping and starting EC2 does not normally run it again.
It runs as the root user.
Avoid placing passwords or sensitive information inside it.

User data = automatic first-time EC2 setup.

EC2 Instance Types
Q: What is an EC2 instance type?

The instance type determines the EC2 instance’s:

CPU.
RAM.
Storage capabilities.
Networking performance.
Specialist hardware.
Q: What are the main instance-type categories?
Type	Best for
General Purpose	Balanced everyday applications
Compute Optimized	CPU-heavy calculations
Memory Optimized	Large databases and data processing
Storage Optimized	Storage-heavy applications
Accelerated Computing	GPUs, machine learning and video processing
HPC Optimized	Extremely demanding scientific calculations
Q: How do you read an instance name such as m5.2xlarge?
m = family or purpose.
5 = generation or version.
2xlarge = size or power.

Common families:

T: Burstable General Purpose.
M: General Purpose.
C: Compute Optimized.
R: Memory Optimized.

Family = purpose. Generation = version. Size = power.

EC2 Purchasing Options
Q: What are the main ways to pay for EC2?
Option	Meaning	Best for
On-Demand	Pay while using it with no commitment	Temporary or unpredictable work
Reserved Instances	Commit for 1 or 3 years for a discount	Steady, long-term workloads
Savings Plans	Commit to hourly compute spending for a discount	Predictable usage with more flexibility
Spot Instances	Use spare AWS capacity cheaply, but AWS can interrupt it	Work that can safely stop and restart
Dedicated Host	Rent an entire physical server	Licensing or strict compliance
Dedicated Instance	Use hardware not shared with other customers	Hardware-isolation requirements
Capacity Reservation	Reserve capacity in one Availability Zone	Workloads that must be able to launch
Q: What Reserved Instance options are available?
Standard: Larger discount but less flexibility.
Convertible: More flexibility but usually a smaller discount.
Q: What is important about Spot Instances?

Spot Instances:

Use AWS’s spare capacity.
Can be much cheaper.
Can be interrupted by AWS.

They are suitable only when the work can safely stop and restart.

A Spot Fleet is a collection of Spot Instances used to provide the required capacity.

Q: Does a Capacity Reservation provide a discount?

No. It guarantees that EC2 capacity is available in a particular Availability Zone, but it does not automatically reduce the price.

Final Recall
EC2: A virtual computer rented from AWS.
EBS: Its virtual hard drive.
ELB: Distributes traffic.
ASG: Adds or removes instances.
User data: Automatically sets up EC2 on first launch.
Instance type: Decides the resources and performance.
Purchasing option: Decides how you pay.
On-Demand: Flexible.
Reserved/Savings Plans: Long-term discounts.
Spot: Cheap but interruptible.
Dedicated Host: Entire physical server.
Capacity Reservation: Guaranteed EC2 capacity.
Scalability: Adjust resources when demand changes.
High availability: Keep the application working when failures happen.