# Lab 03: Wireshark Network Traffic Analysis & Threat Monitoring

## Objective
The goal of this project is to perform hands-on network traffic analysis using Wireshark in a controlled virtualized environment. By capturing and analyzing packets between a monitoring machine (Ubuntu Server) and an attacker machine (Kali Linux), this lab demonstrates the practical mechanics of baseline network communication, the vulnerabilities of legacy unencrypted protocols, and the packet-level behavior of active reconnaissance scans.

## Environment Setup
*   **Monitoring/Target Machine:** Ubuntu Server (IP: `10.157.52.217`) running Wireshark and `vsftpd`.
*   **Attacker Machine:** Kali Linux (IP: `10.157.52.66`) running Nmap.
*   **Network Configuration:** Bridged Subnet (`10.157.52.0/24`).

---

## Phase 1: Baseline Traffic Analysis (ICMP)

**Execution:**
To establish a baseline of normal network communication, 4 ICMP packets were transmitted from the Kali machine to the Ubuntu monitoring machine using the `ping` utility. The Wireshark capture was filtered using the `icmp` display filter to isolate this specific traffic.

**Analysis:**
The capture successfully recorded 8 packets in total. The traffic consisted of four **ICMP Echo Requests (Type 8)** originating from the Kali machine, followed immediately by four corresponding **ICMP Echo Replies (Type 0)** from the Ubuntu machine. This validates that two-way communication is fully operational at the network layer and demonstrates how raw connectivity is established prior to higher-level service interaction.

**Evidence:**
*   ![Kali Ping Execution](Lab_Assets/Screenshot%201.jpg)
*   ![Wireshark ICMP Capture](Lab_Assets/Screenshot%202.jpg)
*   [Download Phase 1 PCAP File](Lab_Assets/baseline_icmp.pcapng)

---

## Phase 2: Unencrypted Protocol Analysis (FTP)

**Execution:**
To demonstrate the inherent vulnerabilities of legacy protocols, an FTP server (`vsftpd`) was provisioned on the Ubuntu target. A remote login attempt was executed from the Kali machine using the command `ftp 10.157.52.217`. A dummy username (`ubuntu`) and password (`password1234`) were submitted while Wireshark monitored the `ftp` traffic.

**Analysis:**
The packet capture confirms that FTP transmits authentication data in plain text without cryptographic protection. By inspecting the payload of the captured packets, the exact credentials (`USER ubuntu` and `PASS password1234`) were easily intercepted and read by the monitoring interface. This practically demonstrates why legacy protocols like FTP and Telnet are deprecated in favor of encrypted alternatives like SFTP and SSH.

**Evidence:**
*   ![Kali FTP Authentication](Lab_Assets/Screenshot%203.jpg)
*   ![Wireshark Cleartext Interception](Lab_Assets/Screenshot%204.png)
*   [Download Phase 2 PCAP File](Lab_Assets/ftp.pcapng)

---

## Phase 3: Reconnaissance & Port Scanning (Nmap & TCP)

**Execution:**
To observe the initial phase of a cyber attack, a Stealth SYN Scan was executed from Kali targeting common service ports (FTP, SSH, HTTP) on the Ubuntu machine using `sudo nmap -sS -p 21,22,80 10.157.52.217`. The Wireshark capture utilized the `tcp.port == 21` filter to isolate the specific TCP handshake mechanics for the FTP service.

**Analysis:**
The Nmap scan successfully identified all three target ports (21, 22, and 80) as actively listening. By analyzing the captured packets for Port 21, the mechanics of the "Stealth SYN" technique are clearly visible. Instead of completing a standard TCP 3-way handshake, the attacker machine sends a `SYN` packet, receives a `SYN-ACK` from the target (confirming the port is open), and immediately terminates the interaction with an `RST` (Reset) packet. This prevents a full connection from being established, allowing the scan to often bypass basic application-level logging on the target server.

**Evidence:**
*   ![Nmap Reconnaissance Scan](Lab_Assets/Screenshot%205.jpg)
*   ![Wireshark TCP SYN-ACK-RST](Lab_Assets/Screenshot%206.png)
*   [Download Phase 3 PCAP File](Lab_Assets/tcp.pcapng)
