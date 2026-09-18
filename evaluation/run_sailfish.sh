#!/bin/bash
# Runs Sailfish's contractlint.py against both categories of the
# daval_dataset:
#   <DATASET_DIR>/fixes/*.sol
#   <DATASET_DIR>/vulnerables/*.sol
#
# contractlint.py analyzes one .sol file at a time. Its exact
# location inside the prebuilt image isn't guaranteed, so it's
# located at runtime via `find` unless SAILFISH_ANALYSIS_DIR is set
# explicitly (skips the search).
#
# Since the symbolic engine can run for a very long time on some
# contracts, each run is capped by TIMEOUT_SECONDS (default: 600 =
# 10 minutes). Timed-out contracts are logged and skipped rather than
# blocking the rest of the dataset.

set -uo pipefail

DATASET_DIR="${1:-/dataset}"
RESULTS_DIR="${RESULTS_DIR:-/results}"
TIMEOUT_SECONDS="${TIMEOUT_SECONDS:-600}"
CATEGORIES=("fixes" "vulnerables")

if [ ! -d "${DATASET_DIR}" ]; then
  echo "Dataset directory ${DATASET_DIR} not found." >&2
  exit 1
fi

analysis_dir="${SAILFISH_ANALYSIS_DIR:-}"
if [ -z "${analysis_dir}" ]; then
  echo "Locating contractlint.py..."
  analysis_dir="$(dirname "$(find / -xdev -name 'contractlint.py' 2>/dev/null | head -n1)")"
fi
if [ -z "${analysis_dir}" ] || [ ! -d "${analysis_dir}" ]; then
  echo "Could not locate contractlint.py anywhere on the filesystem." >&2
  echo "Inspect the image manually, e.g.:" >&2
  echo "  docker run --rm -it --entrypoint bash <image> -c 'find / -iname contractlint.py'" >&2
  echo "then set SAILFISH_ANALYSIS_DIR to the containing directory." >&2
  exit 1
fi
echo "Using Sailfish analysis dir: ${analysis_dir}"

for category in "${CATEGORIES[@]}"; do
  category_dir="${DATASET_DIR}/${category}"
  if [ ! -d "${category_dir}" ]; then
    echo "Skipping missing category directory: ${category_dir}" >&2
    continue
  fi

  echo " Sailfish: ${category}"
  mkdir -p "${RESULTS_DIR}/${category}"
  cd "${analysis_dir}" || exit 1

  for contract in "${category_dir}"/*.sol; do
    [ -e "${contract}" ] || continue
    name="$(basename "${contract}" .sol)"
    echo "--- Sailfish: ${category}/${name} (timeout: ${TIMEOUT_SECONDS}s) ---"
    mkdir -p "${RESULTS_DIR}/${category}/${name}"
    timeout "${TIMEOUT_SECONDS}s" python contractlint.py \
      -c "${contract}" \
      -o "${RESULTS_DIR}/${category}/${name}" \
      -r range -p DAO,TOD -oo -sv cvc4
    status=$?
    if [ "${status}" -eq 124 ]; then
      echo "Sailfish TIMED OUT on ${category}/${name} after ${TIMEOUT_SECONDS}s, continuing..." | tee -a "${RESULTS_DIR}/timeouts.log"
    elif [ "${status}" -ne 0 ]; then
      echo "Sailfish failed on ${category}/${name} (exit ${status}), continuing..."
    fi
  done
done

echo " Done. Sailfish results written to ${RESULTS_DIR}"