## Dynamic Frontrunning Analysis: MEV Examples
### Example 1: Non-monetary attack

This vulnerability has been reported in [ACO Protocol Audit [M03]](https://www.openzeppelin.com/news/aco-protocol-audit#medium-severity).

#### Attack description: 
An account replenishes its own balance to meet or exceed `tokenData[account].amount` immediately prior to assignment execution, causing `_getAssignableAmount()` to evaluate to zero and thereby avoiding the exercise obligation.

#### Reasoning:

1. The manipulating transaction is a standard token transfer between accounts controlled by the attacker. It involves no swap, trade, or price impact, and therefore provides no observable value that a profit-based heuristic could quantify.
2. The benefit obtained is an avoided obligation (evasion of collateral assignment) rather than acquired value; no corresponding loss is transferred from a counterparty into the attacker's balance.

As there is no quantifiable monetary delta to detect, the MEV definition does not flag this vulnerability. 

---

### Example 2: Eventual attack

This vulnerability has been reported in [Empty Set V2 Audit [M04]](https://www.openzeppelin.com/news/empty-set-v2-audit#medium-severity).

#### Attack description:
An ordinary call to `swap()` is executed ahead of a pending governance order update, which zeroes the accounting balance. The resulting damage — a broken order that causes future calls to `swap()` to revert — only manifests at a later, unspecified point in time.

#### Reasoning:

1. The frontrunning transaction (`swap()`) is, in isolation, entirely ordinary and exhibits no adversarial characteristics, making it impossible to identify a discrete attacker/victim pair.
2. The resulting state corruption (decoupling of the accounting balance from the actual token balance) remains dormant following the transaction, producing no revert or other visible failure at the time it occurs.
3. The consequence — a reversion in an unrelated party's subsequent `swap()` call — may occur at any point afterward, from minutes to days later, with no fixed temporal relationship to the original transaction.

Because the cause and its impact are separated by an arbitrary and unbounded time interval, no single-block or single-bundle window analysis can establish a connection between them.