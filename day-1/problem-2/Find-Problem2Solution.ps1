<#
    .SYNOPSIS
        Take supplied input and solve for product where two numbers added together equal 2020

    .DESCRIPTION
        Must take supplied input of numbers and, when two numbers added together equal 2020, supply the product
        of those same two numbers. Also outputs the runtime efficiency of the algorithm.

    .PARAMETER SuppliedNumbers
        Mandatory parameter of numbers supplied via text format from AoC website at https://adventofcode.com/2020/day/1/input

    .EXAMPLE
        Find-Problem2Solution.ps1 -suppliedNumbers suppliedNumbers.txt
    
    .NOTES
        Author: Richard J. Breiten
        Version: 7.0-00001
        Created: 2020-12-06
        Modified: 
#>

[CmdletBinding()]
param (
    #TODO: Implement iwr for programmatic pull of supplied files?
    [Parameter()]$suppliedNumbers = "..\problem-1\suppliedNumbers.txt"
)

begin {
    $startTimestamp = (Get-Date -Format HH:mm:ss.fff)
    $suppliedNumbers = Get-Content $suppliedNumbers | Sort-Object
}

process {
    foreach ($firstNumber in $suppliedNumbers) {
        foreach ($secondNumber in $suppliedNumbers) {
            foreach ($thirdNumber in $suppliedNumbers) {
                if ($thirdNumber -ne $firstNumber -and $secondNumber) {
                    $summation = [int]$thirdNumber + [int]$secondNumber + [int]$firstNumber
                    if ($summation -eq "2020") {
                        $solution = [int]$thirdNumber * [int]$secondNumber * [int]$firstNumber
                        Write-Output "solution: $solution"
                        return
                    }    
                }
            }
        }
    }
}

end {
    $endTimestamp = (Get-Date -Format HH:mm:ss.fff)
    "$(New-TimeSpan $startTimestamp $endTimestamp)"
}