# Ports and Protocols

## Ports

- Logical endpoints on a device.
- Identified by numbers.
- Used to direct traffic to applications.
- Examples:
  - 80 = HTTP
  - 443 = HTTPS

---

## Protocols

- Define how data is formatted and transmitted.
- Ensure systems communicate consistently.
- Examples:
  - HTTP
  - FTP
  - SMTP

---

# TCP

- Transmission Control Protocol.
- Connection-oriented.
- Uses a three-way handshake.
- Reliable delivery.
- Retransmits lost packets.
- Maintains order.
- Error checking and flow control.
- Used for:
  - web browsing
  - email
  - file transfer

---

# UDP

- User Datagram Protocol.
- Connectionless.
- Sends data immediately.
- No delivery guarantee.
- No retransmission.
- Faster than TCP.
- Used for:
  - streaming
  - gaming
  - DNS
  - VPN protocols

---

## TCP vs UDP

| Feature | TCP | UDP |
|------|-----|-----|
| Connection | Yes | No |
| Reliability | High | Low |
| Speed | Slower | Faster |
| Error Checking | Yes | No |
| Use Cases | Web, Email | Streaming, DNS |
