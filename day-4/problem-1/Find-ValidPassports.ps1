<#
    .SYNOPSIS
        Given an input text file of paths down a hill, find the number of trees on the route

    .DESCRIPTION
        Given an input text file of paths, determine the number of trees on the route down the hill, assuming a path downhill
        of 3 moves right for every line moved down.

    .PARAMETER SuppliedMap
        Mandatory parameter of "map" supplied via text format from AoC website at https://adventofcode.com/2020/day/3/input

    .EXAMPLE
        Find-ValidPassports.ps1

    .EXAMPLE
        Find-ValidPassports.ps1 -suppliedPassports fubar.txt

    .NOTES
        Author: Richard J. Breiten
        Version: 7.0-00001
        Created: 2020-12-12
        Modified:
#>

[CmdletBinding()]
param (
    #TODO: Implement iwr for programmatic pull of supplied files?
    [Parameter()]$suppliedPassports = ".\passports.txt"
)

begin {
    $startTimestamp = (Get-Date -Format HH:mm:ss.fff)
    $suppliedPassports = Get-Content -Path $suppliedPassports -Raw
    $requiredParameters = @(
        'byr'
        'iyr'
        'eyr'
        'hgt'
        'ecl'
        'pid'
        'cid'
    )
    $validPassport = 0
}

process { 
    foreach ( $passport in $suppliedPassports ) {
        $passport = $passport.Replace("`n`n", ";").Replace("`n"," ")
        $passport.split( ";" ) | ForEach-Object {
            $transientData = @{}
            $_.Split( " " ) | ForEach-Object {
                $data = $_.Split( ":" )
                $transientData.Add( $data[0],$data[1] )
            }
            return $transientData
        }
    
        $missingParameters = @($requiredParameters.Where( {$transientData.Keys -notcontains $_ } ))
        if ($missingParameters.Count -eq 0) {
            $validPassport += 1
        } elseif ($missingParameters.Count -eq 1 -and $missingParameters -eq 'cid') {
            $validPassport += 1
        }
    }
}

end {
    Write-Output $validPassport
    $endTimestamp = (Get-Date -Format HH:mm:ss.fff)
    "$(New-TimeSpan $startTimestamp $endTimestamp)"
}