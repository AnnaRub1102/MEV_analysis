#!/usr/bin/env python3
"""Summarize Nyx results into a single JSON: {ContractName: [[func1, func2], ...]}.

Each contract has a .log file. If there's no corresponding .json file
(execution failed before producing results), the contract is reported as "error".
"""
import json
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
RESULT_DIRS = [BASE_DIR / "results" / "nyx" / "fixes", BASE_DIR / "results" / "nyx" / "vulnerables"]
OUTPUT_FILE = BASE_DIR / "results" / "nyx" / "summary.json"

ERROR = "error"


def extract_function_name(signature: str) -> str:
    """Extract the bare function name from 'Contract.func(argTypes)'."""
    return signature.split("(")[0].rsplit(".", 1)[-1]


def pair_matches(name1: str, name2: str, nyx_pairs: list) -> bool:
    """Check if (name1, name2) matches a pair in nyx_pairs, order-independent."""
    target = {name1, name2}
    for pair in nyx_pairs:
        pair_names = {extract_function_name(f) for f in pair}
        if pair_names == target:
            return True
    return False


def summarize() -> dict:
    summary = {}
    for result_dir in RESULT_DIRS:
        for log_file in sorted(result_dir.glob("*.log")):
            contract_name = log_file.stem
            json_file = log_file.with_suffix(".json")

            if not json_file.exists():
                summary[contract_name] = ERROR
                continue

            with open(json_file) as f:
                data = json.load(f)

            summary[contract_name] = {
                tuple(extract_function_name(f) for f in pair) for pair in data.get("result", [])
            }

    return summary


def main():
    summary = summarize()
    # JSON has no set/tuple type, so pairs are written out as plain lists (strings pass through).
    serializable = {
        name: [list(pair) for pair in pairs] if isinstance(pairs, set) else pairs
        for name, pairs in summary.items()
    }
    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    with open(OUTPUT_FILE, "w") as f:
        json.dump(serializable, f, indent=2)
    print(f"Wrote summary for {len(summary)} contracts to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
