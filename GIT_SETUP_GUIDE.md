# Step-by-Step Guide: Push Your Project to GitHub

## STEP 1: Create a New Repository on GitHub
1. Go to https://github.com/new
2. Name it: `security-lab-pipeline` (or your preferred name)
3. Description: "Security Engineering CI/CD pipeline with automated scanning"
4. Choose **Public** (so you can share it in interviews)
5. Do NOT initialize with README (we already have one)
6. Click **Create Repository**

## STEP 2: Set Up Git Locally (If Not Already Done)

### On Windows:
Download Git from https://git-scm.com/download/win and run the installer.

### On Mac:
```bash
brew install git
```

### On Linux:
```bash
sudo apt-get install git
```

### Configure Git (one-time setup):
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@gmail.com"
```

## STEP 3: Initialize Your Local Repository

Navigate to your project folder in terminal/command prompt:

```bash
cd /path/to/your/security-lab-pipeline

# Initialize git
git init

# Add all files
git add .

# Create first commit
git commit -m "Initial commit: Vulnerable Flask app with CI/CD security pipeline"
```

## STEP 4: Connect to GitHub and Push

Copy the commands from GitHub (they look like this):

```bash
# Add the remote (replace USERNAME and REPO-NAME)
git remote add origin https://github.com/USERNAME/security-lab-pipeline.git

# Rename branch to main (if needed)
git branch -M main

# Push to GitHub
git push -u origin main
```

**That's it!** 

Your code is now on GitHub. Within 30 seconds, the GitHub Actions workflow will automatically trigger.

## STEP 5: Watch the Pipeline Run

1. Go to your GitHub repository
2. Click the **"Actions"** tab
3. You'll see "Security Scanning Pipeline" running
4. Wait 1-2 minutes
5. You'll see ❌ failures (this is expected - that's the vulnerability being caught!)
6. Click on the failed job to see the Bandit and Trivy results

## STEP 6: View Security Findings

1. Go to **Security** tab on your GitHub repo
2. Click **Code scanning alerts**
3. You'll see the Command Injection vulnerability flagged by Bandit

---

## Troubleshooting

### "fatal: not a git repository"
Make sure you're in the correct folder with the files.

### "Permission denied" or "fatal: could not read Username"
Use SSH instead:
```bash
git remote set-url origin git@github.com:USERNAME/security-lab-pipeline.git
```

### Workflow not running
1. Check the `.github/workflows/` folder exists
2. File must be named `security-scan.yml` (not `.yaml`)
3. YAML indentation must be exact (no tabs, only spaces)

---


