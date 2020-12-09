$PathArray = @("$env:USERNAME","Documents","LazyTools")
$date = Get-Date -Format yyyy-MM-dd
$FileName = "log-$date.txt" 
$env:LazyLogPath = "C:\Users"
foreach ($stub in $PathArray) {
    $env:LazyLogPath = Join-Path $env:LazyLogPath $stub
}
$env:LazyLogPath = Join-Path $LogFolder $FileName

function Write-LogMessage {
    param(
        [Parameter(Mandatory=$true,Position=0)] [string]$Message
    )
    Get-Timestamp
    $Message = "$env:time :: $Message"
    Add-Content -Path $env:LazyLogPath -Value $Message
}