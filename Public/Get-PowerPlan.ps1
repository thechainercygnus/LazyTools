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
        Write-LogMessage "Found Power Plan [$planName] with GUID [$planGUID]"
    }
    Return $PowerPlans
}