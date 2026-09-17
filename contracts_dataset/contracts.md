## Contract Dataset Details

In [contracts_dataset.xlsx](contracts_dataset.xlsx), we report the list of contracts for which the source code (D_aval) and the corresponding fix are both available (D_fixes). Here we report:

  - **Contract**: the contract name
  - **Audit**: the selected audit from each auditor
  - **Auditor**: the company that performed the audit
  - **Issue ID**: the issue/section ID as reported in the audit
  - **Event of Interest**: for the evaluation of NOD (see later)
  - **Function 1** and **Function 2**: the vulnerable functions causing the frontrunning vulnerability, as mentioned in the audit
  - **MEV**: we apply the definition of MEV to verify whether it is able to capture the specific vulnerability. We report:
      - YES: if the definition captures the reported vulnerability, i.e. there is an immediate gain for the attacker
      - NO: if the definition doesn’t capture the attack. In this case, we report the reason in the column Limitation. 
  - **Limitation**: we report:
      - 1 to denote that the attack is eventual
      - 2 to denote that the attack does not result in any immediate monetary gain to the attacker
      - 1,2 to denote that MEV cannot capture the identified vulnerability due to (1) and (2) combined
      - (Oth) to denote that MEV cannot capture the identified vulnerability due to other reasons besides (1) and/or (2).