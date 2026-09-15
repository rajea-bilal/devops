Serverless basics

1. What does serverless mean, and are there still servers?
   Serverless means AWS manages the servers behind the services you use. Servers still exist, but you do not set them up or maintain them. You still manage your code, service settings and permissions.

2. What is FaaS, and is all serverless computing function-based?
   FaaS means Function as a Service: you deploy individual functions that run when needed. Lambda is an example. Serverless also includes databases, storage and messaging services, so it is not limited to functions.

3. What is AWS Lambda, and what triggers it?
   Lambda runs your code as a function without you managing servers. A trigger causes it to run—for example, an S3 upload, an API request or a scheduled time. One run is called an invocation.

AWS serverless services

4. What is the difference between DynamoDB and Aurora Serverless?
   Both store database data without you managing database servers.

DynamoDB: a NoSQL database that stores items with attributes.
Aurora Serverless: a relational database that stores data in tables with defined relationships.

5. Do serverless databases always scale without configuration?
   Their behaviour depends on their settings:

DynamoDB on-demand: automatically manages read and write capacity.
DynamoDB provisioned: you choose capacity and can configure automatic scaling.
Aurora Serverless: adjusts computing capacity within configured limits.

6. What does Amazon S3 store?
   S3 — Simple Storage Service — stores files as objects inside buckets. These can include images, documents and static website files. AWS manages the underlying storage as your data grows.

7. What does Amazon Cognito do?
   Cognito handles user accounts, signups and logins. It provides authentication, which means checking that a user is who they claim to be.

8. Does API Gateway pass frontend requests to a backend or to Lambda?
   It can pass requests to either a Lambda function or another configured backend, such as an application running on a server. Lambda itself can be your backend. Backend describes its role; serverless describes how it runs.

9. How could Cognito, S3, API Gateway, Lambda and DynamoDB work together?
   S3 stores the frontend’s static files. Cognito handles login. The frontend sends an API request to API Gateway, which calls Lambda. Lambda processes the request, reads or writes DynamoDB data, and returns a response through API Gateway.

10. What is the difference between SNS and SQS?
    Both help application components communicate.

SNS — Simple Notification Service: delivers published messages to subscribers, potentially notifying several systems.
SQS — Simple Queue Service: holds messages until another component retrieves and processes them.

11. What does Amazon Data Firehose do?
    It delivers streaming data—continuously arriving data such as logs—to destinations for storage and analysis. It was previously called Kinesis Data Firehose. It mainly delivers data rather than analysing it, and it may briefly collect data before sending it.

12. What does AWS Step Functions do?
    It coordinates and monitors a workflow: a series of tasks involving Lambda functions or other services. For example, it can manage the steps for checking an order, processing payment and arranging delivery.

Lambda versus EC2

13. What is the main difference between EC2 and Lambda?
    With EC2, you manage a virtual server, its operating system and installed software. With Lambda, you deploy functions and AWS manages the servers that run them.

14. How do EC2 and Lambda differ in scaling?
    For EC2, you change the number of instances yourself or configure Auto Scaling. Lambda automatically adjusts simultaneous function executions, within its limits.

15. What is Lambda concurrency, and is scaling unlimited?
    Concurrency means how many function executions run at the same time. Lambda has limits on simultaneous executions and how quickly it can add capacity. Automatic scaling does not mean unlimited capacity.

16. What is Lambda’s execution time limit?
    A standard invocation can run for up to 15 minutes. You set a timeout, which can be shorter. The limit applies to each run, not the lifetime of the deployed function.

17. Would one standard Lambda invocation suit a task needing 30 uninterrupted minutes?
    No. It exceeds the 15-minute limit. An EC2 instance does not have that Lambda-style task limit. Lambda suits shorter tasks that run when triggered.

Pricing, resources and monitoring

18. How does payment differ between a running EC2 instance and on-demand Lambda?
    A running EC2 instance costs money even when it has no work—called idle time. Standard on-demand Lambda mainly charges for requests and execution usage. Optional features such as Provisioned Concurrency, which keeps environments ready, can add waiting-time charges.

19. What is a GB-second, and how is it calculated?
    A GB-second measures allocated memory multiplied by execution time:

Memory in GB × running time in seconds

For example, 2 GB × 3 seconds = 6 GB-seconds. Billing uses allocated memory, not only the memory the code actually uses.

20. What monthly Lambda free allowance did we cover?
    1 million requests and 400,000 GB-seconds. Whether an application stays within it depends on request volume, memory and execution time. S3, DynamoDB and other services can charge separately.

21. What happens when you increase a Lambda function’s memory?
    Lambda also allocates more CPU processing power. You can configure up to 10,240 MB, commonly called 10 GB.

The function may finish faster, but each second costs more. Overall cost depends on the time saved. More memory does not guarantee faster network transfers.

22. How is increasing memory different from automatic scaling?
    Increasing memory gives each execution more resources. Automatic scaling changes how many executions run at the same time.

23. How does CloudWatch help you monitor Lambda?
    CloudWatch shows:

Invocations: how often the function runs.
Duration: how long it takes.
Errors: whether runs fail.
Logs: recorded messages that help explain what happened.
Languages, runtimes and containers

24. What is a runtime, and which languages did we cover?
    A runtime is the software environment that executes code.

We covered JavaScript through Node.js, Python, Java, C#, PowerShell, Ruby and Go. Node.js runs JavaScript; .NET is a platform used by C#. PowerShell uses packaging through .NET rather than its own managed Lambda runtime.

25. What is a custom runtime, and how does Go run on Lambda?
    A custom runtime supplies an execution environment when the managed runtimes do not fit your needs. It uses the Lambda Runtime API to receive events, execute code and return results or errors.

Go is already supported through OS-only runtimes, where you supply the compiled program and required integration. The Runtime API is separate from API Gateway.

26. Why package a Lambda function as a container image?
    An image packages your code with its dependencies—the libraries and software it needs. This helps with complex setups.

The image must integrate with the Lambda Runtime API. AWS Lambda base images include that integration. Container packaging does not remove Lambda’s execution limits.

27. How does a Lambda container image differ from ECS with Fargate?
    A Lambda image runs as a function under Lambda’s execution model and limits.

ECS with Fargate runs general container applications, including applications that keep running. Fargate manages the underlying servers, but you configure ECS Service Auto Scaling if you want the number of tasks to adjust automatically.

Practical examples

28. How does the automatic thumbnail example work?
    An image upload to S3 sends an event to Lambda. The event identifies the image; Lambda retrieves it, creates a smaller thumbnail and saves it in S3. Lambda can also save metadata, such as the image name and size, in DynamoDB.

S3 stores the images. DynamoDB records information about them. You must configure the trigger and permissions.

29. How do you stop a thumbnail from triggering thumbnail creation again?
    Use a separate output bucket, or filter the trigger so it only watches original uploads.

For example, trigger on originals/ and save outputs under thumbnails/. These beginnings of object names are called prefixes. A different prefix alone is insufficient—the trigger must exclude it.

30. How do scheduled Lambda tasks work, and how do rate and cron differ?
    EventBridge Scheduler controls when the function starts; Lambda performs the work. This can automate backups or cleanup without keeping your own server running to wait.

Rate expression: a regular interval, such as every hour.
Cron expression: particular times or calendar patterns, such as every day at 9 a.m.

EventBridge Scheduler is the recommended approach for new schedules; older EventBridge scheduled rules are a legacy feature. The function still has its execution limits and usage costs.
