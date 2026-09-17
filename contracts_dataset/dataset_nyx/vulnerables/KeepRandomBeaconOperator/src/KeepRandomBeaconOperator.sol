
// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/op2/contracts/math/SafeMath.sol

pragma solidity ^0.5.0;

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
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
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
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
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
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/op2/contracts/utils/ReentrancyGuard.sol

pragma solidity ^0.5.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 *
 * _Since v2.5.0:_ this module is now much more gas efficient, given net gas
 * metering changes introduced in the Istanbul hardfork.
 */
contract ReentrancyGuard {
    bool private _notEntered;

    constructor () internal {
        // Storing an initial non-zero value makes deployment a bit more
        // expensive, but in exchange the refund on every call to nonReentrant
        // will be lower in amount. Since refunds are capped to a percetange of
        // the total transaction's gas, it is best to keep them low in cases
        // like this one, to increase the likelihood of the full refund coming
        // into effect.
        _notEntered = true;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_notEntered, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _notEntered = false;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _notEntered = true;
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/op2/contracts/GSN/Context.sol

pragma solidity ^0.5.0;

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
contract Context {
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

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/op2/contracts/token/ERC20/IERC20.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {ERC20Detailed}.
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
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
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
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/op2/contracts/token/ERC20/ERC20.sol

pragma solidity ^0.5.0;




/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20Mintable}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for `sender`'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
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

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
     //   emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
    //    emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
    //    emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
     //   emit Approval(owner, spender, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     *
     * See {_burn} and {_approve}.
     */
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "ERC20: burn amount exceeds allowance"));
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/op2/contracts/token/ERC20/ERC20Burnable.sol

pragma solidity ^0.5.0;



/**
 * @dev Extension of {ERC20} that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */
contract ERC20Burnable is Context, ERC20 {
    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev See {ERC20-_burnFrom}.
     */
    function burnFrom(address account, uint256 amount) public {
        _burnFrom(account, amount);
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/op2/contracts/utils/Address.sol

pragma solidity ^0.5.5;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following 
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Converts an `address` into `address payable`. Note that this is
     * simply a type cast: the actual underlying value is not changed.
     *
     * _Available since v2.4.0._
     */
    function toPayable(address account) internal pure returns (address payable) {
        return address(uint160(account));
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     *
     * _Available since v2.4.0._
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-call-value
        (bool success, ) = recipient.call.value(amount)("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/op2/contracts/token/ERC20/SafeERC20.sol

pragma solidity ^0.5.0;




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
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
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

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/solidity-bytes-utils-0.0.7/contracts/BytesLib.sol

/*
 * @title Solidity Bytes Arrays Utils
 * @author Gonçalo Sá <goncalo.sa@consensys.net>
 *
 * @dev Bytes tightly packed arrays utility library for ethereum contracts written in Solidity.
 *      The library lets you concatenate, slice and type cast bytes arrays both in memory and storage.
 */

pragma solidity ^0.5.0;


library BytesLib {
    function concat(
        bytes memory _preBytes,
        bytes memory _postBytes
    )
        internal
        pure
        returns (bytes memory)
    {
        bytes memory tempBytes;

        assembly {
            // Get a location of some free memory and store it in tempBytes as
            // Solidity does for memory variables.
            tempBytes := mload(0x40)

            // Store the length of the first bytes array at the beginning of
            // the memory for tempBytes.
            let length := mload(_preBytes)
            mstore(tempBytes, length)

            // Maintain a memory counter for the current write location in the
            // temp bytes array by adding the 32 bytes for the array length to
            // the starting location.
            let mc := add(tempBytes, 0x20)
            // Stop copying when the memory counter reaches the length of the
            // first bytes array.
            let end := add(mc, length)

            for {
                // Initialize a copy counter to the start of the _preBytes data,
                // 32 bytes into its memory.
                let cc := add(_preBytes, 0x20)
            } lt(mc, end) {
                // Increase both counters by 32 bytes each iteration.
                mc := add(mc, 0x20)
                cc := add(cc, 0x20)
            } {
                // Write the _preBytes data into the tempBytes memory 32 bytes
                // at a time.
                mstore(mc, mload(cc))
            }

            // Add the length of _postBytes to the current length of tempBytes
            // and store it as the new length in the first 32 bytes of the
            // tempBytes memory.
            length := mload(_postBytes)
            mstore(tempBytes, add(length, mload(tempBytes)))

            // Move the memory counter back from a multiple of 0x20 to the
            // actual end of the _preBytes data.
            mc := end
            // Stop copying when the memory counter reaches the new combined
            // length of the arrays.
            end := add(mc, length)

            for {
                let cc := add(_postBytes, 0x20)
            } lt(mc, end) {
                mc := add(mc, 0x20)
                cc := add(cc, 0x20)
            } {
                mstore(mc, mload(cc))
            }

            // Update the free-memory pointer by padding our last write location
            // to 32 bytes: add 31 bytes to the end of tempBytes to move to the
            // next 32 byte block, then round down to the nearest multiple of
            // 32. If the sum of the length of the two arrays is zero then add 
            // one before rounding down to leave a blank 32 bytes (the length block with 0).
            mstore(0x40, and(
              add(add(end, iszero(add(length, mload(_preBytes)))), 31),
              not(31) // Round down to the nearest 32 bytes.
            ))
        }

        return tempBytes;
    }

    function concatStorage(bytes storage _preBytes, bytes memory _postBytes) internal {
        assembly {
            // Read the first 32 bytes of _preBytes storage, which is the length
            // of the array. (We don't need to use the offset into the slot
            // because arrays use the entire slot.)
            let fslot := sload(_preBytes_slot)
            // Arrays of 31 bytes or less have an even value in their slot,
            // while longer arrays have an odd value. The actual length is
            // the slot divided by two for odd values, and the lowest order
            // byte divided by two for even values.
            // If the slot is even, bitwise and the slot with 255 and divide by
            // two to get the length. If the slot is odd, bitwise and the slot
            // with -1 and divide by two.
            let slength := div(and(fslot, sub(mul(0x100, iszero(and(fslot, 1))), 1)), 2)
            let mlength := mload(_postBytes)
            let newlength := add(slength, mlength)
            // slength can contain both the length and contents of the array
            // if length < 32 bytes so let's prepare for that
            // v. http://solidity.readthedocs.io/en/latest/miscellaneous.html#layout-of-state-variables-in-storage
            switch add(lt(slength, 32), lt(newlength, 32))
            case 2 {
                // Since the new array still fits in the slot, we just need to
                // update the contents of the slot.
                // uint256(bytes_storage) = uint256(bytes_storage) + uint256(bytes_memory) + new_length
                sstore(
                    _preBytes_slot,
                    // all the modifications to the slot are inside this
                    // next block
                    add(
                        // we can just add to the slot contents because the
                        // bytes we want to change are the LSBs
                        fslot,
                        add(
                            mul(
                                div(
                                    // load the bytes from memory
                                    mload(add(_postBytes, 0x20)),
                                    // zero all bytes to the right
                                    exp(0x100, sub(32, mlength))
                                ),
                                // and now shift left the number of bytes to
                                // leave space for the length in the slot
                                exp(0x100, sub(32, newlength))
                            ),
                            // increase length by the double of the memory
                            // bytes length
                            mul(mlength, 2)
                        )
                    )
                )
            }
            case 1 {
                // The stored value fits in the slot, but the combined value
                // will exceed it.
                // get the keccak hash to get the contents of the array
                mstore(0x0, _preBytes_slot)
                let sc := add(keccak256(0x0, 0x20), div(slength, 32))

                // save new length
                sstore(_preBytes_slot, add(mul(newlength, 2), 1))

                // The contents of the _postBytes array start 32 bytes into
                // the structure. Our first read should obtain the `submod`
                // bytes that can fit into the unused space in the last word
                // of the stored array. To get this, we read 32 bytes starting
                // from `submod`, so the data we read overlaps with the array
                // contents by `submod` bytes. Masking the lowest-order
                // `submod` bytes allows us to add that value directly to the
                // stored value.

                let submod := sub(32, slength)
                let mc := add(_postBytes, submod)
                let end := add(_postBytes, mlength)
                let mask := sub(exp(0x100, submod), 1)

                sstore(
                    sc,
                    add(
                        and(
                            fslot,
                            0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00
                        ),
                        and(mload(mc), mask)
                    )
                )

                for {
                    mc := add(mc, 0x20)
                    sc := add(sc, 1)
                } lt(mc, end) {
                    sc := add(sc, 1)
                    mc := add(mc, 0x20)
                } {
                    sstore(sc, mload(mc))
                }

                mask := exp(0x100, sub(mc, end))

                sstore(sc, mul(div(mload(mc), mask), mask))
            }
            default {
                // get the keccak hash to get the contents of the array
                mstore(0x0, _preBytes_slot)
                // Start copying to the last used word of the stored array.
                let sc := add(keccak256(0x0, 0x20), div(slength, 32))

                // save new length
                sstore(_preBytes_slot, add(mul(newlength, 2), 1))

                // Copy over the first `submod` bytes of the new data as in
                // case 1 above.
                let slengthmod := mod(slength, 32)
                let mlengthmod := mod(mlength, 32)
                let submod := sub(32, slengthmod)
                let mc := add(_postBytes, submod)
                let end := add(_postBytes, mlength)
                let mask := sub(exp(0x100, submod), 1)

                sstore(sc, add(sload(sc), and(mload(mc), mask)))
                
                for { 
                    sc := add(sc, 1)
                    mc := add(mc, 0x20)
                } lt(mc, end) {
                    sc := add(sc, 1)
                    mc := add(mc, 0x20)
                } {
                    sstore(sc, mload(mc))
                }

                mask := exp(0x100, sub(mc, end))

                sstore(sc, mul(div(mload(mc), mask), mask))
            }
        }
    }

    function slice(
        bytes memory _bytes,
        uint _start,
        uint _length
    )
        internal
        pure
        returns (bytes memory)
    {
        require(_bytes.length >= (_start + _length));

        bytes memory tempBytes;

        assembly {
            switch iszero(_length)
            case 0 {
                // Get a location of some free memory and store it in tempBytes as
                // Solidity does for memory variables.
                tempBytes := mload(0x40)

                // The first word of the slice result is potentially a partial
                // word read from the original array. To read it, we calculate
                // the length of that partial word and start copying that many
                // bytes into the array. The first word we copy will start with
                // data we don't care about, but the last `lengthmod` bytes will
                // land at the beginning of the contents of the new array. When
                // we're done copying, we overwrite the full first word with
                // the actual length of the slice.
                let lengthmod := and(_length, 31)

                // The multiplication in the next line is necessary
                // because when slicing multiples of 32 bytes (lengthmod == 0)
                // the following copy loop was copying the origin's length
                // and then ending prematurely not copying everything it should.
                let mc := add(add(tempBytes, lengthmod), mul(0x20, iszero(lengthmod)))
                let end := add(mc, _length)

                for {
                    // The multiplication in the next line has the same exact purpose
                    // as the one above.
                    let cc := add(add(add(_bytes, lengthmod), mul(0x20, iszero(lengthmod))), _start)
                } lt(mc, end) {
                    mc := add(mc, 0x20)
                    cc := add(cc, 0x20)
                } {
                    mstore(mc, mload(cc))
                }

                mstore(tempBytes, _length)

                //update free-memory pointer
                //allocating the array padded to 32 bytes like the compiler does now
                mstore(0x40, and(add(mc, 31), not(31)))
            }
            //if we want a zero-length slice let's just return a zero-length array
            default {
                tempBytes := mload(0x40)

                mstore(0x40, add(tempBytes, 0x20))
            }
        }

        return tempBytes;
    }

    function toAddress(bytes memory _bytes, uint _start) internal  pure returns (address) {
        require(_bytes.length >= (_start + 20));
        address tempAddress;

        assembly {
            tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
        }

        return tempAddress;
    }

    function toUint8(bytes memory _bytes, uint _start) internal  pure returns (uint8) {
        require(_bytes.length >= (_start + 1));
        uint8 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x1), _start))
        }

        return tempUint;
    }

    function toUint16(bytes memory _bytes, uint _start) internal  pure returns (uint16) {
        require(_bytes.length >= (_start + 2));
        uint16 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x2), _start))
        }

        return tempUint;
    }

    function toUint32(bytes memory _bytes, uint _start) internal  pure returns (uint32) {
        require(_bytes.length >= (_start + 4));
        uint32 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x4), _start))
        }

        return tempUint;
    }

    function toUint(bytes memory _bytes, uint _start) internal  pure returns (uint256) {
        require(_bytes.length >= (_start + 32));
        uint256 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x20), _start))
        }

        return tempUint;
    }

    function toBytes32(bytes memory _bytes, uint _start) internal  pure returns (bytes32) {
        require(_bytes.length >= (_start + 32));
        bytes32 tempBytes32;

        assembly {
            tempBytes32 := mload(add(add(_bytes, 0x20), _start))
        }

        return tempBytes32;
    }

    function equal(bytes memory _preBytes, bytes memory _postBytes) internal pure returns (bool) {
        bool success = true;

        assembly {
            let length := mload(_preBytes)

            // if lengths don't match the arrays are not equal
            switch eq(length, mload(_postBytes))
            case 1 {
                // cb is a circuit breaker in the for loop since there's
                //  no said feature for inline assembly loops
                // cb = 1 - don't breaker
                // cb = 0 - break
                let cb := 1

                let mc := add(_preBytes, 0x20)
                let end := add(mc, length)

                for {
                    let cc := add(_postBytes, 0x20)
                // the next line is the loop condition:
                // while(uint(mc < end) + cb == 2)
                } eq(add(lt(mc, end), cb), 2) {
                    mc := add(mc, 0x20)
                    cc := add(cc, 0x20)
                } {
                    // if any of these checks fails then arrays are not equal
                    if iszero(eq(mload(mc), mload(cc))) {
                        // unsuccess:
                        success := 0
                        cb := 0
                    }
                }
            }
            default {
                // unsuccess:
                success := 0
            }
        }

        return success;
    }

    function equalStorage(
        bytes storage _preBytes,
        bytes memory _postBytes
    )
        internal
        view
        returns (bool)
    {
        bool success = true;

        assembly {
            // we know _preBytes_offset is 0
            let fslot := sload(_preBytes_slot)
            // Decode the length of the stored array like in concatStorage().
            let slength := div(and(fslot, sub(mul(0x100, iszero(and(fslot, 1))), 1)), 2)
            let mlength := mload(_postBytes)

            // if lengths don't match the arrays are not equal
            switch eq(slength, mlength)
            case 1 {
                // slength can contain both the length and contents of the array
                // if length < 32 bytes so let's prepare for that
                // v. http://solidity.readthedocs.io/en/latest/miscellaneous.html#layout-of-state-variables-in-storage
                if iszero(iszero(slength)) {
                    switch lt(slength, 32)
                    case 1 {
                        // blank the last byte which is the length
                        fslot := mul(div(fslot, 0x100), 0x100)

                        if iszero(eq(fslot, mload(add(_postBytes, 0x20)))) {
                            // unsuccess:
                            success := 0
                        }
                    }
                    default {
                        // cb is a circuit breaker in the for loop since there's
                        //  no said feature for inline assembly loops
                        // cb = 1 - don't breaker
                        // cb = 0 - break
                        let cb := 1

                        // get the keccak hash to get the contents of the array
                        mstore(0x0, _preBytes_slot)
                        let sc := keccak256(0x0, 0x20)

                        let mc := add(_postBytes, 0x20)
                        let end := add(mc, mlength)

                        // the next line is the loop condition:
                        // while(uint(mc < end) + cb == 2)
                        for {} eq(add(lt(mc, end), cb), 2) {
                            sc := add(sc, 1)
                            mc := add(mc, 0x20)
                        } {
                            if iszero(eq(sload(sc), mload(mc))) {
                                // unsuccess:
                                success := 0
                                cb := 0
                            }
                        }
                    }
                }
            }
            default {
                // unsuccess:
                success := 0
            }
        }

        return success;
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/utils/AddressArrayUtils.sol

pragma solidity ^0.5.4;


library AddressArrayUtils {

    function contains(address[] memory self, address _address)
        internal
        pure
        returns (bool)
    {
        for (uint i = 0; i < self.length; i++) {
            if (_address == self[i]) {
                return true;
            }
        }
        return false;
    }

    function removeAddress(address[] storage self, address _addressToRemove)
        internal
        returns (address[] storage)
    {
        for (uint i = 0; i < self.length; i++) {
            // If address is found in array.
            if (_addressToRemove == self[i]) {
                // Delete element at index and shift array.
                for (uint j = i; j < self.length-1; j++) {
                    self[j] = self[j+1];
                }
                self.length--;
                i--;
            }
        }
        return self;
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/StakeDelegatable.sol

pragma solidity ^0.5.4;







/**
 * @title Stake Delegatable
 * @dev A base contract to allow stake delegation for staking contracts.
 */
contract StakeDelegatable {
    using SafeMath for uint256;
    using SafeERC20 for ERC20Burnable;
    using BytesLib for bytes;
    using AddressArrayUtils for address[];

    ERC20Burnable public token;

    uint256 public initializationPeriod;
    uint256 public undelegationPeriod;

    // List of operators for the stake owner.
    mapping(address => address[]) public ownerOperators;

    struct Operator {
        uint256 amount;
        uint256 createdAt;
        uint256 undelegatedAt;
        address owner;
        address payable beneficiary;
        address authorizer;
    }

    mapping(address => Operator) public operators;

    modifier onlyOperatorAuthorizer(address _operator) {
        require(
            operators[_operator].authorizer == msg.sender,
            "Not operator authorizer"
        );
        _;
    }

    /**
     * @dev Gets the stake balance of the specified address.
     * @param _address The address to query the balance of.
     * @return An uint256 representing the amount staked by the passed address.
     */
    function balanceOf(address _address) public view returns (uint256 balance) {
        return operators[_address].amount;
    }

    /**
     * @dev Gets the list of operators of the specified address.
     * @return An array of addresses.
     */
    function operatorsOf(address _address) public view returns (address[] memory) {
        return ownerOperators[_address];
    }

    /**
     * @dev Gets the stake owner for the specified operator address.
     * @return Stake owner address.
     */
    function ownerOf(address _operator) public view returns (address) {
        return operators[_operator].owner;
    }

    /**
     * @dev Gets the magpie for the specified operator address.
     * @return Magpie address.
     */
    function magpieOf(address _operator) public view returns (address payable) {
        return operators[_operator].beneficiary;
    }

    /**
     * @dev Gets the authorizer for the specified operator address.
     * @return Authorizer address.
     */
    function authorizerOf(address _operator) public view returns (address) {
        return operators[_operator].authorizer;
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/utils/UintArrayUtils.sol

pragma solidity ^0.5.4;


library UintArrayUtils {

    function removeValue(uint256[] storage self, uint256 _value) 
        internal
        returns(uint256[] storage)
    {
        for (uint i = 0; i < self.length; i++) {
            // If value is found in array.
            if (_value == self[i]) {
                // Delete element at index and shift array.
                for (uint j = i; j < self.length-1; j++) {
                    self[j] = self[j+1];
                }
                self.length--;
                i--;
            }
        }
        return self;
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/Registry.sol

pragma solidity ^0.5.4;


/**
 * @title Registry
 * @dev Governance owned registry of approved contracts and roles.
 */
contract Registry {
    // Governance role is to enable recovery from key compromise by rekeying other roles.
    address internal governance;

    // Registry Keeper maintains approved operator contracts. Each operator
    // contract must be approved before it can be authorized by a staker or
    // used by a service contract.
    address internal registryKeeper;

    // The Panic Button can disable malicious or malfunctioning contracts
    // that have been previously approved by the Registry Keeper.
    address internal panicButton;

    // Each service contract has a Operator Contract Upgrader whose purpose
    // is to manage operator contracts for that specific service contract.
    // The Operator Contract Upgrader can add new operator contracts to the
    // service contract’s operator contract list, and deprecate old ones.
    mapping(address => address) public operatorContractUpgraders;

    // The registry of operator contracts
    // 0 - NULL (default), 1 - APPROVED, 2 - DISABLED
    mapping(address => uint256) public operatorContracts;

    modifier onlyGovernance() {
        require(governance == msg.sender, "Not authorized");
        _;
    }

    modifier onlyRegistryKeeper() {
        require(registryKeeper == msg.sender, "Not authorized");
        _;
    }

    modifier onlyPanicButton() {
        require(panicButton == msg.sender, "Not authorized");
        _;
    }

    constructor() public {
        governance = msg.sender;
        registryKeeper = msg.sender;
        panicButton = msg.sender;
    }

    function setGovernance(address _governance) public onlyGovernance {
        governance = _governance;
    }

    function setRegistryKeeper(address _registryKeeper) public onlyGovernance {
        registryKeeper = _registryKeeper;
    }

    function setPanicButton(address _panicButton) public onlyGovernance {
        panicButton = _panicButton;
    }

    function setOperatorContractUpgrader(address _serviceContract, address _operatorContractUpgrader) public onlyGovernance {
        operatorContractUpgraders[_serviceContract] = _operatorContractUpgrader;
    }

    function approveOperatorContract(address operatorContract) public onlyRegistryKeeper {
        operatorContracts[operatorContract] = 1;
    }

    function disableOperatorContract(address operatorContract) public onlyPanicButton {
        operatorContracts[operatorContract] = 2;
    }

    function isApprovedOperatorContract(address operatorContract) public view returns (bool) {
        return operatorContracts[operatorContract] == 1;
    }

    function operatorContractUpgraderFor(address _serviceContract) public view returns (address) {
        return operatorContractUpgraders[_serviceContract];
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/TokenStaking.sol

pragma solidity ^0.5.4;





/**
 * @title TokenStaking
 * @dev A token staking contract for a specified standard ERC20Burnable token.
 * A holder of the specified token can stake delegate its tokens to this contract
 * and recover the stake after undelegation period is over.
 */
contract TokenStaking is StakeDelegatable {

    using UintArrayUtils for uint256[];

    event Staked(address indexed from, uint256 value);
    event Undelegated(address indexed operator, uint256 undelegatedAt);
    event RecoveredStake(address operator, uint256 recoveredAt);

    // Registry contract with a list of approved operator contracts and upgraders.
    Registry public registry;

    // Authorized operator contracts.
    mapping(address => mapping (address => bool)) internal authorizations;

    modifier onlyApprovedOperatorContract(address operatorContract) {
        require(
            registry.isApprovedOperatorContract(operatorContract),
            "Operator contract is not approved"
        );
        _;
    }

    /**
     * @dev Creates a token staking contract for a provided Standard ERC20Burnable token.
     * @param _tokenAddress Address of a token that will be linked to this contract.
     * @param _registry Address of a keep registry that will be linked to this contract.
     * @param _initializationPeriod To avoid certain attacks on work selection, recently created
     * operators must wait for a specific period of time before being eligible for work selection.
     * @param _undelegationPeriod The staking contract guarantees that an undelegated operator’s
     * stakes will stay locked for a number of blocks after undelegation, and thus available as
     * collateral for any work the operator is engaged in.
     */
    constructor(address _tokenAddress, address _registry, uint256 _initializationPeriod, uint256 _undelegationPeriod) public {
        require(_tokenAddress != address(0x0), "Token address can't be zero.");
        token = ERC20Burnable(_tokenAddress);
        registry = Registry(_registry);
        initializationPeriod = _initializationPeriod;
        undelegationPeriod = _undelegationPeriod;
    }

    /**
     * @notice Receives approval of token transfer and stakes the approved amount.
     * @dev Makes sure provided token contract is the same one linked to this contract.
     * @param _from The owner of the tokens who approved them to transfer.
     * @param _value Approved amount for the transfer and stake.
     * @param _token Token contract address.
     * @param _extraData Data for stake delegation. This byte array must have the
     * following values concatenated: Magpie address (20 bytes) where the rewards for participation
     * are sent, operator's (20 bytes) address, authorizer (20 bytes) address.
     */
    function receiveApproval(address _from, uint256 _value, address _token, bytes memory _extraData) public {
        require(ERC20Burnable(_token) == token, "Token contract must be the same one linked to this contract.");
        require(_value <= token.balanceOf(_from), "Sender must have enough tokens.");
        require(_extraData.length == 60, "Stake delegation data must be provided.");

        address payable magpie = address(uint160(_extraData.toAddress(0)));
        address operator = _extraData.toAddress(20);
        require(operators[operator].owner == address(0), "Operator address is already in use.");
        address authorizer = _extraData.toAddress(40);

        // Transfer tokens to this contract.
        token.transferFrom(_from, address(this), _value);

        operators[operator] = Operator(_value, block.number, 0, _from, magpie, authorizer);
        ownerOperators[_from].push(operator);

     //   emit Staked(operator, _value);
    }

    /**
     * @notice Cancels stake of tokens within the operator initialization period
     * without being subjected to the token lockup for the undelegation period.
     * This can be used to undo mistaken delegation to the wrong operator address.
     * @param _operator Address of the stake operator.
     */
    function cancelStake(address _operator) public {
        address owner = operators[_operator].owner;
        require(
            msg.sender == _operator ||
            msg.sender == owner, "Only operator or the owner of the stake can cancel the delegation."
        );

        require(
            block.number <= operators[_operator].createdAt.add(initializationPeriod),
            "Initialization period is over"
        );

        uint256 amount = operators[_operator].amount;
        delete operators[_operator];
        token.safeTransfer(owner, amount);
    }

    /**
     * @notice Undelegates staked tokens. You will be able to recover your stake by calling
     * `recoverStake()` with operator address once undelegation period is over.
     * @param _operator Address of the stake operator.
     */
    function undelegate(address _operator) public {
        address owner = operators[_operator].owner;
        require(
            msg.sender == _operator ||
            msg.sender == owner, "Only operator or the owner of the stake can undelegate."
        );
        operators[_operator].undelegatedAt = block.number;
    //    emit Undelegated(_operator, block.number);
    }

    /**
     * @notice Recovers staked tokens and transfers them back to the owner. Recovering
     * tokens can only be performed when the operator is finished undelegating.
     * @param _operator Operator address.
     */
    function recoverStake(address _operator) public {
        require(
            block.number >= operators[_operator].undelegatedAt.add(undelegationPeriod),
            "Can not recover stake before undelegation period is over."
        );
        address owner = operators[_operator].owner;
        uint256 amount = operators[_operator].amount;
        delete operators[_operator];

        token.safeTransfer(owner, amount);
    //   emit RecoveredStake(_operator, block.number);
    }

    /**
     * @dev Gets undelegate request by Operator.
     * @param _operator Operator address.
     * @return amount The amount the given operator will be able to recover
     * once undelegation period has passed.
     * @return undelegatedAt The time of undelegate request used to determine
     * when the undelegation period has passed.
     */
    function getUndelegation(address _operator) public view returns (uint256 amount, uint256 undelegatedAt) {
        return (operators[_operator].amount, operators[_operator].undelegatedAt);
    }

    /**
     * @dev Slash provided token amount from every member in the misbehaved
     * operators array and burn 100% of all the tokens.
     * @param amount Token amount to slash from every misbehaved operator.
     * @param misbehavedOperators Array of addresses to seize the tokens from.
     */
    function slash(uint256 amount, address[] memory misbehavedOperators) 
        public
        onlyApprovedOperatorContract(msg.sender) {
        for (uint i = 0; i < misbehavedOperators.length; i++) {
            address operator = misbehavedOperators[i];
            require(authorizations[msg.sender][operator], "Not authorized");
            operators[operator].amount = operators[operator].amount.sub(amount);
        }

        token.burn(misbehavedOperators.length.mul(amount));
    }

    /**
     * @dev Seize provided token amount from every member in the misbehaved
     * operators array. The tattletale is rewarded with 5% of the total seized
     * amount scaled by the reward adjustment parameter and the rest 95% is burned.
     * @param amount Token amount to seize from every misbehaved operator.
     * @param rewardMultiplier Reward adjustment in percentage. Min 1% and 100% max.
     * @param tattletale Address to receive the 5% reward.
     * @param misbehavedOperators Array of addresses to seize the tokens from.
     */
    function seize(
        uint256 amount,
        uint256 rewardMultiplier,
        address tattletale,
        address[] memory misbehavedOperators
    ) public onlyApprovedOperatorContract(msg.sender) {
        for (uint i = 0; i < misbehavedOperators.length; i++) {
            address operator = misbehavedOperators[i];
            require(authorizations[msg.sender][operator], "Not authorized");
            operators[operator].amount = operators[operator].amount.sub(amount);
        }

        uint256 total = misbehavedOperators.length.mul(amount);
        uint256 tattletaleReward = (total.mul(5).div(100)).mul(rewardMultiplier).div(100);

        token.transfer(tattletale, tattletaleReward);
        token.burn(total.sub(tattletaleReward));
    }

    /**
     * @dev Authorizes operator contract to access staked token balance of
     * the provided operator. Can only be executed by stake operator authorizer.
     * @param _operator address of stake operator.
     * @param _operatorContract address of operator contract.
     */
    function authorizeOperatorContract(address _operator, address _operatorContract)
        public
        onlyOperatorAuthorizer(_operator)
        onlyApprovedOperatorContract(_operatorContract) {
        authorizations[_operatorContract][_operator] = true;
    }

    /**
     * @dev Gets the eligible stake balance of the specified address.
     * An eligible stake is a stake that passed the initialization period
     * and is not currently undelegating. Also, the operator had to approve
     * the specified operator contract.
     *
     * Operator with a minimum required amount of eligible stake can join the
     * network and participate in new work selection.
     *
     * @param _operator address of stake operator.
     * @param _operatorContract address of operator contract.
     * @return an uint256 representing the eligible stake balance.
     */
    function eligibleStake(
        address _operator,
        address _operatorContract
    ) public view returns (uint256 balance) {
        bool isAuthorized = authorizations[_operatorContract][_operator];

        Operator memory operator = operators[_operator];

        bool isActive = block.number >= operator.createdAt.add(initializationPeriod);
        bool notUndelegated = block.number <= operator.undelegatedAt || operator.undelegatedAt == 0;

        if (isAuthorized && isActive && notUndelegated) {
            balance = operator.amount;
        }
    }

    /**
     * @dev Gets the active stake balance of the specified address.
     * An active stake is a stake that passed the initialization period.
     * Also, the operator had to approve the specified operator contract.
     *
     * The difference between eligible stake is that active stake does not make
     * the operator eligible for work selection but it may be still finishing
     * earlier work during undelegation period. Operator with a minimum required
     * amount of active stake can join the network but cannot be selected to any
     * new work.
     *
     * @param _operator address of stake operator.
     * @param _operatorContract address of operator contract.
     * @return an uint256 representing the eligible stake balance.
     */
    function activeStake(
        address _operator,
        address _operatorContract
    ) public view returns (uint256 balance) {
        bool isAuthorized = authorizations[_operatorContract][_operator];

        Operator memory operator = operators[_operator];

        bool isActive = block.number >= operator.createdAt.add(initializationPeriod);

        if (isAuthorized && isActive) {
            balance = operator.amount;
        }
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/utils/ModUtils.sol

pragma solidity ^0.5.4;


library ModUtils {

    /**
     * @dev Wrap the modular exponent pre-compile introduced in Byzantium.
     * Returns base^exponent mod p.
     */
    function modExp(uint256 base, uint256 exponent, uint256 p)
        internal
        view returns(uint256)
    {
        uint256[1] memory output;
        /* solium-disable-next-line */
        assembly {
            // Args for the precompile: [<length_of_BASE> <length_of_EXPONENT>
            // <length_of_MODULUS> <BASE> <EXPONENT> <MODULUS>]
            let args := mload(0x40)
            mstore(args, 0x20)
            mstore(add(args, 0x20), 0x20)
            mstore(add(args, 0x40), 0x20)
            mstore(add(args, 0x60), base)
            mstore(add(args, 0x80), exponent)
            mstore(add(args, 0xa0), p)

            // 0x05 is the modular exponent contract address
            if iszero(staticcall(not(0), 0x05, args, 0xc0, output, 0x20)) {
                revert(0, 0)
            }
        }
        return output[0];
    }

    /**
     * @dev Calculates and returns the square root of a mod p,
     * or 0 if there is no such root.
     */
    function modSqrt(uint256 a, uint256 p)
        internal
        view returns(uint256)
    {

        if (legendre(a, p) != 1) {
            return 0;
        }

        if (a == 0) {
            return 0;
        }

        if (p == 2) {
            return p;
        }

        if (p % 4 == 3) {
            return modExp(a, (p + 1) / 4, p);
        }

        uint256 s = p - 1;
        uint8 e = 0;

        while (s % 2 == 0) {
            s = s / 2;
            e = e + 1;
        }

        // Note the smaller int- finding n with Legendre symbol or -1
        // should be quick
        uint32 n = 2;
        while (legendre(n, p) != -1) {
            n = n + 1;
        }

        uint256 x = modExp(a, (s + 1) / 2, p);
        uint256 b = modExp(a, s, p);
        uint256 g = modExp(n, s, p);
        uint8 r = e;
        uint256 gs = 0;
        uint8 m = 0;
        uint256 t = b;

        while (true) {
            t = b;
            m = 0;

            for (m = 0; m < r; m++) {
                if (t == 1) {
                    break;
                }
                t = modExp(t, 2, p);
            }

            if (m == 0) {
                return x;
            }

            gs = modExp(g, uint256(2) ** (r - m - 1), p);
            g = (gs * gs) % p;
            x = (x * gs) % p;
            b = (b * g) % p;
            r = m;
        }
    }

    /**
     * @dev Calculates the Legendre symbol of the given a mod p.
     * @return Returns 1 if a is a quadratic residue mod p, -1 if it is
     * a non-quadratic residue, and 0 if a is 0.
     */
    function legendre(uint256 a, uint256 p)
        internal
        view returns(int8)
    {
        uint256 raised = modExp(a, (p - 1) / uint256(2), p);

        if (raised == 0 || raised == 1) {
            return int8(raised);
        } else if (raised == p - 1) {
            return -1;
        }

        require(false, "Failed to calculate legendre.");
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/cryptography/AltBn128.sol

pragma solidity ^0.5.4;


/**
 * @title Operations on alt_bn128
 * @dev Implementations of common elliptic curve operations on Ethereum's
 * (poorly named) alt_bn128 curve. Whenever possible, use post-Byzantium
 * pre-compiled contracts to offset gas costs. Note that these pre-compiles
 * might not be available on all (eg private) chains.
 */
library AltBn128 {

    using ModUtils for uint256;

    // G1Point implements a point in G1 group.
    struct G1Point {
        uint256 x;
        uint256 y;
    }

    // gfP2 implements a field of size p² as a quadratic extension of the base field.
    struct gfP2 {
        uint256 x;
        uint256 y;
    }

    // G2Point implements a point in G2 group.
    struct G2Point {
        gfP2 x;
        gfP2 y;
    }

    // p is a prime over which we form a basic field
    // Taken from go-ethereum/crypto/bn256/cloudflare/constants.go
    uint256 constant p = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    function getP() internal pure returns (uint256) {
        return p;
    }

    /**
     * @dev Gets generator of G1 group.
     * Taken from go-ethereum/crypto/bn256/cloudflare/curve.go
     */
    function g1() internal pure returns (G1Point memory) {
        return G1Point(uint256(1), uint256(2));
    }

    /**
     * @dev Gets generator of G2 group.
     * Taken from go-ethereum/crypto/bn256/cloudflare/twist.go
     */
    function g2() internal pure returns (G2Point memory) {
        return G2Point(
            gfP2(
                11559732032986387107991004021392285783925812861821192530917403151452391805634,
                10857046999023057135944570762232829481370756359578518086990519993285655852781
            ),
            gfP2(
                4082367875863433681332203403145435568316851327593401208105741076214120093531,
                8495653923123431417604973247489272438418190587263600148770280649306958101930
            )
        );
    }

    /**
     * @dev Gets twist curve B constant.
     * Taken from go-ethereum/crypto/bn256/cloudflare/twist.go
     */
    function twistB() private pure returns (gfP2 memory) {
        return gfP2(
            266929791119991161246907387137283842545076965332900288569378510910307636690,
            19485874751759354771024239261021720505790618469301721065564631296452457478373
        );
    }

    /**
     * @dev Gets root of the point where x and y are equal.
     */
    function hexRoot() private pure returns (gfP2 memory) {
        return gfP2(
            21573744529824266246521972077326577680729363968861965890554801909984373949499,
            16854739155576650954933913186877292401521110422362946064090026408937773542853
        );
    }

    /**
     * @dev g1YFromX computes a Y value for a G1 point based on an X value.
     * This computation is simply evaluating the curve equation for Y on a
     * given X, and allows a point on the curve to be represented by just
     * an X value + a sign bit.
     */
    function g1YFromX(uint256 x)
        internal
        view returns(uint256)
    {
        return ((x.modExp(3, p) + 3) % p).modSqrt(p);
    }

    /**
     * @dev g2YFromX computes a Y value for a G2 point based on an X value.
     * This computation is simply evaluating the curve equation for Y on a
     * given X, and allows a point on the curve to be represented by just
     * an X value + a sign bit.
     */
    function g2YFromX(gfP2 memory _x)
        internal
        pure returns(gfP2 memory y)
    {
        gfP2 memory x = gfP2Add(gfP2Pow(_x, 3), twistB());

        // Using formula y = x ^ (p^2 + 15) / 32 from
        // https://github.com/ethereum/beacon_chain/blob/master/beacon_chain/utils/bls.py
        // (p^2 + 15) / 32 results into a big 512bit value, so breaking it to two uint256 as (a * a + b)
        uint256 a = 3869331240733915743250440106392954448556483137451914450067252501901456824595;
        uint256 b = 146360017852723390495514512480590656176144969185739259173561346299185050597;
  
        y = gfP2Multiply(gfP2Pow(gfP2Pow(x, a), a), gfP2Pow(x, b));
        
        // Multiply y by hexRoot constant to find correct y.
        while (!g2X2y(x, y)) {
            y = gfP2Multiply(y, hexRoot());
        }
    }

    /**
     * @dev Hash a byte array message, m, and map it deterministically to a
     * point on G1. Note that this approach was chosen for its simplicity /
     * lower gas cost on the EVM, rather than good distribution of points on
     * G1.
     */
    function g1HashToPoint(bytes memory m)
        internal
        view returns(G1Point memory)
    {
        bytes32 h = sha256(m);
        uint256 x = uint256(h) % p;
        uint256 y;

        while (true) {
            y = g1YFromX(x);
            if (y > 0) {
                return G1Point(x, y);
            }
            x += 1;
        }
    }

    /**
     * @dev Calculates whether the provided number is even or odd.
     * @return 0x01 if y is an even number and 0x00 if it's odd.
     */
    function parity(uint256 value) private pure returns (byte) {
        return bytes32(value)[31] & 0x01;
    }

    /**
     * @dev Compress a point on G1 to a single uint256 for serialization.
     */
    function g1Compress(G1Point memory point)
        internal
        pure returns(bytes32)
    {
        bytes32 m = bytes32(point.x);

        byte leadM = m[0] | parity(point.y) << 7;
        uint256 mask = 0xff << 31*8;
        m = (m & ~bytes32(mask)) | (leadM >> 0);

        return m;
    }

    /**
     * @dev Compress a point on G2 to a pair of uint256 for serialization.
     */
    function g2Compress(G2Point memory point)
        internal
        pure returns(bytes memory)
    {
        bytes32 m = bytes32(point.x.x);

        byte leadM = m[0] | parity(point.y.x) << 7;
        uint256 mask = 0xff << 31*8;
        m = (m & ~bytes32(mask)) | (leadM >> 0);

        return abi.encodePacked(m, bytes32(point.x.y));
    }

    /**
     * @dev Decompress a point on G1 from a single uint256.
     */
    function g1Decompress(bytes32 m)
        internal
        view returns(G1Point memory)
    {
        bytes32 mX = bytes32(0);
        byte leadX = m[0] & 0x7f;
        uint256 mask = 0xff << 31*8;
        mX = (m & ~bytes32(mask)) | (leadX >> 0);

        uint256 x = uint256(mX);
        uint256 y = g1YFromX(x);

        if (parity(y) != (m[0] & 0x80) >> 7) {
            y = p - y;
        }

        require(isG1PointOnCurve(G1Point(x, y)), "Malformed bn256.G1 point.");

        return G1Point(x, y);
    }

    /**
     * @dev Unmarshals a point on G1 from bytes in an uncompressed form.
     */
    function g1Unmarshal(bytes memory m) internal pure returns(G1Point memory) {
        bytes32 x;
        bytes32 y;

        /* solium-disable-next-line */
        assembly {
            x := mload(add(m, 0x20))
            y := mload(add(m, 0x40))
        }

        return G1Point(uint256(x), uint256(y));
    }

    /**
     * @dev Unmarshals a point on G2 from bytes in an uncompressed form.
     */
    function g2Unmarshal(bytes memory m) internal pure returns(G2Point memory) {
        bytes32 xx;
        bytes32 xy;
        bytes32 yx;
        bytes32 yy;

        /* solium-disable-next-line */
        assembly {
            xx := mload(add(m, 0x20))
            xy := mload(add(m, 0x40))
            yx := mload(add(m, 0x60))
            yy := mload(add(m, 0x80))
        }

        return G2Point(gfP2(uint256(xx), uint256(xy)), gfP2(uint256(yx),uint256(yy)));
    }

    /**
     * @dev Decompress a point on G2 from a pair of uint256.
     */
    function g2Decompress(bytes memory m)
        internal
        pure returns(G2Point memory)
    {
        bytes32 x1;
        bytes32 x2;
        uint256 temp;

        // Extract two bytes32 from bytes array
        /* solium-disable-next-line */
        assembly {
            temp := add(m, 32)
            x1 := mload(temp)
            temp := add(m, 64)
            x2 := mload(temp)
        }

        bytes32 mX = bytes32(0);
        byte leadX = x1[0] & 0x7f;
        uint256 mask = 0xff << 31*8;
        mX = (x1 & ~bytes32(mask)) | (leadX >> 0);

        gfP2 memory x = gfP2(uint256(mX), uint256(x2));
        gfP2 memory y = g2YFromX(x);

        if (parity(y.x) != (m[0] & 0x80) >> 7) {
            y.x = p - y.x;
            y.y = p - y.y;
        }

        require(isG2PointOnCurve(G2Point(x, y)), "Malformed bn256.G2 point.");
        return G2Point(x, y);
    }

    /**
     * @dev Wrap the point addition pre-compile introduced in Byzantium. Return
     * the sum of two points on G1. Revert if the provided points aren't on the
     * curve.
     */
    function g1Add(G1Point memory a, G1Point memory b) internal view returns (G1Point memory) {
        uint256[4] memory arg;
        arg[0] = a.x;
        arg[1] = a.y;
        arg[2] = b.x;
        arg[3] = b.y;
        uint256[2] memory c;

        /* solium-disable-next-line */
        assembly {
            // 0x60 is the ECADD precompile address
            if iszero(staticcall(not(0), 0x06, arg, 0x80, c, 0x40)) {
                revert(0, 0)
            }
        }

        return G1Point(c[0], c[1]);
    }

    /**
     * @dev Return the sum of two gfP2 field elements.
     */
    function gfP2Add(gfP2 memory a, gfP2 memory b) internal pure returns(gfP2 memory) {
        return gfP2(
            addmod(a.x, b.x, p),
            addmod(a.y, b.y, p)
        );
    }

    /**
     * @dev Return multiplication of two gfP2 field elements.
     */
    function gfP2Multiply(gfP2 memory a, gfP2 memory b) internal pure returns(gfP2 memory) {
        return gfP2(
            addmod(mulmod(a.x, b.y, p), mulmod(b.x, a.y, p), p),
            addmod(mulmod(a.y, b.y, p), p - mulmod(a.x, b.x, p), p)
        );
    }

    /**
     * @dev Return gfP2 element to the power of the provided exponent.
     */
    function gfP2Pow(gfP2 memory _a, uint256 _exp) internal pure returns(gfP2 memory result) {
        uint256 exp = _exp;
        gfP2 memory a;
        result.x = 0;
        result.y = 1;
        a.x = _a.x;
        a.y = _a.y;

        // Reduce exp dividing by 2 gradually to 0 while computing final
        // result only when exp is an odd number.
        while (exp > 0) {
            if (parity(exp) == 0x01) {
                result = gfP2Multiply(result, a);
            }

            exp = exp / 2;
            a = gfP2Multiply(a, a);
        }
    }

    /**
     * @dev Return true if G2 point's y^2 equals x.
     */
    function g2X2y(gfP2 memory x, gfP2 memory y) internal pure returns(bool) {
       
        gfP2 memory y2;
        y2 = gfP2Pow(y, 2);

        return (y2.x == x.x && y2.y == x.y);
    }

    /**
     * @dev Return true if G1 point is on the curve.
     */
    function isG1PointOnCurve(G1Point memory point) internal view returns (bool) {
        return point.y.modExp(2, p) == (point.x.modExp(3, p) + 3) % p;
    }

    /**
     * @dev Return true if G2 point is on the curve.
     */
    function isG2PointOnCurve(G2Point memory point) internal pure returns(bool) {

        gfP2 memory y2;
        gfP2 memory x3;

        y2 = gfP2Pow(point.y, 2);
        x3 = gfP2Add(gfP2Pow(point.x, 3), twistB());

        return (y2.x == x3.x && y2.y == x3.y);
    }

    /**
     * @dev Wrap the scalar point multiplication pre-compile introduced in
     * Byzantium. The result of a point from G1 multiplied by a scalar should
     * match the point added to itself the same number of times. Revert if the
     * provided point isn't on the curve.
     */
    function scalarMultiply(G1Point memory p_1, uint256 scalar) internal view returns (G1Point memory) {
        uint256[3] memory arg;
        arg[0] = p_1.x;
        arg[1] = p_1.y;
        arg[2] = scalar;
        uint256[2] memory p_2;
        /* solium-disable-next-line */
        assembly {
            // 0x70 is the ECMUL precompile address
            if iszero(staticcall(not(0), 0x07, arg, 0x60, p_2, 0x40)) {
                revert(0, 0)
            }
        }
        return G1Point(p_2[0], p_2[1]);
    }

    /**
     * @dev Wrap the pairing check pre-compile introduced in Byzantium. Return
     * the result of a pairing check of 2 pairs (G1 p1, G2 p2) (G1 p3, G2 p4)
     */
    function pairing(G1Point memory p1, G2Point memory p2, G1Point memory p3, G2Point memory p4) internal view returns (bool) {
        uint256[12] memory arg = [
            p1.x, p1.y, p2.x.x, p2.x.y, p2.y.x, p2.y.y, p3.x, p3.y, p4.x.x, p4.x.y, p4.y.x, p4.y.y
        ];
        uint[1] memory c;
        /* solium-disable-next-line */
        assembly {
            // call(gasLimit, to, value, inputOffset, inputSize, outputOffset, outputSize)
            if iszero(staticcall(not(0), 0x08, arg, 0x180, c, 0x20)) {
                revert(0, 0)
            }
        }
        return c[0] != 0;
    }

}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/cryptography/BLS.sol

pragma solidity ^0.5.4;



/**
 * @title BLS signatures verification
 * @dev Library for verification of 2-pairing-check BLS signatures, including
 * basic, aggregated, or reconstructed threshold BLS signatures, generated
 * using the AltBn128 curve.
 */
library BLS {

    /**
     * @dev Verify performs the pairing operation to check if the signature
     * is correct for the provided message and the corresponding public key.
     * Public key must be a valid point on G2 curve in an uncompressed format.
     * Message must be a valid point on G1 curve in an uncompressed format.
     * Signature must be a valid point on G1 curve in an uncompressed format.
     */
    function verify(
        bytes memory publicKey,
        bytes memory message,
        bytes memory signature
    ) public view returns (bool) {

        AltBn128.G1Point memory _signature = AltBn128.g1Unmarshal(signature);

        return AltBn128.pairing(
            AltBn128.G1Point(_signature.x, AltBn128.getP() - _signature.y),
            AltBn128.g2(),
            AltBn128.g1Unmarshal(message),
            AltBn128.g2Unmarshal(publicKey)
        );
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/libraries/operator/GroupSelection.sol

pragma solidity ^0.5.4;



/**
 * The group selection protocol is an interactive method of selecting candidate
 * group from the set of all stakers given a pseudorandom seed value.
 *
 * The protocol produces a representative result, where each staker's profit is
 * proportional to the number of tokens they have staked. Produced candidate
 * groups are of constant size.
 *
 * Group selection protocol accepts seed as an input - a pseudorandom value
 * used to construct candidate tickets. Each candidate group member can
 * submit their tickets. The maximum number of tickets one can submit depends
 * on their staking weight - relation of the minimum stake to the candidate's
 * stake.
 *
 * There is a certain timeout, expressed in blocks, when tickets can be
 * submitted. Each ticket is a mix of staker's address, virtual staker index
 * and group selection seed. Candidate group members are selected based on
 * the best tickets submitted. There has to be a minimum number of tickets
 * submitted, equal to the candidate group size so that the protocol can
 * complete successfully.
 */
library GroupSelection {

    using SafeMath for uint256;
    using BytesLib for bytes;

    struct Storage {
        // Tickets submitted by member candidates during the current group
        // selection execution and accepted by the protocol for the
        // consideration.
        uint64[] tickets;

        // Information about ticket submitters (group member candidates).
        mapping(uint256 => address) candidate;

        // Pseudorandom seed value used as an input for the group selection.
        uint256 seed;

        // Timeout in blocks after which the ticket submission is finished.
        uint256 ticketSubmissionTimeout;

        // Number of block at which the group selection started and from which
        // ticket submissions are accepted.
        uint256 ticketSubmissionStartBlock;

        // Indicates whether a group selection is currently in progress.
        // Concurrent group selections are not allowed.
        bool inProgress;

        // Map simulates a sorted linked list of ticket values by their indexes.
        // key -> value represent indices from the tickets[] array.
        // 'key' index holds an index of a ticket and 'value' holds an index
        // of the next ticket. Tickets are sorted by their value in
        // descending order starting from the tail.
        // Ex. tickets = [151, 42, 175, 7]
        // tail: 2 because tickets[2] = 175
        // previousTicketIndex[0] -> 1
        // previousTicketIndex[1] -> 3
        // previousTicketIndex[2] -> 0
        // previousTicketIndex[3] -> 3 note: index that holds a lowest
        // value points to itself because there is no `nil` in Solidity.
        // Traversing from tail: [2]->[0]->[1]->[3] result in 175->151->42->7
        mapping(uint256 => uint256) previousTicketIndex;

        // Tail represents an index of a ticket in a tickets[] array which holds
        // the highest ticket value. It is a tail of the linked list defined by
        // `previousTicketIndex`.
        uint256 tail;

        // Size of a group in the threshold relay.
        uint256 groupSize;
    }

    /**
     * @dev Starts group selection protocol.
     * @param _seed pseudorandom seed value used as an input for the group
     * selection. All submitted tickets needs to have the seed mixed-in into the
     * value.
     */
    function start(Storage storage self, uint256 _seed) public {
        // We execute the minimum required cleanup here needed in case the
        // previous group selection failed and did not clean up properly in
        // stop function.
        cleanupTickets(self);
        self.inProgress = true;
        self.seed = _seed;
        self.ticketSubmissionStartBlock = block.number;
    }

    /**
     * @dev Stops group selection protocol clearing up all the submitted
     * tickets. This function may be expensive if not executed as a part of
     * another transaction consuming a lot of gas and as a result, getting
     * gas refund for clearing up the storage.
     */
    function stop(Storage storage self) public {
        cleanupCandidates(self);
        cleanupTickets(self);
        self.inProgress = false;
    }

    /**
     * @dev Submits ticket to request to participate in a new candidate group.
     * @param ticket Bytes representation of a ticket that holds the following:
     * - ticketValue: first 8 bytes of a result of keccak256 cryptography hash
     *   function on the combination of the group selection seed (previous
     *   beacon output), staker-specific value (address) and virtual staker index.
     * - stakerValue: a staker-specific value which is the address of the staker.
     * - virtualStakerIndex: 4-bytes number within a range of 1 to staker's weight;
     *   has to be unique for all tickets submitted by the given staker for the
     *   current candidate group selection.
     * @param stakingWeight Ratio of the minimum stake to the candidate's
     * stake.
     */
    function submitTicket(
        Storage storage self,
        bytes32 ticket,
        uint256 stakingWeight
    ) public {
        uint64 ticketValue;
        uint160 stakerValue;
        uint32 virtualStakerIndex;

        bytes memory ticketBytes = abi.encodePacked(ticket);
        /* solium-disable-next-line */
        assembly {
            // ticket value is 8 bytes long
            ticketValue := mload(add(ticketBytes, 8))
            // staker value is 20 bytes long
            stakerValue := mload(add(ticketBytes, 28))
            // virtual staker index is 4 bytes long
            virtualStakerIndex := mload(add(ticketBytes, 32))
        }

        submitTicket(
            self,
            ticketValue,
            uint256(stakerValue),
            uint256(virtualStakerIndex),
            stakingWeight
        );
    }


    /**
     * @dev Submits ticket to request to participate in a new candidate group.
     * @param ticketValue First 8 bytes of a result of keccak256 cryptography hash
     * function on the combination of the group selection seed (previous
     * beacon output), staker-specific value (address) and virtual staker index.
     * @param stakerValue Staker-specific value which is the address of the staker.
     * @param virtualStakerIndex 4-bytes number within a range of 1 to staker's weight;
     * has to be unique for all tickets submitted by the given staker for the
     * current candidate group selection.
     * @param stakingWeight Ratio of the minimum stake to the candidate's
     * stake.
     */
    function submitTicket(
        Storage storage self,
        uint64 ticketValue,
        uint256 stakerValue,
        uint256 virtualStakerIndex,
        uint256 stakingWeight
    ) public {
        if (block.number > self.ticketSubmissionStartBlock.add(self.ticketSubmissionTimeout)) {
            revert("Ticket submission is over");
        }

        if (self.candidate[ticketValue] != address(0)) {
            revert("Duplicate ticket");
        }

        if (isTicketValid(
            ticketValue,
            stakerValue,
            virtualStakerIndex,
            stakingWeight,
            self.seed
        )) {
            addTicket(self, ticketValue);
        } else {
            // TODO: should we slash instead of reverting?
            revert("Invalid ticket");
        }
    }

    /**
     * @dev Performs full verification of the ticket.
     */
    function isTicketValid(
        uint64 ticketValue,
        uint256 stakerValue,
        uint256 virtualStakerIndex,
        uint256 stakingWeight,
        uint256 groupSelectionSeed
    ) internal view returns(bool) {
        uint64 ticketValueExpected;
        bytes memory ticketBytes = abi.encodePacked(
            keccak256(
                abi.encodePacked(
                    groupSelectionSeed,
                    stakerValue,
                    virtualStakerIndex
                )
            )
        );
        // use first 8 bytes to compare ticket values
        /* solium-disable-next-line */
        assembly {
            ticketValueExpected := mload(add(ticketBytes, 8))
        }

        bool isVirtualStakerIndexValid = virtualStakerIndex > 0 && virtualStakerIndex <= stakingWeight;
        bool isStakerValueValid = stakerValue == uint256(msg.sender);
        bool isTicketValueValid = ticketValue == ticketValueExpected;

        return isVirtualStakerIndexValid && isStakerValueValid && isTicketValueValid;
    }

    /**
     * @dev Adds a new, verified ticket. Ticket is accepted when it is lower
     * than the currently highest ticket or when the number of tickets is still
     * below the group size.
     */
    function addTicket(Storage storage self, uint64 newTicketValue) internal {
        uint256[] memory ordered = getTicketValueOrderedIndices(self);

        // any ticket goes when the tickets array size is lower than the group size
        if (self.tickets.length < self.groupSize) {
            // no tickets
            if (self.tickets.length == 0) {
                self.tickets.push(newTicketValue);
            // higher than the current highest
            } else if (newTicketValue > self.tickets[self.tail]) {
                self.tickets.push(newTicketValue);
                uint256 oldTail = self.tail;
                self.tail = self.tickets.length-1;
                self.previousTicketIndex[self.tail] = oldTail;
            // lower than the current lowest
            } else if (newTicketValue < self.tickets[ordered[0]]) {
                self.tickets.push(newTicketValue);
                // last element points to itself
                self.previousTicketIndex[self.tickets.length - 1] = self.tickets.length - 1;
                // previous lowest ticket points to the new lowest
                self.previousTicketIndex[ordered[0]] = self.tickets.length - 1;
            // higher than the lowest ticket value and lower than the highest ticket value
            } else {
                self.tickets.push(newTicketValue);
                uint256 j = findReplacementIndex(self, newTicketValue, ordered);
                self.previousTicketIndex[self.tickets.length - 1] = self.previousTicketIndex[j];
                self.previousTicketIndex[j] = self.tickets.length - 1;
            }
            self.candidate[newTicketValue] = msg.sender;
        } else if (newTicketValue < self.tickets[self.tail]) {
            uint256 ticketToRemove = self.tickets[self.tail];
            // new ticket is lower than currently lowest
            if (newTicketValue < self.tickets[ordered[0]]) {
                // replacing highest ticket with the new lowest
                self.tickets[self.tail] = newTicketValue;
                uint256 newTail = self.previousTicketIndex[self.tail];
                self.previousTicketIndex[ordered[0]] = self.tail;
                self.previousTicketIndex[self.tail] = self.tail;
                self.tail = newTail;
            } else { // new ticket is between lowest and highest
                uint256 j = findReplacementIndex(self, newTicketValue, ordered);
                self.tickets[self.tail] = newTicketValue;
                // do not change the order if a new ticket is still highest
                if (j != self.tail) {
                    uint newTail = self.previousTicketIndex[self.tail];
                    self.previousTicketIndex[self.tail] = self.previousTicketIndex[j];
                    self.previousTicketIndex[j] = self.tail;
                    self.tail = newTail;
                }
            }
            // we are replacing tickets so we also need to replace information
            // about the submitter
            delete self.candidate[ticketToRemove];
            self.candidate[newTicketValue] = msg.sender;
        }
    }

    /**
     * @dev Use binary search to find an index for a new ticket in the tickets[] array
     */
    function findReplacementIndex(
        Storage storage self,
        uint64 newTicketValue,
        uint256[] memory ordered
    ) internal view returns (uint256) {
        uint256 lo = 0;
        uint256 hi = ordered.length - 1;
        uint256 mid = 0;
        while (lo <= hi) {
            mid = (lo + hi) >> 1;
            if (newTicketValue < self.tickets[ordered[mid]]) {
                hi = mid - 1;
            } else if (newTicketValue > self.tickets[ordered[mid]]) {
                lo = mid + 1;
            } else {
                return ordered[mid];
            }
        }

        return ordered[lo];
    }

    /**
     * @dev Creates an array of ticket indexes based on their values in the ascending order:
     *
     * ordered[n-1] = tail
     * ordered[n-2] = previousTicketIndex[tail]
     * ordered[n-3] = previousTicketIndex[ordered[n-2]]
     */
    function getTicketValueOrderedIndices(Storage storage self) internal view returns (uint256[] memory) {
        uint256[] memory ordered = new uint256[](self.tickets.length);
        if (ordered.length > 0) {
            ordered[self.tickets.length-1] = self.tail;
            if (ordered.length > 1) {
                for (uint256 i = self.tickets.length - 1; i > 0; i--) {
                    ordered[i-1] = self.previousTicketIndex[ordered[i]];
                }
            }
        }

        return ordered;
    }

    /**
     * @dev Gets selected participants in ascending order of their tickets.
     */
    function selectedParticipants(Storage storage self) public view returns (address[] memory) {
        require(
            block.number >= self.ticketSubmissionStartBlock.add(self.ticketSubmissionTimeout),
            "Ticket submission in progress"
        );

        require(self.tickets.length >= self.groupSize, "Not enough tickets submitted");

        address[] memory selected = new address[](self.groupSize);
        uint256 ticketIndex = self.tail;
        selected[self.tickets.length - 1] = self.candidate[self.tickets[ticketIndex]];
        for (uint256 i = self.tickets.length - 1; i > 0; i--) {
            ticketIndex = self.previousTicketIndex[ticketIndex];
            selected[i-1] = self.candidate[self.tickets[ticketIndex]];
        }

        return selected;
    }

    /**
     * @dev Clears up data of the group selection tickets.
     */
    function cleanupTickets(Storage storage self) internal {
        delete self.tickets;
        self.tail = 0;
    }

    /**
     * @dev Clears up data of the group selection candidates.
     * This operation may have a significant cost if not executed as a part of
     * another transaction consuming a lot of gas and as a result, getting
     * gas refund for clearing up the storage.
     */
    function cleanupCandidates(Storage storage self) internal {
        for (uint i = 0; i < self.tickets.length; i++) {
            delete self.candidate[self.tickets[i]];
        }
    }
}
// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/libraries/operator/Groups.sol

pragma solidity ^0.5.4;







library Groups {
    using SafeMath for uint256;
    using BytesLib for bytes;

    struct Group {
        bytes groupPubKey;
        uint registrationBlockHeight;
    }

    struct Storage {
        // Time in blocks after which a group expires.
        uint256 groupActiveTime;

        // Duplicated constant from operator contract to avoid extra call.
        // The value is set when the operator contract is added.
        uint256 relayEntryTimeout;

        Group[] groups;
        uint256[] terminatedGroups;
        mapping (bytes => address[]) groupMembers;

        // Sum of all group member rewards earned so far. The value is the same for
        // all group members. Submitter reward and reimbursement is paid immediately
        // and is not included here. Each group member can withdraw no more than
        // this value.
        mapping (bytes => uint256) groupMemberRewards;

        // expiredGroupOffset is pointing to the first active group, it is also the
        // expired groups counter
        uint256 expiredGroupOffset;

        TokenStaking stakingContract;
    }

    /**
     * @dev Adds group.
     */
    function addGroup(
        Storage storage self,
        bytes memory groupPubKey
    ) internal {
        self.groups.push(Group(groupPubKey, block.number));
    }

    /**
     * @dev Sets addresses of members for the group with the given public key
     * eliminating members at positions pointed by the misbehaved array.
     * @param groupPubKey Group public key.
     * @param members Group member addresses as outputted by the group selection
     * protocol.
     * @param misbehaved Bytes array of misbehaved (disqualified or inactive)
     * group members indexes in ascending order; Indexes reflect positions of
     * members in the group as outputted by the group selection protocol -
     * member indexes start from 1.
     */
    function setGroupMembers(
        Storage storage self,
        bytes memory groupPubKey,
        address[] memory members,
        bytes memory misbehaved
    ) internal {
        self.groupMembers[groupPubKey] = members;

        // Iterate misbehaved array backwards, replace misbehaved
        // member with the last element and reduce array length
        uint256 i = misbehaved.length;
        while (i > 0) {
             // group member indexes start from 1, so we need to -1 on misbehaved
            uint256 memberArrayPosition = misbehaved.toUint8(i - 1) - 1;
            self.groupMembers[groupPubKey][memberArrayPosition] = self.groupMembers[groupPubKey][self.groupMembers[groupPubKey].length - 1];
            self.groupMembers[groupPubKey].length--;
            i--;
        }
    }

    /**
     * @dev Adds group member reward per group so the accumulated amount can be withdrawn later.
     */
    function addGroupMemberReward(
        Storage storage self,
        bytes memory groupPubKey,
        uint256 amount
    ) internal {
        self.groupMemberRewards[groupPubKey] = self.groupMemberRewards[groupPubKey].add(amount);
    }

    /**
     * @dev Returns accumulated group member rewards for provided group.
     */
    function getGroupMemberRewards(
        Storage storage self,
        bytes memory groupPubKey
    ) internal view returns (uint256) {
        return self.groupMemberRewards[groupPubKey];
    }

    /**
     * @dev Gets group public key.
     */
    function getGroupPublicKey(
        Storage storage self,
        uint256 groupIndex
    ) internal view returns (bytes memory) {
        return self.groups[groupIndex].groupPubKey;
    }

    /**
     * @dev Gets group member.
     */
    function getGroupMember(
        Storage storage self,
        bytes memory groupPubKey,
        uint256 memberIndex
    ) internal view returns (address) {
        return self.groupMembers[groupPubKey][memberIndex];
    }

    /**
     * @dev Gets all indices in the provided group for a member.
     */
    function getGroupMemberIndices(
        Storage storage self,
        bytes memory groupPubKey,
        address member
    ) public view returns (uint256[] memory indices) {
        uint256 counter;
        for (uint i = 0; i < self.groupMembers[groupPubKey].length; i++) {
            if (self.groupMembers[groupPubKey][i] == member) {
                counter++;
            }
        }

        indices = new uint256[](counter);
        counter = 0;
        for (uint i = 0; i < self.groupMembers[groupPubKey].length; i++) {
            if (self.groupMembers[groupPubKey][i] == member) {
                indices[counter] = i;
                counter++;
            }
        }
    }

    /**
     * @dev Terminates group.
     */
    function terminateGroup(
        Storage storage self,
        uint256 groupIndex
    ) internal {
        self.terminatedGroups.push(groupIndex);
    }

    /**
     * @dev Checks if group with the given index is terminated.
     */
    function isGroupTerminated(
        Storage storage self,
        uint256 groupIndex
    ) internal view returns(bool) {
        for (uint i = 0; i < self.terminatedGroups.length; i++) {
            if (self.terminatedGroups[i] == groupIndex) {
                return true;
            }
        }
        return false;
    }

    /**
     * @dev Checks if group with the given public key is registered.
     */
    function isGroupRegistered(
        Storage storage self,
        bytes memory groupPubKey
    ) internal view returns(bool) {
        for (uint i = 0; i < self.groups.length; i++) {
            if (self.groups[i].groupPubKey.equalStorage(groupPubKey)) {
                return true;
            }
        }
        return false;
    }

    /**
     * @dev Gets the cutoff time in blocks until which the given group is
     * considered as an active group assuming it hasn't been terminated before.
     */
    function groupActiveTimeOf(
        Storage storage self,
        Group memory group
    ) internal view returns(uint256) {
        return group.registrationBlockHeight.add(self.groupActiveTime);
    }

    /**
     * @dev Gets the cutoff time in blocks after which the given group is
     * considered as stale. Stale group is an expired group which is no longer
     * performing any operations.
     */
    function groupStaleTime(
        Storage storage self,
        Group memory group
    ) internal view returns(uint256) {
        return groupActiveTimeOf(self, group).add(self.relayEntryTimeout);
    }

    /**
     * @dev Checks if a group with the given public key is a stale group.
     * Stale group is an expired group which is no longer performing any
     * operations. It is important to understand that an expired group may
     * still perform some operations for which it was selected when it was still
     * active. We consider a group to be stale when it's expired and when its
     * expiration time and potentially executed operation timeout are both in
     * the past.
     */
    function isStaleGroup(
        Storage storage self,
        bytes memory groupPubKey
    ) public view returns(bool) {
        for (uint i = 0; i < self.groups.length; i++) {
            if (self.groups[i].groupPubKey.equalStorage(groupPubKey)) {
                bool isExpired = self.expiredGroupOffset > i;
                bool isStale = groupStaleTime(self, self.groups[i]) < block.number;
                return isExpired && isStale;
            }
        }

        revert("Group does not exist");
    }

    /**
     * @dev Checks if a group with the given index is a stale group.
     * Stale group is an expired group which is no longer performing any
     * operations. It is important to understand that an expired group may
     * still perform some operations for which it was selected when it was still
     * active. We consider a group to be stale when it's expired and when its
     * expiration time and potentially executed operation timeout are both in
     * the past.
     */
    function isStaleGroup(
        Storage storage self,
        uint256 groupIndex
    ) public view returns(bool) {
        return groupStaleTime(self, self.groups[groupIndex]) < block.number;
    }

    /**
     * @dev Gets the number of active groups. Expired and terminated groups are
     * not counted as active.
     */
    function numberOfGroups(
        Storage storage self
    ) internal view returns(uint256) {
        return self.groups.length.sub(self.expiredGroupOffset).sub(self.terminatedGroups.length);
    }

    /**
     * @dev Goes through groups starting from the oldest one that is still
     * active and checks if it hasn't expired. If so, updates the information
     * about expired groups so that all expired groups are marked as such.
     */
    function expireOldGroups(Storage storage self) internal {
        // move expiredGroupOffset as long as there are some groups that should
        // be marked as expired
        while(groupActiveTimeOf(self, self.groups[self.expiredGroupOffset]) < block.number) {
            self.expiredGroupOffset++;
        }

        // Go through all terminatedGroups and if some of the terminated
        // groups are expired, remove them from terminatedGroups collection.
        // This is needed because we evaluate the shift of selected group index
        // based on how many non-expired groups has been terminated.
        for (uint i = 0; i < self.terminatedGroups.length; i++) {
            if (self.expiredGroupOffset > self.terminatedGroups[i]) {
                self.terminatedGroups[i] = self.terminatedGroups[self.terminatedGroups.length - 1];
                self.terminatedGroups.length--;
            }
        }
    }

    /**
     * @dev Returns an index of a randomly selected active group. Terminated and
     * expired groups are not considered as active.
     * Before new group is selected, information about expired groups
     * is updated. At least one active group needs to be present for this
     * function to succeed.
     * @param seed Random number used as a group selection seed.
     */
    function selectGroup(
        Storage storage self,
        uint256 seed
    ) public returns(uint256) {
        require(numberOfGroups(self) > 0, "At least one active group required");

        expireOldGroups(self);
        uint256 selectedGroup = seed % numberOfGroups(self);
        return shiftByTerminatedGroups(self, shiftByExpiredGroups(self, selectedGroup));
    }

    /**
     * @dev Evaluates the shift of selected group index based on the number of
     * expired groups.
     */
    function shiftByExpiredGroups(
        Storage storage self,
        uint256 selectedIndex
    ) internal view returns(uint256) {
        return self.expiredGroupOffset.add(selectedIndex);
    }

    /**
     * @dev Evaluates the shift of selected group index based on the number of
     * non-expired, terminated groups.
     */
    function shiftByTerminatedGroups(
        Storage storage self,
        uint256 selectedIndex
    ) internal view returns(uint256) {
        uint256 shiftedIndex = selectedIndex;
        for (uint i = 0; i < self.terminatedGroups.length; i++) {
            if (self.terminatedGroups[i] <= shiftedIndex) {
                shiftedIndex++;
            }
        }

        return shiftedIndex;
    }

    /**
     * @dev Withdraws accumulated group member rewards for operator
     * using the provided group index and member indices. Once the
     * accumulated reward is withdrawn from the selected group, member is
     * removed from it. Rewards can be withdrawn only from stale group.
     * @param operator Operator address.
     * @param groupIndex Group index.
     * @param groupMemberIndices Array of member indices for the group member.
     */
    function withdrawFromGroup(
        Storage storage self,
        address operator,
        uint256 groupIndex,
        uint256[] memory groupMemberIndices
    ) public returns (uint256 rewards) {
        bool isExpired = self.expiredGroupOffset > groupIndex;
        bool isStale = isStaleGroup(self, groupIndex);
        require(isExpired && isStale, "Group must be expired and stale");
        bytes memory groupPublicKey = getGroupPublicKey(self, groupIndex);
        for (uint i = 0; i < groupMemberIndices.length; i++) {
            if (operator == self.groupMembers[groupPublicKey][groupMemberIndices[i]]) {
                delete self.groupMembers[groupPublicKey][groupMemberIndices[i]];
                rewards = rewards.add(self.groupMemberRewards[groupPublicKey]);
            }
        }
    }

    /**
     * @dev Returns addresses of all the members in the provided group.
     */
    function membersOf(
        Storage storage self,
        bytes memory groupPubKey
    ) public view returns (address[] memory members) {
        return self.groupMembers[groupPubKey];
    }

    /**
     * @dev Returns addresses of all the members in the provided group.
     */
    function membersOf(
        Storage storage self,
        uint256 groupIndex
    ) public view returns (address[] memory members) {
        bytes memory groupPubKey = self.groups[groupIndex].groupPubKey;
        return self.groupMembers[groupPubKey];
    }

    /**
     * @dev Reports unauthorized signing for the provided group. Must provide
     * a valid signature of the group address as a message. Successful signature
     * verification means the private key has been leaked and all group members
     * should be punished by seizing their tokens. The submitter of this proof is
     * rewarded with 5% of the total seized amount scaled by the reward adjustment
     * parameter and the rest 95% is burned.
     */
    function reportUnauthorizedSigning(
        Storage storage self,
        uint256 groupIndex,
        bytes memory signedGroupPubKey,
        uint256 minimumStake
    ) public {
        require(!isStaleGroup(self, groupIndex), "Group can not be stale");
        bytes memory groupPubKey = getGroupPublicKey(self, groupIndex);

        AltBn128.G1Point memory point = AltBn128.g1HashToPoint(groupPubKey);
        bytes memory message = new bytes(64);
        bytes32 x = bytes32(point.x);
        bytes32 y = bytes32(point.y);
        assembly {
            mstore(add(message, 32), x)
            mstore(add(message, 64), y)
        }

        bool isSignatureValid = BLS.verify(groupPubKey, message, signedGroupPubKey);

        if (!isGroupTerminated(self, groupIndex) && isSignatureValid) {
            emit DebugUnauthorizedSigningReported();
            terminateGroup(self, groupIndex);
            self.stakingContract.seize(minimumStake, 100, msg.sender, self.groupMembers[groupPubKey]);
        }
    }

    event DebugUnauthorizedSigningReported();

    function reportRelayEntryTimeout(
        Storage storage self,
        uint256 groupIndex,
        uint256 groupSize,
        uint256 minimumStake
    ) public {
        terminateGroup(self, groupIndex);
        // Reward is limited to min(1, 20 / group_size) of the maximum tattletale reward, see the Yellow Paper for more details.
        uint256 rewardAdjustment = uint256(20 * 100).div(groupSize); // Reward adjustment in percentage
        rewardAdjustment = rewardAdjustment > 100 ? 100:rewardAdjustment; // Reward adjustment can be 100% max
        self.stakingContract.seize(minimumStake, rewardAdjustment, msg.sender, membersOf(self, groupIndex));
    }

    /**
     * @dev Returns members of the given group by group public key.
     *
     * @param groupPubKey Group public key.
     */
    function getGroupMembers(Storage storage self, bytes memory groupPubKey) public view returns (address[] memory ) {
        return self.groupMembers[groupPubKey];
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/op2/contracts/cryptography/ECDSA.sol

pragma solidity ^0.5.0;

/**
 * @dev Elliptic Curve Digital Signature Algorithm (ECDSA) operations.
 *
 * These functions can be used to verify that a message was signed by the holder
 * of the private keys of a given address.
 */
library ECDSA {
    /**
     * @dev Returns the address that signed a hashed message (`hash`) with
     * `signature`. This address can then be used for verification purposes.
     *
     * The `ecrecover` EVM opcode allows for malleable (non-unique) signatures:
     * this function rejects them by requiring the `s` value to be in the lower
     * half order, and the `v` value to be either 27 or 28.
     *
     * NOTE: This call _does not revert_ if the signature is invalid, or
     * if the signer is otherwise unable to be retrieved. In those scenarios,
     * the zero address is returned.
     *
     * IMPORTANT: `hash` _must_ be the result of a hash operation for the
     * verification to be secure: it is possible to craft signatures that
     * recover to arbitrary addresses for non-hashed data. A safe way to ensure
     * this is by receiving a hash of the original message (which may otherwise
     * be too long), and then calling {toEthSignedMessageHash} on it.
     */
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        // Check the signature length
        if (signature.length != 65) {
            return (address(0));
        }

        // Divide the signature in r, s and v variables
        bytes32 r;
        bytes32 s;
        uint8 v;

        // ecrecover takes the signature parameters, and the only way to get them
        // currently is to use assembly.
        // solhint-disable-next-line no-inline-assembly
        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }

        // EIP-2 still allows signature malleability for ecrecover(). Remove this possibility and make the signature
        // unique. Appendix F in the Ethereum Yellow paper (https://ethereum.github.io/yellowpaper/paper.pdf), defines
        // the valid range for s in (281): 0 < s < secp256k1n ÷ 2 + 1, and for v in (282): v ∈ {27, 28}. Most
        // signatures from current libraries generate a unique signature with an s-value in the lower half order.
        //
        // If your library generates malleable signatures, such as s-values in the upper range, calculate a new s-value
        // with 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141 - s1 and flip v from 27 to 28 or
        // vice versa. If your library also generates signatures with 0/1 for v instead 27/28, add 27 to v to accept
        // these malleable signatures as well.
        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
            return address(0);
        }

        if (v != 27 && v != 28) {
            return address(0);
        }

        // If the signature is valid (and not malleable), return the signer address
        return ecrecover(hash, v, r, s);
    }

    /**
     * @dev Returns an Ethereum Signed Message, created from a `hash`. This
     * replicates the behavior of the
     * https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_sign[`eth_sign`]
     * JSON-RPC method.
     *
     * See {recover}.
     */
    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        // 32 is the length in bytes of hash,
        // enforced by the type signature above
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/libraries/operator/DKGResultVerification.sol

pragma solidity ^0.5.4;




library DKGResultVerification {
    using BytesLib for bytes;
    using ECDSA for bytes32;
    using GroupSelection for GroupSelection.Storage;

    struct Storage {
        // Time in blocks after which DKG result is complete and ready to be
        // published by clients.
        uint256 timeDKG;

        // Time in blocks after which the next group member is eligible
        // to submit DKG result.
        uint256 resultPublicationBlockStep;

        // Size of a group in the threshold relay.
        uint256 groupSize;

        // The minimum number of signatures required to support DKG result.
        // This number needs to be at least the same as the signing threshold
        // and it is recommended to make it higher than the signing threshold
        // to keep a safety margin for misbehaving members.
        uint256 signatureThreshold;
    }

    /**
     * @dev Verifies the submitted DKG result against supporting member
     * signatures and if the submitter is eligible to submit at the current block.
     *
     * @param submitterMemberIndex Claimed submitter candidate group member index
     * @param groupPubKey Generated candidate group public key
     * @param misbehaved Bytes array of misbehaved (disqualified or inactive)
     * group members indexes; Indexes reflect positions of members in the group,
     * as outputted by the group selection protocol.
     * @param signatures Concatenation of signatures from members supporting the
     * result.
     * @param signingMemberIndices Indices of members corresponding to each
     * signature.
     * @param members Addresses of candidate group members as outputted by the
     * group selection protocol.
     * @param groupSelectionEndBlock Block height at which the group selection
     * protocol ended.
     *
     * @return true if submitter is eligible to submit and the result is valid;
     * Otherwise, transaction is reverted.
     */
    function verify(
        Storage storage self,
        uint256 submitterMemberIndex,
        bytes memory groupPubKey,
        bytes memory misbehaved,
        bytes memory signatures,
        uint256[] memory signingMemberIndices,
        address[] memory members,
        uint256 groupSelectionEndBlock
    ) public view returns (bool) {
        require(submitterMemberIndex > 0, "Invalid submitter index");
        require(
            members[submitterMemberIndex - 1] == msg.sender,
            "Unexpected submitter index"
        );

        uint T_init = groupSelectionEndBlock + self.timeDKG;
        require(
            block.number >= (T_init + (submitterMemberIndex-1) * self.resultPublicationBlockStep),
            "Submitter not eligible"
        );

        uint256 signaturesCount = signatures.length / 65;
        require(signatures.length >= 65, "Too short signatures array");
        require(signatures.length % 65 == 0, "Malformed signatures array");
        require(signaturesCount == signingMemberIndices.length, "Unexpected signatures count");
        require(signaturesCount >= self.signatureThreshold, "Too few signatures");

        bytes32 resultHash = keccak256(abi.encodePacked(groupPubKey, misbehaved));

        bytes memory current; // Current signature to be checked.

        for(uint i = 0; i < signaturesCount; i++){
            require(signingMemberIndices[i] > 0, "Invalid index");
            require(signingMemberIndices[i] <= members.length, "Index out of range");
            current = signatures.slice(65*i, 65);
            address recoveredAddress = resultHash.toEthSignedMessageHash().recover(current);

            require(members[signingMemberIndices[i] - 1] == recoveredAddress, "Invalid signature");
        }

        return true;
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/libraries/operator/Reimbursements.sol

pragma solidity ^0.5.4;




library Reimbursements {
    using SafeMath for uint256;
    using BytesLib for bytes;

    /**
     * @dev Reimburses callback execution cost and surplus based on actual gas
     * usage to the submitter's beneficiary address and if necessary to the
     * callback requestor (surplus recipient).
     * @param stakingContract Staking contract to get the address of the beneficiary
     * @param gasLimit Gas limit set for the callback
     * @param gasSpent Gas spent by the submitter on the callback
     * @param callbackFee Fee paid for the callback by the requestor
     * @param callbackReturnData Data containing surplus recipient address
     */
    function reimburseCallback(
        TokenStaking stakingContract,
        uint256 priceFeedEstimate,
        uint256 gasLimit,
        uint256 gasSpent,
        uint256 callbackFee,
        bytes memory callbackReturnData
    ) public {
        uint256 gasPrice = tx.gasprice < priceFeedEstimate ? tx.gasprice : priceFeedEstimate;

        // Obtain the actual callback gas expenditure and refund the surplus.
        //
        // In case of heavily underpriced transactions, EVM may wrap the call
        // with additional opcodes. In this case gasSpent > gasLimit.
        // The worst scenario cost is included in entry verification fee.
        // If this happens we return just the gasLimit here.
        uint256 actualCallbackGas = gasSpent < gasLimit ? gasSpent : gasLimit;
        uint256 actualCallbackFee = actualCallbackGas.mul(gasPrice);

        // Get the beneficiary.
        address payable magpie = stakingContract.magpieOf(msg.sender);

        // If we spent less on the callback than the customer transferred for the
        // callback execution, we need to reimburse the difference.
        if (actualCallbackFee < callbackFee) {
            uint256 callbackSurplus = callbackFee.sub(actualCallbackFee);
            // Reimburse submitter with his actual callback cost.
            magpie.call.value(actualCallbackFee)("");

            // Return callback surplus to the requestor.
            // Expecting 32 bytes data containing 20 byte address
            if (callbackReturnData.length == 32) {
                address surplusRecipient = callbackReturnData.toAddress(12);
                surplusRecipient.call.gas(8000).value(callbackSurplus)("");
            }
        } else {
            // Reimburse submitter with the callback payment sent by the requestor.
            magpie.call.value(callbackFee)("");
        }
    }
}

// File: keep-core-b76b418f04bc94030d10aff18220d8e560a2ab09/contracts/solidity/contracts/KeepRandomBeaconOperator.sol

pragma solidity ^0.5.4;










interface ServiceContract {
    function entryCreated(uint256 requestId, bytes calldata entry, address payable submitter) external;
    function fundRequestSubsidyFeePool() external payable;
    function fundDkgFeePool() external payable;
}

/**
 * @title KeepRandomBeaconOperator
 * @dev Keep client facing contract for random beacon security-critical operations.
 * Handles group creation and expiration, BLS signature verification and incentives.
 * The contract is not upgradeable. New functionality can be implemented by deploying
 * new versions following Keep client update and re-authorization by the stakers.
 */
contract KeepRandomBeaconOperator is ReentrancyGuard {
    using SafeMath for uint256;
    using AddressArrayUtils for address[];
    using GroupSelection for GroupSelection.Storage;
    using Groups for Groups.Storage;
    using DKGResultVerification for DKGResultVerification.Storage;

    event OnGroupRegistered(bytes groupPubKey);

    // TODO: Rename to DkgResultSubmittedEvent
    // TODO: Add memberIndex
    event DkgResultPublishedEvent(bytes groupPubKey);

    event RelayEntryRequested(bytes previousEntry, bytes groupPublicKey);
    event RelayEntrySubmitted();

    event GroupSelectionStarted(uint256 newEntry);

    event GroupMemberRewardsWithdrawn(address indexed beneficiary, address operator, uint256 amount, uint256 groupIndex);
    GroupSelection.Storage groupSelection;
    Groups.Storage groups;
    DKGResultVerification.Storage dkgResultVerification;

    // Contract owner.
    address internal owner;

    address[] internal serviceContracts;

    // TODO: replace with a secure authorization protocol (addressed in RFC 11).
    TokenStaking internal stakingContract;

    // Minimum amount of KEEP that allows sMPC cluster client to participate in
    // the Keep network. Expressed as number with 18-decimal places.
    uint256 public minimumStake = 200000 * 1e18;

    // Each signing group member reward expressed in wei.
    uint256 public groupMemberBaseReward = 145*1e11; // 14500 Gwei, 10% of operational cost

    // The price feed estimate is used to calculate the gas price for reimbursement
    // next to the actual gas price from the transaction. We use both values to
    // defend against malicious miner-submitters who can manipulate transaction
    // gas price. Expressed in wei.
    uint256 public priceFeedEstimate = 20*1e9; // (20 Gwei = 20 * 10^9 wei)

    // Fluctuation margin to cover the immediate rise in gas price.
    // Expressed in percentage.
    uint256 public fluctuationMargin = 50; // 50%

    // Size of a group in the threshold relay.
    uint256 public groupSize = 64;

    // Minimum number of group members needed to interact according to the
    // protocol to produce a relay entry.
    uint256 public groupThreshold = 33;

    // Time in blocks after which the next group member is eligible
    // to submit the result.
    uint256 public resultPublicationBlockStep = 3;

    // Time in blocks it takes off-chain cluster to generate a new relay entry
    // and be ready to submit it to the chain.
    uint256 public relayEntryGenerationTime = (1+3);

    // Timeout in blocks for a relay entry to appear on the chain. Blocks are
    // counted from the moment relay request occur.
    //
    // Timeout is never shorter than the time needed by clients to generate
    // relay entry and the time it takes for the last group member to become
    // eligible to submit the result plus at least one block to submit it.
    uint256 public relayEntryTimeout = relayEntryGenerationTime.add(groupSize.mul(resultPublicationBlockStep));

    // Gas required to verify BLS signature and produce successful relay
    // entry. Excludes callback and DKG gas. The worst case (most expensive)
    // scenario.
    uint256 public entryVerificationGasEstimate = 280000;

    // Gas required to submit DKG result. Excludes initiation of group selection.
    uint256 public dkgGasEstimate = 1740000;

    // Gas required to trigger DKG (starting group selection).
    uint256 public groupSelectionGasEstimate = 100000;

    // Reimbursement for the submitter of the DKG result.
    // This value is set when a new DKG request comes to the operator contract.
    // It contains a full payment for DKG multiplied by the fluctuation margin.
    // When submitting DKG result, the submitter is reimbursed with the actual cost
    // and some part of the fee stored in this field may be returned to the service
    // contract.
    uint256 public dkgSubmitterReimbursementFee;

    // Service contract that triggered current group selection.
    ServiceContract internal groupSelectionStarterContract;

    struct SigningRequest {
        uint256 relayRequestId;
        uint256 entryVerificationAndProfitFee;
        uint256 callbackFee;
        uint256 groupIndex;
        bytes previousEntry;
        address serviceContract;
    }

    uint256 internal currentEntryStartBlock;
    SigningRequest internal signingRequest;

    // Seed value used for the genesis group selection.
    // https://www.wolframalpha.com/input/?i=pi+to+78+digits
    uint256 internal _genesisGroupSeed = 31415926535897932384626433832795028841971693993751058209749445923078164062862;

    /**
     * @dev Triggers the first group selection. Genesis can be called only when
     * there are no groups on the operator contract.
     */
    function genesis() public payable {
        require(numberOfGroups() == 0, "Groups exist");
        // Set latest added service contract as a group selection starter to receive any DKG fee surplus.
        groupSelectionStarterContract = ServiceContract(serviceContracts[serviceContracts.length.sub(1)]);
        startGroupSelection(_genesisGroupSeed, msg.value);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner == msg.sender, "Caller is not the owner");
        _;
    }

    /**
     * @dev Checks if sender is authorized.
     */
    modifier onlyServiceContract() {
        require(
            serviceContracts.contains(msg.sender),
            "Caller is not an authorized contract"
        );
        _;
    }

    constructor(address _serviceContract, address _stakingContract) public {
        owner = msg.sender;

        serviceContracts.push(_serviceContract);
        stakingContract = TokenStaking(_stakingContract);

        groups.stakingContract = TokenStaking(_stakingContract);
        groups.groupActiveTime = TokenStaking(_stakingContract).undelegationPeriod();

        groupSelection.ticketSubmissionTimeout = 12;
        groupSelection.groupSize = groupSize;

        dkgResultVerification.timeDKG = 5*(1+5) + 2*(1+10);
        dkgResultVerification.resultPublicationBlockStep = resultPublicationBlockStep;
        dkgResultVerification.groupSize = groupSize;
        // TODO: For now, the required number of signatures is equal to group
        // threshold. This should be updated to keep a safety margin for
        // participants misbehaving during signing.
        dkgResultVerification.signatureThreshold = groupThreshold;
    }

    /**
     * @dev Adds service contract
     * @param serviceContract Address of the service contract.
     */
    function addServiceContract(address serviceContract) public onlyOwner {
        serviceContracts.push(serviceContract);
    }

    /**
     * @dev Removes service contract
     * @param serviceContract Address of the service contract.
     */
    function removeServiceContract(address serviceContract) public onlyOwner {
        serviceContracts.removeAddress(serviceContract);
    }

    /**
     * @dev Set the gas price in wei for calculating reimbursements.
     * @param _priceFeedEstimate is the gas price for calculating reimbursements.
     */
    function setPriceFeedEstimate(uint256 _priceFeedEstimate) public onlyOwner {
        priceFeedEstimate = _priceFeedEstimate;
    }

    /**
     * @dev Adds a safety margin for gas price fluctuations to the current gas price.
     * The gas price for DKG or relay entry is set when the request is processed
     * but the result submission transaction will be sent later. We add a safety
     * margin that should be sufficient for getting requests processed within a
     * a deadline under all circumstances.
     * @param gasPrice Gas price in wei.
     */
    function gasPriceWithFluctuationMargin(uint256 gasPrice) internal view returns (uint256) {
        return gasPrice.add(gasPrice.mul(fluctuationMargin).div(100));
    }

    /**
     * @dev Triggers the selection process of a new candidate group.
     * @param _newEntry New random beacon value that stakers will use to
     * generate their tickets.
     * @param submitter Operator of this contract.
     */
    function createGroup(uint256 _newEntry, address payable submitter) public payable onlyServiceContract {
        uint256 groupSelectionStartFee = groupSelectionGasEstimate
            .mul(gasPriceWithFluctuationMargin(priceFeedEstimate));

        groupSelectionStarterContract = ServiceContract(msg.sender);
        startGroupSelection(_newEntry, msg.value.sub(groupSelectionStartFee));

        // reimbursing a submitter that triggered group selection
        (bool success, ) = stakingContract.magpieOf(submitter).call.value(groupSelectionStartFee)("");
        require(success, "Failed reimbursing submitter for starting a group selection");
    }

    function startGroupSelection(uint256 _newEntry, uint256 _payment) internal {
        require(
            _payment >= gasPriceWithFluctuationMargin(priceFeedEstimate).mul(dkgGasEstimate),
            "Insufficient DKG fee"
        );

        require(isGroupSelectionPossible(), "Group selection in progress");

        // If previous group selection failed and there is reimbursement left
        // return it to the DKG fee pool.
        if (dkgSubmitterReimbursementFee > 0) {
            uint256 surplus = dkgSubmitterReimbursementFee;
            dkgSubmitterReimbursementFee = 0;
            ServiceContract(msg.sender).fundDkgFeePool.value(surplus)();
        }

        groupSelection.start(_newEntry);
       // emit GroupSelectionStarted(_newEntry);
        dkgSubmitterReimbursementFee = _payment;
    }

    function isGroupSelectionPossible() public view returns (bool) {
        if (!groupSelection.inProgress) {
            return true;
        }

        // dkgTimeout is the time after key generation protocol is expected to
        // be complete plus the expected time to submit the result.
        uint256 dkgTimeout = groupSelection.ticketSubmissionStartBlock +
        groupSelection.ticketSubmissionTimeout +
        dkgResultVerification.timeDKG +
        groupSize * resultPublicationBlockStep;

        return block.number > dkgTimeout;
    }

    /**
     * @dev Submits ticket to request to participate in a new candidate group.
     * @param ticket Bytes representation of a ticket that holds the following:
     * - ticketValue: first 8 bytes of a result of keccak256 cryptography hash
     *   function on the combination of the group selection seed (previous
     *   beacon output), staker-specific value (address) and virtual staker index.
     * - stakerValue: a staker-specific value which is the address of the staker.
     * - virtualStakerIndex: 4-bytes number within a range of 1 to staker's weight;
     *   has to be unique for all tickets submitted by the given staker for the
     *   current candidate group selection.
     */
    function submitTicket(bytes32 ticket) public {
        uint256 stakingWeight = stakingContract.eligibleStake(msg.sender, address(this)).div(minimumStake);
        groupSelection.submitTicket(ticket, stakingWeight);
    }

    /**
     * @dev Gets the timeout in blocks after which group candidate ticket
     * submission is finished.
     */
    function ticketSubmissionTimeout() public view returns (uint256) {
        return groupSelection.ticketSubmissionTimeout;
    }

    /**
     * @dev Gets the number of submitted group candidate tickets so far.
     */
    function submittedTicketsCount() public view returns (uint256) {
        return groupSelection.tickets.length;
    }

    /**
     * @dev Gets selected participants in ascending order of their tickets.
     */
    function selectedParticipants() public view returns (address[] memory) {
        return groupSelection.selectedParticipants();
    }

    /**
     * @dev Submits result of DKG protocol. It is on-chain part of phase 14 of
     * the protocol.
     *
     * @param submitterMemberIndex Claimed submitter candidate group member index
     * @param groupPubKey Generated candidate group public key
     * @param misbehaved Bytes array of misbehaved (disqualified or inactive)
     * group members indexes in ascending order; Indexes reflect positions of
     * members in the group as outputted by the group selection protocol.
     * @param signatures Concatenation of signatures from members supporting the
     * result.
     * @param signingMembersIndexes Indices of members corresponding to each
     * signature.
     */
    function submitDkgResult(
        uint256 submitterMemberIndex,
        bytes memory groupPubKey,
        bytes memory misbehaved,
        bytes memory signatures,
        uint[] memory signingMembersIndexes
    ) public {
        address[] memory members = selectedParticipants();

        dkgResultVerification.verify(
            submitterMemberIndex,
            groupPubKey,
            misbehaved,
            signatures,
            signingMembersIndexes,
            members,
            groupSelection.ticketSubmissionStartBlock + groupSelection.ticketSubmissionTimeout
        );

        groups.setGroupMembers(groupPubKey, members, misbehaved);
        groups.addGroup(groupPubKey);
        reimburseDkgSubmitter();
    //    emit DkgResultPublishedEvent(groupPubKey);
        groupSelection.stop();
    }

    /**
     * @dev Compare the reimbursement fee calculated based on the current transaction gas
     * price and the current price feed estimate with the DKG reimbursement fee calculated
     * and paid at the moment when the DKG was requested. If there is any surplus, it will
     * be returned to the DKG fee pool of the service contract which triggered the DKG.
     */
    function reimburseDkgSubmitter() internal {
        uint256 gasPrice = priceFeedEstimate;
        // We need to check if tx.gasprice is non-zero as a workaround to a bug
        // in go-ethereum:
        // https://github.com/ethereum/go-ethereum/pull/20189
        if (tx.gasprice > 0 && tx.gasprice < priceFeedEstimate) {
            gasPrice = tx.gasprice;
        }

        uint256 reimbursementFee = dkgGasEstimate.mul(gasPrice);
        address payable magpie = stakingContract.magpieOf(msg.sender);

        if (reimbursementFee < dkgSubmitterReimbursementFee) {
            uint256 surplus = dkgSubmitterReimbursementFee.sub(reimbursementFee);
            dkgSubmitterReimbursementFee = 0;
            // Reimburse submitter with actual DKG cost.
            magpie.call.value(reimbursementFee)("");

            // Return surplus to the contract that started DKG.
            groupSelectionStarterContract.fundDkgFeePool.value(surplus)();
        } else {
            // If submitter used higher gas price reimburse only dkgSubmitterReimbursementFee max.
            reimbursementFee = dkgSubmitterReimbursementFee;
            dkgSubmitterReimbursementFee = 0;
            magpie.call.value(reimbursementFee)("");
        }
    }

    /**
     * @dev Set the minimum amount of KEEP that allows a Keep network client to participate in a group.
     * @param _minimumStake Amount in KEEP.
     */
    function setMinimumStake(uint256 _minimumStake) public onlyOwner {
        minimumStake = _minimumStake;
    }

    /**
     * @dev Creates a request to generate a new relay entry, which will include a
     * random number (by signing the previous entry's random number).
     * @param requestId Request Id trackable by service contract
     * @param previousEntry Previous relay entry
     */
    function sign(
        uint256 requestId,
        bytes memory previousEntry
    ) public payable onlyServiceContract {
        uint256 entryVerificationAndProfitFee = groupProfitFee().add(
            entryVerificationGasEstimate.mul(gasPriceWithFluctuationMargin(priceFeedEstimate))
        );
        require(
            msg.value >= entryVerificationAndProfitFee,
            "Insufficient new entry fee"
        );
        uint256 callbackFee = msg.value.sub(entryVerificationAndProfitFee);
        signRelayEntry(
            requestId, previousEntry, msg.sender,
            entryVerificationAndProfitFee, callbackFee
        );
    }

    function signRelayEntry(
        uint256 requestId,
        bytes memory previousEntry,
        address serviceContract,
        uint256 entryVerificationAndProfitFee,
        uint256 callbackFee
    ) internal {
        require(!isEntryInProgress() || hasEntryTimedOut(), "Beacon is busy");

        currentEntryStartBlock = block.number;

        uint256 groupIndex = groups.selectGroup(uint256(keccak256(previousEntry)));
        signingRequest = SigningRequest(
            requestId,
            entryVerificationAndProfitFee,
            callbackFee,
            groupIndex,
            previousEntry,
            serviceContract
        );

        bytes memory groupPubKey = groups.getGroupPublicKey(groupIndex);
    //    emit RelayEntryRequested(previousEntry, groupPubKey);
    }

    /**
     * @dev Creates a new relay entry and stores the associated data on the chain.
     * @param _groupSignature Group BLS signature over the concatenation of the
     * previous entry and seed.
     */
    function relayEntry(bytes memory _groupSignature) public nonReentrant {
        require(isEntryInProgress(), "Entry was submitted");
        require(!hasEntryTimedOut(), "Entry timed out");

        bytes memory groupPubKey = groups.getGroupPublicKey(signingRequest.groupIndex);

        require(
            BLS.verify(
                groupPubKey,
                signingRequest.previousEntry,
                _groupSignature
            ),
            "Invalid signature"
        );

     //   emit RelayEntrySubmitted();

        // Spend no more than groupSelectionGasEstimate + 40000 gas max
        // This will prevent relayEntry failure in case the service contract is compromised
        signingRequest.serviceContract.call.gas(groupSelectionGasEstimate.add(40000))(
            abi.encodeWithSignature(
                "entryCreated(uint256,bytes,address)",
                signingRequest.relayRequestId,
                _groupSignature,
                msg.sender
            )
        );

        if (signingRequest.callbackFee > 0) {
            executeCallback(signingRequest, uint256(keccak256(_groupSignature)));
        }

        (uint256 groupMemberReward, uint256 submitterReward, uint256 subsidy) = newEntryRewardsBreakdown();
        groups.addGroupMemberReward(groupPubKey, groupMemberReward);

        stakingContract.magpieOf(msg.sender).call.value(submitterReward)("");

        if (subsidy > 0) {
            signingRequest.serviceContract.call.gas(35000).value(subsidy)(abi.encodeWithSignature("fundRequestSubsidyFeePool()"));
        }

        currentEntryStartBlock = 0;
    }

    /**
     * @dev Executes customer specified callback for the relay entry request.
     * @param signingRequest Request data tracked internally by this contract.
     * @param entry The generated random number.
     */
    function executeCallback(SigningRequest memory signingRequest, uint256 entry) internal {
        uint256 callbackFee = signingRequest.callbackFee;

        // Make sure not to spend more than what was received from the service contract for the callback
        uint256 gasLimit = callbackFee.div(gasPriceWithFluctuationMargin(priceFeedEstimate));

        bytes memory callbackReturnData;
        uint256 gasBeforeCallback = gasleft();
        (, callbackReturnData) = signingRequest.serviceContract.call.gas(gasLimit)(abi.encodeWithSignature("executeCallback(uint256,uint256)", signingRequest.relayRequestId, entry));
        uint256 gasAfterCallback = gasleft();
        uint256 gasSpent = gasBeforeCallback.sub(gasAfterCallback);

        Reimbursements.reimburseCallback(
            stakingContract,
            priceFeedEstimate,
            gasLimit,
            gasSpent,
            callbackFee,
            callbackReturnData
        );
    }

    /**
     * @dev Get rewards breakdown in wei for successful entry for the current signing request.
     */
    function newEntryRewardsBreakdown() internal view returns(uint256 groupMemberReward, uint256 submitterReward, uint256 subsidy) {
        uint256 decimals = 1e16; // Adding 16 decimals to perform float division.

        uint256 delayFactor = getDelayFactor();
        groupMemberReward = groupMemberBaseReward.mul(delayFactor).div(decimals);

        // delay penalty = base reward * (1 - delay factor)
        uint256 groupMemberDelayPenalty = groupMemberBaseReward.mul(decimals.sub(delayFactor));

        // The submitter reward consists of:
        // The callback gas expenditure (reimbursed by the service contract)
        // The entry verification fee to cover the cost of verifying the submission,
        // paid regardless of their gas expenditure
        // Submitter extra reward - 5% of the delay penalties of the entire group
        uint256 submitterExtraReward = groupMemberDelayPenalty.mul(groupSize).mul(5).div(100).div(decimals);
        uint256 entryVerificationFee = signingRequest.entryVerificationAndProfitFee.sub(groupProfitFee());
        submitterReward = entryVerificationFee.add(submitterExtraReward);

        // Rewards not paid out to the operators are paid out to requesters to subsidize new requests.
        subsidy = groupProfitFee().sub(groupMemberReward.mul(groupSize)).sub(submitterExtraReward);
    }

    /**
     * @dev Gets delay factor for rewards calculation.
     * @return Integer representing floating-point number with 16 decimals places.
     */
    function getDelayFactor() internal view returns(uint256 delayFactor) {
        uint256 decimals = 1e16; // Adding 16 decimals to perform float division.

        // T_deadline is the earliest block when no submissions are accepted
        // and an entry timed out. The last block the entry can be published in is
        //     currentEntryStartBlock + relayEntryTimeout
        // and submission are no longer accepted from block
        //     currentEntryStartBlock + relayEntryTimeout + 1.
        uint256 deadlineBlock = currentEntryStartBlock.add(relayEntryTimeout).add(1);

        // T_begin is the earliest block the result can be published in.
        // It takes relayEntryGenerationTime to generate a new entry, so it can
        // be published at block relayEntryGenerationTime + 1 the earliest.
        uint256 submissionStartBlock = currentEntryStartBlock.add(relayEntryGenerationTime).add(1);

        // Use submissionStartBlock block as entryReceivedBlock if entry submitted earlier than expected.
        uint256 entryReceivedBlock = block.number <= submissionStartBlock ? submissionStartBlock:block.number;

        // T_remaining = T_deadline - T_received
        uint256 remainingBlocks = deadlineBlock.sub(entryReceivedBlock);

        // T_deadline - T_begin
        uint256 submissionWindow = deadlineBlock.sub(submissionStartBlock);

        // delay factor = [ T_remaining / (T_deadline - T_begin)]^2
        //
        // Since we add 16 decimal places to perform float division, we do:
        // delay factor = [ T_temaining * decimals / (T_deadline - T_begin)]^2 / decimals =
        //    = [T_remaining / (T_deadline - T_begin) ]^2 * decimals
        delayFactor = ((remainingBlocks.mul(decimals).div(submissionWindow))**2).div(decimals);
    }

    /**
     * @dev Returns true if generation of a new relay entry is currently in
     * progress.
     */
    function isEntryInProgress() internal view returns (bool) {
        return currentEntryStartBlock != 0;
    }

    /**
     * @dev Returns true if the currently ongoing new relay entry generation
     * operation timed out. There is a certain timeout for a new relay entry
     * to be produced, see `relayEntryTimeout` value.
     */
    function hasEntryTimedOut() internal view returns (bool) {
        return currentEntryStartBlock != 0 && block.number > currentEntryStartBlock + relayEntryTimeout;
    }

    /**
     * @dev Function used to inform about the fact the currently ongoing
     * new relay entry generation operation timed out. As a result, the group
     * which was supposed to produce a new relay entry is immediately
     * terminated and a new group is selected to produce a new relay entry.
     * All members of the group are punished by seizing minimum stake of
     * their tokens. The submitter of the transaction is rewarded with a
     * tattletale reward which is limited to min(1, 20 / group_size) of the
     * maximum tattletale reward.
     */
    function reportRelayEntryTimeout() public {
        require(hasEntryTimedOut(), "Entry did not time out");
        groups.reportRelayEntryTimeout(signingRequest.groupIndex, groupSize, minimumStake);

        // We could terminate the last active group. If that's the case,
        // do not try to execute signing again because there is no group
        // which can handle it.
        if (numberOfGroups() > 0) {
            signRelayEntry(
                signingRequest.relayRequestId,
                signingRequest.previousEntry,
                signingRequest.serviceContract,
                signingRequest.entryVerificationAndProfitFee,
                signingRequest.callbackFee
            );
        }
    }

    /**
     * @dev Gets group profit fee expressed in wei.
     */
    function groupProfitFee() public view returns(uint256) {
        return groupMemberBaseReward.mul(groupSize);
    }

    /**
     * @dev Checks if the specified account has enough active stake to become
     * network operator and that this contract has been authorized for potential
     * slashing.
     *
     * Having the required minimum of active stake makes the operator eligible
     * to join the network. If the active stake is not currently undelegating,
     * operator is also eligible for work selection.
     *
     * @param staker Staker's address
     * @return True if has enough active stake to participate in the network,
     * false otherwise.
     */
    function hasMinimumStake(address staker) public view returns(bool) {
        return (
            stakingContract.activeStake(staker, address(this)) >= minimumStake
        );
    }

    /**
     * @dev Checks if group with the given public key is registered.
     */
    function isGroupRegistered(bytes memory groupPubKey) public view returns(bool) {
        return groups.isGroupRegistered(groupPubKey);
    }

    /**
     * @dev Checks if a group with the given public key is a stale group.
     * Stale group is an expired group which is no longer performing any
     * operations. It is important to understand that an expired group may
     * still perform some operations for which it was selected when it was still
     * active. We consider a group to be stale when it's expired and when its
     * expiration time and potentially executed operation timeout are both in
     * the past.
     */
    function isStaleGroup(bytes memory groupPubKey) public view returns(bool) {
        return groups.isStaleGroup(groupPubKey);
    }

    /**
     * @dev Gets the number of active groups. Expired and terminated groups are
     * not counted as active.
     */
    function numberOfGroups() public view returns(uint256) {
        return groups.numberOfGroups();
    }

    /**
     * @dev Returns accumulated group member rewards for provided group.
     */
    function getGroupMemberRewards(bytes memory groupPubKey) public view returns (uint256) {
        return groups.groupMemberRewards[groupPubKey];
    }

    /**
     * @dev Gets all indices in the provided group for a member.
     */
    function getGroupMemberIndices(bytes memory groupPubKey, address member) public view returns (uint256[] memory indices) {
        return groups.getGroupMemberIndices(groupPubKey, member);
    }

    /**
     * @dev Withdraws accumulated group member rewards for operator
     * using the provided group index and member indices. Once the
     * accumulated reward is withdrawn from the selected group, member is
     * removed from it. Rewards can be withdrawn only from stale group.
     * @param operator Operator address.
     * @param groupIndex Group index.
     * @param groupMemberIndices Array of member indices for the group member.
     */
    function withdrawGroupMemberRewards(address operator, uint256 groupIndex, uint256[] memory groupMemberIndices) public nonReentrant {
        uint256 accumulatedRewards = groups.withdrawFromGroup(operator, groupIndex, groupMemberIndices);
        (bool success, ) = stakingContract.magpieOf(operator).call.value(accumulatedRewards)("");
        if (success) {
        //    emit GroupMemberRewardsWithdrawn(stakingContract.magpieOf(operator), operator, accumulatedRewards, groupIndex);
        }
    }

    /**
    * @dev Gets the index of the first active group.
    */
    function getFirstActiveGroupIndex() public view returns (uint256) {
        return groups.expiredGroupOffset;
    }

    /**
    * @dev Gets group public key.
    */
    function getGroupPublicKey(uint256 groupIndex) public view returns (bytes memory) {
        return groups.getGroupPublicKey(groupIndex);
    }

    /**
     * @dev Estimates gas for group creation. Includes the cost of DKG and the
     * cost of triggering group selection.
     */
    function groupCreationGasEstimate() public view returns (uint256) {
        return dkgGasEstimate.add(groupSelectionGasEstimate);
    }

     /**
     * @dev Returns members of the given group by group public key.
     */
    function getGroupMembers(bytes memory groupPubKey) public view returns (address[] memory members) {
        return groups.getGroupMembers(groupPubKey);
    }

    /**
     * @dev Reports unauthorized signing for the provided group. Must provide
     * a valid signature of the group address as a message. Successful signature
     * verification means the private key has been leaked and all group members
     * should be punished by seizing their tokens. The submitter of this proof is
     * rewarded with 5% of the total seized amount scaled by the reward adjustment
     * parameter and the rest 95% is burned.
     */
    function reportUnauthorizedSigning(
        uint256 groupIndex,
        bytes memory signedGroupPubKey
    ) public {
        groups.reportUnauthorizedSigning(groupIndex, signedGroupPubKey, minimumStake);
    
    }

}
