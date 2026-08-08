# Usage: run from repository root in PowerShell
param(
    [string]$RemoteUrl = 'https://github.com/Suresh-kumar002/CreaditCardDefaulters.git'
)

Write-Host "Setting remote to: $RemoteUrl"

if (Test-Path .git) {
    git remote remove origin -ErrorAction SilentlyContinue
} else {
    git init
}

git remote add origin $RemoteUrl
git add -A
$msg = Read-Host "Enter commit message (or press Enter for default)"
if ([string]::IsNullOrWhiteSpace($msg)) { $msg = "Add deployment files and README" }
try {
    git commit -m "$msg" | Out-Null
} catch {
    Write-Host "Nothing to commit or already committed"
}
git branch -M main

Write-Host "Pushing to origin main... you may be prompted to authenticate."
git push -u origin main

Write-Host "Done. If push failed, authenticate with GitHub (SSH or PAT) and re-run the script."
