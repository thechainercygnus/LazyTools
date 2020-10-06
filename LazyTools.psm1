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

function Write-LogMessage {
    param(
        [Parameter(Mandatory=$true,Position=0)] [string]$Message
    )
    Get-Timestamp
    $Message = "$time :: $Message"
    Add-Content -Path $env:LazyLogPath -Value $Message
}

function Test-IPNetworking {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$false,Position=0)] [String]$ip = "1.1.1.1" # Default
    )
    $ConnectionTest = Test-Connection $ip -Quiet
    Write-LogMessage "$time :: Connection Test to $ip returned $ConnectionTest"
    Return $ConnectionTest
}

function Test-DNSLookup {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$false,Position=0)] [String]$address = "durish.xyz" # Default
    )
    $ConnectionTest = Test-Connection $address -Quiet
    Write-LogMessage "$time :: Connection Test to $address returned $ConnectionTest"
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
    foreach ($plan in $PowerPlans) {
        Write-LogMessage "$plan"
    }
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
    $trueResultCast = "You compared ($a $operand $b) as $CastType and it returned $true."
    $trueResultNoCast = "You compared ($a $operand $b) and it returned $true."
    $falseResultCast = "You compared ($a $operand $b) as $CastType and it returned $false."
    $falseResultNoCast = "You compared ($a $operand $b) and it returned $false."

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
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $trueResultCast
                        Return $true
                    }
                    default {
                        Write-LogMessage $trueResultNoCast
                        Return $true
                    }
                }
            } else {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $falseResultCast
                    }
                    default {
                        Write-LogMessage $falseResultNoCast
                        Return $false
                    }
                }
                
            }
        }
        'ne' {
            if ($a -ne $b) {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $trueResultCast
                        Return $true
                    }
                    default {
                        Write-LogMessage $trueResultNoCast
                        Return $true
                    }
                }
            } else {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $falseResultCast
                    }
                    default {
                        Write-LogMessage $falseResultNoCast
                        Return $false
                    }
                }
                
            }
        }
        'ge' {
            if ($a -ge $b) {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $trueResultCast
                        Return $true
                    }
                    default {
                        Write-LogMessage $trueResultNoCast
                        Return $true
                    }
                }
            } else {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $falseResultCast
                    }
                    default {
                        Write-LogMessage $falseResultNoCast
                        Return $false
                    }
                }
                
            }
        }
        'gt' {
            if ($a -gt $b) {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $trueResultCast
                        Return $true
                    }
                    default {
                        Write-LogMessage $trueResultNoCast
                        Return $true
                    }
                }
            } else {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $falseResultCast
                    }
                    default {
                        Write-LogMessage $falseResultNoCast
                        Return $false
                    }
                }
                
            }
        }
        'le' {
            if ($a -le $b) {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $trueResultCast
                        Return $true
                    }
                    default {
                        Write-LogMessage $trueResultNoCast
                        Return $true
                    }
                }
            } else {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $falseResultCast
                    }
                    default {
                        Write-LogMessage $falseResultNoCast
                        Return $false
                    }
                }
                
            }
        }
        'lt' {
            if ($a -lt $b) {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $trueResultCast
                        Return $true
                    }
                    default {
                        Write-LogMessage $trueResultNoCast
                        Return $true
                    }
                }
            } else {
                switch ($CastType) {
                    { 'int', 'string', 'char' -contains $_} {
                        Write-LogMessage $falseResultCast
                    }
                    default {
                        Write-LogMessage $falseResultNoCast
                        Return $false
                    }
                }
                
            }
        }
    }
}