#!/usr/bin/env bash
set -euo pipefail
grep -rlZ --exclude-dir=.git -- '-' . | xargs -0 sed -i 's/-/-/g'
