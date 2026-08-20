<#
.SYNOPSIS
    Automated Layer 7 HTTP Burst Test for SafeLine WAF Rate Limiting
.DESCRIPTION
    Sends a burst of 15 HTTP requests to the target login endpoint to verify WAF throttling (HTTP 429).
#>

$TargetUrl = "http://10.157.52.217/DVWA/login.php"
$BurstCount = 15

Write-Host "[*] Initiating Layer 7 burst test against: $TargetUrl" -ForegroundColor Cyan
Write-Host "[*] Total Requests: $BurstCount`n" -ForegroundColor Cyan

1..$BurstCount | ForEach-Object {
    $StatusCode = curl.exe -s -o NUL -w "%{http_code}" $TargetUrl
    if ($StatusCode -eq "200") {
        Write-Host "Request [$_]: HTTP $StatusCode (Allowed)" -ForegroundColor Green
    } elseif ($StatusCode -eq "429" -or $StatusCode -eq "403") {
        Write-Host "Request [$_]: HTTP $StatusCode (Intercepted / Throttled by WAF)" -ForegroundColor Yellow
    } else {
        Write-Host "Request [$_]: HTTP $StatusCode" -ForegroundColor Red
    }
}