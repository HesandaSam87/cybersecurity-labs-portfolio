\# Layer 7 Defense Engineering: SafeLine WAF Deployment \& Threat Mitigation



!\[Security Status](https://img.shields.io/badge/Security-AST%20Semantic%20Inspection-0d9488?style=flat-square)

!\[WAF](https://img.shields.io/badge/WAF-SafeLine%20v9.4.0-blue?style=flat-square)

!\[Target](https://img.shields.io/badge/Target-DVWA%20(Apache%2FMySQL)-red?style=flat-square)

!\[Validation](https://img.shields.io/badge/OWASP%20Mitigation-100%25%20Verified-success?style=flat-square)



A hands-on implementation of a containerized \*\*Web Application Firewall (WAF)\*\* reverse proxy architecture protecting a vulnerable \*\*Damn Vulnerable Web Application (DVWA)\*\* instance. 



This project explores the operational shift from brittle, signature-based regular expression filtering to \*\*Abstract Syntax Tree (AST) Semantic Analysis\*\*, validating real-time defense against OWASP Top 10 vulnerabilities, Layer 7 access controls, and automated request floods.



\---



\## 🏗️ Architecture \& Network Topology



The architecture isolates the backend application to an internal unprivileged port, forcing all incoming HTTP traffic through SafeLine's inspection proxy before reaching the web server.

