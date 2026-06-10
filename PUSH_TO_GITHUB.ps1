$ErrorActionPreference = "Stop"

$repoName = "csphd"
$description = "Second PhD planning notes for Computer Science, AI, spatial intelligence, and age-friendly indoor spatial world models."
$owner = "wenquan0816"
$remoteUrl = "https://github.com/$owner/$repoName.git"

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "GitHub CLI (gh) is not installed. Install it from https://cli.github.com/ first."
    exit 1
}

gh auth status

if (gh repo view "$owner/$repoName" *> $null) {
    if (-not (git remote get-url origin 2>$null)) {
        git remote add origin $remoteUrl
    } else {
        git remote set-url origin $remoteUrl
    }
    git push -u origin main
} else {
    if (git remote get-url origin 2>$null) {
        git remote remove origin
    }
    gh repo create $repoName --private --description $description --source . --remote origin --push
}
