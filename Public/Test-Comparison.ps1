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
    Test-Comparison 1 1
    Will return $true

    .EXAMPLE
    Test-Comparison 1 2
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