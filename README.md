# MEV_analysis

Artifact for **"On Identifying Sound Conditions for Frontrunning Resistance"**, ACM CCS 2026.

This repository provides the State-of-the-art Evaluation (SOTA-Eval) for the Static and Dynamic Frontrunning Analysis.

---

## Scope

| Paper artifact | Where |
| --- | --- |
| [Audits & Frontrunning Vulnerabilities](#audits--frontrunning-vulnerabilities) | `audits_dataset/`  |
| [Smart Contracts Dataset](#smart-contracts-dataset) | `contracts_dataset/` |
| [Dynamic Frontrunning analysis: MEV](#dynamic-frontrunning-analysis) | `evaluation/analysis.ipynb`, `evaluation/mev_examples.md` |
| [Static Frontrunning analysis: Sailfish & Nyx](#static-frontrunning-analysis) | `evaluation/docker-compose.yml`, `evaluation/analysis.ipynb` |

---

## Audits & Frontrunning Vulnerabilities

We report under the folder [audits_dataset/](./audits_dataset/) the list of publicly available audits we collected from the following audit companies:
  - ConsensysDiligence
  - Trail of Bits
  - RuntimeVerification
  - Nethermind
  - HashEx
  - OpenZeppelin
  - Hacken
  - QuantStamp

For each company, we collected the number of audits reported under the "Public" column and filtered them for frontrunning audits.
We assembled a total collection of 287 smart contract audits with frontrunning issues.

| Audit Company | Frontrunning | Public | Link | Commit | Format |
|---|---|---|---|---|---|
| ConsensysDiligence  | 49 | 133 | [Webpage](https://consensys.io/diligence/audits/) | - | HTML,MD |
| Trail of Bits | 56 | 223 | [GitHub](https://github.com/trailofbits/publications) | ff1a0f64 | PDF |
| RuntimeVerification | 15 | 60 | [GitHub](https://github.com/runtimeverification/publications/tree/main/reports/smart-contracts) | e6b3162e | PDF |
| Nethermind | 9 | 40 | [GitHub](https://github.com/NethermindEth/PublicAuditReports) | e826295c | PDF |
| HashEx | 32 | 158 | [GitHub](https://github.com/HashEx/public_audits) | 4e72943f | PDF | 
| OpenZeppelin | 45 | 189 | [Blog](https://blog.openzeppelin.com/tag/security-audits/) | - | HTML |
| Hacken | 27 | 648 | [Webpage](https://hacken.io/audits/) | - | PDF |
| QuantStamp | 54 | 221 | [Webpage](https://certificate.quantstamp.com/) | - | HTML,PDF |

*Note:* the audit inclusion deadline is 2023-12-24, so some of the links may no longer be available.

We report the complete list of audits and the corresponding frontrunning vulnerabilities identified in each of them in the file [audit_dataset.xlsx](./evaluation/audit_dataset.xlsx). For further details, please refer to [audits.md](./evaluation/audits.md).

---

## Smart Contracts Dataset

From the full dataset of 393 vulnerabilities (D_full), we additionally curated a dataset of smart contracts for which the complete source code was available and the corresponding fix had been applied.

In total, we collected two datasets of 24 contracts each: the vulnerable dataset (D_aval) and the fixes dataset (D_fixes).

The contract dataset list is reported in [contracts_dataset.xlsx](./evaluation/contracts_dataset.xlsx). For further details, please refer to [contracts.md](./evaluation/contracts.md).

To replicate Table 1 in the paper, which reports the number of identified vulnerabilities and the contracts, we provide the corresponding script in the Jupyter notebook [analysis.ipynb](./evaluation/analysis.ipynb).

### Running the analysis notebook

**Requirements:**
  - Python 3.9+
  - [Jupyter](https://jupyter.org/) (or the VS Code Jupyter extension)
  - Python packages listed in `evaluation/requirements.txt`: `pandas`, `openpyxl`, `jupyter`, `ipykernel`

*Note*: The notebook can also be executed on [Google Colab](https://colab.research.google.com/). If you'd prefer not to install the requirements locally, simply upload this repository there. Instructions are provided in [Google Colab usage](#google-colab-usage).

**Install the dependencies:**

```bash
pip install -r evaluation/requirements.txt
```

Then open [analysis.ipynb](./evaluation/analysis.ipynb) in Jupyter or in VS Code with the Jupyter extension (select the Python environment where the requirements above are installed as the kernel), and run the cells under the **'Audits and Smart Contracts'** section to replicate Table 1.

---

## Dynamic Frontrunning Analysis

To validate the MEV dynamic analysis reported in Section 2.2.3 of the paper, run the **'MEV analysis'** cell in the [analysis.ipynb](./evaluation/analysis.ipynb) notebook, which checks all the MEV results reported in [audit_dataset.xlsx](./evaluation/audit_dataset.xlsx).

We report in [mev_examples.md](./evaluation/mev_examples.md) examples showing how we applied the definition of MEV, including a case for each of the limitations we identify in the paper: (1) MEV cannot capture eventual attacks, and (2) MEV cannot capture non-monetary attacks.

---

## Static Frontrunning Analysis

To replicate the analysis reported in Section 2.2.3 of the paper, we automatically ran the state-of-the-art Nyx and Sailfish tools on the same set of smart contracts (vulnerable and fixed) used throughout the artifact. The tools' source code is fetched directly from their repositories, as indicated in the original papers:

  - **Nyx**: [repo](https://github.com/Troublor/Nyx), [paper](https://ieeexplore.ieee.org/document/10646603)
  - **Sailfish**: [repo](https://github.com/ucsb-seclab/sailfish), [paper](https://www.computer.org/csdl/proceedings-article/sp/2022/131600b235/1FlQxXGwjtK)

In what follows, we provide instructions on how to use the tools with our dataset in a Docker container.

### Dataset
  - The dataset for Nyx is under the folder [contracts_dataset/dataset_nyx/](contracts_dataset/dataset_nyx) (both [fixes/](contracts_dataset/dataset_nyx/fixes) and [vulnerables/](contracts_dataset/dataset_nyx/vulnerables)), already structured in the format Nyx expects: one folder per contract, containing a `src/` folder with the contract source, plus `metadata.json` and `config.json`.

  - The dataset for Sailfish is under [contracts_dataset/dataset_sailfish/fixes](contracts_dataset/dataset_sailfish/fixes/) and [contracts_dataset/dataset_sailfish/vulnerables](contracts_dataset/dataset_sailfish/vulnerables/), as plain `.sol` files.

The results of both tools are written to the [evaluation/results](evaluation/results) folder, as described below.

*Note*: To aid evaluation, we already provide the results of our last execution of both Nyx and Sailfish in the [evaluation/results](evaluation/results) folder, ready to be used in [analysis.ipynb](./evaluation/analysis.ipynb), in case you do not wish to build/run the containers from scratch (see [Results](#results) below).

### Requirements

**Docker:**
  - [Docker Engine](https://docs.docker.com/engine/install/) with the Compose v2 plugin (the `docker compose` command)
  - Both images are built for `linux/amd64`. On Apple Silicon/ARM hosts, Docker Desktop will run them under emulation (Rosetta/QEMU), so make sure emulation support is enabled
  - Enough free disk space and memory to build and run both the Nyx and Sailfish images (each clones/installs a full analysis toolchain):

    | Tool | Image size | Max. memory usage | Build time | Analysis time |
    |---|---|---|---|---|
    | Nyx | 934MB | ~2.2 GB | ~150s | ~1h15m |
    | Sailfish | 2.3GB | ~1.8 GB | ~2s* | ~1h30m |

    \* Sailfish's Dockerfile is based on a pre-built image ([holmessherlock/sailfish](https://hub.docker.com/r/holmessherlock/sailfish)), so `docker compose build` only pulls that image and copies the dataset/scripts on top of it, rather than installing a toolchain from scratch.

### Build & Run

The Docker setup lives under [evaluation/](evaluation/), so run these commands from there:

```bash
cd evaluation
docker compose build
docker compose up -d
```

`-d` runs the containers detached, freeing up your terminal. To follow the logs:

```bash
docker compose logs -f
```

or just one tool at the time:

```bash
docker compose build nyx 
docker compose up -d nyx 

docker compose build sailfish
docker compose up -d sailfish
```

To follow the logs of a single tool:

```bash
docker compose logs -f nyx
# or
docker compose logs -f sailfish
```

### Quick sanity check (Nyx)

To quickly check that the Nyx container works, without running the full dataset, you can run it against the bundled `HashPuzzle` example instead of the mounted dataset. This test command is taken from [Nyx's own documentation](https://github.com/Troublor/Nyx):

```bash
docker compose run --rm --entrypoint python3 nyx nyx/main.py ./examples/HashPuzzle
```

### Quick sanity check (Sailfish)

To quickly check that the Sailfish container works, without running the full dataset, you can run `contractlint.py` directly against one of the tool's own bundled test cases. This test command is taken from [Sailfish's own documentation](https://github.com/ucsb-seclab/sailfish). Since its exact location inside the prebuilt image isn't guaranteed (cf. [run_sailfish.sh](evaluation/run_sailfish.sh)), we locate it here the same way, via `find`:

```bash
docker compose run --rm --entrypoint bash sailfish -c '
  analysis_dir="$(dirname "$(find / -xdev -name contractlint.py 2>/dev/null | head -n1)")"
  mkdir -p /results/smoke-test
  cd "$analysis_dir" && python contractlint.py \
    -c ../../test_cases/TOD/not_TOD_case_1.sol \
    -o /results/smoke-test \
    -r range -p TOD -oo -sv cvc4
'
```

### Results

After the containers are done, you should find the results for Nyx in `evaluation/results/nyx` and for Sailfish in `evaluation/results/sailfish`.

To evaluate the results as reported in Section 2.2.3 of the paper, i.e. to validate that the function pairs identified by the tools match those mentioned in the audit and reported in the `Function 1` and `Function 2` columns of [contracts_dataset.xlsx](./evaluation/contracts_dataset.xlsx), run the cells under the **'Nyx & Sailfish results'** section of the [analysis.ipynb](./evaluation/analysis.ipynb) notebook.

---

### Google Colab usage

If you decide not to install the required dependencies locally and instead use Google Colab, follow these steps:

1. Access [Google Colab](https://colab.research.google.com/).
2. Upload the notebook [analysis.ipynb](./evaluation/analysis.ipynb).
3. In the new tab, click the Folder icon on the left and upload:
   - [audit_dataset.xlsx](./evaluation/audit_dataset.xlsx)
   - [contracts_dataset.xlsx](./evaluation/contracts_dataset.xlsx)
   - [summarize_nyx_results.py](./evaluation/summarize_nyx_results.py)
   - [summarize_sailfish_results.py](./evaluation/summarize_sailfish_results.py)
   - [results.zip](./evaluation/results.zip) (or zip the new results folder after running Nyx and Sailfish)
4. Execute the **'Audits and Smart Contracts'** cell for MEV analysis, and the **'Nyx & Sailfish results'** cell for Static Frontrunning analysis.

---

### Additional notes on usage

Please note the following:

1. After changing the dataset or scripts, please re-run the docker containers with the following command (from [evaluation/](evaluation/)):

```bash
docker compose build --no-cache
```

2. Sailfish: [run_sailfish.sh](evaluation/run_sailfish.sh) locates `contractlint.py` at runtime via find, since the exact path inside the prebuilt image isn't guaranteed.
If that search fails, or you already know the path, set it explicitly:

```bash
SAILFISH_ANALYSIS_DIR=/actual/path/to/analysis docker compose up -d sailfish
```

The default per-contract time analysis is 600 seconds; if it's too slow for your contracts, decrease/increase it with:

```bash
TIMEOUT_SECONDS=<SECONDS> docker compose up -d sailfish
```

