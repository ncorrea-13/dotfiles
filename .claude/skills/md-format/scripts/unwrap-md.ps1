param([Parameter(Mandatory = $true)][string[]]$Files)

function Unwrap-MarkdownFile {
    param([string]$Path)

    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    $lines = [System.IO.File]::ReadAllLines($Path, [System.Text.Encoding]::UTF8)

    $output = New-Object System.Collections.Generic.List[string]
    $inCode = $false
    $buffer = $null

    function Collapse($s) { $s -replace '(?<=\S) {2,}', ' ' }

    foreach ($line in $lines) {
        if ($line -match '^\s*```') {
            if ($null -ne $buffer) { $output.Add((Collapse $buffer)); $buffer = $null }
            $output.Add($line); $inCode = -not $inCode; continue
        }
        if ($inCode) { $output.Add($line); continue }
        if ($line.Trim() -eq '') {
            if ($null -ne $buffer) { $output.Add((Collapse $buffer)); $buffer = $null }
            $output.Add($line); continue
        }
        if ($line -match '^#{1,6}\s') {
            if ($null -ne $buffer) { $output.Add((Collapse $buffer)); $buffer = $null }
            $output.Add($line); continue
        }
        if ($line.TrimStart().StartsWith('|')) {
            if ($null -ne $buffer) { $output.Add((Collapse $buffer)); $buffer = $null }
            $output.Add($line); continue
        }
        if ($line -match '^\s*(-{3,}|\*{3,}|_{3,})\s*$') {
            if ($null -ne $buffer) { $output.Add((Collapse $buffer)); $buffer = $null }
            $output.Add($line); continue
        }
        if ($line -match '^\s*([-*+]|\d+\.)\s+') {
            if ($null -ne $buffer) { $output.Add((Collapse $buffer)) }
            $buffer = $line.TrimEnd(); continue
        }
        if ($line -match '^\s*>\s?') {
            $bufferIsQuote = ($null -ne $buffer) -and ($buffer -match '^\s*>\s?')
            if ($bufferIsQuote) {
                $cont = ($line -replace '^\s*>\s?', '').Trim()
                $buffer = $buffer.TrimEnd() + ' ' + $cont
            }
            else {
                if ($null -ne $buffer) { $output.Add((Collapse $buffer)) }
                $buffer = $line.TrimEnd()
            }
            continue
        }
        if ($null -ne $buffer) { $buffer = $buffer.TrimEnd() + ' ' + $line.Trim() }
        else { $buffer = $line.TrimEnd() }
    }
    if ($null -ne $buffer) { $output.Add((Collapse $buffer)) }

    [System.IO.File]::WriteAllLines($Path, $output, $utf8NoBom)
}

foreach ($f in $Files) { Unwrap-MarkdownFile -Path $f }
