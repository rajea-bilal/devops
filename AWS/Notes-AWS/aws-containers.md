AWS Containers — Revision Questions and Answers

Videos 86–99, including follow-up explanations

Docker and containers — Videos 86–87

1. What is Docker?
   Docker is a platform for building container images and running containers. It packages an application with the software it needs so it can run consistently in different environments.

2. What is a container?
   A container is an isolated environment in which an application runs. It uses the application code, libraries, dependencies and runtime packaged in its image.

3. What are dependencies and a runtime?
   Dependencies are other software components the application needs. A runtime is the software environment that runs the application, such as the software needed to execute Java code.

4. What problem does Docker help solve?
   It helps prevent an application working on one computer but failing on another because the installed software or versions differ.

5. Why use containers?
   They offer:

Consistency: The application’s packaged environment stays the same.
Portability: Images can be moved between compatible environments.
Speed: Containers generally start quickly.
Efficiency: They use fewer resources than separate full virtual machines.
Simpler deployment: The application and its dependencies are delivered together.

6. What is a host?
   The host is the machine running the containers. It could be your computer, an EC2 instance or another server.

7. What does Docker Engine do?
   Docker Engine is the software that creates and runs containers on the host. The Docker daemon is the background component that manages them.

8. What do containers share, and what stays separate?
   Containers share the host’s CPU, physical memory, networking resources and operating system kernel.

Their application processes, memory spaces and files are isolated. Each container can have its own dependencies and runtime.

9. What is the operating system kernel?
   The kernel is the core of the operating system. Containers share it instead of each running a separate complete operating system.

10. Can two containers use different versions of Java on the same host?
    Yes. Each container can include its own Java version, so the applications do not have to depend on one shared Java installation.

11. Does Docker mean an image can run on absolutely any computer?
    No. It needs a compatible environment that supports the image and container runtime. The lesson’s main point is that packaging the environment makes moving applications more consistent.

Images, Dockerfiles and registries — Videos 86, 88 and 90

12. What is a Docker image?
    An image is the packaged application and the files it needs, including code, libraries, dependencies and configuration. Docker uses it to create containers.

13. What is the difference between an image and a container?
    An image is the stored package. A container is an instance created from that image that can run the application.

Several containers can be created from the same image.

14. What is a Dockerfile?
    A Dockerfile is a text file containing instructions for building a Docker image.

15. What do the main Dockerfile instructions mean?

Instruction Meaning
FROM Choose the base image to start from.
COPY Copy application files into the image.
RUN Execute a command while building the image, such as installing dependencies.
CMD Specify the default command to run when a container starts.

16. What is a base image?
    It is an existing image used as the starting point for your image. The transcript used Ubuntu 18.04 as an example.

17. What is the important difference between RUN and CMD?
    RUN performs work while the image is being built.
    CMD specifies what runs when a container starts.

18. What does docker build -t your-application . do?
    It builds an image:

docker build starts the build.
-t your-application assigns its name or tag.
. uses the current directory as the build context—the files available to the build. By default, Docker looks there for the Dockerfile.

19. What does docker run your-application do?
    It creates and starts a container from that image. The container starts the application using its configured startup command.

20. What are repositories and registries?
    A repository holds related container images. A registry, such as Docker Hub or Amazon ECR, provides image storage through repositories.

21. What do “push” and “pull” mean?
    Push means upload an image to a registry.
    Pull means download an image from a registry.

Pulling an image does not, by itself, start a container.

22. What is Docker Hub?
    Docker Hub is a service for storing and sharing container images. It includes commonly used images such as Ubuntu, Nginx and MySQL.

23. What is the difference between public and private repositories?
    Public repositories let others access shared images.
    Private repositories restrict access to authorised users and services.

Private repositories are useful for internal company applications.

24. How do the Docker steps fit together?
    Write a Dockerfile → build an image → run a container from it.

To use it elsewhere, push the image to a registry, then pull and run it in the destination environment. You do not need to push an image before running it locally.

Docker versus virtual machines — Video 89

25. What is a virtual machine?
    A virtual machine (VM) is a virtual computer. It has its own guest operating system and an allocated share of the physical machine’s resources.

26. What is a hypervisor?
    A hypervisor is software that creates and manages virtual machines on a physical machine.

27. What is the main difference between VMs and containers?

Virtual machines Containers
Virtualise hardware Isolate applications at the operating system level
Each has its own guest operating system Share a host kernel
Usually require more resources Usually require fewer resources
Usually take longer to start Usually start faster

28. Why are containers generally lighter than VMs?
    Each container does not have to run a separate complete operating system. This reduces the CPU, memory and startup work needed.

29. Can containers run inside an EC2 virtual machine?
    Yes. An EC2 instance can be the host running Docker and its containers. Containers and VMs can be used together.

AWS container services — Video 91

30. What do ECS, EKS, Fargate and ECR each do?

Service Main job
ECS — Elastic Container Service Organises and manages containers using AWS’s own orchestration system.
EKS — Elastic Kubernetes Service Provides managed Kubernetes on AWS.
Fargate Provides computing resources for containers without you managing EC2 servers.
ECR — Elastic Container Registry Stores and manages container images.

31. What does container orchestration mean?
    It means coordinating containers: deploying them, deciding where they run, maintaining the required copies and adjusting their number when configured to do so.

32. What does “serverless” mean for Fargate?
    Servers still exist, but AWS manages them. You configure your containers and their resource requirements without creating or maintaining EC2 instances.

33. Can Fargate work with both ECS and EKS?
    Yes. ECS or EKS manages the workloads, and Fargate provides the infrastructure that runs them.

ECS tasks, task definitions and services — Videos 90–95 and follow-ups

34. What is an ECS task?
    A task is one running instance of a task definition. It contains one or more containers that run together.

35. Is a task always a complete application?
    No. It could contain the whole application or just one part, such as its backend. A larger application can use several different tasks.

36. What is a task definition?
    It describes how ECS should run a task, including:

Which container images to use
Which containers belong together
CPU and memory settings
Network and other running settings
The task’s IAM role

37. Does a task definition describe current CPU and memory usage?
    No. It specifies the resources to allocate or request. Actual usage is measured while the task runs.

38. How are a Dockerfile, image, task definition and task different?

Item What it contains or does
Dockerfile Instructions for building an image
Image Application code and dependencies
Task definition References images and explains how ECS should run them
Task The containers created and run from that definition

A task definition does not contain the application code itself.

39. If each task contains two containers, how many containers run in three tasks?
    Six. Each task runs a copy of the two-container setup.

40. What does an ECS service do?
    It maintains a chosen number of copies of a task. If you ask for three backend tasks, the service works to keep three running.

41. How is ECS different from Docker?
    Docker builds images and runs containers on a machine. ECS coordinates tasks across AWS infrastructure and uses services to maintain the required number of tasks.

ECS launch types — Video 92

42. What does an ECS launch type determine?
    It determines how the computing infrastructure for your tasks is provided. The lesson covered EC2 and Fargate.

43. What are you responsible for with the EC2 launch type?
    You provide and maintain the EC2 instances, including their updates, security and available capacity. ECS manages the tasks running on those instances.

44. What is the ECS agent?
    It is software running on each ECS EC2 instance. It registers the instance with the cluster and communicates with ECS so ECS can manage tasks there.

45. Why would you choose the EC2 launch type?
    When you need control over the servers, such as specific performance settings or security and compliance requirements.

46. How is Fargate different?
    With Fargate, you specify the task and its CPU and memory requirements. AWS provides the underlying computing capacity, so you do not maintain EC2 instances.

47. Does Fargate automatically decide how many application copies you need?
    No. You still set the desired task count or configure scaling rules. Fargate handles the infrastructure needed to run those tasks.

ECS permissions — Video 93

48. What is an IAM role?
    An Identity and Access Management (IAM) role provides permissions to perform particular actions in AWS.

49. What is the EC2 instance profile used for in ECS?
    With the EC2 launch type, it provides the EC2 instance’s role to software such as the ECS agent. This lets the agent communicate with ECS and perform permitted AWS operations.

50. What is an ECS task role?
    It gives the application inside a task permission to use AWS services. It is assigned through the task definition.

51. Why give different applications different task roles?
    They may need different permissions.

For example:

Task A needs to read files from S3.
Task B needs to read and write DynamoDB data.

Each should receive the permissions it needs.

52. What is least privilege?
    Give each application or system only the permissions required for its job.

53. Which detail in the earlier IAM summary needs caution?
    The earlier explanation grouped image downloads, log delivery and secret retrieval under the instance profile too broadly. It did not fully establish which role handles each operation in each setup.

Keep the confirmed distinction: the instance profile supports the EC2 agent; the task role gives the running application its AWS permissions. The exact role for those other operations needs verification before implementation.

ECS load balancing — Video 94

54. Why use a load balancer with ECS?
    It receives requests and distributes them among the application’s running targets, allowing multiple tasks to serve users.

55. When is an Application Load Balancer useful?
    An ALB works at Layer 7, the Application Layer. It understands HTTP and HTTPS requests, making it useful for websites, APIs and microservices.

56. What is path-based routing?
    It sends requests to different applications based on the URL path.

For example, /api can go to backend containers while /frontend goes to frontend containers.

57. When is a Network Load Balancer useful?
    An NLB works at Layer 4, the Transport Layer, handling TCP and UDP traffic. The lesson highlights high throughput, low latency, gaming, real-time messaging and AWS PrivateLink use cases.

It does not inspect URL paths for path-based routing.

58. What should you remember about the Classic Load Balancer?
    The CLB is an older option mainly used for legacy applications. It does not support Fargate.

Correction to the earlier comparison table: Its path-based routing entry should say “No”, rather than “Limited.”

ECS Service Auto Scaling — Video 95

59. What does ECS Service Auto Scaling change?
    It changes the number of running tasks:

Scale out: Add tasks.
Scale in: Remove tasks.

This helps handle increased demand and reduce unnecessary running costs.

60. Which service and metrics does ECS use for scaling?
    It uses AWS Application Auto Scaling with configured rules and metrics such as:

CPU utilisation
Memory utilisation
ALB requests per target

A metric is a measured value describing activity or resource use.

61. How does target tracking work?
    You set a target, such as average CPU usage of 40%. AWS adjusts the task count to keep the metric near that target.

62. How does step scaling work?
    You specify changes for particular thresholds.

For example:

CPU above 70% → add two tasks.
CPU below 30% → remove one task.

63. How does scheduled scaling work?
    You plan capacity changes for known busy or quiet times. For example, increase capacity before a regular Tuesday traffic spike and reduce it afterwards.

64. How is task scaling different from server scaling?
    Task scaling adds application copies. Server scaling adds the computers needed to run them.

With EC2, sufficient server capacity must be available. With Fargate, AWS provides the infrastructure for the requested tasks.

Amazon ECR — Video 96

65. How do ECR and ECS work together?
    ECR stores your images. An ECS task definition references an image, and ECS can pull it when starting the task.

66. What stores ECR image data behind the scenes?
    Amazon S3. You use ECR to manage the images.

67. What should you check if ECS cannot pull a private ECR image?
    Check that the relevant AWS identity has the required IAM permissions. Permissions are one possible cause of a failed pull.

68. What do ECR scanning, tags and lifecycle rules do?

Feature Purpose
Vulnerability scanning Finds known security weaknesses in images; it does not fix them.
Tags Label images, such as different application versions.
Lifecycle rules Automatically remove images that meet configured cleanup conditions.
EKS and Kubernetes — Video 97

69. What is Kubernetes?
    Kubernetes is an open-source system that deploys, scales and manages containerised applications.

70. What are the control plane and worker nodes?
    The control plane coordinates the cluster, including deciding where workloads run.
    Worker nodes are the machines running the application’s pods.

Together, they form the Kubernetes cluster.

71. Does EKS mean AWS manages everything?
    No. Standard EKS manages the control plane, including its underlying infrastructure and maintenance.

You still manage your application and its configuration. Your responsibility for worker infrastructure depends on the compute option you choose.

72. Why might a company choose EKS instead of ECS?
    It may already use Kubernetes and want to keep its tools and way of deploying applications when moving to AWS.

ECS uses AWS’s own orchestration system and has a simpler AWS-specific interface.

73. What does “cloud agnostic” mean here?
    Kubernetes can be used across different cloud providers and on an organisation’s own servers.

This can make applications easier to move, but AWS-specific dependencies may still require changes.

74. How can EKS support an application in several AWS Regions?
    You can deploy separate EKS clusters in each Region.

75. What does CloudWatch Container Insights help you do?
    Monitor logs, metrics and performance so you can understand resource use and investigate problems in your container workloads.

EKS architecture and networking — Video 98 and clarifications

76. How do containers, pods and worker nodes fit together?
    Your application runs in a container. Kubernetes groups one or more containers into a pod. The pod runs on a worker node.

One node can run several pods if it has enough CPU and memory.

77. What is a VPC?
    A Virtual Private Cloud (VPC) is your isolated network within AWS. It contains network sections and resources that you configure to communicate.

78. What is a private subnet?
    A subnet is a smaller section of a VPC. A private subnet has no direct route to an internet gateway.

In the lesson’s setup, the worker nodes stay private, and users reach the application through a load balancer.

79. Does a private subnet automatically make everything secure?
    No. You still need correct network rules, including security groups controlling allowed traffic.

80. What is an Availability Zone?
    An Availability Zone (AZ) is an isolated location within an AWS Region containing one or more data centres.

81. Why spread application copies across multiple AZs?
    If one AZ fails, healthy copies elsewhere can continue serving users.

This depends on having enough working application copies and resources. Multiple AZs improve availability; they do not guarantee that an application can never go down.

82. How do users reach an application on private worker nodes?
    Their request reaches the public load balancer. It forwards traffic towards a healthy application target, either through a node or directly to a pod IP, depending on configuration.

The application sends its response back through that connection.

83. Does a load balancer always divide requests equally across nodes?
    No. Distribution depends on the load balancer’s configuration, routing and healthy targets.

84. What do Kubernetes Service, Ingress and AWS Load Balancer Controller mean?

Term Job
Kubernetes Service Provides a stable way to reach a group of pods as individual pods change.
Ingress Describes web-routing rules, such as where /api requests should go.
AWS Load Balancer Controller Configures AWS load balancers from Kubernetes settings.

They are not necessarily three separate stops every request passes through.

85. What does a NAT gateway do?
    A Network Address Translation (NAT) gateway lets private machines start internet connections and receive the replies.

They might download images, get updates or contact an external service. Internet users cannot use it to start a direct connection to those private nodes.

86. Where is the public NAT gateway placed?
    In a public subnet. The worker nodes remain in private subnets.

87. Why have a NAT gateway in each AZ?
    So resources in one AZ do not depend on a NAT gateway in another AZ that might fail. Each AZ’s resources can use their local gateway.

88. Does an application’s response to a load-balanced request go through the NAT gateway?
    No. The response goes back through the load-balanced connection. The NAT gateway is for connections started by the private resources.

89. How are pod scaling and node scaling different?
    Pod scaling adds or removes application copies.
    Node scaling adds or removes computers for those pods.

They are separate processes and need appropriate configuration.

90. What happens when new pods cannot fit on existing nodes?
    The pods wait. A configured node autoscaler can arrange more computing capacity. Kubernetes can then place the waiting pods on the new nodes.

91. How do Cluster Autoscaler, Karpenter and EKS Auto Mode relate to this?
    They can help provide node capacity:

Cluster Autoscaler adjusts EC2 Auto Scaling groups.
Karpenter provides nodes according to workload needs.
EKS Auto Mode provides automated infrastructure management.

Karpenter and EKS Auto Mode do not require the same Auto Scaling group approach.

EKS node options — Video 99

92. What is a managed node group?
    A group of EC2 worker nodes whose creation, registration and lifecycle operations are handled through EKS. The nodes belong to an Auto Scaling group in your AWS account.

93. Does “managed” remove all maintenance responsibility?
    No. EKS simplifies the work, but you still choose settings and manage updates.

Correction to the earlier summary: AWS provides patched EKS-optimised machine images, but you are responsible for deploying those updated images to your managed node groups.

94. Does a managed node group automatically scale with application demand?
    Not simply because it is managed. Workload-aware scaling needs a configured autoscaling system, such as Cluster Autoscaler.

95. What are self-managed nodes?
    EC2 instances that you create, connect to the cluster and maintain yourself. You take responsibility for their configuration, updates, replacement and scaling.

96. What is an EKS-optimised AMI?
    An Amazon Machine Image (AMI) is a template for creating an EC2 instance.

An EKS-optimised AMI includes software prepared for running an EKS worker node. You can also create a custom AMI for a particular environment.

97. Are custom AMIs only available with self-managed nodes?
    No. Managed node groups also support customisation, including custom AMIs. Self-managed nodes give you more direct responsibility for the overall node setup and lifecycle.

98. How do On-Demand and Spot nodes differ?
    On-Demand: Normal EC2 capacity paid for as used.
    Spot: Discounted spare capacity that AWS can reclaim.

Both managed and self-managed nodes can use these options. Applications using Spot must tolerate interruption.

99. What changes when EKS uses Fargate?
    You configure the pods and their resource requirements. AWS supplies and maintains the underlying computing infrastructure.

You do not choose or maintain EC2 worker nodes, but you still manage the application and its configuration.

100. Is Fargate always more expensive?
     No. The transcript says it can be more expensive in some cases. Costs depend on the workload and setup.

The earlier answer labelled this as a correction even though the transcript had already included that qualification.

Applying the concepts

101. You have built a backend image and want three running copies in ECS. What do you need?
     Store the image somewhere ECS can access, such as ECR. Create a task definition referencing it, then use an ECS service with a desired count of three.

Provide computing capacity through EC2 or Fargate.

102. Each ECS task contains an app container and a logging container. Scaling adds two tasks. How many containers are added?
     Four: two app containers and two logging containers.

103. Traffic rises unpredictably, and you want CPU usage near 40%. Which scaling strategy fits?
     Target tracking.

104. Traffic rises every Tuesday at 5 pm. Which strategy lets you prepare beforehand?
     Scheduled scaling.

105. An EKS cluster has new pods waiting because its nodes are full. Would adding more pods solve the capacity problem?
     No. It needs more node capacity, or more available resources on its existing nodes, before those pods can run.

106. A private worker node needs to download an update from the internet. Which component in the lesson supports this?
     The NAT gateway. It allows the outgoing connection and its reply.

107. A customer wants to open your application. Should their request go to the NAT gateway?
     No. It goes to the application’s public load balancer, which forwards it towards a healthy application copy.

108. Your team already uses Kubernetes and wants to move to AWS. Which service preserves that approach?
     EKS. It lets the team continue using Kubernetes while AWS manages the control plane.

109. Your team wants to run pods without maintaining EC2 servers. Which option fits?
     Fargate, provided it supports the workload’s requirements.

110. One task needs S3 access and another needs DynamoDB access. Should both receive unrestricted AWS permissions?
     No. Give each task a role granting only the access its application needs.
