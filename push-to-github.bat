@echo off
REM Security Lab Pipeline - Automated GitHub Push Script (Windows)
REM This script configures Git and pushes your project to GitHub

setlocal enabledelayedexpansion

echo.
echo ============================================
echo Security Lab Pipeline - GitHub Push Script
echo ============================================
echo.

REM Set variables
set GITHUB_USERNAME=bharath107
set REPO_NAME=security-lab-pipeline
set PROJECT_PATH=%USERPROFILE%\security-lab-pipeline

echo [1/5] Checking if project exists...
if not exist "%PROJECT_PATH%" (
    echo ERROR: Project folder not found at %PROJECT_PATH%
    echo Please make sure you created the security-lab-pipeline folder.
    pause
    exit /b 1
)
echo ✓ Project folder found at %PROJECT_PATH%

echo.
echo [2/5] Navigating to project folder...
cd /d "%PROJECT_PATH%"
if errorlevel 1 (
    echo ERROR: Could not navigate to project folder
    pause
    exit /b 1
)
echo ✓ Now in: %cd%

echo.
echo [3/5] Checking if Git is initialized...
if not exist ".git" (
    echo ✓ Git repository already initialized
) else (
    echo ✓ Git repository exists
)

echo.
echo [4/5] Configuring Git credentials...
git config --global user.name "Security Engineer"
git config --global user.email "security@lab.dev"
echo ✓ Git configured

echo.
echo [5/5] Setting up remote and pushing to GitHub...
echo.
echo Creating repository on GitHub...
echo Please go to https://github.com/new and create a repository with these settings:
echo   - Repository name: security-lab-pipeline
echo   - Description: Security Engineering CI/CD pipeline with automated scanning
echo   - Visibility: Public
echo   - Do NOT initialize with README or .gitignore
echo   - Click "Create Repository"
echo.
pause /b

echo.
echo Renaming branch to main...
git branch -M main
if errorlevel 1 echo WARNING: Branch rename failed

echo.
echo Adding remote origin...
git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git
if errorlevel 1 (
    echo ERROR: Could not add remote
    pause
    exit /b 1
)
echo ✓ Remote configured: https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git

echo.
echo Pushing to GitHub (you may need to authenticate)...
git push -u origin main
if errorlevel 1 (
    echo WARNING: Push may have failed. Trying with different authentication method...
    echo Try running this command manually:
    echo git push -u origin main
    echo.
    echo If you get a credential error, use a Personal Access Token (PAT):
    echo 1. Go to https://github.com/settings/tokens
    echo 2. Create a new token with "repo" scope
    echo 3. Paste it when prompted for password
    pause
    exit /b 1
)

echo.
echo ============================================
echo ✓ SUCCESS! Project pushed to GitHub!
echo ============================================
echo.
echo Next steps:
echo   1. Go to: https://github.com/%GITHUB_USERNAME%/%REPO_NAME%
echo   2. Click the "Actions" tab
echo   3. Wait 1-2 minutes for the pipeline to run
echo   4. You'll see security findings (this is expected!)
echo.
echo To view vulnerability details:
echo   - Click the failed workflow
echo   - Look for Bandit (Command Injection)
echo   - Look for Trivy (Outdated dependencies)
echo.
pause
