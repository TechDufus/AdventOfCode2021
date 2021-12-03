Param(
    $File = 'input.txt'
)
$Path = Resolve-Path $File
$Data = Get-Content $Path

[System.Collections.ArrayList]$gamma = @()
[System.Collections.ArrayList]$epsilon = @()

#Gamma loop
For ($i = 0; $i -lt $Data[0].length; $i++) {
    [System.Collections.ArrayList]$Collection = @()
    For ($j = 0; $j -lt $Data.count; $j++) {
        $null=$Collection.Add($Data[$j][$i])
    }
    $Groups = $Collection | Group-Object | Select-Object Name,@{n='Frequency';e={$_.Count}}

    [int]$ZeroCount = ($Groups | Where-Object Name -eq '0').Frequency
    [int]$OneCount  = ($Groups | Where-Object Name -eq '1').Frequency

    If ($ZeroCount -gt $OneCount) {
        Write-Host "Zero wins: 0:$ZeroCount, 1:$OneCount"
        $null=$gamma.Add('0')
        $null=$epsilon.Add('1')
    } Else {
        Write-Host "One wins: 0:$ZeroCount, 1:$OneCount"
        $null=$gamma.Add('1')
        $null=$epsilon.Add('0')
    }
}

$GammaBinary = ($Gamma -join "")
$EpsilonBinary = ($Epsilon -join "")
Write-Host "Winning Gamma Sequence: $GammaBinary"
Write-Host "Winning Epsilon Sequence: $EpsilonBinary"
$GammaDecimal = [convert]::ToInt64($GammaBinary,2)
$EpsilonDecimal = [convert]::ToInt64($EpsilonBinary,2)

Write-Host "Gamma: $GammaDecimal"
Write-Host "Epsilon: $EpsilonDecimal"

Write-Host "Answer: $($GammaDecimal * $EpsilonDecimal)"