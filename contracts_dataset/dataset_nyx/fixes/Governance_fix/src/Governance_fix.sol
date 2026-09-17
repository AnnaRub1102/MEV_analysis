
// File: https://github.com/frankenstien-831/openzeppelin-contracts-ethereum-package/blob/master/contracts/math/SafeMath.sol

pragma solidity ^0.5.8;


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
     //   emit OwnershipTransferred(address(0), _owner);
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
    //    emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    uint256[50] private ______gap;
}

// File: https://github.com/frankenstien-831/openzeppelin-contracts-ethereum-package/blob/master/contracts/token/ERC20/IERC20.sol


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

// File: https://github.com/frankenstien-831/openzeppelin-contracts-ethereum-package/blob/master/contracts/utils/Address.sol


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

// File: https://github.com/frankenstien-831/openzeppelin-contracts-ethereum-package/blob/master/contracts/token/ERC20/SafeERC20.sol


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

// File: https://github.com/frankenstien-831/openzeppelin-contracts-ethereum-package/blob/master/contracts/token/ERC20/ERC20.sol

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
contract ERC20 is Initializable, Context, IERC20 {
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
      //  emit Transfer(sender, recipient, amount);
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
     //   emit Transfer(address(0), account, amount);
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
      //  emit Transfer(account, address(0), amount);
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

    uint256[50] private ______gap;
}

// File: https://github.com/frankenstien-831/openzeppelin-contracts-ethereum-package/blob/master/contracts/token/ERC20/ERC20Burnable.sol

/**
 * @dev Extension of {ERC20} that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */
contract ERC20Burnable is Initializable, Context, ERC20 {
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

    uint256[50] private ______gap;
}

// File: @aragon/court/contracts/lib/Checkpointing.sol


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

// File: test.sol

/**
 * Wrapper around OpenZeppelin's Initializable contract.
 * Exposes initialized state management to ensure logic contract functions cannot be called before initialization.
 * This is needed because OZ's Initializable contract no longer exposes initialized state variable.
 * https://github.com/OpenZeppelin/openzeppelin-sdk/blob/v2.8.0/packages/lib/contracts/Initializable.sol
 */
contract InitializableV2 is Initializable {
    bool private isInitialized;

    string private constant ERROR_NOT_INITIALIZED = "InitializableV2: Not initialized";

    /**
     * @notice wrapper function around parent contract Initializable's `initializable` modifier
     *      initializable modifier ensures this function can only be called once by each deployed child contract
     *      sets isInitialized flag to true to which is used by _requireIsInitialized()
     */
    function initialize() public initializer {
        isInitialized = true;
    }

    /**
     * @notice Reverts transaction if isInitialized is false. Used by child contracts to ensure
     *      contract is initialized before functions can be called.
     */
    function _requireIsInitialized() internal view {
        require(isInitialized == true, ERROR_NOT_INITIALIZED);
    }

    /**
     * @notice Exposes isInitialized bool var to child contracts with read-only access
     */
    function _isInitialized() internal view returns (bool) {
        return isInitialized;
    }
}

contract Staking is InitializableV2 {
    using SafeMath for uint256;
    using Uint256Helpers for uint256;
    using Checkpointing for Checkpointing.History;
    using SafeERC20 for ERC20;

    string private constant ERROR_TOKEN_NOT_CONTRACT = "Staking: Staking token is not a contract";
    string private constant ERROR_AMOUNT_ZERO = "Staking: Zero amount not allowed";
    string private constant ERROR_ONLY_GOVERNANCE = "Staking: Only governance";
    string private constant ERROR_ONLY_DELEGATE_MANAGER = (
      "Staking: Only callable from DelegateManager"
    );
    string private constant ERROR_ONLY_SERVICE_PROVIDER_FACTORY = (
      "Staking: Only callable from ServiceProviderFactory"
    );

    address private governanceAddress;
    address private claimsManagerAddress;
    address private delegateManagerAddress;
    address private serviceProviderFactoryAddress;

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

    event Staked(address indexed user, uint256 amount, uint256 total);
    event Unstaked(address indexed user, uint256 amount, uint256 total);
    event Slashed(address indexed user, uint256 amount, uint256 total);

    /**
     * @notice Function to initialize the contract
     * @dev claimsManagerAddress must be initialized separately after ClaimsManager contract is deployed
     * @dev delegateManagerAddress must be initialized separately after DelegateManager contract is deployed
     * @dev serviceProviderFactoryAddress must be initialized separately after ServiceProviderFactory contract is deployed
     * @param _tokenAddress - address of ERC20 token that will be staked
     * @param _governanceAddress - address for Governance proxy contract
     */
    function initialize(
        address _tokenAddress,
        address _governanceAddress
    ) public initializer
    {
        require(Address.isContract(_tokenAddress), ERROR_TOKEN_NOT_CONTRACT);
        stakingToken = ERC20(_tokenAddress);
        _updateGovernanceAddress(_governanceAddress);
        InitializableV2.initialize();
    }

    /**
     * @notice Set the Governance address
     * @dev Only callable by Governance address
     * @param _governanceAddress - address for new Governance contract
     */
    function setGovernanceAddress(address _governanceAddress) external {
        _requireIsInitialized();

        require(msg.sender == governanceAddress, ERROR_ONLY_GOVERNANCE);
        _updateGovernanceAddress(_governanceAddress);
    }

    /**
     * @notice Set the ClaimsManaager address
     * @dev Only callable by Governance address
     * @param _claimsManager - address for new ClaimsManaager contract
     */
    function setClaimsManagerAddress(address _claimsManager) external {
        _requireIsInitialized();

        require(msg.sender == governanceAddress, ERROR_ONLY_GOVERNANCE);
        claimsManagerAddress = _claimsManager;
    }

    /**
     * @notice Set the ServiceProviderFactory address
     * @dev Only callable by Governance address
     * @param _spFactory - address for new ServiceProviderFactory contract
     */
    function setServiceProviderFactoryAddress(address _spFactory) external {
        _requireIsInitialized();

        require(msg.sender == governanceAddress, ERROR_ONLY_GOVERNANCE);
        serviceProviderFactoryAddress = _spFactory;
    }

    /**
     * @notice Set the DelegateManager address
     * @dev Only callable by Governance address
     * @param _delegateManager - address for new DelegateManager contract
     */
    function setDelegateManagerAddress(address _delegateManager) external {
        _requireIsInitialized();

        require(msg.sender == governanceAddress, ERROR_ONLY_GOVERNANCE);
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
        _requireClaimsManagerAddressIsSet();

        require(
            msg.sender == claimsManagerAddress,
            "Staking: Only callable from ClaimsManager"
        );
        _stakeFor(_stakerAccount, msg.sender, _amount);

        this.updateClaimHistory(_amount, _stakerAccount);
    }

    /**
     * @notice Update claim history by adding an event to the claim history
     * @param _amount - amount to add to claim history
     * @param _stakerAccount - address of staker
     */
    function updateClaimHistory(uint256 _amount, address _stakerAccount) external {
        _requireIsInitialized();
        _requireClaimsManagerAddressIsSet();

        require(
            msg.sender == claimsManagerAddress || msg.sender == address(this),
            "Staking: Only callable from ClaimsManager or Staking.sol"
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
        _requireDelegateManagerAddressIsSet();

        require(
            msg.sender == delegateManagerAddress,
            ERROR_ONLY_DELEGATE_MANAGER
        );

        // Burn slashed tokens from account
        _burnFor(_slashAddress, _amount);

      //  emit Slashed(
      //      _slashAddress,
      //      _amount,
      //      totalStakedFor(_slashAddress)
       // );
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
        _requireServiceProviderFactoryAddressIsSet();

        require(
            msg.sender == serviceProviderFactoryAddress,
            ERROR_ONLY_SERVICE_PROVIDER_FACTORY
        );
        _stakeFor(
            _accountAddress,
            _accountAddress,
            _amount
        );
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
        _requireServiceProviderFactoryAddressIsSet();

        require(
            msg.sender == serviceProviderFactoryAddress,
            ERROR_ONLY_SERVICE_PROVIDER_FACTORY
        );
        _unstakeFor(
            _accountAddress,
            _accountAddress,
            _amount
        );
    }

    /**
     * @notice Stakes `_amount` tokens, transferring them from `_delegatorAddress` to `_accountAddress`,
               only callable by DelegateManager
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
        _requireDelegateManagerAddressIsSet();

        require(
            msg.sender == delegateManagerAddress,
            ERROR_ONLY_DELEGATE_MANAGER
        );
        _stakeFor(
            _accountAddress,
            _delegatorAddress,
            _amount);
    }

    /**
     * @notice Unstakes '_amount` tokens, transferring them from `_accountAddress` to `_delegatorAddress`,
               only callable by DelegateManager
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
        _requireDelegateManagerAddressIsSet();

        require(
            msg.sender == delegateManagerAddress,
            ERROR_ONLY_DELEGATE_MANAGER
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
        _requireIsInitialized();

        return address(stakingToken);
    }

    /**
     * @notice Check whether it supports history of stakes
     * @return Always true
     */
    function supportsHistory() external view returns (bool) {
        _requireIsInitialized();

        return true;
    }

    /**
     * @notice Get last time `_accountAddress` modified its staked balance
     * @param _accountAddress - Account requesting for
     * @return Last block number when account's balance was modified
     */
    function lastStakedFor(address _accountAddress) external view returns (uint256) {
        _requireIsInitialized();

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
        _requireIsInitialized();

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
        _requireIsInitialized();

        return accounts[_accountAddress].stakedHistory.get(_blockNumber.toUint64());
    }

    /**
     * @notice Get the total amount of tokens staked by all users at block number `_blockNumber`
     * @param _blockNumber - Block number at which we are requesting
     * @return The amount of tokens staked at the given block number
     */
    function totalStakedAt(uint256 _blockNumber) external view returns (uint256) {
        _requireIsInitialized();

        return totalStakedHistory.get(_blockNumber.toUint64());
    }

    /// @notice Get the Governance address
    function getGovernanceAddress() external view returns (address) {
        _requireIsInitialized();

        return governanceAddress;
    }

    /// @notice Get the ClaimsManager address
    function getClaimsManagerAddress() external view returns (address) {
        _requireIsInitialized();

        return claimsManagerAddress;
    }

    /// @notice Get the ServiceProviderFactory address
    function getServiceProviderFactoryAddress() external view returns (address) {
        _requireIsInitialized();

        return serviceProviderFactoryAddress;
    }

    /// @notice Get the DelegateManager address
    function getDelegateManagerAddress() external view returns (address) {
        _requireIsInitialized();

        return delegateManagerAddress;
    }

    /**
     * @notice Helper function wrapped around totalStakedFor. Checks whether _accountAddress
            is currently a valid staker with a non-zero stake
     * @param _accountAddress - Account requesting for
     * @return Boolean indicating whether account is a staker
     */
    function isStaker(address _accountAddress) external view returns (bool) {
        _requireIsInitialized();

        return totalStakedFor(_accountAddress) > 0;
    }

    /* Public functions */

    /**
     * @notice Get the amount of tokens staked by `_accountAddress`
     * @param _accountAddress - The owner of the tokens
     * @return The amount of tokens staked by the given account
     */
    function totalStakedFor(address _accountAddress) public view returns (uint256) {
        _requireIsInitialized();

        // we assume it's not possible to stake in the future
        return accounts[_accountAddress].stakedHistory.getLast();
    }

    /**
     * @notice Get the total amount of tokens staked by all users
     * @return The total amount of tokens staked by all users
     */
    function totalStaked() public view returns (uint256) {
        _requireIsInitialized();

        // we assume it's not possible to stake in the future
        return totalStakedHistory.getLast();
    }

    // ========================================= Internal Functions =========================================

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
      //      _stakeAccount,
      //      _amount,
      //      totalStakedFor(_stakeAccount));
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

       // emit Unstaked(
       //     _stakeAccount,
       //     _amount,
       //     totalStakedFor(_stakeAccount)
      //  );
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
                "Staking: Cannot decrease greater than current balance");
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

    /**
     * @notice Set the governance address after confirming contract identity
     * @param _governanceAddress - Incoming governance address
     */
    function _updateGovernanceAddress(address _governanceAddress) internal {
        require(
            Governance(_governanceAddress).isGovernanceAddress() == true,
            "Staking: _governanceAddress is not a valid governance contract"
        );
        governanceAddress = _governanceAddress;
    }

    // ========================================= Private Functions =========================================

    function _requireClaimsManagerAddressIsSet() private view {
        require(claimsManagerAddress != address(0x00), "Staking: claimsManagerAddress is not set");
    }

    function _requireDelegateManagerAddressIsSet() private view {
        require(
            delegateManagerAddress != address(0x00),
            "Staking: delegateManagerAddress is not set"
        );
    }

    function _requireServiceProviderFactoryAddressIsSet() private view {
        require(
            serviceProviderFactoryAddress != address(0x00),
            "Staking: serviceProviderFactoryAddress is not set"
        );
    }

}


/**
* @title Central hub for Audius protocol. It stores all contract addresses to facilitate
*   external access and enable version management.
*/
contract Registry is InitializableV2, Ownable {
    using SafeMath for uint256;

    /**
     * @dev addressStorage mapping allows efficient lookup of current contract version
     *      addressStorageHistory maintains record of all contract versions
     */
    mapping(bytes32 => address) private addressStorage;
    mapping(bytes32 => address[]) private addressStorageHistory;

    event ContractAdded(
        bytes32 indexed _name,
        address indexed _address
    );

    event ContractRemoved(
        bytes32 indexed _name,
        address indexed _address
    );

    event ContractUpgraded(
        bytes32 indexed _name,
        address indexed _oldAddress,
        address indexed _newAddress
    );

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
            "Registry: Contract already registered with given name."
        );
        require(
            _address != address(0x00),
            "Registry: Cannot register zero address."
        );

        setAddress(_name, _address);

       // emit ContractAdded(_name, _address);
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
            "Registry: Cannot remove - no contract registered with given _name."
        );

        setAddress(_name, address(0x00));

     //   emit ContractRemoved(_name, contractAddress);
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
            "Registry: Cannot upgrade - no contract registered with given _name."
        );
        require(
            _newAddress != address(0x00),
            "Registry: Cannot upgrade - cannot register zero address."
        );

        setAddress(_name, _newAddress);

      //  emit ContractUpgraded(_name, oldAddress, _newAddress);
    }

    // ========================================= Getters =========================================

    /**
     * @notice returns contract address registered under given registry key
     * @param _name - registry key for lookup
     * @return contractAddr - address of contract registered under given registry key
     */
    function getContract(bytes32 _name) external view returns (address contractAddr) {
        _requireIsInitialized();

        return addressStorage[_name];
    }

    /// @notice overloaded getContract to return explicit version of contract
    function getContract(bytes32 _name, uint256 _version) external view
    returns (address contractAddr)
    {
        _requireIsInitialized();

        // array length for key implies version number
        require(
            _version <= addressStorageHistory[_name].length,
            "Registry: Index out of range _version."
        );
        return addressStorageHistory[_name][_version.sub(1)];
    }

    /**
     * @notice Returns the number of versions for a contract key
     * @param _name - registry key for lookup
     * @return number of contract versions
     */
    function getContractVersionCount(bytes32 _name) external view returns (uint256) {
        _requireIsInitialized();

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

contract Governance is InitializableV2 {
    using SafeMath for uint256;

    string private constant ERROR_INVALID_PROPOSAL = (
        "Governance: Must provide valid non-zero _proposalId"
    );
    string private constant ERROR_ONLY_GOVERNANCE = (
        "Governance: Only callable by self"
    );
    string private constant ERROR_INVALID_VOTING_PERIOD = (
        "Governance: Requires non-zero _votingPeriod"
    );
    string private constant ERROR_INVALID_REGISTRY = (
        "Governance: Requires non-zero _registryAddress"
    );
    string private constant ERROR_INVALID_VOTING_QUORUM = (
        "Governance: Requires _votingQuorumPercent between 1 & 100"
    );

    /**
     * @notice Address and contract instance of Audius Registry. Used to ensure this contract
     *      can only govern contracts that are registered in the Audius Registry.
     */
    Registry private registry;

    /// @notice Address of Audius staking contract, used to permission Governance method calls
    address private stakingAddress;

    /// @notice Period in blocks for which a governance proposal is open for voting
    uint256 private votingPeriod;

    /// @notice Number of blocks that must pass after votingPeriod has expired before proposal can be evaluated/executed
    uint256 private executionDelay;

    /// @notice Required minimum percentage of total stake to have voted to consider a proposal valid
    ///         Percentaged stored as a uint256 between 0 & 100
    ///         Calculated as: 100 * sum of voter stakes / total staked in Staking (at proposal submission block)
    uint256 private votingQuorumPercent;

    /// @notice Max number of InProgress proposals possible at once
    /// @dev uint16 gives max possible value of 65,535
    uint16 private maxInProgressProposals;

    /// @notice Max number of bytes allowed in a proposal description string
    uint16 private maxDescriptionLength;

    /**
     * @notice Address of account that has special Governance permissions. Can veto proposals
     *      and execute transactions directly on contracts.
     */
    address private guardianAddress;

    /***** Enums *****/

    /**
     * @notice All Proposal Outcome states.
     *      InProgress - Proposal is active and can be voted on.
     *      Rejected - Proposal votingPeriod has closed and vote failed to pass. Proposal will not be executed.
     *      ApprovedExecuted - Proposal votingPeriod has closed and vote passed. Proposal was successfully executed.
     *      QuorumNotMet - Proposal votingPeriod has closed and votingQuorumPercent was not met. Proposal will not be executed.
     *      ApprovedExecutionFailed - Proposal vote passed, but transaction execution failed.
     *      Evaluating - Proposal vote passed, and evaluateProposalOutcome function is currently running.
     *          This status is transiently used inside that function to prevent re-entrancy.
     *      Vetoed - Proposal was vetoed by Guardian.
     *      TargetContractAddressChanged - Proposal considered invalid since target contract address changed
     *      TargetContractCodeHashChanged - Proposal considered invalid since code has at target contract address has changed
     */
    enum Outcome {
        InProgress,
        Rejected,
        ApprovedExecuted,
        QuorumNotMet,
        ApprovedExecutionFailed,
        Evaluating,
        Vetoed,
        TargetContractAddressChanged,
        TargetContractCodeHashChanged
    }

    /**
     * @notice All Proposal Vote states for a voter.
     *      None - The default state, for any account that has not previously voted on this Proposal.
     *      No - The account voted No on this Proposal.
     *      Yes - The account voted Yes on this Proposal.
     * @dev Enum values map to uints, so first value in Enum always is 0.
     */
    enum Vote {None, No, Yes}

    struct Proposal {
        uint256 proposalId;
        address proposer;
        uint256 submissionBlockNumber;
        bytes32 targetContractRegistryKey;
        address targetContractAddress;
        uint256 callValue;
        string functionSignature;
        bytes callData;
        Outcome outcome;
        uint256 voteMagnitudeYes;
        uint256 voteMagnitudeNo;
        uint256 numVotes;
        mapping(address => Vote) votes;
        string description;
        bytes32 contractHash;
    }

    /***** Proposal storage *****/

    /// @notice ID of most recently created proposal. Ids are monotonically increasing and 1-indexed.
    uint256 lastProposalId = 0;

    /// @notice mapping of proposalId to Proposal struct with all proposal state
    mapping(uint256 => Proposal) proposals;

    /// @notice array of proposals with InProgress state
    uint256[] inProgressProposals;


    /***** Events *****/
    event ProposalSubmitted(
        uint256 indexed proposalId,
        address indexed proposer,
        uint256 submissionBlockNumber,
        string description
    );
    event ProposalVoteSubmitted(
        uint256 indexed proposalId,
        address indexed voter,
        Vote indexed vote,
        uint256 voterStake
    );
    event ProposalVoteUpdated(
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
        string indexed functionSignature,
        bytes indexed callData,
        bytes returnData
    );
    event ProposalVetoed(uint256 indexed proposalId);
    event RegistryAddressUpdated(address indexed newRegistryAddress);
    event GuardianshipTransferred(address indexed newGuardianAddress);

    /**
     * @notice Initialize the Governance contract
     * @dev _votingPeriod <= DelegateManager.undelegateLockupDuration
     * @dev stakingAddress must be initialized separately after Staking contract is deployed
     * @param _registryAddress - address of the registry proxy contract
     * @param _votingPeriod - period in blocks for which a governance proposal is open for voting
     * @param _executionDelay - number of blocks that must pass after votingPeriod has expired before proposal can be evaluated/executed
     * @param _votingQuorumPercent - required minimum percentage of total stake to have voted to consider a proposal valid
     * @param _maxInProgressProposals - max number of InProgress proposals possible at once
     * @param _guardianAddress - address of account that has special Governance permissions
     */
    function initialize(
        address _registryAddress,
        uint256 _votingPeriod,
        uint256 _executionDelay,
        uint256 _votingQuorumPercent,
        uint16 _maxInProgressProposals,
        uint16 _maxDescriptionLength,
        address _guardianAddress
    ) public initializer {
        require(_registryAddress != address(0x00), ERROR_INVALID_REGISTRY);
        registry = Registry(_registryAddress);

        require(_votingPeriod > 0, ERROR_INVALID_VOTING_PERIOD);
        votingPeriod = _votingPeriod;

        // executionDelay does not have to be non-zero
        executionDelay = _executionDelay;

        require(
            _maxInProgressProposals > 0,
            "Governance: Requires non-zero _maxInProgressProposals"
        );
        maxInProgressProposals = _maxInProgressProposals;

        require(_maxDescriptionLength > 0, "Governance: Requires non-zero _maxDescriptionLength");
        maxDescriptionLength = _maxDescriptionLength;

        require(
            _votingQuorumPercent > 0 && _votingQuorumPercent <= 100,
            ERROR_INVALID_VOTING_QUORUM
        );
        votingQuorumPercent = _votingQuorumPercent;

        require(
            _guardianAddress != address(0x00),
            "Governance: Requires non-zero _guardianAddress"
        );
        guardianAddress = _guardianAddress;  //Guardian address becomes the only party

        InitializableV2.initialize();
    }

    // ========================================= Governance Actions =========================================

    /**
     * @notice Submit a proposal for vote. Only callable by stakers with non-zero stake.
     * @param _targetContractRegistryKey - Registry key for the contract concerning this proposal
     * @param _callValue - amount of wei to pass with function call if a token transfer is involved
     * @param _functionSignature - function signature of the function to be executed if proposal is successful
     * @param _callData - encoded value(s) to call function with if proposal is successful
     * @param _description - Text description of proposal to be emitted in event
     * @return - ID of new proposal
     */
    function submitProposal(
        bytes32 _targetContractRegistryKey,
        uint256 _callValue,
        string calldata _functionSignature,
        bytes calldata _callData,
        string calldata _description
    ) external returns (uint256)
    {
        _requireIsInitialized();
        _requireStakingAddressIsSet();

        address proposer = msg.sender;

        // Require all InProgress proposals that can be evaluated have been evaluated before new proposal submission
        require(
            this.inProgressProposalsAreUpToDate(),
            "Governance: Cannot submit new proposal until all evaluatable InProgress proposals are evaluated."
        );

        // Require new proposal submission would not push number of InProgress proposals over max number
        require(
            inProgressProposals.length < maxInProgressProposals,
            "Governance: Number of InProgress proposals already at max. Please evaluate if possible, or wait for current proposals' votingPeriods to expire."
        );

        // Require proposer is active Staker or guardian address
        require(
            Staking(stakingAddress).isStaker(proposer) || proposer == guardianAddress,
            "Governance: Proposer must be active staker with non-zero stake or guardianAddress."
        );

        // Require _targetContractRegistryKey points to a valid registered contract
        address targetContractAddress = registry.getContract(_targetContractRegistryKey);
        require(
            targetContractAddress != address(0x00),
            "Governance: _targetContractRegistryKey must point to valid registered contract"
        );

        // Signature cannot be empty
        require(
            bytes(_functionSignature).length != 0,
            "Governance: _functionSignature cannot be empty."
        );

        // Require description length in bytes is within bounds
        require(
            bytes(_description).length > 0 && bytes(_description).length <= maxDescriptionLength,
            "Governance: _description length must be between 1 and maxDescriptionLength"
        );

        // set proposalId
        uint256 newProposalId = lastProposalId.add(1);

        // Store new Proposal obj in proposals mapping
        proposals[newProposalId] = Proposal({
            proposalId: newProposalId,
            proposer: proposer,
            submissionBlockNumber: block.number,
            targetContractRegistryKey: _targetContractRegistryKey,
            targetContractAddress: targetContractAddress,
            callValue: _callValue,
            functionSignature: _functionSignature,
            callData: _callData,
            outcome: Outcome.InProgress,
            voteMagnitudeYes: 0,
            voteMagnitudeNo: 0,
            numVotes: 0,
            description: _description,
            contractHash: _getCodeHash(targetContractAddress)
            /* votes: mappings are auto-initialized to default state */
        });

        // Append new proposalId to inProgressProposals array
        inProgressProposals.push(newProposalId);

      //  emit ProposalSubmitted(
     //       newProposalId,
      //      proposer,
      //      block.number,
      //      _description
      //  );

        lastProposalId = newProposalId;

        return newProposalId;
    }

    /**
     * @notice Vote on an active Proposal. Only callable by stakers with non-zero stake.
     * @param _proposalId - id of the proposal this vote is for
     * @param _vote - can be either {Yes, No} from Vote enum. No other values allowed
     */
    function submitVote(uint256 _proposalId, Vote _vote) external {
        _requireIsInitialized();
        _requireStakingAddressIsSet();

        address voter = msg.sender;

        // Validates new _vote, _proposalId, proposal state, and voter state + returns voterStake
        uint256 voterStake = _validateVoteAndGetVoterStake(voter, _proposalId, _vote);

        // Ensure previous vote is None
        require(
            proposals[_proposalId].votes[voter] == Vote.None,
            "Governance: To update previous vote, call updateVote()"
        );

        // Record vote
        proposals[_proposalId].votes[voter] = _vote;

        // Update vote magnitudes
        if (_vote == Vote.Yes) {
            _increaseVoteMagnitudeYes(_proposalId, voterStake);
        } else {
            _increaseVoteMagnitudeNo(_proposalId, voterStake);
        }

        // Update numVotes
        proposals[_proposalId].numVotes = proposals[_proposalId].numVotes.add(1);

      //  emit ProposalVoteSubmitted(
       //     _proposalId,
       //     voter,
        //    _vote,
        //    voterStake
       // );
    }

    /**
     * @notice Update previous vote on an active Proposal. Only callable by stakers with non-zero stake.
     * @param _proposalId - id of the proposal this vote is for
     * @param _vote - can be either {Yes, No} from Vote enum. No other values allowed
     */
    function updateVote(uint256 _proposalId, Vote _vote) external {
        _requireIsInitialized();
        _requireStakingAddressIsSet();

        address voter = msg.sender;

        // Validates new _vote, _proposalId, proposal state, and voter state + returns voterStake
        uint256 voterStake = _validateVoteAndGetVoterStake(voter, _proposalId, _vote);

        // Record previous vote
        Vote previousVote = proposals[_proposalId].votes[voter];

        // Ensure previous vote is not None
        require(
            previousVote != Vote.None,
            "Governance: To submit new vote, call submitVote()"
        );

        // Override previous vote
        proposals[_proposalId].votes[voter] = _vote;

        // Update vote magnitudes
        if (previousVote == Vote.Yes && _vote == Vote.No) {
            _decreaseVoteMagnitudeYes(_proposalId, voterStake);
            _increaseVoteMagnitudeNo(_proposalId, voterStake);
        } else if (previousVote == Vote.No && _vote == Vote.Yes) {
            _decreaseVoteMagnitudeNo(_proposalId, voterStake);
            _increaseVoteMagnitudeYes(_proposalId, voterStake);
        }
        // If _vote == previousVote, no changes needed to vote magnitudes.

        // Do not update numVotes

      //  emit ProposalVoteUpdated(
      //      _proposalId,
       //     voter,
       //     _vote,
       //     voterStake,
       //     previousVote
      //  );
    }

    /**
     * @notice Once the voting period + executionDelay for a proposal has ended, evaluate the outcome and
     *      execute the proposal if voting quorum met & vote passes.
     *      To pass, stake-weighted vote must be > 50% Yes.
     * @dev Requires that caller is an active staker at the time the proposal is created
     * @param _proposalId - id of the proposal
     * @return Outcome of proposal evaluation
     */
    function evaluateProposalOutcome(uint256 _proposalId)
    external returns (Outcome)
    {
        _requireIsInitialized();
        _requireStakingAddressIsSet();

        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            ERROR_INVALID_PROPOSAL
        );

        // Require proposal has not already been evaluated.
        require(
            proposals[_proposalId].outcome == Outcome.InProgress,
            "Governance: Can only evaluate InProgress proposal."
        );

        // Re-entrancy should not be possible here since this switches the status of the
        // proposal to 'Evaluating' so it should fail the status is 'InProgress' check
        proposals[_proposalId].outcome = Outcome.Evaluating;

        // Require proposal votingPeriod + executionDelay have ended.
        uint256 submissionBlockNumber = proposals[_proposalId].submissionBlockNumber;
        uint256 endBlockNumber = submissionBlockNumber.add(votingPeriod).add(executionDelay);
        require(
            block.number > endBlockNumber,
            "Governance: Proposal votingPeriod & executionDelay must end before evaluation."
        );

        address targetContractAddress = registry.getContract(
            proposals[_proposalId].targetContractRegistryKey
        );

        Outcome outcome;

        // target contract address changed -> close proposal without execution.
        if (targetContractAddress != proposals[_proposalId].targetContractAddress) {
            outcome = Outcome.TargetContractAddressChanged;
        }
        else if (_getCodeHash(targetContractAddress) != proposals[_proposalId].contractHash) {
            outcome = Outcome.TargetContractCodeHashChanged;
        }
        // voting quorum not met -> close proposal without execution.
        else if (_quorumMet(proposals[_proposalId], Staking(stakingAddress)) == false) {
            outcome = Outcome.QuorumNotMet;
        }
        // votingQuorumPercent met & vote passed -> execute proposed transaction & close proposal.
        else if (
            proposals[_proposalId].voteMagnitudeYes > proposals[_proposalId].voteMagnitudeNo
        ) {
            (bool success, bytes memory returnData) = _executeTransaction(
                targetContractAddress,
                proposals[_proposalId].callValue,
                proposals[_proposalId].functionSignature,
                proposals[_proposalId].callData
            );

          //  emit ProposalTransactionExecuted(
          //      _proposalId,
          //      success,
           //     returnData
          //  );

            // Proposal outcome depends on success of transaction execution.
            if (success) {
                outcome = Outcome.ApprovedExecuted;
            } else {
                outcome = Outcome.ApprovedExecutionFailed;
            }
        }
        // votingQuorumPercent met & vote did not pass -> close proposal without transaction execution.
        else {
            outcome = Outcome.Rejected;
        }

        // This records the final outcome in the proposals mapping
        proposals[_proposalId].outcome = outcome;

        // Remove from inProgressProposals array
        _removeFromInProgressProposals(_proposalId);

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
            "Governance: Only guardian can veto proposals."
        );

        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Governance: Must provide valid non-zero _proposalId."
        );

        require(
            proposals[_proposalId].outcome == Outcome.InProgress,
            "Governance: Cannot veto inactive proposal."
        );

        proposals[_proposalId].outcome = Outcome.Vetoed;

        // Remove from inProgressProposals array
        _removeFromInProgressProposals(_proposalId);

        emit ProposalVetoed(_proposalId);
    }

    // ========================================= Config Setters =========================================

    /**
     * @notice Set the Staking address
     * @dev Only callable by self via _executeTransaction
     * @param _stakingAddress - address for new Staking contract
     */
    function setStakingAddress(address _stakingAddress) external {
        _requireIsInitialized();

        require(msg.sender == address(this), ERROR_ONLY_GOVERNANCE);
        require(_stakingAddress != address(0x00), "Governance: Requires non-zero _stakingAddress");
        stakingAddress = _stakingAddress;
    }

    /**
     * @notice Set the voting period for a Governance proposal
     * @dev Only callable by self via _executeTransaction
     * @param _votingPeriod - new voting period
     */
    function setVotingPeriod(uint256 _votingPeriod) external {
        _requireIsInitialized();

        require(msg.sender == address(this), ERROR_ONLY_GOVERNANCE);
        require(_votingPeriod > 0, ERROR_INVALID_VOTING_PERIOD);
        votingPeriod = _votingPeriod;
    }

    /**
     * @notice Set the voting quorum percentage for a Governance proposal
     * @dev Only callable by self via _executeTransaction
     * @param _votingQuorumPercent - new voting period
     */
    function setVotingQuorumPercent(uint256 _votingQuorumPercent) external {
        _requireIsInitialized();

        require(msg.sender == address(this), ERROR_ONLY_GOVERNANCE);
        require(
            _votingQuorumPercent > 0 && _votingQuorumPercent <= 100,
            ERROR_INVALID_VOTING_QUORUM
        );
        votingQuorumPercent = _votingQuorumPercent;
    }

    /**
     * @notice Set the Registry address
     * @dev Only callable by self via _executeTransaction
     * @param _registryAddress - address for new Registry contract
     */
    function setRegistryAddress(address _registryAddress) external {
        _requireIsInitialized();

        require(msg.sender == address(this), ERROR_ONLY_GOVERNANCE);
        require(_registryAddress != address(0x00), ERROR_INVALID_REGISTRY);

        registry = Registry(_registryAddress);

    //    emit RegistryAddressUpdated(_registryAddress);
    }

    /**
     * @notice Set the max number of concurrent InProgress proposals
     * @dev Only callable by self via _executeTransaction
     * @param _newMaxInProgressProposals - new value for maxInProgressProposals
     */
    function setMaxInProgressProposals(uint16 _newMaxInProgressProposals) external {
        _requireIsInitialized();

        require(msg.sender == address(this), ERROR_ONLY_GOVERNANCE);
        require(
            _newMaxInProgressProposals > 0,
            "Governance: Requires non-zero _newMaxInProgressProposals"
        );
        maxInProgressProposals = _newMaxInProgressProposals;
    }

    /**
     * @notice Set the max length in bytes allowed for a proposal description string
     * @dev Only callable by self via _executeTransaction
     * @param _newMaxDescriptionLength - new value for maxDescriptionLength
     */
    function setMaxDescriptionLength(uint16 _newMaxDescriptionLength) external {
        _requireIsInitialized();

        require(msg.sender == address(this), "Only callable by self");
        require(
            _newMaxDescriptionLength > 0,
            "Governance: Requires non-zero _newMaxDescriptionLength"
        );
        maxDescriptionLength = _newMaxDescriptionLength;
    }

    /**
     * @notice Set the execution delay for a proposal
     * @dev Only callable by self via _executeTransaction
     * @param _newExecutionDelay - new value for executionDelay
     */
    function setExecutionDelay(uint256 _newExecutionDelay) external {
        _requireIsInitialized();

        require(msg.sender == address(this), ERROR_ONLY_GOVERNANCE);
        // executionDelay does not have to be non-zero
        executionDelay = _newExecutionDelay;
    }

    // ========================================= Guardian Actions =========================================

    /**
     * @notice Allows the guardianAddress to execute protocol actions
     * @param _targetContractRegistryKey - key in registry of target contract
     * @param _callValue - amount of wei if a token transfer is involved
     * @param _functionSignature - function signature of the function to be executed if proposal is successful
     * @param _callData - encoded value(s) to call function with if proposal is successful
     */
    function guardianExecuteTransaction(
        bytes32 _targetContractRegistryKey,
        uint256 _callValue,
        string calldata _functionSignature,
        bytes calldata _callData
    ) external
    {
        _requireIsInitialized();

        require(
            msg.sender == guardianAddress,
            "Governance: Only guardian."
        );

        // _targetContractRegistryKey must point to a valid registered contract
        address targetContractAddress = registry.getContract(_targetContractRegistryKey);
        require(
            targetContractAddress != address(0x00),
            "Governance: _targetContractRegistryKey must point to valid registered contract"
        );

        // Signature cannot be empty
        require(
            bytes(_functionSignature).length != 0,
            "Governance: _functionSignature cannot be empty."
        );

        (bool success, bytes memory returnData) = _executeTransaction(
            targetContractAddress,
            _callValue,
            _functionSignature,
            _callData
        );

        require(success, "Governance: Transaction failed.");

      //  emit GuardianTransactionExecuted(
      //      targetContractAddress,
       //     _callValue,
       //     _functionSignature,
      //      _callData,
      //      returnData
      //  );
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
            "Governance: Only guardian."
        );

        guardianAddress = _newGuardianAddress;

     //   emit GuardianshipTransferred(_newGuardianAddress);
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
        uint256 submissionBlockNumber,
        bytes32 targetContractRegistryKey,
        address targetContractAddress,
        uint256 callValue,
        string memory functionSignature,
        bytes memory callData,
        Outcome outcome,
        uint256 voteMagnitudeYes,
        uint256 voteMagnitudeNo,
        uint256 numVotes
    )
    {
        _requireIsInitialized();

        // TODO: Move error to string
        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Governance: Must provide valid non-zero _proposalId"
        );

        Proposal memory proposal = proposals[_proposalId];
        return (
            proposal.proposalId,
            proposal.proposer,
            proposal.submissionBlockNumber,
            proposal.targetContractRegistryKey,
            proposal.targetContractAddress,
            proposal.callValue,
            proposal.functionSignature,
            proposal.callData,
            proposal.outcome,
            proposal.voteMagnitudeYes,
            proposal.voteMagnitudeNo,
            proposal.numVotes
            /** @notice - votes mapping cannot be returned by external function */
        );
    }

     /**
     * @notice Get proposal target contract hash by proposalId
     * @dev This is a separate function because the getProposalById returns too many
            variables already and by adding more, you get the error
            `InternalCompilerError: Stack too deep, try using fewer variables`
     * @param _proposalId - id of proposal
     */
    function getProposalTargetContractHash(uint256 _proposalId)
    external view returns (bytes32)
    {
        _requireIsInitialized();

        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Governance: Must provide valid non-zero _proposalId"
        );

        return (proposals[_proposalId].contractHash);
    }

     /**
     * @notice Get proposal description by proposalId
     * @dev This is a separate function because the getProposalById returns too many
            variables already and by adding more, you get the error
            `InternalCompilerError: Stack too deep, try using fewer variables`
     * @param _proposalId - id of proposal
     */
    function getProposalDescriptionById(uint256 _proposalId)
    external view returns (string memory)
    {
        _requireIsInitialized();

        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Governance: Must provide valid non-zero _proposalId"
        );

        return (proposals[_proposalId].description);
    }

    /**
     * @notice Get how a voter voted for a given proposal
     * @param _proposalId - id of the proposal
     * @param _voter - address of the voter we want to check
     * @return returns a value from the Vote enum if a valid vote, otherwise returns no value
     */
    function getVoteByProposalAndVoter(uint256 _proposalId, address _voter)
    external view returns (Vote)
    {
        _requireIsInitialized();

        // TODO: Move error to string
        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Governance: Must provide valid non-zero _proposalId"
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
        _requireIsInitialized();

        return stakingAddress;
    }

    /// @notice Get the contract voting period
    function getVotingPeriod() external view returns (uint256) {
        _requireIsInitialized();

        return votingPeriod;
    }

    /// @notice Get the contract voting quorum percent
    function getVotingQuorumPercent() external view returns (uint256) {
        _requireIsInitialized();

        return votingQuorumPercent;
    }

    /// @notice Get the registry address
    function getRegistryAddress() external view returns (address) {
        _requireIsInitialized();

        return address(registry);
    }

    /// @notice Used to check if is governance contract before setting governance address in other contracts
    function isGovernanceAddress() external pure returns (bool) {
        return true;
    }

    /// @notice Get the max number of concurrent InProgress proposals
    function getMaxInProgressProposals() external view returns (uint16) {
        _requireIsInitialized();

        return maxInProgressProposals;
    }

    /// @notice Get the proposal execution delay
    function getExecutionDelay() external view returns (uint256) {
        _requireIsInitialized();

        return executionDelay;
    }

    /// @notice Get the max length in bytes of a proposal description string
    function getMaxDescriptionLength() external view returns (uint16) {
        _requireIsInitialized();

        return maxDescriptionLength;
    }

    /// @notice Get the array of all InProgress proposal Ids
    function getInProgressProposals() external view returns (uint256[] memory) {
        _requireIsInitialized();

        return inProgressProposals;
    }

    /**
     * @notice Returns false if any proposals in inProgressProposals array are evaluatable
     *          Evaluatable = proposals with closed votingPeriod
     * @dev Is public since its called internally in `submitProposal()` as well as externally in UI
     */
    function inProgressProposalsAreUpToDate() external view returns (bool) {
        _requireIsInitialized();

        // compare current block number against endBlockNumber of each proposal
        for (uint256 i = 0; i < inProgressProposals.length; i++) {
            if (
                block.number >
                (proposals[inProgressProposals[i]].submissionBlockNumber).add(votingPeriod).add(executionDelay)
            ) {
                return false;
            }
        }

        return true;
    }

    // ========================================= Internal Functions =========================================

    /**
     * @notice Execute a transaction attached to a governance proposal
     * @dev We are aware of both potential re-entrancy issues and the risks associated with low-level solidity
     *      function calls here, but have chosen to keep this code with those issues in mind. All governance
     *      proposals go through a voting process, and all will be reviewed carefully to ensure that they
     *      adhere to the expected behaviors of this call - but adding restrictions here would limit the ability
     *      of the governance system to do required work in a generic way.
     * @param _targetContractAddress - address of registry proxy contract to execute transaction on
     * @param _callValue - amount of wei if a token transfer is involved
     * @param _functionSignature - function signature of the function to be executed if proposal is successful
     * @param _callData - encoded value(s) to call function with if proposal is successful
     */
    function _executeTransaction(
        address _targetContractAddress,
        uint256 _callValue,
        string memory _functionSignature,
        bytes memory _callData
    ) internal returns (bool success, bytes memory returnData)
    {
        bytes memory encodedCallData = abi.encodePacked(
            bytes4(keccak256(bytes(_functionSignature))),
            _callData
        );
        (success, returnData) = (
            // solium-disable-next-line security/no-call-value
            _targetContractAddress.call.value(_callValue)(encodedCallData)
        );

        return (success, returnData);
    }

    function _increaseVoteMagnitudeYes(uint256 _proposalId, uint256 _voterStake) internal {
        proposals[_proposalId].voteMagnitudeYes = (
            proposals[_proposalId].voteMagnitudeYes.add(_voterStake)
        );
    }

    function _increaseVoteMagnitudeNo(uint256 _proposalId, uint256 _voterStake) internal {
        proposals[_proposalId].voteMagnitudeNo = (
            proposals[_proposalId].voteMagnitudeNo.add(_voterStake)
        );
    }

    function _decreaseVoteMagnitudeYes(uint256 _proposalId, uint256 _voterStake) internal {
        proposals[_proposalId].voteMagnitudeYes = (
            proposals[_proposalId].voteMagnitudeYes.sub(_voterStake)
        );
    }

    function _decreaseVoteMagnitudeNo(uint256 _proposalId, uint256 _voterStake) internal {
        proposals[_proposalId].voteMagnitudeNo = (
            proposals[_proposalId].voteMagnitudeNo.sub(_voterStake)
        );
    }

    /**
     * @dev Can make O(1) by storing index pointer in proposals mapping.
     *      Requires inProgressProposals to be 1-indexed, since all proposals that are not present
     *          will have pointer set to 0.
     */
    function _removeFromInProgressProposals(uint256 _proposalId) internal {
        uint256 index = 0;
        for (uint256 i = 0; i < inProgressProposals.length; i++) {
            if (inProgressProposals[i] == _proposalId) {
                index = i;
                break;
            }
        }

        // Swap proposalId to end of array + pop (deletes last elem + decrements array length)
        inProgressProposals[index] = inProgressProposals[inProgressProposals.length - 1];
        inProgressProposals.pop();
    }

    /**
     * @notice Returns true if voting quorum percentage met for proposal, else false.
     * @dev Quorum is met if total voteMagnitude * 100 / total active stake in Staking
     * @dev Eventual multiplication overflow:
     *      (proposal.voteMagnitudeYes + proposal.voteMagnitudeNo), with 100% staking participation,
     *          can sum to at most the entire token supply of 10^27
     *      With 7% annual token supply inflation, multiplication can overflow ~1635 years at the earliest:
     *      log(2^256/(10^27*100))/log(1.07) ~= 1635
     */
    function _quorumMet(Proposal memory proposal, Staking stakingContract)
    internal view returns (bool)
    {
        uint256 participation = (
            (proposal.voteMagnitudeYes + proposal.voteMagnitudeNo)
            .mul(100)
            .div(stakingContract.totalStakedAt(proposal.submissionBlockNumber))
        );
        return participation >= votingQuorumPercent;
    }

    // ========================================= Private Functions =========================================

    function _requireStakingAddressIsSet() private view {
        require(
            stakingAddress != address(0x00),
            "Governance: stakingAddress is not set"
        );
    }

    /**
     * @notice Helper function to perform validation for submitVote() and updateVote() functions
     * @dev Validates new _vote, _proposalId, proposal state, and voter state
     * @return stake of voter at proposal submission time
     */
    function _validateVoteAndGetVoterStake(address _voter, uint256 _proposalId, Vote _vote)
    private view returns (uint256) {
        require(
            _proposalId <= lastProposalId && _proposalId > 0,
            "Governance: Must provide valid non-zero _proposalId"
        );

        // Require voter was active Staker at proposal submission time
        uint256 voterStake = Staking(stakingAddress).totalStakedForAt(
            _voter,
            proposals[_proposalId].submissionBlockNumber
        );
        require(
            voterStake > 0,
            "Governance: Voter must be active staker with non-zero stake."
        );

        // Require proposal is still active
        require(
            proposals[_proposalId].outcome == Outcome.InProgress,
            "Governance: Cannot vote on inactive proposal."
        );

        // Require proposal votingPeriod is still active.
        uint256 submissionBlockNumber = proposals[_proposalId].submissionBlockNumber;
        uint256 endBlockNumber = submissionBlockNumber.add(votingPeriod);
        require(
            block.number > submissionBlockNumber && block.number <= endBlockNumber,
            "Governance: Proposal votingPeriod has ended"
        );

        // Require vote is either Yes or No
        require(
            _vote == Vote.Yes || _vote == Vote.No,
            "Governance: Can only submit a Yes or No vote"
        );

        return voterStake;
    }

    // solium-disable security/no-inline-assembly
    /**
     * @notice Helper function to generate the code hash for a contract address
     * @return contract code hash
     */
    function _getCodeHash(address _contract) private view returns (bytes32) {
        bytes32 contractHash;
        assembly {
          contractHash := extcodehash(_contract)
        }
        return contractHash;
    }
}