# Glossary

## API Gateway

API Gateway is an AWS service that gives your backend a public web address. It receives HTTP requests at that address. For each request, it looks at two things: the **path** (like `/students`) and the **method** (like GET). It then calls whichever backend you connected to that pair, which here is a Lambda function. When the function finishes, API Gateway sends the result back to the client.

It can also check things before the request reaches your code. In my project, it checked for an API key and enforced the request limits from my usage plan.

## Deploying and stages

Setting up an API in API Gateway is a lot like setting up routes in Express. I define the paths (`/submit`, `/students`), the methods (POST, GET) and which Lambda function handles each one.

But changes I make in the console are only a **draft**. The client can't see them yet. To make them live, I have to **deploy** the API.

A **stage** is the live version of the API that clients call. I named mine `DeployedAPI`, which is why it's in the URL:

```
https://<api-id>.execute-api.eu-north-1.amazonaws.com/DeployedAPI/students
```

This works the same way as Express. If I add a new route to an Express app, the client can't use it until I restart or redeploy the server. In API Gateway, the **Deploy** button does that job.

### When I need to deploy

Only when I change how the API itself is set up, for example:
- Adding or changing a path or method
- Changing which Lambda a method calls
- Turning "API Key Required" on or off

### When I don't need to deploy

- **Changing my Lambda code.** Lambda is a separate service with its own Deploy button. API Gateway calls the latest code automatically.
- **Linking a usage plan or WAF to the stage.** These attach to the stage directly.

### Why stages exist

One API can have several stages, like `dev` and `prod`, each with its own URL. I can test changes on `dev` without breaking what real users are calling on `prod`.

## Usage plans and WAF

The API key travels *with* the request, from Postman to AWS, inside a header called `x-api-key`. AWS reads it when the request arrives.

### What a usage plan is

A usage plan is **a set of limits for how many requests an API key can make**. It lives inside API Gateway.

On its own, an API key is just a code that says who is calling. The usage plan sets how much that caller is allowed to do. Mine had three limits:

| Limit | My setting | Meaning |
|---|---|---|
| Rate | 2 per second | The steady speed allowed |
| Burst | 5 | A short spike allowed above the rate |
| Quota | 500 per month | The total allowed in a month |

When a request comes in, API Gateway reads the key, finds the usage plan that key belongs to, and counts the request against that plan. Once a caller goes over a limit, API Gateway rejects their extra requests.

For this to work, three links have to be in place:
1. The **key** is added to the **usage plan**
2. The **usage plan** is linked to the **API stage** (`DeployedAPI`)
3. The **method** (GET or POST) is set to **require an API key**

My 403 error happened because link 2 was missing.

### What AWS WAF is

WAF stands for **Web Application Firewall**. It's a **separate AWS service** that checks each request **before** it reaches the API, using rules you write. Each rule says what to look for and what to do: allow the request or block it.

My rule was: *"If one IP address sends more than 100 requests in 5 minutes, block it."* For the test, I lowered this to 20.

### How they differ

| | Usage plan | WAF |
|---|---|---|
| Counts requests by | **API key** (who is calling) | **IP address** (where the request comes from) |
| Part of | API Gateway | A separate service in front of it |
| Main job | Fair use limits for each caller | Stopping floods or bad traffic |
| Cost | Included with API Gateway | Extra charges, which is why I removed it |

**Why use both?** A usage plan only works if callers send a key. WAF doesn't need a key, because it looks at where the traffic is coming from. So it can stop a flood of requests even when they don't have a valid key, or when someone has copied a key.
