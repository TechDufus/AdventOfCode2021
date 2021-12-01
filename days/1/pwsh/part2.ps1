$data = Get-Content (Join-Path $PSScriptRoot 'input.txt')

# Loop through numbers and count how many times the number increases
$Count = 0
For ($i = 1; $i -lt $data.count; $i++) {
    $current = ($data[$i..($i + 2)] | Measure-Object -Sum).Sum
    $previous = ($data[($i - 1)..($i + 1)] | Measure-Object -Sum).Sum
    if ($current -gt $previous) {
        $Count++
    }
}

Write-Host "Increases: $Count"