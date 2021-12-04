function GetMostCommonValues($data, $index, [switch]$LeastCommon) {
    [int]$zero = 0
    [int]$one = 0
    foreach ($row in $data) {
        foreach ($char in [char[]]$row) {
            [int][string]$row[$index] -eq 0 ? $zero++ : $one++ | Out-Null
        }
    }

    $KeepValue = $zero -gt $one ? '0' : '1'
    if ($leastCommon) { $keepValue = $keepValue -eq '0' ? '1' : '0' }

    $data.where{
        $PSItem[$index] -eq $KeepValue
    }
}

function GetOxygenRating {
    $filteredValues = Get-Content ./input.txt
    for ($i = 0; $i -lt $filteredValues[0].length; $i++) {
        $filteredValues = GetMostCommonValues -data $filteredValues -index $i
    }
    [Convert]::ToInt32((($filteredValues) -join ''), 2)
}

function GetCO2Rating {
    $filteredValues = Get-Content ./input.txt
    for ($i = 0; $i -lt $filteredValues[0].length; $i++) {
        $filteredValues = GetMostCommonValues -data $filteredValues -index $i -LeastCommon
    }
    [Convert]::ToInt32((($filteredValues) -join ''), 2)
}

$O = GetOxygenRating
$CO2 = GetCO2Rating

$O * $CO2