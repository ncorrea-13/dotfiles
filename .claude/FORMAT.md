# FORMAT.md - convención de formato Markdown

Regla de formato para todo archivo `.md` de este proyecto (y de cualquier otro donde se copie este archivo). No es sobre contenido, es sobre cómo se ve el _source_ del `.md`.

## Regla principal

**Un párrafo = una sola línea de texto en el archivo fuente**, sin importar cuán larga quede. No usar saltos de línea manuales para simular un ancho de columna fijo (nada de "wrapping" a 80/100 caracteres a mano). Markdown ya hace su propio reflow visual al renderizar - los saltos de línea manuales dentro de un párrafo no aportan nada y solo ensucian los diffs de git (un cambio de una palabra reescribe 5 líneas en vez de 1).

Antes (mal):

```
Plan de desarrollo sugerido, ordenado por dependencias reales entre
módulos (no por número de módulo del documento de requisitos). La idea
es poder levantar el backend en capas y enchufar frontend a medida que
cada capa queda estable.
```

Después (bien):

```
Plan de desarrollo sugerido, ordenado por dependencias reales entre módulos (no por número de módulo del documento de requisitos). La idea es poder levantar el backend en capas y enchufar frontend a medida que cada capa queda estable.
```

## Qué NO se colapsa a una línea

- **Bloques de código** (entre ` ``` `): se dejan tal cual, línea por línea, sin tocar - ahí el salto de línea y los espacios de indentación son significativos (árboles de directorio, snippets, JSON, etc.).
- **Tablas**: cada fila de tabla (incluida la de separadores `|---|---|`) queda en su propia línea.
- **Ítems de lista** (`-`, `*`, `1.`, etc.): cada ítem es su propia línea. Si el ítem venía envuelto en varias líneas por wrapping manual, sus líneas de continuación se juntan en la línea del ítem - pero un ítem nunca se junta con el ítem siguiente ni con una sublista anidada.
- **Encabezados** (`#`, `##`, ...): siempre en su propia línea (ya lo están por definición).
- Líneas en blanco entre bloques (párrafo/lista/tabla/código): se mantienen tal cual, son las que separan la estructura del documento.

## Blockquotes

Un blockquote (`>`) es un párrafo como cualquier otro: sus líneas de continuación se colapsan en una sola línea, igual que un párrafo normal. La diferencia es que **cada línea de continuación trae su propio marcador `>` que hay que descartar** al unirla - si no se descarta, el marcador queda pegado en medio del texto ya unido, arruinando el blockquote. Antes (mal, dos líneas de origen):

```
> 🔎 Importante:
> Rust no tiene `null`, en su lugar usa `Option<T>`.
```

Después (bien, marcador único al inicio):

```
> 🔎 Importante: Rust no tiene `null`, en su lugar usa `Option<T>`.
```

Resultado incorrecto que produce un script que no contempla esta excepción (el marcador de la segunda línea queda suelto en medio del texto en vez de descartarse):

```
> 🔎 Importante: > Rust no tiene `null`, en su lugar usa `Option<T>`.
```

## Espaciado

Al unir líneas de un mismo párrafo o ítem, se usa un único espacio entre ellas (nunca se concatenan sin espacio, ni se dejan dobles espacios residuales de una line-break a mitad de palabra/frase).

## Codificación

UTF-8 sin BOM. Cuando se edite/regenere un `.md`, no agregar BOM aunque el editor lo ofrezca por defecto.

## Script para aplicarlo automáticamente

Implementa la regla de arriba: junta líneas de párrafo/ítem wrappeadas a mano en una sola línea, sin tocar bloques de código, tablas ni encabezados, y colapsa espacios dobles residuales. Elegí la versión según el sistema.

### PowerShell (`unwrap-md.ps1`)

````powershell
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
````

Uso: `.\unwrap-md.ps1 -Files archivo1.md, archivo2.md`

### Bash (`unwrap-md.sh`, usa `awk`)

````bash
#!/usr/bin/env bash
set -euo pipefail

unwrap_file() {
    local file="$1"
    local tmp
    tmp="$(mktemp)"

    awk '
        function collapse(s,    lead, rest) {
            match(s, /^[ \t]*/)
            lead = substr(s, RSTART, RLENGTH)
            rest = substr(s, RLENGTH + 1)
            gsub(/  +/, " ", rest)
            return lead rest
        }
        function flush() {
            if (have) { print collapse(buf); buf = ""; have = 0 }
        }
        BEGIN { incode = 0; have = 0; buf = "" }
        {
            line = $0
            if (line ~ /^[ \t]*```/) { flush(); print line; incode = !incode; next }
            if (incode) { print line; next }

            t = line
            gsub(/^[ \t]+|[ \t]+$/, "", t)
            if (t == "") { flush(); print line; next }

            if (line ~ /^#{1,6}[ \t]/) { flush(); print line; next }
            if (t ~ /^\|/) { flush(); print line; next }
            if (line ~ /^[ \t]*(-{3,}|\*{3,}|_{3,})[ \t]*$/) { flush(); print line; next }

            if (line ~ /^[ \t]*([-*+]|[0-9]+\.)[ \t]+/) {
                flush()
                sub(/[ \t]+$/, "", line)
                buf = line
                have = 1
                next
            }

            if (line ~ /^[ \t]*>[ \t]?/) {
                if (have && buf ~ /^[ \t]*>[ \t]?/) {
                    cont = line
                    sub(/^[ \t]*>[ \t]?/, "", cont)
                    gsub(/^[ \t]+|[ \t]+$/, "", cont)
                    buf = buf " " cont
                } else {
                    flush()
                    sub(/[ \t]+$/, "", line)
                    buf = line
                    have = 1
                }
                next
            }

            if (have) { buf = buf " " t } else { buf = t; have = 1 }
        }
        END { flush() }
    ' "$file" > "$tmp"

    mv "$tmp" "$file"
}

for f in "$@"; do
    unwrap_file "$f"
done
````

Uso: `chmod +x unwrap-md.sh && ./unwrap-md.sh archivo1.md archivo2.md`

Ambas versiones hacen exactamente lo mismo línea por línea (mismo criterio de qué es código/tabla/encabezado/ítem de lista/blockquote), así que dan resultados idénticos sobre el mismo archivo.

## Cómo aplicarlo con Claude Code

Pedile explícitamente "aplicá FORMAT.md" o "quitá el wrapping manual" y que corra el script de arriba (o procese los `.md` a mano si no hay shell disponible) respetando las excepciones de arriba (código, tablas, listas, encabezados, blockquotes). No es necesario tocar el contenido ni el significado de ningún documento - es una pasada puramente de formato.

Ya existe un script en ~/.claude/format.sh el cual realiza esto. Además ~/.claude/replace-emdash.sh reemplaza todos los guiones. Debe tenerse en cuenta también para el formato
