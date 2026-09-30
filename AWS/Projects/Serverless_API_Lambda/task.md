Assignment 4 - Serverless API with Lambda, IAM, and API Gateway (BONUS)

A hands-on, production-like serverless workflow. This teaches IAM least-privilege, API design, Lambda basics, and debugging.

Objective

Build a simple REST API using API Gateway → Lambda → DynamoDB.
Your API should accept a POST request, store the data, and return a response.

Tasks

1. Create the DynamoDB Table

Table name: students

Partition key: id (string)

Provisioning: On-demand capacity mode

2. Create the Lambda Function

Runtime: Python or Node.js

Permissions:

Allow PutItem on the DynamoDB table

Logic (you can use AI to write the code, no probz here):

Generate a UUID

Store { id, timestamp, payload }

Return a structured JSON response

Bonus
Add error handling and CloudWatch logs.

3. Build the API Gateway REST API

Create a POST /submit endpoint

Integrate directly with Lambda (proxy integration)

Enable CORS

Deploy the API and get the endpoint URL

4. IAM Permissions

Your Lambda execution role must:

Allow write access to DynamoDB

Have basic Lambda logging permissions

(No over-permissive policies like _:_)

5. Testing

Use curl or Postman:

POST https://<api-id>.execute-api.<region>.amazonaws.com/prod/submit

Payload example:

{
"name": "Mo",
"module": "AWS"
}

Check DynamoDB for inserted items

Check CloudWatch for logs

Bonus (Optional)

Add a GET /students endpoint to scan the table

Add API keys + usage plans

Add WAF (AWS Firewall) with basic rate-limiting rules

Add Custom Domain via ACM
