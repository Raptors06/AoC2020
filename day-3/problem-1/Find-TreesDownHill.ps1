<#
    .SYNOPSIS
        Given an input text file of paths down a hill, find the number of trees on the route

    .DESCRIPTION
        Given an input text file of paths, determine the number of trees on the route down the hill, assuming a path downhill
        of 3 moves right for every line moved down.

    .PARAMETER SuppliedMap
        Mandatory parameter of "map" supplied via text format from AoC website at https://adventofcode.com/2020/day/3/input

    .EXAMPLE
        Find-TreesDownHill.ps1

    .EXAMPLE
        Find-TreesDownHill.ps1 -suppliedMap fubar.txt

    .NOTES
        Author: Richard J. Breiten
        Version: 7.0-00001
        Created: 2020-12-12
        Modified:
#>

[CmdletBinding()]
param (
    #TODO: Implement iwr for programmatic pull of supplied files?
    [Parameter()]$suppliedMap = ".\input.txt",

    [Parameter()][int]$MovementRight = "3",

    [Parameter()][int]$MovementDown = "1"
)

begin {
    $startTimestamp = (Get-Date -Format HH:mm:ss.fff)
    $suppliedMap = Get-Content $suppliedMap
    $xPosition = 0
    $yPosition = 0
    $TreesinPath = 0
}

process {
    for (( $xPosition ),( $yPosition ),( $TreesinPath ); ( $yPosition -lt ( $suppliedMap ).Count ); ( $xPosition += $MovementRight ), ( $yPosition += $MovementDown ) ) {
        if ( $xPosition -ge $suppliedMap[$yPosition].Length ) {
            $xPosition -= $suppliedMap[$yPosition].Length
        }

        $TreesinPath += $suppliedMap[$yPosition][$xPosition] -eq '#'
    }
}

end {
    Write-Output $TreesinPath
    $endTimestamp = (Get-Date -Format HH:mm:ss.fff)
    "$(New-TimeSpan $startTimestamp $endTimestamp)"
}