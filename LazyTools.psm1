$PathArray = @("$env:USERNAME","Documents","LazyTools")
$date = Get-Date -Format yyyy-MM-dd
$FileName = "log-$date.txt" 
$env:LazyLogPath = "C:\Users"
foreach ($stub in $PathArray) {
    $env:LazyLogPath = Join-Path $env:LazyLogPath $stub
}
$env:LazyLogPath = Join-Path $LogFolder $FileName

function Get-Timestamp {
    $env:time = Get-Date -Format "hh:mm:ss tt"
}

function Test-IPNetworking {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$false,Position=0)] [String]$ip = "1.1.1.1" # Default
    )
    $ConnectionTest = Test-Connection $ip -Quiet
    Get-Timestamp
    Add-Content -Path $env:LazyLogPath -Value "$time :: Connection Test to $ip returned $ConnectionTest"
    Return $ConnectionTest
}

function Test-DNSLookup {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$false,Position=0)] [String]$address = "durish.xyz" # Default
    )
    $ConnectionTest = Test-Connection $address -Quiet
    Get-Timestamp
    Add-Content -Path $env:LazyLogPath -Value "$time :: Connection Test to $address returned $ConnectionTest"
    Return $ConnectionTest
}

function Get-PowerPlan {
    [CmdletBinding()]
    <#
    .SYNOPSIS
    Returns an object containing all Power Plans currently enabled on a system.

    .DESCRIPTION
    This cmdlet returns a list of all available power plans and their associated GUID in a
    custom object that is able to be passed to Set-PowerPlan

    #>
    $PowerPlanList = powercfg -l
    $PowerArrayLength = $PowerPlanList.Length - 1
    $PowerPlanList = $PowerPlanList[3..$PowerArrayLength]
    $GUID_Pattern = '([a-zA-Z0-9]{8}[-a-zA-Z0-9]{4}[-a-zA-Z0-9]{4}[-a-zA-Z0-9]{4}[-a-zA-Z0-9]{12})\w+'

    $PowerPlans = foreach ($Plan in $PowerPlanList) {
    
        $planGUID = [regex]::Match($Plan,$GUID_Pattern).Groups[1].Value
        $planName = $Plan.Split('()')[1]
        [PSCustomObject]@{
            PowerPlan = $planName
            GUID = $planGUID
        }
    }
    Return $PowerPlans
}

function Test-Comparison {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0)] $a,
        [Parameter(Mandatory=$true,Position=1)][ValidateSet('eq','ne','ge','gt','le','lt')] $Operand,
        [Parameter(Mandatory=$true,Position=2)] $b,
        [Parameter(Mandatory=$false,Position=3)][ValidateSet('int','string','char')] $CastType
    )
    <#
    .SYNOPSIS
    Compares two objects to see if they are logicially equal.

    .DESCRIPTION
    Takes two parameters $a and $b which do not need to be called explicitly.

    .PARAMETER $operand

    .EXAMPLE
    Test-LogicMatch 1 1
    Will return $true

    .EXAMPLE
    Test-LogicMatch 1 2
    Will return $false

    #>
    switch ($CastType) {
        'int' {
            [int]$a = $a
            [int]$b = $b
        }
        'string' {
            [string]$a = $a
            [string]$b = $b
        }
        'char' {
            [char]$a = $a
            [char]$b = $b
        }
    }

    switch ($Operand) {
        'eq' {
            if ($a -eq $b) {
                switch ($CastType) {
                    'int' {
                        Get-Timestamp
                        Add-Content -Path $env:LazyLogPath -Value "$time :: You compared ($a $operand $b) as $CastType and it returned $true."
                        Return $true
                    }
                    'string' {
                        Get-Timestamp
                        Add-Content -Path $env:LazyLogPath -Value "$time :: You compared ($a $operand $b) as $CastType and it returned $true."
                        Return $true
                    }
                    'char' {
                        Get-Timestamp
                        Add-Content -Path $env:LazyLogPath -Value "$time :: You compared ($a $operand $b) as $CastType and it returned $true."
                        Return $true
                    }
                    default {
                        Get-Timestamp
                        Add-Content -Path $env:LazyLogPath -Value "$time :: You compared ($a $operand $b) and it returned $true."
                        Return $true
                    }
                }
            } else {
                switch ($CastType) {
                    'int' {
                        Get-Timestamp
                        Add-Content -Path $env:LazyLogPath -Value "$time :: You compared ($a $operand $b) as $CastType and it returned $false."
                        Return $false
                    }
                    'string' {
                        Get-Timestamp
                        Add-Content -Path $env:LazyLogPath -Value "$time :: You compared ($a $operand $b) as $CastType and it returned $false."
                        Return $false
                    }
                    'char' {
                        Get-Timestamp
                        Add-Content -Path $env:LazyLogPath -Value "$time :: You compared ($a $operand $b) as $CastType and it returned $false."
                        Return $false
                    }
                    default {
                        Get-Timestamp
                        Add-Content -Path $env:LazyLogPath -Value "$time :: You compared ($a $operand $b) and it returned $false."
                        Return $false
                    }
                }
                
            }
        }
        'ne' {

        }
        'ge' {

        }
        'gt' {

        }
        'le' {

        }
        'lt' {
            
        }
    }
}