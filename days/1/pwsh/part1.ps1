$data = Get-Content (Join-Path $PSScriptRoot 'input.txt')

# Loop through numbers and count how many times the number increases
$Count = 0
For ($i = 1; $i -lt $data.count; $i++) {
    [int]$current = $data[$i]
    [int]$previous = $data[$i - 1]
    if ($current -gt $previous) {
        $Count++
    }
}

Write-Host "Increases: $Count"