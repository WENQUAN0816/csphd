$ErrorActionPreference = "Stop"

$repoName = "计算机科学博士"
$description = "Second PhD planning notes for Computer Science, AI, spatial intelligence, and age-friendly indoor spatial world models."

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "GitHub CLI (gh) is not installed. Install it from https://cli.github.com/ first."
    exit 1
}

gh auth status

if (-not (git remote get-url origin 2>$null)) {
    gh repo create $repoName --private --description $description --source . --remote origin --push
} else {
    git push -u origin main
}

