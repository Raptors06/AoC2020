<#
    .SYNOPSIS
        Take supplied input and solve for how many passwords meet their specified criteria for number of recurring characters

    .DESCRIPTION
        Must take supplied input of position of characters required, specific character, and supplied passwords, and
        determine the count of passwords that meet their criteria within each supplied input line.

    .PARAMETER SupplidInputs
        Mandatory parameter of numbers supplied via text format from AoC website at https://adventofcode.com/2020/day/2/input

    .EXAMPLE
        Get-UpdatedMatchingPasswords.ps1

    .EXAMPLE
        Get-UpdatedMatchingPasswords.ps1 -suppliedInputs fubar.txt

    .NOTES
        Author: Richard J. Breiten
        Version: 7.0-00001
        Created: 2020-12-12
        Modified:
#>

[CmdletBinding()]
param (
    #TODO: Implement iwr for programmatic pull of supplied files?
    [Parameter()]$suppliedInputs = "..\problem-1\input.txt"
)

begin {
    $startTimestamp = (Get-Date -Format HH:mm:ss.fff)
    $suppliedInputs = Get-Content $suppliedInputs
    $output = @()
}

process {
    foreach ( $suppliedInput in $suppliedInputs ) {
        $requirements, $reqletter, $password = $suppliedInput -split " "
        [int]$firstPos, [int]$secPos = $requirements -split "-"
        $reqletter = $reqletter -replace ":",""
        if ( $password -match $reqletter ) {
            if (( $password.ToCharArray()[$firstPos-1] -eq $reqletter ) -or ( $password.ToCharArray()[$secPos-1] -eq $reqletter )) {
                if (-not (( $password.ToCharArray()[$firstPos-1] -eq $reqletter ) -and ( $password.ToCharArray()[$secPos-1] -eq $reqletter ))) {
                    $output += $password
                }
            }
        }
    }
}

end {
    Write-Output $output.Count
    $endTimestamp = (Get-Date -Format HH:mm:ss.fff)
    "$(New-TimeSpan $startTimestamp $endTimestamp)"
}