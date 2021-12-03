Param(
    $File = 'input.txt'
)
$Path = Resolve-Path $File
$Data = Get-Content $Path

[System.Collections.ArrayList]$O2 = @()
[System.Collections.ArrayList]$CO2 = @()

#O2 loop
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
        $null=$O2.Add('0')
        $null=$CO2.Add('1')
    } Else {
        Write-Host "One wins: 0:$ZeroCount, 1:$OneCount"
        $null=$O2.Add('1')
        $null=$CO2.Add('0')
    }
}

$O2Binary = ($O2 -join "")
$CO2Binary = ($CO2 -join "")
Write-Host "Winning O2 Sequence: $O2Binary"
Write-Host "Winning CO2 Sequence: $CO2Binary"

[System.Collections.ArrayList]$O2KeepMe = $Data
For ($i = 0; $i -lt $Data[0].length; $i++) {
    If ($O2KeepMe.Count -le 1) {
        break
    } Else {
        For ($j = 0; $j -lt $Data.count; $j++) {
            If ($Data[$j][$i] -ne $O2[$i]) {
                $null=$O2KeepMe.Remove($Data[$j])
            }
        }
    }
}
[System.Collections.ArrayList]$CO2KeepMe = $Data
For ($i = 0; $i -lt $Data[0].length; $i++) {
    If ($CO2KeepMe.Count -le 1) {
        break
    } Else {
        For ($j = 0; $j -lt $Data.count; $j++) {
            If ($Data[$j][$i] -ne $CO2[$i]) {
                $null=$CO2KeepMe.Remove($Data[$j])
            }
        }
    }
}

$O2Keepme
$CO2KeepMe


$O2Decimal = [convert]::ToInt64($O2Keepme,2)
$CO2Decimal = [convert]::ToInt64($CO2KeepMe,2)


Write-Host "Answer: $($O2Decimal * $CO2Decimal)"