param([string]$msg = "")

if ($msg -eq "") {
    $msg = "Update site $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
}

cd "c:\dev\mobile-saiyo-hp"
git add -A
git commit -m $msg
git push origin master
