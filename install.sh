#!/usr/bin/env bash

set -euo pipefail

CURL="curl --show-error --silent --location"

echo "downloading bash_unit"
current_working_dir=$PWD
tarball_urls=$($CURL https://api.github.com/repos/ndavies-om1/bash_unit/releases | grep tarball_url)
tarball_url=$(echo "$tarball_urls" | head -n 1 | cut -d '"' -f 4)
tmp_dir=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmpdir')
cd "$tmp_dir" || exit
$CURL "$tarball_url" | tar -xz -f -
find "${tmp_dir}" -maxdepth 2 -type f -name "bash_unit" -exec cp {} "${current_working_dir}" \;
rm -rf "$tmp_dir"
echo "thank you for downloading bash_unit, you can now run ./bash_unit"
