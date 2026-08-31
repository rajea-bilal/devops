AWS started as technology that Amazon built for itself to run its online shop.

Amazon then realised:

“Our infrastructure is powerful. Why not let other companies use it too?”

Timeline:

2002 — Used inside Amazon
Amazon created infrastructure to support its own website and online orders.

2003 — The AWS idea
Amazon decided it could offer this infrastructure to other companies as a paid service.

2004 — First public service
Amazon launched SQS, which helps different parts of an application send and manage messages.

2006 — Major AWS launch
Amazon introduced three important services:
S3 — store files and data
EC2 — rent virtual computers/servers
SQS — send and manage messages between systems

2007 — AWS expanded globally
AWS launched in Europe, allowing more businesses around the world to use its cloud infrastructure.

AWS is not only for one type of company. It can power many different businesses and applications.

## What can AWS do?

- Build and run applications
- Increase resources as an application grows
- Store files and data
- Back up important information
- Analyse large amounts of data
- Host websites and mobile apps
- Run online games for players around the world

Industries using AWS
- IT: storage, backups and data analysis
- Healthcare: applications and secure data storage
- Entertainment: streaming films and programmes
- Gaming: hosting games and supporting multiplayer gameplay
- Food and retail: running and scaling global business systems

Companies using AWS

- Netflix: streams films and programmes
- Dropbox: provides online file storage
- Activision: hosts online games
- McDonald’s: supports its worldwide operations

The main idea to remember

AWS is flexible and scalable:

A business can start small and increase its AWS resources as it grows.

AWS is used to run applications, store data and support large numbers of users across many industries.

## AWS Regions

An AWS Region is a geographical area where AWS has a group of data centres.

Examples:

eu-west-2 = London
eu-west-1 = Ireland
us-east-1 = Northern Virginia

Each region contains multiple separate data centres, called Availability Zones. This can help keep an application running if one location has a problem—but your service must be configured to use them properly.

An Availability Zone is one or more separate data centres with their own:

Electricity
Networking
Internet connectivity

The AZs are physically separated, so a problem in one is less likely to affect the others.

Services usually belong to one region

When you create something such as an EC2 virtual server, you choose where it will run.

### The region affects:

- Where your application and data are located
- How quickly users can access the application
- Which AWS services are available
- How much you pay

AWS does not normally move your data to another region unless you configure or permit it.

### How to choose a region

Remember these four things:

1. Compliance

Laws may require data to remain in a particular country or region.

2. Proximity

Choose a region close to your users for faster response times and lower latency.

3. Services

Not every AWS service or new feature is available in every region.

4. Price

The same AWS service can cost different amounts in different regions.

The main idea to remember

An AWS Region is the geographical location where you choose to run your services and store your data.

Choose based on rules, user location, available services and price.


## AWS Edge Locations 

AWS has Points of Presence in cities around the world.

These include:

- Edge locations
- Regional edge caches

They are different from AWS Regions and Availability Zones.

### What does an edge location do?

An edge location stores a temporary copy—called a cached copy—of content closer to users.

This can include:

- Images
- Videos
- Website files
- Downloads

Instead of getting every file from the main AWS Region, the user can receive cached content from a nearby edge location.

AWS commonly provides this through CloudFront, its content delivery network (CDN).

### Why are edge locations useful?

A shorter distance means:

- Lower latency or delay
- Faster loading
- Smoother streaming
- A better experience for users worldwide

### Remember the difference

- Region: geographical area where your main AWS services run
- Availability Zone: separate data-centre location inside a region
- Edge location: delivers cached content closer to users

The main idea to remember

Edge locations reduce latency by delivering content from a location closer to the user.

## AWS Console and service scope 

The AWS Management Console is the website where you create, view and manage your AWS services.

AWS services fall into two main groups:

### 1. Global services

These are not controlled using one selected AWS Region.

Examples:

- IAM: controls who can access your AWS account and what they can do
- Route 53: connects domain names to applications using DNS
- CloudFront: delivers cached content from locations close to users
- AWS WAF: protects applications from harmful web traffic
(WAF can protect global CloudFront distributions or resources in a specific region.)


### 2. Region-scoped services

When creating these resources, you must choose a region such as London (eu-west-2).

Examples:

- EC2: virtual computers
- Elastic Beanstalk: deploys and manages applications
- Lambda: runs code without you managing a server
- Rekognition: analyses images and videos

Not every service is available in every region, so AWS provides a regional services table to check availability.

### Why your selected region matters

If you cannot find a resource in the console, check the region selector. You may be viewing a different region from the one where you created it.

The main idea to remember

The AWS Console manages everything in one place, but some services are global and most resources are created inside a specific region.





## IAM stands for Identity and Access Management.

It controls:

Who can access AWS and what they are allowed to do.

The five main parts

User: an individual person with AWS access
Group: several users who need the same permissions
Policy: rules stating what is allowed or denied
MFA: an extra security check when signing in
Role: temporary access without permanent credentials
How they work

Users and groups

Instead of giving permissions to every user separately, you can place users into a group and give the group permissions.

Example:

Developers group
├── Rajea
├── Ahmed
└── Sarah

Everyone in that group receives the group’s permissions.

Policies

Policies are permission rules written in JSON. They can allow or deny actions such as:

Creating an S3 bucket
Starting an EC2 server
Reading certain data

MFA

MFA requires:

A password
A temporary code from an authentication app or device

It protects the account even if someone steals the password.

Roles

Roles provide temporary permissions to people, applications or AWS services.

For example, an EC2 server can use a role to access an S3 bucket without storing permanent AWS credentials.

One-line memory aid

IAM = users get permissions through policies, while MFA protects access and roles provide temporary access.

## Root user

When you create an AWS account, AWS automatically creates the root user.

The root user:

- Has complete access to everything
- Should not be shared
- Should not be used for everyday work
- Should be protected with MFA

**Only use it for important account tasks that require root access.**

### IAM users

Create a separate identity for each person who needs access.

Each user:

- Has their own login
- Can receive specific permissions
- Only accesses what they are allowed to access

For applications and AWS services, **IAM roles** are normally safer than permanent IAM users.

### IAM groups

A group collects users who need similar permissions.

Examples:

Developers
Operations
Auditors

You attach permissions to the group, and every user in that group receives them.

### Important group rules

- Groups can contain users only
- A group cannot contain another group
- A user can belong to multiple groups
- A user does not have to belong to any group
- Users can also receive permissions directly, although groups make them easier to manage

The main idea to remember

Protect the root user, give each person separate access and use groups to manage shared permissions.

## AM permissions control:

Which AWS actions someone can perform and which resources they can perform them on.

### Policies

Permissions are written inside policies, which are JSON documents attached to:

- Users
- Groups
- Roles

A policy states:

- Effect: allow or deny
- Action: what they can do
- Resource: what they can do it to

For example, a policy could allow someone to:

- View EC2 instances
- View load balancers
- List CloudWatch monitoring information

Users in a group receive the permissions attached to that group.

### The principle of least privilege

Give users only the permissions they genuinely need.

For example:

If someone only needs to read database data, allow reading.
Do not also allow them to edit or delete the data.

Permissions can be added later if their responsibilities change.

The main idea to remember

IAM policies define what actions are allowed or denied on specific AWS resources.

Users receive the permissions of every group they belong to.

An inline policy is a policy embedded directly in one particular user, group or role.

Important rule: a deny wins

If one policy allows an action but another applicable policy explicitly denies it, AWS denies the action.

Group permissions combine. Direct policies can customise access. An explicit deny overrides an allow.