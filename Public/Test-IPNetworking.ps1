function Test-IPNetworking {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$false,Position=0)] [String]$ip = "1.1.1.1" # Default
    )
    $ConnectionTest = Test-Connection $ip -Quiet
    Write-LogMessage "Connection Test to $ip returned $ConnectionTest"
    Return $ConnectionTest
}