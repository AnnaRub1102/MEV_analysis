#!/bin/bash
# Runs Nyx against both categories of the Nyx dataset:
#   <DATASET_DIR>/fixes/<contract>/      (config.json, metadata.json, src/*.sol)
#   <DATASET_DIR>/vulnerables/<contract>/
#
# Each subfolder is already a Nyx project directory, so it's passed
# to Nyx as-is — one run per contract.
#
# Every run's stdout/stderr is captured to a per-contract .log file,
# regardless of success or failure, so failures (e.g. solc version
# mismatches, compilation errors) are recorded instead of just
# scrolling past in the container log.
#
# Results:
#   /results/fixes/<contract>.json   (on success)
#   /results/fixes/<contract>.log    (always — stdout/stderr of the run)
#   /results/vulnerables/<contract>.json
#   /results/vulnerables/<contract>.log
#   /results/errors.log              (one line per failed contract)

set -uo pipefail

DATASET_DIR="${1:-/dataset}"
RESULTS_DIR="${RESULTS_DIR:-/results}"
CATEGORIES=("fixes" "vulnerables")

if [ ! -d "${DATASET_DIR}" ]; then
  echo "Dataset directory ${DATASET_DIR} not found." >&2
  exit 1
fi

run_nyx_category() {
  local category_dir="$1"
  local category="$2"
  echo " Nyx: ${category}"
  mkdir -p "${RESULTS_DIR}/${category}"

  for project in "${category_dir}"/*/; do
    [ -d "${project}" ] || continue
    name="$(basename "${project}")"
    echo "--- Nyx: ${category}/${name} ---"
    log_file="${RESULTS_DIR}/${category}/${name}.log"
    (
      cd /nyx || exit 1
      python3 nyx/main.py "${project}"
    ) > "${log_file}" 2>&1
    status=$?

    if [ "${status}" -eq 0 ] && [ -f /nyx/result.json ]; then
      mv /nyx/result.json "${RESULTS_DIR}/${category}/${name}.json"
    else
      echo "Nyx failed on ${category}/${name} (exit ${status}), see ${name}.log"
      echo "FAILED exit=${status} project=${category}/${name}" >> "${RESULTS_DIR}/errors.log"
    fi
  done
}

for category in "${CATEGORIES[@]}"; do
  category_dir="${DATASET_DIR}/${category}"
  if [ ! -d "${category_dir}" ]; then
    echo "Skipping missing category directory: ${category_dir}" >&2
    continue
  fi
  run_nyx_category "${category_dir}" "${category}"
done

echo " Nyx results written to ${RESULTS_DIR}"