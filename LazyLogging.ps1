$PathArray = @("C:\Users","$env:USERNAME","Documents","LazyTools")
$date = Get-Date -Format yyyy-MM-dd
$FileName = "log-$date.txt" 

$UserFolder = Join-Path $PathArray[0] $PathArray[1]
$DocumentsFolder = Join-Path $UserFolder $PathArray[2]
$LogFolder = Join-Path $DocumentsFolder $PathArray[3]
$LazyLogPath = Join-Path $LogFolder $FileName

$LogMessages = @()

function Get-Timestamp {
    $Script:time = Get-Date -Format "hh:mm:ss tt"
}

if (-not (Test-Path $LazyLogPath)) {
    if (-not (Test-Path $LogFolder)) {
        New-Item -Path $DocumentsFolder -Name $PathArray[3] -ItemType Directory | Out-Null
        $script:FolderCreated = ":: Logging Folder was created"
    } elseif ((Test-Path $LogFolder)) {
        Get-Timestamp
        $LogMessages += "$time :: LazyLog folder found"
    } else {
        Get-Timestamp
        Write-Error "$time :: Not sure how you made Test-Path return a non-bool result. Good job!"
    }
    $LogMessages += "LazyTools by Bryce Jenkins"
    $LogMessages += "Please Enjoy Responsibly"
    $LogMessages += "All timestamps use system time"
    $LogMessages += "Please feel free to open issues at https://github.com/thechainercygnus/LazyTools/issues"
    Get-Timestamp
    $LogMessages += "$time :: Initializing LazyLog"
    New-Item -Path $LogFolder -Name $FileName -ItemType File | Out-Null
    Get-Timestamp
    $LogMessages += "$time :: Logfile initialized"
    if ($script:FolderCreated){
        Get-Timestamp
        $LogMessages += "$time " + $script:FolderCreated
    }    
    Get-Timestamp
    $LogMessages += "$time :: Enjoy your day"
} elseif ((Test-Path $Global:LazyLogPath)) {
    Get-Timestamp
    $LogMessages += "$time :: LazyLog file found"
}

foreach ($Message in $LogMessages) {
    Add-Content -Path $Global:LazyLogPath -Value $Message
}