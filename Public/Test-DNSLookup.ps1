function Test-DNSLookup {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$false,Position=0)] [String]$address = "durish.xyz" # Default
    )
    $ConnectionTest = Test-Connection $address -Quiet
    Write-LogMessage "Connection Test to $address returned $ConnectionTest"
    Return $ConnectionTest
}