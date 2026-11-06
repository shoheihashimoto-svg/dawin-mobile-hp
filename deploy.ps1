param([string]$Pass = "")

$ftpHost   = "sv35.xserver.jp"
$username  = "dawin.m@dawin.co.jp"
$localPath = "C:\dev\mobile-saiyo-hp\dist"
$remote    = ""

if ($Pass -eq "") {
    $sp = Read-Host "FTP Password" -AsSecureString
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($sp)
    $Pass = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
}

$cred = New-Object System.Net.NetworkCredential($username, $Pass)

function FtpMkdir($url) {
    $r = [System.Net.FtpWebRequest]::Create($url)
    $r.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
    $r.Credentials = $cred
    $r.UsePassive = $true
    try { $r.GetResponse().Close() } catch {}
}

function FtpPut($src, $url) {
    $r = [System.Net.FtpWebRequest]::Create($url)
    $r.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
    $r.Credentials = $cred
    $r.UsePassive = $true
    $r.UseBinary = $true
    $b = [System.IO.File]::ReadAllBytes($src)
    $r.ContentLength = $b.Length
    $s = $r.GetRequestStream()
    $s.Write($b, 0, $b.Length)
    $s.Close()
    $r.GetResponse().Close()
}

Write-Host "Uploading dist/ to Xserver..."

$dirs = Get-ChildItem -Path $localPath -Recurse -Directory | Sort-Object FullName
foreach ($d in $dirs) {
    $rel = $d.FullName.Substring($localPath.Length).Replace('\','/')
    FtpMkdir "ftp://$ftpHost$remote$rel"
    Write-Host "[dir] $rel"
}

$files = Get-ChildItem -Path $localPath -Recurse -File
$ok = 0
$ng = @()
$i  = 0
foreach ($f in $files) {
    $i++
    $rel = $f.FullName.Substring($localPath.Length).Replace('\','/')
    try {
        FtpPut $f.FullName "ftp://$ftpHost$remote$rel"
        $ok++
        Write-Host "[$i/$($files.Count)] OK  $rel"
    } catch {
        $ng += $rel
        Write-Host "[$i/$($files.Count)] ERR $rel : $_" -ForegroundColor Red
    }
}

if ($ng.Count -eq 0) {
    Write-Host "Done! $ok files uploaded." -ForegroundColor Green
    Write-Host "https://mobile.dawin.co.jp"
} else {
    Write-Host "$ok OK / $($ng.Count) failed:" -ForegroundColor Yellow
    $ng | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
}
