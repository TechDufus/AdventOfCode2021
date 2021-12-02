$data = Get-Content (Join-Path $PSScriptRoot 'input.txt')

$x = 0 # forward
$y = 0 # aim
$z = 0 # depth (up, down)

For ($i = 0; $i -lt $data.count; $i++) {
    $splitdata = $data[$i].split(' ')
    $action = [PSCustomObject]@{
        Direction = [System.String]$splitdata[0]
        Amount    = [int]$splitdata[1]
    }

    Switch($Action.Direction) {
        'forward' {
            $x = $x + $Action.Amount
            $z = $z + ($y * $Action.Amount)
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
Write-Host "Z: $z"
Write-Host "Answer: $($x * $z)"
