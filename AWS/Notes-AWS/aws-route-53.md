DNS records are settings that tell DNS where a domain should point. You can add, update or delete them.

Without Route 53: GoDaddy manages DNS, Vercel hosts the app

Buy yourdomain.com from GoDaddy. You’re registering the name. In this example, GoDaddy also provides its default name servers and stores your DNS records.
Deploy your application on Vercel. Vercel runs your application and gives it an address such as your-app.vercel.app.
Add yourdomain.com to your project’s domain settings in Vercel. This tells Vercel which application to serve when requests arrive for that domain.
Vercel shows you the DNS records required to connect the domain.
Open your DNS records in GoDaddy. Add any missing records or update the relevant existing ones with the values Vercel supplied. Existing records don’t automatically know where your Vercel app is.
Allow time for DNS changes to take effect. Vercel checks the domain’s setup and automatically sets up the HTTPS certificate so visitors can connect securely.

When someone visits your domain, their DNS resolver finds the address through GoDaddy’s DNS servers. Their browser connects to Vercel, which recognises the custom domain and serves your application.

If you then decide to use Route 53 for DNS

Create a public hosted zone for yourdomain.com in Route 53. This is where its DNS records will be managed.
Copy your website records and any other needed records, such as email records, from GoDaddy into that zone. Keep the values pointing to Vercel. Route 53 creates its own NS and SOA records—records identifying its name servers and zone information—so keep those rather than replacing them with GoDaddy’s versions.
Route 53 supplies four name server addresses. These identify the AWS DNS servers that will answer lookups using your hosted zone.
In GoDaddy, change the domain’s name server settings to those four addresses. This switches responsibility for DNS answers from GoDaddy to Route 53. Copying records alone does not make that switch.
Allow time for the switch to take effect. Keep the old DNS setup available during this period because some DNS resolvers may still use it.
Keep the custom domain configured in Vercel. You already added it earlier, so you don’t need to add it again. Your application’s hosting hasn’t changed.

Assuming GoDaddy manages your DNS:

The browser/device asks the DNS resolver for your domain’s IP address.
The resolver finds and asks GoDaddy’s name servers.
Those name servers read your DNS records and return the answer.
The resolver returns the resulting IP address to your device.
The browser connects to that IP address and sends a website request that includes your custom domain name.
Vercel matches that domain to your project and serves your application.

Route 53 and DNS — Q&A Review

These notes cover the lessons you pasted and the follow-up explanations we worked through.

133–134: Introduction to Route 53 and Hosted Zones

1. Q: What is DNS, and what is Route 53?
   A: DNS means Domain Name System. It finds IP addresses for domain names. Route 53 is AWS’s managed DNS service: AWS runs the DNS servers, and you manage your domain’s records. It also offers domain registration and health checks.

2. Q: What is the difference between domain registration, DNS management and website hosting?
   A:

Service Its job
Domain registrar Registers your domain name for a period of time. You renew it to keep it.
DNS provider Stores your DNS records and answers lookups.
Hosting provider Runs your website or application so people can access it.

One company can provide several of these services, but buying a domain alone does not mean you have website hosting.

3. Q: How do you connect a GoDaddy domain to an application hosted on Vercel?
   A:

Deploy your application on Vercel.
Add your custom domain to the project in Vercel.
Vercel supplies the required DNS record values.
Add or update those records wherever your DNS is managed—for example, GoDaddy.

DNS helps the browser reach Vercel. Your domain configuration in Vercel tells it which application to serve.

4. Q: What is a hosted zone?
   A: A hosted zone stores DNS records for a domain and its subdomains. For example, the zone for example.com can hold records for example.com, www.example.com and api.example.com.

5. Q: What is the difference between DNS records and name servers?
   A: DNS records are information, such as a domain’s IP address. Name servers are servers that answer DNS questions using those records. The servers are not inside the hosted zone; the zone stores the records they use.

6. Q: What does “authoritative name server” mean?
   A: It means the server provides the official DNS answers for a domain. If you configure your domain to use Route 53’s name servers, they provide those official answers.

7. Q: Why does Route 53 give you four name server addresses?
   A: They identify the DNS servers assigned to answer lookups for your public hosted zone. Having several provides reliability. They are not four IP addresses for your website.

8. Q: Does Route 53’s 100% availability SLA mean it can never fail?
   A: No. SLA means Service Level Agreement: an availability commitment with service credits for eligible failures. The 100% commitment applies to authoritative DNS outside GovCloud; it does not guarantee your whole website stays online.

9. Q: Why is it called Route 53, and what is the basic hosted zone charge?
   A: 53 refers to port 53, the standard port for DNS queries. The pricing checked during these lessons was $0.50 USD per hosted zone per month for the first 25, then $0.10 each. Public DNS queries can cost extra.

135: Public vs Private Hosted Zones

10. Q: What is the difference between a public and private hosted zone?
    A: A public hosted zone supplies records for public internet DNS lookups. A private hosted zone supplies internal DNS records to associated VPCs—Virtual Private Clouds. One private zone can be associated with several VPCs.

11. Q: How does an application find a database using a private hosted zone?
    A:

The application asks its VPC’s DNS resolver for a name such as db.example.internal.
The resolver uses the associated private hosted zone’s record.
It returns the database’s private IP address.
The application connects, if the network settings allow it.

12. Q: Does a private hosted zone itself secure your database?
    A: No. It keeps those DNS records out of public DNS. Security groups and other network settings control access to the database.

136–138: DNS Terms and How DNS Works

13. Q: What is a DNS resolver?
    A: It finds DNS answers on your device’s behalf. It may be provided by your internet service provider, your company or another provider.

14. Q: What is a DNS cache?
    A: A cache temporarily stores previous DNS answers. A resolver can reuse a valid saved answer instead of repeating the lookup.

15. Q: What happens when you enter example.com in your browser?
    A: The browser or device asks a DNS resolver for the domain’s IP address. The resolver follows this flow:

The DNS resolver checks its cache first. If it needs to do the full lookup, it asks a root DNS server. The root points it to the .com name servers.

The resolver asks a .com name server, which points it to example.com’s name servers.

The resolver asks example.com’s name server, which checks its DNS records and returns the website’s IP address.

The resolver temporarily saves that answer and returns it to the browser. The browser then uses the IP address to connect to the website.

16. Q: What do the root server, TLD server and domain’s name server each know?
    A:

Server What it supplies
Root DNS server Where to find servers for endings such as .com or .org.
TLD server—Top-Level Domain server Where to find a particular domain’s name servers.
Domain’s authoritative name server The domain’s official DNS records, such as its website IP address.

Root servers already exist around the world. You do not create them.

17. Q: Does the root server forward the lookup to the next server?
    A: No. It replies to the resolver with where to ask next. The resolver contacts each server itself. Saved information can let it skip some steps.

18. Q: Does DNS send the website request to your hosting provider?
    A: No. DNS returns information that lets the browser find the destination. The browser then makes a separate website request, including the domain name so the hosting provider can identify the correct website.

19. Q: What are the parts of http://api.www.example.com?
    A:

Part Meaning
http:// The protocol used for the website request. HTTP operates at application Layer 7.
api.www.example.com The complete DNS name, called a Fully Qualified Domain Name—FQDN.
api and www Subdomain levels. Neither is compulsory.
example The Second-Level Domain—SLD.
.com The Top-Level Domain—TLD.
Final .—usually omitted The DNS root: api.www.example.com.

20. Q: Are “hostname” and “domain name” exactly the same?
    A: A hostname is a domain name used to identify a host or service. Both example.com and www.example.com can be hostnames. For these lessons, “domain or subdomain name” is usually enough.

21. Q: What is a zone file?
    A: A text file containing DNS records for a zone. In Route 53, you manage your records in a hosted zone.

139–140: DNS Records and Record Types

22. Q: What information does a Route 53 record contain?
    A: Its name, record type, value, routing policy and, for non-alias records, TTL. These specify what name the record concerns, what answer it holds, how Route 53 chooses it and how long it can be cached.

23. Q: What do A, AAAA, CNAME and NS records do?
    A:

Record Purpose
A Points a name to an IPv4 address.
AAAA Points a name to an IPv6 address.
CNAME—Canonical Name Points one name to another name for DNS to look up.
NS—Name Server Identifies the name servers responsible for a domain or zone.

24. Q: What do MX, TXT and CAA records do?
    A:

Record Purpose
MX—Mail Exchange Identifies servers that receive email for a domain.
TXT—Text Stores text, often for domain verification or email security.
CAA—Certification Authority Authorization Specifies which certificate authorities may issue certificates for the domain.

SPF—Sender Policy Framework identifies permitted email senders and is published using TXT records. The separate SPF record type is obsolete.

141: TTL—Time To Live

25. Q: What does TTL control?
    A: Time To Live specifies how long a DNS answer can be cached, in seconds. A TTL of 300 allows the resolver to reuse the answer for five minutes. After expiry, the next lookup needs a fresh answer.

26. Q: What is the trade-off between a high and low TTL?
    A:

High TTL Low TTL
Fewer fresh DNS queries, potentially lower query costs. More fresh queries, potentially higher query costs.
Old answers can remain cached longer after a change. Updated answers can reach users sooner.

A low TTL reduces delay; it does not make changes instant.

27. Q: Does changing a DNS record immediately change cached answers?
    A: No. Resolvers can continue using their old answers until the remaining TTL expires. Lowering the TTL now does not shorten the lifetime of answers already cached with the previous TTL.

28. Q: Do you set the TTL directly on an Alias record?
    A: No. Route 53 uses the TTL determined by the Alias target.

142 and 144: CNAME vs Alias and Supported Targets

29. Q: When should you use CNAME or Alias to connect a domain to an AWS load balancer?
    A: An Alias lets you point your main domain or a subdomain to an AWS load balancer. A CNAME can do this for a subdomain, but not the hosted zone’s main domain.

30. Q: How does an Alias connect example.com to a load balancer?
    A: You create an A record with Alias enabled and select the load balancer as its target. Route 53 returns the load balancer’s current IP addresses, so you do not enter those addresses manually.

31. Q: Can an Alias point to any AWS resource?
    A: No—its target must be supported. Common targets include load balancers, CloudFront, API Gateway custom domains, eligible Elastic Beanstalk environments, S3 website endpoints, VPC interface endpoints and Global Accelerator. It can also point to a compatible record in the same hosted zone.

32. Q: How do you point a domain directly to an EC2 instance?
    A: An Alias cannot point directly to the instance’s DNS name. Use an A record for its IPv4 address, an AAAA record for its IPv6 address, or a CNAME from a subdomain to its DNS name. An Elastic IP provides a stable public IPv4 address.

33. Q: Are Alias records completely free and automatically health-checked?
    A: No. DNS queries to eligible AWS Alias targets are free, but hosted zones and resources can still cost money. Health evaluation depends on the target and configuration; it is not automatically available for every Alias.

145–148: Routing Policies, Simple, Weighted and Latency

34. Q: What does a Route 53 routing policy actually control?
    A: It controls which DNS answer Route 53 returns. If your application runs on several servers, the policy can determine which server’s IP address the resolver receives. Route 53 does not forward the application request.

35. Q: What does Simple routing do?
    A: It returns the value or values configured in the record. With several IP addresses, the client chooses which to try; Route 53 does not guarantee an even split. You cannot attach health checks to Simple records.

36. Q: Can a Simple Alias record point to several resources?
    A: It has one target, such as one load balancer. That load balancer can still distribute application requests across many servers.

37. Q: How does Weighted routing work?
    A: You create records with the same name and type but different destinations and weights. Route 53 chooses records in proportion to their weights:

Record weight ÷ total weight × 100

Weights of 70, 20 and 10 give the same proportions as 7, 2 and 1.

38. Q: Does a weight of 70 guarantee 70% of users reach that server?
    A: No. It controls the approximate share of DNS answers, not exact website visits. Resolvers can cache one answer and reuse it for several users.

39. Q: Why use Weighted routing, and what does weight 0 mean?
    A: You can give a new application version a small share while the existing version gets most requests. Weight 0 normally excludes a record, but if all weights are zero they are treated equally. With health checks, zero-weight records can be considered when all positive-weight records are unhealthy.

40. Q: How does Latency-based routing work?
    A: You configure destinations in different AWS Regions. Route 53 uses AWS’s network measurements to choose the Region expected to have the lowest delay and returns that resource’s address. The geographically closest Region is not always fastest.

41. Q: Does Latency-based routing test your application’s speed on every lookup?
    A: No. It uses AWS latency measurements. Health checks can help exclude unhealthy resources, while caching can delay changes in which destination users receive.

149: Health Checks and Failover

42. Q: Who performs Route 53 health checks, and when?
    A: AWS operates Route 53’s health-checking system. Checks run in the background, independently of DNS lookups. Route 53 uses their results when selecting DNS answers; the resolver receives the answer, not the health report.

43. Q: What are the three health-check types?
    A:

Type Who does what
Endpoint Route 53 health checkers contact your application and assess its response.
Calculated Route 53 combines other checks using your rule, such as “at least two must pass”.
CloudWatch-based CloudWatch monitors resource measurements; Route 53 uses the configured alarm conditions to determine health.

44. Q: What does “configure an endpoint health check” mean?
    A: You tell Route 53 which address, port and, for a web check, path to test. For example, your application could respond at primary.example.com/health. Repeated failures can cause it to be marked unhealthy.

45. Q: What are failover DNS records?
    A: Two records for the same name and type: one Primary for the main application and one Secondary for the backup. With health monitoring configured, Route 53 returns the primary address while healthy and the secondary address when the primary fails.

46. Q: Do health checks guarantee uninterrupted access?
    A: No. Detecting failure takes time, old DNS answers may still be cached, and the backup can also fail. DNS failover changes answers for lookups; it does not move existing connections.

47. Q: Can direct Route 53 endpoint health checks reach private resources?
    A: They need a publicly reachable endpoint. For private resources, a CloudWatch-based health check can use measurements reported from inside your network.

150–152: Geolocation, Geoproximity and IP-based Routing

48. Q: How does Geolocation routing choose a destination?
    A: It follows rules you configure for continents, countries or US states. The most specific matching rule wins—for example, France takes priority over Europe. The application at the chosen destination serves the regional content.

49. Q: Why create a default Geolocation record?
    A: It supplies an answer for locations without a matching rule or whose location cannot be identified. Without it, those lookups may receive no answer.

50. Q: How does Geoproximity routing work, and what is bias?
    A: It chooses based on the geographic distance between users and resources. Bias adjusts the area served by a resource:

0: no adjustment.
+1 to +99: expands its area.
−1 to −99: shrinks its area.

A bias of +50 does not mean 50% more traffic.

51. Q: How does Route 53 know where a Geoproximity resource is?
    A: For AWS resources, you specify the Region or supported Local Zone location. For resources outside AWS, provide latitude and longitude. Traffic Flow is optional; it provides visual maps for these rules.

52. Q: What is the difference between Geolocation, Geoproximity and Latency-based routing?
    A:

Policy Basis for choosing
Geolocation Your country, continent or US-state rules.
Geoproximity Geographic distance, adjusted by bias.
Latency-based Expected network delay based on AWS measurements.

53. Q: How does IP-based routing work?
    A: You specify source IP ranges and assign a destination to each range. Route 53 checks which range matches the query’s source IP information and returns that destination’s address.

54. Q: What is CIDR doing in IP-based routing?
    A: CIDR—Classless Inter-Domain Routing—is a short way to describe an IP range. It does not create IP addresses. Here, the range identifies which visitors or resolvers a rule applies to—not the destination server’s network.

For example: “If the source IP is within 192.0.2.0/24, return Server A’s IP address.”

55. Q: Does Route 53 always see the individual user’s IP address?
    A: No. It usually sees the resolver’s IP address. If the resolver supplies information about the user’s IP range, Route 53 can use that instead. IP-based rules can help send customers of a particular internet provider to a suitable server; a default record handles unmatched ranges.

153: Multivalue Routing

56. Q: How does Multivalue routing work?
    A: You create several records for the same name, each with a different server address. Route 53 can return up to eight healthy records in one answer. The browser or application chooses an address to try.

57. Q: How do health checks affect Multivalue answers?
    A: Records with failing checks can be excluded while healthy records are available. A record without a health check is treated as healthy. If all records are unhealthy, Route 53 can still return unhealthy records.

58. Q: How is Multivalue different from Simple routing and a load balancer?
    A: Unlike Simple routing, Multivalue allows a health check for each record. It still only supplies DNS answers. An Application Load Balancer—ALB—receives application requests and forwards them to servers, so Multivalue does not replace it.

155: GoDaddy as Registrar and Route 53 as DNS Provider

59. Q: How do you switch DNS management from GoDaddy to Route 53?
    A:

Create a public hosted zone for your domain in Route 53.
Copy the needed website, email and other DNS records into it. Keep Route 53’s automatically created NS and SOA records.
Copy the four name server addresses supplied by Route 53.
Enter them in your domain’s name server settings at GoDaddy.
Allow time for the switch and keep the old DNS setup available during the transition.

Copying records alone does not switch DNS providers. Changing the name server settings makes the switch.

60. Q: After switching DNS to Route 53, what changes—and what stays where it was?
    A: You manage DNS records in Route 53. You still renew the domain with GoDaddy, and your application stays with its hosting provider, such as Vercel. Keep the custom domain configured in Vercel so it knows which application to serve.
