
// File: @aragon/court/contracts/lib/Checkpointing.sol
pragma solidity ^0.5.8;

/**
* @title Checkpointing - Library to handle a historic set of numeric values
*/
library Checkpointing {
    uint256 private constant MAX_UINT192 = uint256(uint192(-1));

    string private constant ERROR_VALUE_TOO_BIG = "CHECKPOINT_VALUE_TOO_BIG";
    string private constant ERROR_CANNOT_ADD_PAST_VALUE = "CHECKPOINT_CANNOT_ADD_PAST_VALUE";

    /**
    * @dev To specify a value at a given point in time, we need to store two values:
    *      - `time`: unit-time value to denote the first time when a value was registered
    *      - `value`: a positive numeric value to registered at a given point in time
    *
    *      Note that `time` does not need to refer necessarily to a timestamp value, any time unit could be used
    *      for it like block numbers, terms, etc.
    */
    struct Checkpoint {
        uint64 time;
        uint192 value;
    }

    /**
    * @dev A history simply denotes a list of checkpoints
    */
    struct History {
        Checkpoint[] history;
    }

    /**
    * @dev Add a new value to a history for a given point in time. This function does not allow to add values previous
    *      to the latest registered value, if the value willing to add corresponds to the latest registered value, it
    *      will be updated.
    * @param self Checkpoints history to be altered
    * @param _time Point in time to register the given value
    * @param _value Numeric value to be registered at the given point in time
    */
    function add(History storage self, uint64 _time, uint256 _value) internal {
        require(_value <= MAX_UINT192, ERROR_VALUE_TOO_BIG);
        _add192(self, _time, uint192(_value));
    }

    /**
    * @dev Fetch the latest registered value of history, it will return zero if there was no value registered
    * @param self Checkpoints history to be queried
    */
    function getLast(History storage self) internal view returns (uint256) {
        uint256 length = self.history.length;
        if (length > 0) {
            return uint256(self.history[length - 1].value);
        }

        return 0;
    }

    /**
    * @dev Fetch the most recent registered past value of a history based on a given point in time that is not known
    *      how recent it is beforehand. It will return zero if there is no registered value or if given time is
    *      previous to the first registered value.
    *      It uses a binary search.
    * @param self Checkpoints history to be queried
    * @param _time Point in time to query the most recent registered past value of
    */
    function get(History storage self, uint64 _time) internal view returns (uint256) {
        return _binarySearch(self, _time);
    }

    /**
    * @dev Fetch the most recent registered past value of a history based on a given point in time. It will return zero
    *      if there is no registered value or if given time is previous to the first registered value.
    *      It uses a linear search starting from the end.
    * @param self Checkpoints history to be queried
    * @param _time Point in time to query the most recent registered past value of
    */
    function getRecent(History storage self, uint64 _time) internal view returns (uint256) {
        return _backwardsLinearSearch(self, _time);
    }

    /**
    * @dev Private function to add a new value to a history for a given point in time. This function does not allow to
    *      add values previous to the latest registered value, if the value willing to add corresponds to the latest
    *      registered value, it will be updated.
    * @param self Checkpoints history to be altered
    * @param _time Point in time to register the given value
    * @param _value Numeric value to be registered at the given point in time
    */
    function _add192(History storage self, uint64 _time, uint192 _value) private {
        uint256 length = self.history.length;
        if (length == 0 || self.history[self.history.length - 1].time < _time) {
            // If there was no value registered or the given point in time is after the latest registered value,
            // we can insert it to the history directly.
            self.history.push(Checkpoint(_time, _value));
        } else {
            // If the point in time given for the new value is not after the latest registered value, we must ensure
            // we are only trying to update the latest value, otherwise we would be changing past data.
            Checkpoint storage currentCheckpoint = self.history[length - 1];
            require(_time == currentCheckpoint.time, ERROR_CANNOT_ADD_PAST_VALUE);
            currentCheckpoint.value = _value;
        }
    }

    /**
    * @dev Private function to execute a backwards linear search to find the most recent registered past value of a
    *      history based on a given point in time. It will return zero if there is no registered value or if given time
    *      is previous to the first registered value. Note that this function will be more suitable when we already know
    *      that the time used to index the search is recent in the given history.
    * @param self Checkpoints history to be queried
    * @param _time Point in time to query the most recent registered past value of
    */
    function _backwardsLinearSearch(History storage self, uint64 _time) private view returns (uint256) {
        // If there was no value registered for the given history return simply zero
        uint256 length = self.history.length;
        if (length == 0) {
            return 0;
        }

        uint256 index = length - 1;
        Checkpoint storage checkpoint = self.history[index];
        while (index > 0 && checkpoint.time > _time) {
            index--;
            checkpoint = self.history[index];
        }

        return checkpoint.time > _time ? 0 : uint256(checkpoint.value);
    }

    /**
    * @dev Private function execute a binary search to find the most recent registered past value of a history based on
    *      a given point in time. It will return zero if there is no registered value or if given time is previous to
    *      the first registered value. Note that this function will be more suitable when don't know how recent the
    *      time used to index may be.
    * @param self Checkpoints history to be queried
    * @param _time Point in time to query the most recent registered past value of
    */
    function _binarySearch(History storage self, uint64 _time) private view returns (uint256) {
        // If there was no value registered for the given history return simply zero
        uint256 length = self.history.length;
        if (length == 0) {
            return 0;
        }

        // If the requested time is equal to or after the time of the latest registered value, return latest value
        uint256 lastIndex = length - 1;
        if (_time >= self.history[lastIndex].time) {
            return uint256(self.history[lastIndex].value);
        }

        // If the requested time is previous to the first registered value, return zero to denote missing checkpoint
        if (_time < self.history[0].time) {
            return 0;
        }

        // Execute a binary search between the checkpointed times of the history
        uint256 low = 0;
        uint256 high = lastIndex;

        while (high > low) {
            // No need for SafeMath: for this to overflow array size should be ~2^255
            uint256 mid = (high + low + 1) / 2;
            Checkpoint storage checkpoint = self.history[mid];
            uint64 midTime = checkpoint.time;

            if (_time > midTime) {
                low = mid;
            } else if (_time < midTime) {
                // No need for SafeMath: high > low >= 0 => high >= 1 => mid >= 1
                high = mid - 1;
            } else {
                return uint256(checkpoint.value);
            }
        }

        return uint256(self.history[low].value);
    }
}

// File: @aragon/court/contracts/lib/os/Uint256Helpers.sol

// Brought from https://github.com/aragon/aragonOS/blob/v4.3.0/contracts/common/Uint256Helpers.sol
// Adapted to use pragma ^0.5.8 and satisfy our linter rules


library Uint256Helpers {
    uint256 private constant MAX_UINT8 = uint8(-1);
    uint256 private constant MAX_UINT64 = uint64(-1);

    string private constant ERROR_UINT8_NUMBER_TOO_BIG = "UINT8_NUMBER_TOO_BIG";
    string private constant ERROR_UINT64_NUMBER_TOO_BIG = "UINT64_NUMBER_TOO_BIG";

    function toUint8(uint256 a) internal pure returns (uint8) {
        require(a <= MAX_UINT8, ERROR_UINT8_NUMBER_TOO_BIG);
        return uint8(a);
    }

    function toUint64(uint256 a) internal pure returns (uint64) {
        require(a <= MAX_UINT64, ERROR_UINT64_NUMBER_TOO_BIG);
        return uint64(a);
    }
}

// File: https://github.com/OpenZeppelin/openzeppelin-sdk/blob/v2.8.0/packages/lib/contracts/utils/Address.sol


/**
 * Utility library of inline functions on addresses
 *
 * Source https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-solidity/v2.1.3/contracts/utils/Address.sol
 * This contract is copied here and renamed from the original to avoid clashes in the compiled artifacts
 * when the user imports a zos-lib contract (that transitively causes this contract to be compiled and added to the
 * build/artifacts folder) as well as the vanilla Address implementation from an openzeppelin version.
 */
library OpenZeppelinUpgradesAddress {
    /**
     * Returns whether the target address is a contract
     * @dev This function will return false if invoked during the constructor of a contract,
     * as the code is not actually created until after the constructor finishes.
     * @param account address of the account to check
     * @return whether the target address is a contract
     */
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        // XXX Currently there is no better way to check if there is a contract in an address
        // than to check the size of the code at that address.
        // See https://ethereum.stackexchange.com/a/14016/36603
        // for more details about how this works.
        // TODO Check this again before the Serenity release, because all addresses will be
        // contracts then.
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }
}

// File: @openzeppelin/contracts@2.3.0/token/ERC20/IERC20.sol

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see `ERC20Detailed`.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through `transferFrom`. This is
     * zero by default.
     *
     * This value changes when `approve` or `transferFrom` are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * > Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an `Approval` event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to `approve`. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts@2.3.0/math/SafeMath.sol


/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;
    }
}

// File: @openzeppelin/contracts@2.3.0/utils/Address.sol


/**
 * @dev Collection of functions related to the address type,
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * > It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }
}

// File: @openzeppelin/contracts@2.3.0/token/ERC20/SafeERC20.sol

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value);
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves.

        // A Solidity high level call has three parts:
        //  1. The target address is checked to verify it contains contract code
        //  2. The call itself is made, and success asserted
        //  3. The return value is decoded, which in turn checks the size of the returned data.
        // solhint-disable-next-line max-line-length
        require(address(token).isContract(), "SafeERC20: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// File: @openzeppelin/contracts@2.3.0/token/ERC20/ERC20.sol


/**
 * @dev Implementation of the `IERC20` interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using `_mint`.
 * For a generic mechanism see `ERC20Mintable`.
 *
 * *For a detailed writeup see our guide [How to implement supply
 * mechanisms](https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226).*
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an `Approval` event is emitted on calls to `transferFrom`.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard `decreaseAllowance` and `increaseAllowance`
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See `IERC20.approve`.
 */
contract ERC20 is IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    /**
     * @dev See `IERC20.totalSupply`.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See `IERC20.balanceOf`.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See `IERC20.transfer`.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    /**
     * @dev See `IERC20.allowance`.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See `IERC20.approve`.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    /**
     * @dev See `IERC20.transferFrom`.
     *
     * Emits an `Approval` event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of `ERC20`;
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `value`.
     * - the caller must have allowance for `sender`'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to `approve` that can be used as a mitigation for
     * problems described in `IERC20.approve`.
     *
     * Emits an `Approval` event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to `approve` that can be used as a mitigation for
     * problems described in `IERC20.approve`.
     *
     * Emits an `Approval` event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to `transfer`, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a `Transfer` event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
      //  emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a `Transfer` event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
     //   emit Transfer(address(0), account, amount);
    }

     /**
     * @dev Destoys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a `Transfer` event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 value) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _totalSupply = _totalSupply.sub(value);
        _balances[account] = _balances[account].sub(value);
     //   emit Transfer(account, address(0), value);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an `Approval` event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = value;
      //  emit Approval(owner, spender, value);
    }

    /**
     * @dev Destoys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     *
     * See `_burn` and `_approve`.
     */
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(account, msg.sender, _allowances[account][msg.sender].sub(amount));
    }
}

// File: @openzeppelin/contracts@2.3.0/token/ERC20/ERC20Burnable.sol


/**
 * @dev Extension of `ERC20` that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */
contract ERC20Burnable is ERC20 {
    /**
     * @dev Destoys `amount` tokens from the caller.
     *
     * See `ERC20._burn`.
     */
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    /**
     * @dev See `ERC20._burnFrom`.
     */
    function burnFrom(address account, uint256 amount) public {
        _burnFrom(account, amount);
    }
}

// File: @openzeppelin/upgrades/contracts/Initializable.sol


/**
 * @title Initializable
 *
 * @dev Helper contract to support initializer functions. To use it, replace
 * the constructor with a function that has the `initializer` modifier.
 * WARNING: Unlike constructors, initializer functions must be manually
 * invoked. This applies both to deploying an Initializable contract, as well
 * as extending an Initializable contract via inheritance.
 * WARNING: When used with inheritance, manual care must be taken to not invoke
 * a parent initializer twice, or ensure that all initializers are idempotent,
 * because this is not dealt with automatically as with constructors.
 */
contract Initializable {

  /**
   * @dev Indicates that the contract has been initialized.
   */
  bool private initialized;

  /**
   * @dev Indicates that the contract is in the process of being initialized.
   */
  bool private initializing;

  /**
   * @dev Modifier to use in the initializer function of a contract.
   */
  modifier initializer() {
    require(initializing || isConstructor() || !initialized, "Contract instance has already been initialized");

    bool isTopLevelCall = !initializing;
    if (isTopLevelCall) {
      initializing = true;
      initialized = true;
    }

    _;

    if (isTopLevelCall) {
      initializing = false;
    }
  }

  /// @dev Returns true if and only if the function is running in the constructor
  function isConstructor() private view returns (bool) {
    // extcodesize checks the size of the code stored in an address, and
    // address returns the current address. Since the code is still not
    // deployed when running a constructor, any checks on its code size will
    // yield zero, making it an effective way to detect if a contract is
    // under construction or not.
    address self = address(this);
    uint256 cs;
    assembly { cs := extcodesize(self) }
    return cs == 0;
  }

  // Reserved storage space to allow for layout changes in the future.
  uint256[50] private ______gap;
}

// File: https://github.com/frankenstien-831/openzeppelin-contracts-ethereum-package/blob/master/contracts/GSN/Context.sol

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context is Initializable {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: https://github.com/frankenstien-831/openzeppelin-contracts-ethereum-package/blob/master/contracts/ownership/Ownable.sol

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be aplied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Initializable, Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    function initialize(address sender) public initializer {
        _owner = sender;
      //  emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * > Note: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
       // emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
     //   emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    uint256[50] private ______gap;
}

// File: test.sol

/**
 * Wrapper around OpenZeppelin's Initializable contract.
 * Exposes initialized state management to ensure logic contract functions cannot be called before initialization.
 * This is needed because OZ's Initializable contract no longer exposes initialized state variable.
 * https://github.com/OpenZeppelin/openzeppelin-sdk/blob/v2.8.0/packages/lib/contracts/Initializable.sol
 */
contract InitializableV2 is Initializable {
    bool private isInitialized;

    string private constant ERROR_NOT_INITIALIZED = "INIT_NOT_INITIALIZED";
    string private constant ERROR_ALREADY_INITIALIZED = "ERROR_ALREADY_INITIALIZED";

    function initialize() public initializer {
        isInitialized = true;
    }

    function _requireIsInitialized() internal view {
        require(isInitialized == true, ERROR_NOT_INITIALIZED);
    }

    function _isInitialized() internal view returns (bool) {
        return isInitialized;
    }
}


/**
* @title Central hub for Audius protocol. It stores all contract addresses to facilitate
*   external access and enable version management.
*/
contract Registry is InitializableV2, Ownable {
    using SafeMath for uint;

    /**
     * @dev addressStorage mapping allows efficient lookup of current contract version
     *      addressStorageHistory maintains record of all contract versions
     */
    mapping(bytes32 => address) private addressStorage;
    mapping(bytes32 => address[]) private addressStorageHistory;

    event ContractAdded(bytes32 _name, address _address);
    event ContractRemoved(bytes32 _name, address _address);
    event ContractUpgraded(bytes32 _name, address _oldAddress, address _newAddress);

    function initialize() public initializer {
        /// @notice Ownable.initialize(address _sender) sets contract owner to _sender.
        Ownable.initialize(msg.sender);
        InitializableV2.initialize();
    }

    // ========================================= Setters =========================================

    /**
     * @notice addContract registers contract name to address mapping under given registry key
     * @param _name - registry key that will be used for lookups
     * @param _address - address of contract
     */
    function addContract(bytes32 _name, address _address) external onlyOwner {
        _requireIsInitialized();

        require(
            addressStorage[_name] == address(0x00),
            "Registry::addContract: Contract already registered with given name."
        );
        require(
            _address != address(0x00),
            "Registry::addContract: Cannot register zero address."
        );

        setAddress(_name, _address);

     //   emit ContractAdded(_name, _address);
    }

    /**
     * @notice removes contract address registered under given registry key
     * @param _name - registry key for lookup
     */
    function removeContract(bytes32 _name) external onlyOwner {
        _requireIsInitialized();

        address contractAddress = addressStorage[_name];
        require(
            contractAddress != address(0x00),
            "Registry::removeContract: Cannot remove - no contract registered with given _name."
        );

        setAddress(_name, address(0x00));

      //  emit ContractRemoved(_name, contractAddress);
    }

    /**
     * @notice replaces contract address registered under given key with provided address
     * @param _name - registry key for lookup
     * @param _newAddress - new contract address to register under given key
     */
    function upgradeContract(bytes32 _name, address _newAddress) external onlyOwner {
        _requireIsInitialized();

        address oldAddress = addressStorage[_name];
        require(
            oldAddress != address(0x00),
            "Registry::upgradeContract: Cannot upgrade - no contract registered with given _name."
        );

        setAddress(_name, _newAddress);

     // emit ContractUpgraded(_name, oldAddress, _newAddress);
    }

    // ========================================= Getters =========================================

    /**
     * @notice returns contract address registered under given registry key
     * @param _name - registry key for lookup
     * @return contractAddr - address of contract registered under given registry key
     */
    function getContract(bytes32 _name) external view returns (address contractAddr) {
        return addressStorage[_name];
    }

    /// @notice overloaded getContract to return explicit version of contract
    function getContract(bytes32 _name, uint _version) external view
    returns (address contractAddr)
    {
        // array length for key implies version number
        require(
            _version <= addressStorageHistory[_name].length,
            "Registry::getContract: Index out of range _version."
        );
        return addressStorageHistory[_name][_version.sub(1)];
    }

    /**
     * @notice Returns the number of versions for a contract key
     * @param _name - registry key for lookup
     * @return number of contract versions
     */
    function getContractVersionCount(bytes32 _name) external view returns (uint) {
        return addressStorageHistory[_name].length;
    }

    // ========================================= Private functions =========================================

    /**
     * @param _key the key for the contract address
     * @param _value the contract address
     */
    function setAddress(bytes32 _key, address _value) private {
        // main map for cheap lookup
        addressStorage[_key] = _value;
        // keep track of contract address history
        addressStorageHistory[_key].push(_value);
    }

}

contract Staking is InitializableV2 {
    using SafeMath for uint256;
    using Uint256Helpers for uint256;
    using Checkpointing for Checkpointing.History;
    using SafeERC20 for ERC20;

    string private constant ERROR_TOKEN_NOT_CONTRACT = "STAKING_TOKEN_NOT_CONTRACT";
    string private constant ERROR_AMOUNT_ZERO = "STAKING_AMOUNT_ZERO";
    string private constant ERROR_TOKEN_TRANSFER = "STAKING_TOKEN_TRANSFER";
    string private constant ERROR_NOT_ENOUGH_BALANCE = "STAKING_NOT_ENOUGH_BALANCE";

    /// @dev stores the history of staking and claims for a given address
    struct Account {
        Checkpointing.History stakedHistory;
        Checkpointing.History claimHistory;
    }

    /// @dev ERC-20 token that will be used to stake with
    ERC20 internal stakingToken;

    /// @dev maps addresses to staking and claims history
    mapping (address => Account) internal accounts;

    /// @dev total staked tokens at a given block
    Checkpointing.History internal totalStakedHistory;

    address governanceAddress;
    address claimsManagerAddress;
    address delegateManagerAddress;
    address serviceProviderFactoryAddress;

    event Staked(address indexed user, uint256 amount, uint256 total);
    event Unstaked(address indexed user, uint256 amount, uint256 total);
    event Slashed(address indexed user, uint256 amount, uint256 total);

    /**
     * @notice Function to initialize the contract
     * @param _stakingToken - address of ERC20 token that will be staked
     * @param _governanceAddress - address for Governance proxy contract     * @param _test - address for Governance proxy contract
     */
    function initialize(
        address _stakingToken,
        address _governanceAddress
    ) public initializer
    {
        require(Address.isContract(_stakingToken), ERROR_TOKEN_NOT_CONTRACT);
        stakingToken = ERC20(_stakingToken);
        governanceAddress = _governanceAddress;
        InitializableV2.initialize();
    }

    /**
     * @notice Set the Governance address
     * @dev Only callable by Governance address
     * @param _governanceAddress - address for new Governance contract
     */
    function setGovernanceAddress(address _governanceAddress) external {
        require(msg.sender == governanceAddress, "Only governance");
        governanceAddress = _governanceAddress;
    }

    /**
     * @notice Set the ClaimsManaager address
     * @dev Only callable by Governance address
     * @param _claimsManager - address for new ClaimsManaager contract
     */
    function setClaimsManagerAddress(address _claimsManager) external {
        require(msg.sender == governanceAddress, "Only governance");
        claimsManagerAddress = _claimsManager;
    }

    /**
     * @notice Set the ServiceProviderFactory address
     * @dev Only callable by Governance address
     * @param _spFactory - address for new ServiceProviderFactory contract
     */
    function setServiceProviderFactoryAddress(address _spFactory) external {
        require(msg.sender == governanceAddress, "Only governance");
        serviceProviderFactoryAddress = _spFactory;
    }

    /**
     * @notice Set the DelegateManager address
     * @dev Only callable by Governance address
     * @param _delegateManager - address for new DelegateManager contract
     */
    function setDelegateManagerAddress(address _delegateManager) external {
        require(msg.sender == governanceAddress, "Only governance");
        delegateManagerAddress = _delegateManager;
    }

    /* External functions */

    /**
     * @notice Funds `_amount` of tokens from ClaimsManager to target account
     * @param _amount - amount of rewards to  add to stake
     * @param _stakerAccount - address of staker
     */
    function stakeRewards(uint256 _amount, address _stakerAccount) external {
        _requireIsInitialized();
        require(
            msg.sender == claimsManagerAddress,
            "Only callable from ClaimsManager"
        );
        _stakeFor(_stakerAccount, msg.sender, _amount);

        this.updateClaimHistory(_amount, _stakerAccount);
    }

    /**
     * @notice Update claim history by adding an event to the claim historry
     * @param _amount - amount to add to claim history
     * @param _stakerAccount - address of staker
     */
    function updateClaimHistory(uint256 _amount, address _stakerAccount) external {
        _requireIsInitialized();
        require(
            msg.sender == claimsManagerAddress || msg.sender == address(this),
            "Only callable from ClaimsManager or Staking.sol"
        );

        // Update claim history even if no value claimed
        accounts[_stakerAccount].claimHistory.add(block.number.toUint64(), _amount);
    }

    /**
     * @notice Slashes `_amount` tokens from _slashAddress
     * @dev Callable from DelegateManager
     * @param _amount - Number of tokens slashed
     * @param _slashAddress - Address being slashed
     */
    function slash(
        uint256 _amount,
        address _slashAddress
    ) external
    {
        _requireIsInitialized();
        require(
            msg.sender == delegateManagerAddress,
            "Only callable from DelegateManager"
        );

        // Burn slashed tokens from account
        _burnFor(_slashAddress, _amount);

      //  emit Slashed(
       //     _slashAddress,
        //    _amount,
         //   totalStakedFor(_slashAddress)
        //);
    }

    /**
     * @notice Stakes `_amount` tokens, transferring them from _accountAddress, and assigns them to `_accountAddress`
     * @param _accountAddress - The final staker of the tokens
     * @param _amount - Number of tokens staked
     */
    function stakeFor(
        address _accountAddress,
        uint256 _amount
    ) external
    {
        _requireIsInitialized();
        require(
            msg.sender == serviceProviderFactoryAddress,
            "Only callable from ServiceProviderFactory"
        );
        _stakeFor(
            _accountAddress,
            _accountAddress,
            _amount);
    }

    /**
     * @notice Unstakes `_amount` tokens, returning them to the desired account.
     * @param _accountAddress - Account unstaked for, and token recipient
     * @param _amount - Number of tokens staked
     */
    function unstakeFor(
        address _accountAddress,
        uint256 _amount
    ) external
    {
        _requireIsInitialized();
        require(
            msg.sender == serviceProviderFactoryAddress,
            "Only callable from ServiceProviderFactory"
        );
        _unstakeFor(
            _accountAddress,
            _accountAddress,
            _amount
        );
    }

    /**
     * @notice Stakes `_amount` tokens, transferring them from caller, and assigns them to `_accountAddress`
     * @param _accountAddress - The final staker of the tokens
     * @param _delegatorAddress - Address from which to transfer tokens
     * @param _amount - Number of tokens staked
     */
    function delegateStakeFor(
        address _accountAddress,
        address _delegatorAddress,
        uint256 _amount
    ) external {
        _requireIsInitialized();
        require(
            msg.sender == delegateManagerAddress,
            "delegateStakeFor - Only callable from DelegateManager"
        );
        _stakeFor(
            _accountAddress,
            _delegatorAddress,
            _amount);
    }

    /**
     * @notice Stakes `_amount` tokens, transferring them from caller, and assigns them to `_accountAddress`
     * @param _accountAddress - The staker of the tokens
     * @param _delegatorAddress - Address from which to transfer tokens
     * @param _amount - Number of tokens unstaked
     */
    function undelegateStakeFor(
        address _accountAddress,
        address _delegatorAddress,
        uint256 _amount
    ) external {
        _requireIsInitialized();
        require(
            msg.sender == delegateManagerAddress,
            "undelegateStakeFor - Only callable from DelegateManager"
        );
        _unstakeFor(
            _accountAddress,
            _delegatorAddress,
            _amount);
    }

    /**
     * @notice Get the token used by the contract for staking and locking
     * @return The token used by the contract for staking and locking
     */
    function token() external view returns (address) {
        return address(stakingToken);
    }

    /**
     * @notice Check whether it supports history of stakes
     * @return Always true
     */
    function supportsHistory() external pure returns (bool) {
        return true;
    }

    /**
     * @notice Get last time `_accountAddress` modified its staked balance
     * @param _accountAddress - Account requesting for
     * @return Last block number when account's balance was modified
     */
    function lastStakedFor(address _accountAddress) external view returns (uint256) {
        uint256 length = accounts[_accountAddress].stakedHistory.history.length;
        if (length > 0) {
            return uint256(accounts[_accountAddress].stakedHistory.history[length - 1].time);
        }
        return 0;
    }

    /**
     * @notice Get last time `_accountAddress` claimed a staking reward
     * @param _accountAddress - Account requesting for
     * @return Last block number when claim requested
     */
    function lastClaimedFor(address _accountAddress) external view returns (uint256) {
        uint256 length = accounts[_accountAddress].claimHistory.history.length;
        if (length > 0) {
            return uint256(accounts[_accountAddress].claimHistory.history[length - 1].time);
        }
        return 0;
    }

    /**
     * @notice Get the total amount of tokens staked by `_accountAddress` at block number `_blockNumber`
     * @param _accountAddress - Account requesting for
     * @param _blockNumber - Block number at which we are requesting
     * @return The amount of tokens staked by the account at the given block number
     */
    function totalStakedForAt(
        address _accountAddress,
        uint256 _blockNumber
    ) external view returns (uint256) {
        return accounts[_accountAddress].stakedHistory.get(_blockNumber.toUint64());
    }

    /**
     * @notice Get the total amount of tokens staked by all users at block number `_blockNumber`
     * @param _blockNumber - Block number at which we are requesting
     * @return The amount of tokens staked at the given block number
     */
    function totalStakedAt(uint256 _blockNumber) external view returns (uint256) {
        return totalStakedHistory.get(_blockNumber.toUint64());
    }

    /// @notice Get the Governance address
    function getGovernanceAddress() external view returns (address addr) {
        return governanceAddress;
    }

    /// @notice Get the ClaimsManager address
    function getClaimsManagerAddress() external view returns (address addr) {
        return claimsManagerAddress;
    }

    /// @notice Get the ServiceProviderFactory address
    function getServiceProviderFactoryAddress() external view returns (address addr) {
        return serviceProviderFactoryAddress;
    }

    /// @notice Get the DelegateManager address
    function getDelegateManagerAddress() external view returns (address addr) {
        return delegateManagerAddress;
    }

    /* Public functions */

    /**
     * @notice Get the amount of tokens staked by `_accountAddress`
     * @param _accountAddress - The owner of the tokens
     * @return The amount of tokens staked by the given account
     */
    function totalStakedFor(address _accountAddress) public view returns (uint256) {
        // we assume it's not possible to stake in the future
        return accounts[_accountAddress].stakedHistory.getLast();
    }

    /**
     * @notice Get the total amount of tokens staked by all users
     * @return The total amount of tokens staked by all users
     */
    function totalStaked() public view returns (uint256) {
        // we assume it's not possible to stake in the future
        return totalStakedHistory.getLast();
    }

    /* Internal functions */

    /**
     * @notice Adds stake from a transfer account to the stake account
     * @param _stakeAccount - Account that funds will be staked for
     * @param _transferAccount - Account that funds will be transferred from
     * @param _amount - amount to stake
     */
    function _stakeFor(
        address _stakeAccount,
        address _transferAccount,
        uint256 _amount
    ) internal
    {
        // staking 0 tokens is invalid
        require(_amount > 0, ERROR_AMOUNT_ZERO);

        // Checkpoint updated staking balance
        _modifyStakeBalance(_stakeAccount, _amount, true);

        // checkpoint total supply
        _modifyTotalStaked(_amount, true);

        // pull tokens into Staking contract
        stakingToken.safeTransferFrom(_transferAccount, address(this), _amount);

      //  emit Staked(
       //     _stakeAccount,
        //    _amount,
        //    totalStakedFor(_stakeAccount));
    }

    /**
     * @notice Unstakes tokens from a stake account to a transfer account
     * @param _stakeAccount - Account that staked funds will be transferred from
     * @param _transferAccount - Account that funds will be transferred to
     * @param _amount - amount to unstake
     */
    function _unstakeFor(
        address _stakeAccount,
        address _transferAccount,
        uint256 _amount
    ) internal
    {
        require(_amount > 0, ERROR_AMOUNT_ZERO);

        // checkpoint updated staking balance
        _modifyStakeBalance(_stakeAccount, _amount, false);

        // checkpoint total supply
        _modifyTotalStaked(_amount, false);

        // transfer tokens
        stakingToken.safeTransfer(_transferAccount, _amount);

     //   emit Unstaked(
     //       _stakeAccount,
      //      _amount,
       //     totalStakedFor(_stakeAccount)
       // );
    }

    /**
     * @notice Burn tokens for a given staker
     * @dev Called when slash occurs
     * @param _stakeAccount - Account for which funds will be burned
     * @param _amount - amount to burn
     */
    function _burnFor(address _stakeAccount, uint256 _amount) internal {
        // burning zero tokens is not allowed
        require(_amount > 0, ERROR_AMOUNT_ZERO);

        // checkpoint updated staking balance
        _modifyStakeBalance(_stakeAccount, _amount, false);

        // checkpoint total supply
        _modifyTotalStaked(_amount, false);

        // burn
        ERC20Burnable(address(stakingToken)).burn(_amount);

        /** No event emitted since token.burn() call already emits a Transfer event */
    }

    /**
     * @notice Increase or decrease the staked balance for an account
     * @param _accountAddress - Account to modify
     * @param _by - amount to modify
     * @param _increase - true if increase in stake, false if decrease
     */
    function _modifyStakeBalance(address _accountAddress, uint256 _by, bool _increase) internal {
        uint256 currentInternalStake = accounts[_accountAddress].stakedHistory.getLast();

        uint256 newStake;
        if (_increase) {
            newStake = currentInternalStake.add(_by);
        } else {
            require(
                currentInternalStake >= _by,
                "Cannot decrease greater than current balance");
            newStake = currentInternalStake.sub(_by);
        }

        // add new value to account history
        accounts[_accountAddress].stakedHistory.add(block.number.toUint64(), newStake);
    }

    /**
     * @notice Increase or decrease the staked balance across all accounts
     * @param _by - amount to modify
     * @param _increase - true if increase in stake, false if decrease
     */
    function _modifyTotalStaked(uint256 _by, bool _increase) internal {
        uint256 currentStake = totalStaked();

        uint256 newStake;
        if (_increase) {
            newStake = currentStake.add(_by);
        } else {
            newStake = currentStake.sub(_by);
        }

        // add new value to total history
        totalStakedHistory.add(block.number.toUint64(), newStake);
    }
}


contract Governance is InitializableV2 {
    using SafeMath for uint;

    /**
     * @notice Address and contract instance of Audius Registry. Used to ensure this contract
     *      can only govern contracts that are registered in the Audius Registry.
     */
    Registry private registry;
    address private registryAddress;

    /// @notice Address of Audius staking contract, used to permission Governance method calls
    address private stakingAddress;

    /// @notice Period in blocks for which a governance proposal is open for voting
    uint256 private votingPeriod;

    /// @notice Required miniumum number of votes to consider a proposal valid
    uint256 private votingQuorum;

    /**
     * @notice Address of account that has special Governance permissions. Can veto proposals
     *      and execute transactions directly on contracts.
     */
    address private guardianAddress;

    /***** Enums *****/

    /**
     * @notice All Proposal Outcome states.
     *      InProgress - Proposal is active and can be voted on
     *      No - Proposal votingPeriod has closed and decision is No. Proposal will not be executed.
     *      Yes - Proposal votingPeriod has closed and decision is Yes. Proposal will be executed.
     *      Invalid - Proposal votingPeriod has closed and votingQuorum was not met. Proposal will not be executed.
     *      TxFailed - Proposal voting decision was Yes, but transaction execution failed.
     *      Evaluating - Proposal voting decision was Yes, and evaluateProposalOutcome function is currently running.
     *          This status is transiently used inside that function to prevent re-entrancy.
     */
    enum Outcome {InProgress, No, Yes, Invalid, TxFailed, Evaluating}

    /**
     * @notice All Proposal Vote states for a voter.
     *      None - The default state, for any account that has not previously voted on this Proposal.
     *      No - The account voted No on this Proposal.
     *      Yes - The account voted Yes on this Proposal.
     *
     * @dev Enum values map to uints, so first value in Enum always is 0.
     */
    enum Vote {None, No, Yes}

    struct Proposal {
        uint256 proposalId;
        address proposer;
        uint256 startBlockNumber;
        bytes32 targetContractRegistryKey;
        address targetContractAddress;
        uint callValue;
        string signature;
        bytes callData;
        Outcome outcome;
        uint256 voteMagnitudeYes;
        uint256 voteMagnitudeNo;
        uint256 numVotes;
        mapping(address => Vote) votes;
    }

    /***** Proposal storage *****/
    uint256 lastProposalId = 0;
    mapping(uint256 => Proposal) proposals;

    /***** Events *****/
    event ProposalSubmitted(
        uint256 indexed proposalId,
        address indexed proposer,
        uint256 startBlockNumber,
        string description
    );
    event ProposalVoteSubmitted(
        uint256 indexed proposalId,
        address indexed voter,
        Vote indexed vote,
        uint256 voterStake,
        Vote previousVote
    );
    event ProposalOutcomeEvaluated(
        uint256 indexed proposalId,
        Outcome indexed outcome,
        uint256 voteMagnitudeYes,
        uint256 voteMagnitudeNo,
        uint256 numVotes
    );
    event ProposalTransactionExecuted(
        uint256 indexed proposalId,
        bool indexed success,
        bytes returnData
    );
    event GuardianTransactionExecuted(
        address indexed targetContractAddress,
        uint256 callValue,
        string indexed signature,
        bytes indexed callData,
        bytes returnData
    );
    event ProposalVetoed(uint256 indexed proposalId);

    /**
     * @notice Initialize the Governance contract
     * @dev _votingPeriod <= DelegateManager.undelegateLockupDuration
     * @param _registryAddress - address of the registry proxy contract
     * @param _votingPeriod - period in blocks for which a governance proposal is open for voting
     * @param _votingQuorum - required minimum number of votes to consider a proposal valid
     * @param _guardianAddress - address of account that has special Governance permissions

     */
    function initialize(
        address _registryAddress,
        uint256 _votingPeriod,
        uint256 _votingQuorum,
        address _guardianAddress
    ) public initializer {
        require(_registryAddress != address(0x00), "Requires non-zero _registryAddress");
        registryAddress = _registryAddress;
        registry = Registry(_registryAddress);

        require(_votingPeriod > 0, "Requires non-zero _votingPeriod");
        votingPeriod = _votingPeriod;

        require(_votingQuorum > 0, "Requires non-zero _votingQuorum");
        votingQuorum = _votingQuorum;

        require(_guardianAddress != address(0x00), "Requires non-zero _guardianAddress");
        guardianAddress = _guardianAddress;  //Guardian address becomes the only party

        InitializableV2.initialize();
    }

    // ========================================= Governance Actions =========================================

    /**
     * @notice Submit a proposal for vote. Only callable by stakers with non-zero stake.
     * @param _targetContractRegistryKey - Registry key for the contract concerning this proposal
     * @param _callValue - amount of wei to pass with function call if a token transfer is involved
     * @param _signature - function signature of the function to be executed if proposal is successful
     * @param _callData - encoded value(s) to call function with if proposal is successful
     * @param _description - Text description of proposal to be emitted in event
     */
    function submitProposal(
        bytes32 _targetContractRegistryKey,
        uint256 _callValue,
        string calldata _signature,
        bytes calldata _callData,
        string calldata _description
    ) external returns (uint256 proposalId)
    {
        _requireIsInitialized();

        address proposer = msg.sender;

        // Require proposer is active Staker
        Staking stakingContract = Staking(stakingAddress);
        require(
            stakingContract.totalStakedFor(proposer) > 0,
            "Proposer must be active staker with non-zero stake."
        );

        // Require _targetContractRegistryKey points to a valid registered contract
        address targetContractAddress = registry.getContract(_targetContractRegistryKey);
        require(
            targetContractAddress != address(0x00),
            "_targetContractRegistryKey must point to valid registered contract"
        );

        // Signature cannot be empty
        require(
            bytes(_signature).length != 0,
            "Governance::submitProposal: _signature cannot be empty."
        );

        // set proposalId
        uint256 newProposalId = lastProposalId.add(1);

        // Store new Proposal obj in proposals mapping
        proposals[newProposalId] = Proposal({
            proposalId: newProposalId,
            proposer: proposer,
            startBlockNumber: block.number,
            targetContractRegistryKey: _targetContractRegistryKey,
            targetContractAddress: targetContractAddress,
            callValue: _callValue,
            signature: _signature,
            callData: _callData,
            outcome: Outcome.InProgress,
            voteMagnitudeYes: 0,
            voteMagnitudeNo: 0,
            numVotes: 0
            /* votes: mappings are auto-initialized to default state */
        });

    /// @title A title that should describe the contract/interface
    /// @author The name of the author
    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details    
    //emit ProposalSubmitted(
     //       newProposalId,
      //      proposer,
       //     block.number,
        //    _description
        //);

        lastProposalId = lastProposalId.add(1);

        return newProposalId;
    }

    /**
     * @notice Vote on an active Proposal. Only callable by stakers with non-zero stake.
     * @param _proposalId - id of the proposal this vote is for
     * @param _vote - can be either {Yes, No} from Vote enum. No other values allowed
     */
    function submitProposalVote(uint256 _proposalId, Vote _vote) external {
        _requireIsInitialized();

        address voter = msg.sender;

        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Must provide valid non-zero _proposalId"
        );

        // Require voter is active Staker + get voterStake.
        Staking stakingContract = Staking(stakingAddress);

        uint256 voterStake = stakingContract.totalStakedForAt(
            voter,
            proposals[_proposalId].startBlockNumber
        );
        require(voterStake > 0, "Voter must be active staker with non-zero stake.");

        // Require proposal is still active
        require(
            proposals[_proposalId].outcome == Outcome.InProgress,
            "Governance::submitProposalVote: Cannot vote on inactive proposal."
        );

        // Require proposal votingPeriod is still active.
        uint256 startBlockNumber = proposals[_proposalId].startBlockNumber;
        uint256 endBlockNumber = startBlockNumber.add(votingPeriod);
        require(
            block.number > startBlockNumber && block.number <= endBlockNumber,
            "Governance::submitProposalVote: Proposal votingPeriod has ended"
        );

        // Require vote is either Yes or No
        require(
            _vote == Vote.Yes || _vote == Vote.No,
            "Governance::submitProposalVote: Can only submit a Yes or No vote"
        );

        // Record previous vote.
        Vote previousVote = proposals[_proposalId].votes[voter];

        // Will override staker's previous vote if present.
        proposals[_proposalId].votes[voter] = _vote;

        /* Update voteMagnitudes accordingly */

        // New voter (Vote enum defaults to 0)
        if (previousVote == Vote.None) {
            if (_vote == Vote.Yes) {
                proposals[_proposalId].voteMagnitudeYes = (
                    proposals[_proposalId].voteMagnitudeYes.add(voterStake)
                );
            } else {
                proposals[_proposalId].voteMagnitudeNo = (
                    proposals[_proposalId].voteMagnitudeNo.add(voterStake)
                );
            }
            proposals[_proposalId].numVotes = proposals[_proposalId].numVotes.add(1);
        } else { // Repeat voter
            if (previousVote == Vote.Yes && _vote == Vote.No) {
                proposals[_proposalId].voteMagnitudeYes = (
                    proposals[_proposalId].voteMagnitudeYes.sub(voterStake)
                );
                proposals[_proposalId].voteMagnitudeNo = (
                    proposals[_proposalId].voteMagnitudeNo.add(voterStake)
                );
            } else if (previousVote == Vote.No && _vote == Vote.Yes) {
                proposals[_proposalId].voteMagnitudeYes = (
                    proposals[_proposalId].voteMagnitudeYes.add(voterStake)
                );
                proposals[_proposalId].voteMagnitudeNo = (
                    proposals[_proposalId].voteMagnitudeNo.sub(voterStake)
                );
            }
            // If _vote == previousVote, no changes needed to vote magnitudes.
        }

        //emit ProposalVoteSubmitted(
        //    _proposalId,
        //    voter,
        //    _vote,
        //    voterStake,
        //    previousVote
       // );
    }

    /**
     * @notice Once the voting period for a proposal has ended, evaluate the outcome and
     *      execute the proposal if stake-weighted vote is >= 50% Yes and voting quorum met.
     * @dev Requires that caller is an active staker at the time the proposal is created
     * @param _proposalId - id of the proposal
     */
    function evaluateProposalOutcome(uint256 _proposalId)
    external returns (Outcome proposalOutcome)
    {
        _requireIsInitialized();

        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Governance::evaluateProposalOutcome: Must provide valid non-zero _proposalId."
        );

        // Require proposal has not already been evaluated.
        require(
            proposals[_proposalId].outcome == Outcome.InProgress,
            "Governance::evaluateProposalOutcome: Cannot evaluate inactive proposal."
        );

        /// Re-entrancy should not be possible here since this switches the status of the
        /// proposal to 'Evaluating' so it should fail the status is 'InProgress' check
        proposals[_proposalId].outcome = Outcome.Evaluating;

        // Require msg.sender is active Staker.
        Staking stakingContract = Staking(stakingAddress);

        require(
            stakingContract.totalStakedForAt(
                msg.sender, proposals[_proposalId].startBlockNumber
            ) > 0,
            "Governance::evaluateProposalOutcome: Caller must be active staker with non-zero stake."
        );

        // Require proposal votingPeriod has ended.
        uint256 startBlockNumber = proposals[_proposalId].startBlockNumber;
        uint256 endBlockNumber = startBlockNumber.add(votingPeriod);
        require(
            block.number > endBlockNumber,
            "Governance::evaluateProposalOutcome: Proposal votingPeriod must end before evaluation."
        );

        // Require registered contract address for provided registryKey has not changed.
        address targetContractAddress = registry.getContract(
            proposals[_proposalId].targetContractRegistryKey
        );
        require(
            targetContractAddress == proposals[_proposalId].targetContractAddress,
            "Governance::evaluateProposalOutcome: Registered contract address for targetContractRegistryKey has changed"
        );

        // Calculate outcome
        Outcome outcome;
        // votingQuorum not met -> proposal is invalid.
        if (proposals[_proposalId].numVotes < votingQuorum) {
            outcome = Outcome.Invalid;
        }
        // votingQuorum met & vote is Yes -> execute proposed transaction & close proposal.
        else if (
            proposals[_proposalId].voteMagnitudeYes >= proposals[_proposalId].voteMagnitudeNo
        ) {
            (bool success, bytes memory returnData) = _executeTransaction(
                targetContractAddress,
                proposals[_proposalId].callValue,
                proposals[_proposalId].signature,
                proposals[_proposalId].callData
            );

          //  emit ProposalTransactionExecuted(
          //      _proposalId,
           //     success,
           //     returnData
           // );

            // Proposal outcome depends on success of transaction execution.
            if (success) {
                outcome = Outcome.Yes;
            } else {
                outcome = Outcome.TxFailed;
            }
        }
        // votingQuorum met & vote is No -> close proposal without transaction execution.
        else {
            outcome = Outcome.No;
        }

        /// This records the final outcome in the proposals mapping
        proposals[_proposalId].outcome = outcome;

        emit ProposalOutcomeEvaluated(
            _proposalId,
            outcome,
            proposals[_proposalId].voteMagnitudeYes,
            proposals[_proposalId].voteMagnitudeNo,
            proposals[_proposalId].numVotes
        );

        return outcome;
    }

    /**
     * @notice Action limited to the guardian address that can veto a proposal
     * @param _proposalId - id of the proposal
     */
    function vetoProposal(uint256 _proposalId) external {
        _requireIsInitialized();

        require(
            msg.sender == guardianAddress,
            "Governance::vetoProposal: Only guardian can veto proposals."
        );

        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Governance::vetoProposal: Must provide valid non-zero _proposalId."
        );

        require(
            proposals[_proposalId].outcome == Outcome.InProgress,
            "Governance::vetoProposal: Cannot veto inactive proposal."
        );

        proposals[_proposalId].outcome = Outcome.No;

        emit ProposalVetoed(_proposalId);
    }

    // ========================================= Config Setters =========================================

    /**
     * @notice Set the Staking address
     * @dev Only callable by self via _executeTransaction
     * @param _stakingAddress - address for new Staking contract
     */
    function setStakingAddress(address _stakingAddress) external {
        require(msg.sender == address(this), "Only callable by self");
        require(_stakingAddress != address(0x00), "Requires non-zero _stakingAddress");
        stakingAddress = _stakingAddress;
    }

    /**
     * @notice Set the voting period for a Governance proposal
     * @dev Only callable by self via _executeTransaction
     * @param _votingPeriod - new voting period
     */
    function setVotingPeriod(uint256 _votingPeriod) external {
        require(msg.sender == address(this), "Only callable by self");
        votingPeriod = _votingPeriod;
    }

    /**
     * @notice Set the voting quorum for a Governance proposal
     * @dev Only callable by self via _executeTransaction
     * @param _votingQuorum - new voting period
     */
    function setVotingQuorum(uint256 _votingQuorum) external {
        require(msg.sender == address(this), "Only callable by self");
        votingQuorum = _votingQuorum;
    }

    /**
     * @notice Set the Registry address
     * @dev Only callable by self via _executeTransaction
     * @param _registryAddress - address for new Registry contract
     */
    function setRegistryAddress(address _registryAddress) external {
        require(msg.sender == address(this), "Only callable by self");
        require(_registryAddress != address(0x00), "Requires non-zero _registryAddress");
        registryAddress = _registryAddress;
        registry = Registry(_registryAddress);
    }

    // ========================================= Guardian Actions =========================================

    /**
     * @notice Allows the guardianAddress to execute protocol actions
     * @param _targetContractRegistryKey - key in registry of target contraact
     * @param _callValue - amount of wei if a token transfer is involved
     * @param _signature - function signature of the function to be executed if proposal is successful
     * @param _callData - encoded value(s) to call function with if proposal is successful
     */
    function guardianExecuteTransaction(
        bytes32 _targetContractRegistryKey,
        uint256 _callValue,
        string calldata _signature,
        bytes calldata _callData
    ) external
    {
        _requireIsInitialized();

        require(
            msg.sender == guardianAddress,
            "Governance::guardianExecuteTransaction: Only guardian."
        );

        // _targetContractRegistryKey must point to a valid registered contract
        address targetContractAddress = registry.getContract(_targetContractRegistryKey);
        require(
            targetContractAddress != address(0x00),
            "Governance::guardianExecuteTransaction: _targetContractRegistryKey must point to valid registered contract"
        );

        // Signature cannot be empty
        require(
            bytes(_signature).length != 0,
            "Governance::guardianExecuteTransaction: _signature cannot be empty."
        );

        (bool success, bytes memory returnData) = _executeTransaction(
            targetContractAddress,
            _callValue,
            _signature,
            _callData
        );

        require(success, "Governance::guardianExecuteTransaction: Transaction failed.");

      //  emit GuardianTransactionExecuted(
      //      targetContractAddress,
      //      _callValue,
      //      _signature,
      //      _callData,
     //       returnData
       // );
    }

    /**
     * @notice Change the guardian address
     * @dev Only callable by current guardian
     * @param _newGuardianAddress - new guardian address
     */
    function transferGuardianship(address _newGuardianAddress) external {
        _requireIsInitialized();

        require(
            msg.sender == guardianAddress,
            "Governance::guardianExecuteTransaction: Only guardian."
        );

        guardianAddress = _newGuardianAddress;
    }

    // ========================================= Getter Functions =========================================

    /**
     * @notice Get proposal information by proposal Id
     * @param _proposalId - id of proposal
     */
    function getProposalById(uint256 _proposalId)
    external view returns (
        uint256 proposalId,
        address proposer,
        uint256 startBlockNumber,
        bytes32 targetContractRegistryKey,
        address targetContractAddress,
        uint callValue,
        string memory signature,
        bytes memory callData,
        Outcome outcome,
        uint256 voteMagnitudeYes,
        uint256 voteMagnitudeNo,
        uint256 numVotes
    )
    {
        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Must provide valid non-zero _proposalId"
        );

        Proposal memory proposal = proposals[_proposalId];
        return (
            proposal.proposalId,
            proposal.proposer,
            proposal.startBlockNumber,
            proposal.targetContractRegistryKey,
            proposal.targetContractAddress,
            proposal.callValue,
            proposal.signature,
            proposal.callData,
            proposal.outcome,
            proposal.voteMagnitudeYes,
            proposal.voteMagnitudeNo,
            proposal.numVotes
            /** @notice - votes mapping cannot be returned by external function */
        );
    }

    /**
     * @notice Get how a voter voted for a given proposal
     * @param _proposalId - id of the proposal
     * @param _voter - address of the voter we want to check
     * @return returns a value from the Vote enum if a valid vote, otherwise returns no value
     */
    function getVoteByProposalAndVoter(uint256 _proposalId, address _voter)
    external view returns (Vote vote)
    {
        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Must provide valid non-zero _proposalId"
        );
        return proposals[_proposalId].votes[_voter];
    }

    /// @notice Get the contract Guardian address
    function getGuardianAddress() external view returns (address) {
        _requireIsInitialized();

        return guardianAddress;
    }

    /// @notice Get the Staking address
    function getStakingAddress() external view returns (address) {
        return stakingAddress;
    }

    /// @notice Get the contract voting period
    function getVotingPeriod() external view returns (uint) {
        _requireIsInitialized();

        return votingPeriod;
    }

    /// @notice Get the contract voting quorum
    function getVotingQuorum() external view returns (uint) {
        _requireIsInitialized();

        return votingQuorum;
    }

    /// @notice Get the registry address
    function getRegistryAddress() external view returns (address) {
        return registryAddress;
    }

    // ========================================= Internal Functions =========================================

    /**
     * @notice Execute a transaction attached to a governanace proposal
     * @dev We are aware of both potential re-entrancy issues and the risks associated with low-level solidity
     *      function calls here, but have chosen to keep this code with those issues in mind. All governance
     *      proposals go through a voting process, and all will be reviewed carefully to ensure that they
     *      adhere to the expected behaviors of this call - but adding restrictions here would limit the ability
     *      of the governance system to do required work in a generic way.
     * @param _targetContractAddress - address of registry proxy contract to execute transaction on
     * @param _callValue - amount of wei if a token transfer is involved
     * @param _signature - function signature of the function to be executed if proposal is successful
     * @param _callData - encoded value(s) to call function with if proposal is successful
     */
    function _executeTransaction(
        address _targetContractAddress,
        uint256 _callValue,
        string memory _signature,
        bytes memory _callData
    ) internal returns (bool /** success */, bytes memory /** returnData */)
    {
        bytes memory encodedCallData = abi.encodePacked(
            bytes4(keccak256(bytes(_signature))),
            _callData
        );
        (bool success, bytes memory returnData) = (
            // solium-disable-next-line security/no-call-value
            _targetContractAddress.call.value(_callValue)(encodedCallData)
        );

        return (success, returnData);
    }
}