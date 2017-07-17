#!/usr/bin/env bash
# 
# Install script for Webutil packaged utility from packaged-utilities.
# 

# ======= CONFIGURATIONS ==============

# Directory where files will be downloaded.
readonly DOWNLOAD_DIR="${HOME}"

# ======= ! CONFIGURATIONS ==============

readonly MASTER_URL='https://raw.githubusercontent.com/linux-shell-base/packaged-utilities/master'
readonly BASE_URL="${MASTER_URL}/webutil"
readonly BASE_DIR="${DOWNLOAD_DIR}/packaged-utilities/webutil"

echo -e "::Downloading files to ${BASE_DIR}\n  Please wait"

if [ ! -d "${DOWNLOAD_DIR}/packaged-utilities" ]; then
  mkdir -p "${DOWNLOAD_DIR}/packaged-utilities"
fi

[ -d "${BASE_DIR}" ] && rm -Rf "${BASE_DIR}"
mkdir "${BASE_DIR}"
cd "${BASE_DIR}"

exec 3>&1 4>&2; exec >/dev/null 2>&1 # redirect all output to /dev/null

# ============================================
#   Download files from webutil/
# ============================================

wget -i - <<EOF
  ${BASE_URL}/url-aliases
  ${BASE_URL}/url-aliases-file-parser.pl
  ${BASE_URL}/webutil
EOF
chmod +x url-aliases-file-parser.pl webutil

# ============================================
#   Download files from _global/
# ============================================

wget "${MASTER_URL}/_global/url-search-placeholder-parser.pl"
chmod +x url-search-placeholder-parser.pl


exec >&3 2>&4 # redirect all output back to /dev/tty
echo '::Finished'

