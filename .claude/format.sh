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
