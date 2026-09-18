## Audit Dataset Details

In the file [audit_dataset.xlsx](audit_dataset.xlsx), we report the frontrunning vulnerabilities identified by the auditors.

We identified 393 frontrunning vulnerabilities in total. Specifically, for each frontrunning vulnerability, we include:

  - **Audit**: the selected audit from each auditor
  - **Auditor**: the company that performed the audit
  - **Date**: the audit date
  - **Link**: link to the audit
  - **Issue ID**: the issue/section ID as reported in the audit
  - **Score**: for each vulnerability identified by the auditors, we also report the severity score as reported by each auditor. We use NA to report when the severity is not mentioned in the audit
  - **MEV**: we apply the definition of MEV to verify whether it is able to capture the specific vulnerability. We report:
      - YES: if the definition captures the reported vulnerability, i.e. there is an immediate gain for the attacker
      - NO: if the definition doesn’t capture the attack. In this case, we report the reason in the column Limitation. 
  - **Limitation**: we report:
      - 1 to denote that the attack is eventual
      - 2 to denote that the attack does not result in any immediate monetary gain to the attacker
      - 1,2 to denote that MEV cannot capture the identified vulnerability due to (1) and (2) combined
      - (Oth) to denote that MEV cannot capture the identified vulnerability due to other reasons besides (1) and/or (2).
  - **Fix**: this column indicates whether the vulnerability has also been fixed. In particular, we report:
     - YES, if the proposed fix is applied.
     - NO, if the proposed fix is not applied.
     - ACK, if the proposed fix is acknowledged but not resolved.
     - PARTIAL, if the proposed fix is only partially applied.
     - NF, if there is no mention of any fix.
  - **Source Code**: we investigated the availability of the source code for each investigated smart contract. We report:
      - YES, to indicate that the smart contract's source code is available either on GitHub or Etherscan.
      - NO, to indicate that the source code is not available, or that we could not locate it.
  - **Source Code Link**: the link to the source code, where available, otherwise we mark the column with 'no repo' when the Source Code column is YES but only a code snippet from the audit was found, with no public repository available.
