#!/usr/bin/env python3
"""Summarize Sailfish results into a single JSON: {ContractName: [[func1, func2], ...]}.

Each contract folder is one of:
- only contains contractlint.log -> execution error
- contains dependency_info.json + tod_path_info.json, tod_path_info.json empty -> not detected
- otherwise -> TOD pairs extracted from dependency_info.json's "composed_functions"
"""
import json
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
RESULT_DIRS = [BASE_DIR / "results" / "sailfish" / "fixes", BASE_DIR / "results" / "sailfish" / "vulnerables"]
OUTPUT_FILE = BASE_DIR / "results" / "sailfish" / "summary.json"

ERROR = "error"
NOT_DETECTED = "not_detected"


def summarize() -> dict:
    summary = {}
    for result_dir in RESULT_DIRS:
        for contract_dir in sorted(p for p in result_dir.iterdir() if p.is_dir()):
            contract_name = contract_dir.name
            nested_dir = contract_dir / contract_name
            files = {f.name for f in nested_dir.iterdir()}

            if files == {"contractlint.log"}:
                summary[contract_name] = ERROR
                continue

            if "dependency_info.json" not in files or "tod_path_info.json" not in files:
                summary[contract_name] = ERROR
                continue

            with open(nested_dir / "tod_path_info.json") as f:
                tod_path_info = json.load(f)

            if not tod_path_info:
                summary[contract_name] = NOT_DETECTED
                continue

            with open(nested_dir / "dependency_info.json") as f:
                dependency_info = json.load(f)

            pairs = set()
            for entries in dependency_info.values():
                for entry in entries:
                    if entry.get("attack_type") == "TOD":
                        composed = entry.get("composed_functions")
                        if composed and len(composed) == 2:
                            pairs.add(tuple(composed))
            summary[contract_name] = pairs if pairs else NOT_DETECTED

    return summary


def main():
    summary = summarize()
    # JSON has no set/tuple type, so pairs are written out as plain lists.
    serializable = {
        name: sorted(list(pair) for pair in pairs) if isinstance(pairs, set) else pairs
        for name, pairs in summary.items()
    }
    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    with open(OUTPUT_FILE, "w") as f:
        json.dump(serializable, f, indent=2)
    print(f"Wrote summary for {len(summary)} contracts to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
