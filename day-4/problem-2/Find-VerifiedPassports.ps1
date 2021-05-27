<#
    .SYNOPSIS
        Given an input file of possible passport values, determine the number of passports where all required fields are both
        present and valid according to specific rules.

    .DESCRIPTION
        Given an input file of possible passport values, determine the number of passports where all require fields are both
        present and valid according to the following rules:

            * `byr` (Birth Year) - four digits; at least `1920` and at most `2002`.
            * `iyr` (Issue Year) - four digits; at least `2010` and at most `2020`.
            * `eyr` (Expiration Year) - four digits; at least `2020` and at most `2030`.
            * `hgt` (Height) - a number followed by either `cm` or `in`:
                * If `cm`, the number must be at least `150` and at most `193`.
                * If `in`, the number must be at least `59` and at most `76`.
            * `hcl` (Hair color) - a `#` followed by exactly six characters `0`-`9` or `a`-`f`
            * `ecl` (Eye color) - exactly one of: `amb` or `blu` or `brn` or `gry` or `grn` or `hzl` or `oth`.
            * `pid` (Passport ID) - a nine-digit number, includig leading zeroes
            * `cid` (Country ID) - ignore, missing or not

    .PARAMETER SuppliedPassports
        Mandatory parameter of passports supplied via text format from AoC website at https://adventofcode.com/2020/day/4/input

    .EXAMPLE
        Find-VerifiedPassports.ps1

    .EXAMPLE
        Find-ValidPassports.ps1 -suppliedPassports fubar.txt

    .NOTES
        Author: Richard J. Breiten
        Version: 7.0-00001
        Created: 2021-05-26
        Modified:
#>

[CmdletBinding()]
param (
    #TODO: Implement iwr for programmatic pull of supplied files?
    [Parameter()]$suppliedPassports = "..\passports.txt"
)

begin {
    $startTimestamp = (Get-Date -Format HH:mm:ss.fff)
    $suppliedPassports = (Get-Content -Path $suppliedPassports -Raw) -split '(\r?\n){2}' | Where-Object { $_.Trim() }
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
        $passport = $passport -split ' ' -replace ':', '=' | Out-String | Convertfrom-StringData #.Replace("`n`n", ";").Replace("`n"," ")
        # $passport.split( "=" ) | ForEach-Object {
        #     $transientData = @{}
        #     $_.Split( " " ) | ForEach-Object {
        #         $data = $_.Split( ":" )
        #         $transientData.Add( $data[0],$data[1] )
        #     }
        #     $transientData | Out-Null
        # }
    
        $missingParameters = @($requiredParameters.Where( {$passport.Keys -notcontains $_ } ))
        if ($missingParameters.Count -eq 0) {
            $validPassport += 1
        } elseif (($missingParameters.Count -eq 1) -and ($passport.ContainsKey('cid'))) {
            $validPassport += 1
        }
    }
}

end {
    Write-Output "Number of valid passports: $validPassport"
    $endTimestamp = (Get-Date -Format HH:mm:ss.fff)
    "$(New-TimeSpan $startTimestamp $endTimestamp)"
}