# Security Engineering Lab: CI/CD Pipeline with Automated Scanning

## Overview
This project demonstrates a **Security Engineering best practice**: using automated security tools in a CI/CD pipeline to catch vulnerabilities before they reach production.

## What's in This Project?

### Files
- **`app.py`** - A deliberately vulnerable Flask application (Command Injection bug)
- **`Dockerfile`** - Containerized app with intentional outdated base image
- **`requirements.txt`** - Python dependencies (with old versions to trigger scanners)
- **`.github/workflows/security-scan.yml`** - GitHub Actions pipeline

### Security Tools Used
1. **Trivy** - Scans Docker images and filesystem for known vulnerabilities
2. **Bandit** - Detects common security issues in Python code (Command Injection, SQL Injection, etc.)
3. **pip-audit** - Finds vulnerable dependencies

## How It Works

### The Vulnerability
The `ping()` endpoint in `app.py` has a **Command Injection** vulnerability:

```python
result = subprocess.run(f"ping -c 1 {host}", shell=True, capture_output=True, text=True)
```

**Attack example**: A user could submit `8.8.8.8; cat /etc/passwd` to execute arbitrary commands.

### The Pipeline
When you push code to GitHub:
1. GitHub Actions automatically triggers
2. Trivy scans the Docker image
3. Bandit scans the Python code
4. pip-audit scans dependencies
5. Results appear in GitHub Security tab
6. *(Optional) Merge is blocked if critical issues found*

### The Learning
- **Identification**: You can spot the bug in `app.py` line 28
- **Automation**: The pipeline detects it automatically
- **Enforcement**: The merge is blocked (preventing production deployment)

## Running Locally

### Prerequisites
- Python 3.9+
- Docker (optional)

### Setup
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
python app.py
```

Visit `http://localhost:5000` and try the vulnerable ping endpoint.

### Run Security Scanners Locally
```bash
# Install tools
pip install bandit pip-audit

# Scan Python code for vulnerabilities
bandit -r app.py

# Scan dependencies
pip-audit
```

## Interview Story

**"In this project, I built a deliberately vulnerable Flask app to demonstrate the full security engineering lifecycle:**

1. **I identified** a Command Injection vulnerability in the code
2. **I automated** a GitHub Actions pipeline that catches it with Bandit, Trivy, and pip-audit
3. **I enforced** a policy that blocks merges if critical issues are found

When I push code, GitHub scans it automatically before I can merge. This proves I understand not just how to find bugs, but how to prevent them from reaching production."

## Next Steps (Production Hardening)

To fix the vulnerability:

```python
# SAFE: Use shlex.quote() or avoid shell=True
import shlex
result = subprocess.run(
    ["ping", "-c", "1", shlex.quote(host)],
    shell=False,  # Never use shell=True with user input
    capture_output=True,
    text=True
)
```

## Resources

- [OWASP Command Injection](https://owasp.org/www-community/attacks/Command_Injection)
- [Bandit Documentation](https://bandit.readthedocs.io/)
- [Trivy GitHub](https://github.com/aquasecurity/trivy)
- [GitHub Actions Security Best Practices](https://docs.github.com/en/actions/security-guides)

---

