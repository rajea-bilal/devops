# Networking Module – DevOps Learning Notes

Core networking concepts used daily by DevOps and cloud engineers, plus a deployment project that made them concrete.

---

## Notes

| File | Covers |
| --- | --- |
| [ports-protocols-tcp-udp.md](ports-protocols-tcp-udp.md) | Ports, common protocols, and TCP vs UDP — connection-oriented vs connectionless |
| [osi-model.md](osi-model.md) | The seven OSI layers, why communication models exist, and what happens at each layer |

---

## Project — Deploying a site to AWS EC2 by hand

The practical half of this module. I deployed my Next.js portfolio to a Linux server I configured myself, which turned DNS records and firewall rules from diagrams into things I had to get right.

**AWS EC2 (Ubuntu) · NGINX · Cloudflare DNS · Certbot + Let's Encrypt**

**[Full write-up with screenshots →](Deployment_project/README.md)**

Covers Security Groups as firewall rules, `sites-available` / `sites-enabled`, serving a static build, issuing a TLS certificate, and repointing DNS to an EC2 public IP.

The site has since moved back to Vercel — deploying by hand left no path from commit to live without SSH-ing into the server, which is the gap CI/CD closes. The write-up explains that in full.

---

## Suggested order

1. `ports-protocols-tcp-udp.md` — ports and protocols first, since everything else references them
2. `osi-model.md` — the layered mental model
3. `Deployment_project/` — apply it to a real server

---

## Still to cover

Topics on the list for when I return to this module:

- TCP/IP model
- DNS components, records, and the resolution process
- DNS debugging tools and the hosts file
- Routing basics and routing protocols
- Subnetting, binary, CIDR, and NAT
- Network troubleshooting tools
- Cloud networking

---

Notes are written for revision — simplified into bullet points, correct terminology, focused on DevOps relevance.
