$data = Get-Content (Join-Path $PSScriptRoot 'input.txt')

$x = 0
$y = 0

For ($i = 0; $i -lt $data.count; $i++) {
    $splitdata = $data[$i].split(' ')
    $action = [PSCustomObject]@{
        Direction = [System.String]$splitdata[0]
        Amount    = [int]$splitdata[1]
    }

    Switch($Action.Direction) {
        'forward' {
            $x = $x + $Action.Amount
        }
        'down' {
            $y = $y + $Action.Amount
        }
        'up' {
            $y = $y - $Action.Amount
        }
        DEFAULT {}
    }
}

Write-Host "X: $x"
Write-Host "Y: $y"
Write-Host "Answer: $($x * $y)"
