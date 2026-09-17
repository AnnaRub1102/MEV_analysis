
// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/lib/CompoundOracleInterface.sol

pragma solidity 0.5.10;
// AT MAINNET ADDRESS: 0x02557a5E05DeFeFFD4cAe6D83eA3d173B272c904
contract CompoundOracleInterface {
    // returns asset:eth -- to get USDC:eth, have to do 10**24/result,


    constructor() public {
    }

    /**
  * @notice retrieves price of an asset
  * @dev function to get price for an asset
  * @param asset Asset for which to get the price
  * @return uint mantissa of asset price (scaled by 1e18) or zero if unset or contract paused
  */
    function getPrice(address asset) public view returns (uint);
    // function getPrice(address asset) public view returns (uint) {
    //     return 527557000000000;
    // }

}

// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/lib/UniswapExchangeInterface.sol

pragma solidity 0.5.10;


// Solidity Interface
contract UniswapExchangeInterface {
    // Address of ERC20 token sold on this exchange
    function tokenAddress() external view returns (address token);
    // Address of Uniswap Factory
    function factoryAddress() external view returns (address factory);
    // Provide Liquidity
    function addLiquidity(uint256 min_liquidity, uint256 max_tokens, uint256 deadline) external payable returns (uint256);
    function removeLiquidity(uint256 amount, uint256 min_eth, uint256 min_tokens, uint256 deadline) external returns (uint256, uint256);
    // Get Prices
    function getEthToTokenInputPrice(uint256 eth_sold) external view returns (uint256 tokens_bought);
    function getEthToTokenOutputPrice(uint256 tokens_bought) external view returns (uint256 eth_sold);
    function getTokenToEthInputPrice(uint256 tokens_sold) external view returns (uint256 eth_bought);
    function getTokenToEthOutputPrice(uint256 eth_bought) external view returns (uint256 tokens_sold);
    // Trade ETH to ERC20
    function ethToTokenSwapInput(uint256 min_tokens, uint256 deadline) external payable returns (uint256  tokens_bought);
    function ethToTokenTransferInput(uint256 min_tokens, uint256 deadline, address recipient) external payable returns (uint256  tokens_bought);
    function ethToTokenSwapOutput(uint256 tokens_bought, uint256 deadline) external payable returns (uint256  eth_sold);
    function ethToTokenTransferOutput(uint256 tokens_bought, uint256 deadline, address recipient) external payable returns (uint256  eth_sold);
    // Trade ERC20 to ETH
    function tokenToEthSwapInput(uint256 tokens_sold, uint256 min_eth, uint256 deadline) external returns (uint256  eth_bought);
    function tokenToEthTransferInput(uint256 tokens_sold, uint256 min_eth, uint256 deadline, address recipient) external returns (uint256  eth_bought);
    function tokenToEthSwapOutput(uint256 eth_bought, uint256 max_tokens, uint256 deadline) external returns (uint256  tokens_sold);
    function tokenToEthTransferOutput(uint256 eth_bought, uint256 max_tokens, uint256 deadline, address recipient) external returns (uint256  tokens_sold);
    // Trade ERC20 to ERC20
    function tokenToTokenSwapInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address token_addr) external returns (uint256  tokens_bought);
    function tokenToTokenTransferInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address recipient, address token_addr) external returns (uint256  tokens_bought);
    function tokenToTokenSwapOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address token_addr) external returns (uint256  tokens_sold);
    function tokenToTokenTransferOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address recipient, address token_addr) external returns (uint256  tokens_sold);
    // Trade ERC20 to Custom Pool
    function tokenToExchangeSwapInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address exchange_addr) external returns (uint256  tokens_bought);
    function tokenToExchangeTransferInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address recipient, address exchange_addr) external returns (uint256  tokens_bought);
    function tokenToExchangeSwapOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address exchange_addr) external returns (uint256  tokens_sold);
    function tokenToExchangeTransferOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address recipient, address exchange_addr) external returns (uint256  tokens_sold);
    // ERC20 comaptibility for liquidity tokens
    bytes32 public name;
    bytes32 public symbol;
    uint256 public decimals;
    function transfer(address _to, uint256 _value) external returns (bool);
    function transferFrom(address _from, address _to, uint256 value) external returns (bool);
    function approve(address _spender, uint256 _value) external returns (bool);
    function allowance(address _owner, address _spender) external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256);
    function totalSupply() external view returns (uint256);
    // Never use
    function setup(address token_addr) external;
}

// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/lib/UniswapFactoryInterface.sol

pragma solidity 0.5.10;


// Solidity Interface
contract UniswapFactoryInterface {
    // Public Variables
    address public exchangeTemplate;
    uint256 public tokenCount;
    // // Create Exchange
    function createExchange(address token) external returns (address exchange);
    // Get Exchange and Token Info
    function getExchange(address token) external view returns (address exchange);
    function getToken(address exchange) external view returns (address token);
    function getTokenWithId(uint256 tokenId) external view returns (address token);
    // Never use
    function initializeFactory(address template) external;
    // function createExchange(address token) external returns (address exchange) {
    //     return 0x06D014475F84Bb45b9cdeD1Cf3A1b8FE3FbAf128;
    // }
    // // Get Exchange and Token Info
    // function getExchange(address token) external view returns (address exchange){
    //     return 0x06D014475F84Bb45b9cdeD1Cf3A1b8FE3FbAf128;
    // }
    // function getToken(address exchange) external view returns (address token) {
    //     return 0x06D014475F84Bb45b9cdeD1Cf3A1b8FE3FbAf128;
    // }
    // function getTokenWithId(uint256 tokenId) external view returns (address token) {
    //     return 0x06D014475F84Bb45b9cdeD1Cf3A1b8FE3FbAf128;
    // }
}

// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/op2/contracts/token/ERC20/IERC20.sol

pragma solidity 0.5.10;

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

// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/OptionsUtils.sol

pragma solidity 0.5.10;





contract OptionsUtils {
    // defauls are for mainnet
    UniswapFactoryInterface public UNISWAP_FACTORY = UniswapFactoryInterface(
        0xc0a47dFe034B400B47bDaD5FecDa2621de6c4d95
    );

    CompoundOracleInterface public COMPOUND_ORACLE = CompoundOracleInterface(
        0x02557a5E05DeFeFFD4cAe6D83eA3d173B272c904
    );

    constructor (address _uniswapFactory, address _compoundOracle) public {
        UNISWAP_FACTORY = UniswapFactoryInterface(_uniswapFactory);
        COMPOUND_ORACLE = CompoundOracleInterface(_compoundOracle);
    }

    // TODO: for now gets Uniswap, later update to get other exchanges
    function getExchange(address _token) public view returns (UniswapExchangeInterface) {
        UniswapExchangeInterface exchange = UniswapExchangeInterface(
            UNISWAP_FACTORY.getExchange(_token)
        );

        if (address(exchange) == address(0)) {
            revert("No payout exchange");
        }

        return exchange;
    }

    function isETH(IERC20 _ierc20) public pure returns (bool) {
        return _ierc20 == IERC20(0);
    }
}

// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/OptionsExchange.sol

pragma solidity 0.5.10;







contract OptionsExchange is OptionsUtils {

    uint256 constant LARGE_BLOCK_SIZE = 1651753129000;

    constructor (address _uniswapFactory, address _compoundOracle)
        OptionsUtils(_uniswapFactory, _compoundOracle)
        public
    {
    }

    // TODO: write these functions later
    function sellPTokens(uint256 _pTokens, address payoutTokenAddress) public {
        // TODO: first need to boot strap the uniswap exchange to get the address.
        // uniswap transfer input _pTokens to payoutTokens
    }

    // TODO: write these functions later
    function buyPTokens(uint256 _pTokens, address paymentTokenAddress) public payable {
        // uniswap transfer output. This transfer enough paymentToken to get desired pTokens.
    }

}

// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/op2/contracts/GSN/Context.sol

pragma solidity 0.5.10;

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

// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/op2/contracts/math/SafeMath.sol

pragma solidity 0.5.10;

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

// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/op2/contracts/token/ERC20/ERC20.sol

pragma solidity 0.5.10;




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
        // emit Transfer(account, address(0), amount);
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
      //  emit Approval(owner, spender, amount);
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

// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/op2/contracts/ownership/Ownable.sol

pragma solidity 0.5.10;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
      //  emit OwnershipTransferred(address(0), msgSender);
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
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
     //   emit OwnershipTransferred(_owner, address(0));
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
        // emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/OptionsContract.sol

pragma solidity 0.5.10;










/**
 * @title Opyn's Options Contract
 * @author Opyn
 */
contract OptionsContract is Ownable, OptionsUtils, ERC20 {
    using SafeMath for uint256;

    struct Number {
        uint256 value;
        int32 exponent;
    }

    // Keeps track of the collateral, debt for each repo.
    struct Repo {
        uint256 collateral;
        uint256 putsOutstanding;
        address payable owner;
    }

    OptionsExchange public optionsExchange;

    Repo[] public repos;

    // 10 is 0.01 i.e. 1% incentive.
    Number liquidationIncentive = Number(10, -3);


    // 100 is egs. 0.1 i.e. 10%.
    Number transactionFee = Number(0, -3);

    /* 500 is 0.5. Max amount that a repo can be liquidated by i.e.
    max collateral that can be taken in one function call */
    Number liquidationFactor = Number(500, -3);

    /* 1054 is 1.054 i.e. 5.4% liqFee.
    The fees paid to our protocol every time a liquidation happens */
    Number liquidationFee = Number(0, -3);

    /* 16 means 1.6. The minimum ratio of a repo's collateral to insurance promised.
    The ratio is calculated as below:
    repo.collateral / (repo.putsOutstanding * strikePrice) */
    Number public collateralizationRatio = Number(16, -1);

    // The amount of insurance promised per oToken
    Number public strikePrice;

    // The amount of underlying that 1 oToken protects.
    Number public oTokenExchangeRate = Number(1, -18);

    /* UNIX time.
    Exercise period starts at `(expiry - windowSize)` and ends at `expiry` */
    uint256 windowSize;

    /* The total collateral withdrawn from the Options Contract every time
    the exercise function is called */
    uint256 totalExercised;

    /* The total fees accumulated in the contract any time liquidate or exercise is called */
    uint256 totalFee;

    /* The total amount of underlying that is added to the contract during the exercise window.
    This number can only increase and is only incremented in the exercise function. After expiry,
    this value is used to calculate the proportion of underlying paid out to the respective repo
    owners in the claim collateral function */
    uint256 totalUnderlying;

    /* The totalCollateral is only updated on add, remove, liquidate. After expiry,
    this value is used to calculate the proportion of underlying paid out to the respective repo
    owner in the claim collateral function. The amount of collateral any repo owner gets back is
    caluculated as below:
    repo.collateral / totalCollateral * (totalCollateral - totalExercised) */
    uint256 totalCollateral;

    // The time of expiry of the options contract
    uint256 public expiry;

    // The precision of the collateral
    int32 collateralExp = -18;

    // The collateral asset
    IERC20 public collateral;

    // The asset being protected by the insurance
    IERC20 public underlying;


    // The asset in which insurance is denominated in.
    IERC20 public strike;

    /**
    * @param _collateral The collateral asset
    * @param _collExp The precision of the collateral (-18 if ETH)
    * @param _underlying The asset that is being protected
    * @param _oTokenExchangeExp The precision of the `amount of underlying` that 1 oToken protects
    * @param _strikePrice The amount of strike asset that will be paid out
    * @param _strikeExp The precision of the strike asset (-18 if ETH)
    * @param _strike The asset in which the insurance is calculated
    * @param _expiry The time at which the insurance expires
    * @param _optionsExchange The contract which interfaces with the exchange + oracle
    * @param _windowSize UNIX time. Exercise window is from `expiry - _windowSize` to `expiry`.
    */
    constructor(
        IERC20 _collateral,
        int32 _collExp,
        IERC20 _underlying,
        int32 _oTokenExchangeExp,
        uint256 _strikePrice,
        int32 _strikeExp,
        IERC20 _strike,
        uint256 _expiry,
        OptionsExchange _optionsExchange,
        uint256 _windowSize

    )
        OptionsUtils(
            address(_optionsExchange.UNISWAP_FACTORY()), address(_optionsExchange.COMPOUND_ORACLE())
        )
        public
    {
        collateral = _collateral;
        collateralExp = _collExp;

        underlying = _underlying;
        oTokenExchangeRate = Number(1, _oTokenExchangeExp);

        strikePrice = Number(_strikePrice, _strikeExp);
        strike = _strike;

        expiry = _expiry;
        optionsExchange = _optionsExchange;
        windowSize = _windowSize;
    }

    /*** Events ***/
    event RepoOpened(uint256 repoIndex, address repoOwner);
    event ETHCollateralAdded(uint256 repoIndex, uint256 amount, address payer);
    event ERC20CollateralAdded(uint256 repoIndex, uint256 amount, address payer);
    event IssuedOTokens(address issuedTo, uint256 oTokensIssued, uint256 repoIndex);
    event Liquidate (uint256 amtCollateralToPay, uint256 repoIndex, address liquidator);
    event Exercise (uint256 amtUnderlyingToPay, uint256 amtCollateralToPay, address exerciser);
    event ClaimedCollateral(uint256 amtCollateralClaimed, uint256 amtUnderlyingClaimed, uint256 repoIndex, address repoOwner);
    event BurnOTokens (uint256 repoIndex, uint256 oTokensBurned);
    event TransferRepoOwnership (uint256 repoIndex, address oldOwner, address payable newOwner);
    event RemoveCollateral (uint256 repoIndex, uint256 amtRemoved, address repoOwner);

    /**
     * @notice Can only be called by owner. Used to update the fees, minCollateralizationRatio, etc
     * @param _liquidationIncentive The incentive paid to liquidator. 10 is 0.01 i.e. 1% incentive.
     * @param _liquidationFactor Max amount that a repo can be liquidated by. 500 is 0.5.
     * @param _liquidationFee The fees paid to our protocol every time a liquidation happens. 1054 is 1.054 i.e. 5.4% liqFee.
     * @param _transactionFee The fees paid to our protocol every time a execution happens. 100 is egs. 0.1 i.e. 10%.
     * @param _collateralizationRatio The minimum ratio of a repo's collateral to insurance promised. 16 means 1.6.
     */
    function updateParameters(
        uint256 _liquidationIncentive,
        uint256 _liquidationFactor,
        uint256 _liquidationFee,
        uint256 _transactionFee,
        uint256 _collateralizationRatio)
        public onlyOwner {
            liquidationIncentive.value = _liquidationIncentive;
            liquidationFactor.value = _liquidationFactor;
            liquidationFee.value = _liquidationFee;
            transactionFee.value = _transactionFee;
            collateralizationRatio.value = _collateralizationRatio;
    }

    /**
     * @notice Can only be called by owner. Used to take out the protocol fees from the contract.
     * @param _address The address to send the fee to.
     */
    function transferFee(address payable _address) public onlyOwner {
        uint256 fees = totalFee;
        totalFee = 0;
        transferCollateral(_address, fees);
    }

    /**
     * @notice Returns the number of repos in the options contract.
     */
    function numRepos() public returns (uint256) {
        return repos.length;
    }

    /**
     * @notice Creates a new empty repo and sets the owner of the repo to be the msg.sender.
     */
    function openRepo() public returns (uint) {
        require(block.timestamp < expiry, "Options contract expired");
        repos.push(Repo(0, 0, msg.sender));
        uint256 repoIndex = repos.length - 1;
      //  emit RepoOpened(repoIndex, msg.sender);
        return repoIndex;
    }

    /**
     * @notice If the collateral type is ETH, anyone can call this function any time before
     * expiry to increase the amount of collateral in a repo. Will fail if ETH is not the
     * collateral asset.
     * @param repoIndex the index of the repo to which collateral will be added.
     */
    function addETHCollateral(uint256 repoIndex) public payable returns (uint256) {
        require(isETH(collateral), "ETH is not the specified collateral type");
     //   emit ETHCollateralAdded(repoIndex, msg.value, msg.sender);
        return _addCollateral(repoIndex, msg.value);
    }

    /**
     * @notice If the collateral type is any ERC20, anyone can call this function any time before
     * expiry to increase the amount of collateral in a repo. Can only transfer in the collateral asset.
     * Will fail if ETH is the collateral asset.
     * @param repoIndex the index of the repo to which collateral will be added.
     * @param amt the amount of collateral to be transferred in.
     */
    function addERC20Collateral(uint256 repoIndex, uint256 amt) public returns (uint256) {
        require(
            collateral.transferFrom(msg.sender, address(this), amt),
            "Could not transfer in collateral tokens"
        );

       // emit ERC20CollateralAdded(repoIndex, amt, msg.sender);
        return _addCollateral(repoIndex, amt);
    }

    /**
     * @notice Called by anyone holding the oTokens and equal amount of underlying during the
     * exercise window i.e. from `expiry - windowSize` time to `expiry` time. The caller
     * transfers in their oTokens and corresponding amount of underlying and gets
     * `strikePrice * oTokens` amount of collateral out. The collateral paid out is taken from
     * all repo holders. At the end of the expiry window, repo holders can redeem their proportional
     * share of collateral based on how much collateral is left after all exercise calls have been made.
     * @param _oTokens the number of oTokens being exercised.
     * @dev oTokenExchangeRate is the number of underlying tokens that 1 oToken protects.
     */
    function exercise(uint256 _oTokens) public payable {
        // 1. before exercise window: revert
        require(block.timestamp >= expiry - windowSize, "Too early to exercise");
        require(block.timestamp < expiry, "Beyond exercise time");

        // 2. during exercise window: exercise
        // 2.1 ensure person calling has enough pTokens
        require(balanceOf(msg.sender) >= _oTokens, "Not enough pTokens");

        // 2.2 check they have corresponding number of underlying (and transfer in)
        uint256 amtUnderlyingToPay = _oTokens.mul(10 ** underlyingExp());
        if (isETH(underlying)) {
            require(msg.value == amtUnderlyingToPay, "Incorrect msg.value");
        } else {
            require(
                underlying.transferFrom(msg.sender, address(this), amtUnderlyingToPay),
                "Could not transfer in tokens"
            );
        }

        totalUnderlying = totalUnderlying.add(amtUnderlyingToPay);

        // 2.3 transfer in oTokens
        _burn(msg.sender, _oTokens);

        // 2.4 payout enough collateral to get (strikePrice * pTokens  + fees) amount of collateral
        uint256 amtCollateralToPay = calculateCollateralToPay(_oTokens, Number(1, 0));

        // 2.5 Fees
        uint256 amtFee = calculateCollateralToPay(_oTokens, transactionFee);
        totalFee = totalFee.add(amtFee);

        totalExercised = totalExercised.add(amtCollateralToPay).add(amtFee);
       // emit Exercise(amtUnderlyingToPay, amtCollateralToPay, msg.sender);

        // Pay out collateral
        transferCollateral(msg.sender, amtCollateralToPay);
    }

    /**
     * @notice This function is called to issue the option tokens
     * @dev The owner of a repo should only be able to have a max of
     * floor(Collateral * collateralToStrike / (minCollateralizationRatio * strikePrice)) tokens issued.
     * @param repoIndex The index of the repo to issue tokens from
     * @param numTokens The number of tokens to issue
     * @param receiver The address to send the oTokens to
     */
    function issueOTokens (uint256 repoIndex, uint256 numTokens, address receiver) public {
        //check that we're properly collateralized to mint this number, then call _mint(address account, uint256 amount)
        require(block.timestamp < expiry, "Options contract expired");

        Repo storage repo = repos[repoIndex];
        require(msg.sender == repo.owner, "Only owner can issue options");

        // checks that the repo is sufficiently collateralized
        uint256 newNumTokens = repo.putsOutstanding.add(numTokens);
        require(isSafe(repo.collateral, newNumTokens), "unsafe to mint");
        _mint(receiver, numTokens);
        repo.putsOutstanding = newNumTokens;

       // emit IssuedOTokens(msg.sender, numTokens, repoIndex);
        return;
    }

    /**
     * @notice Returns an array of indecies of the repos owned by `_owner`
     * @param _owner the address of the owner
     */
    function getReposByOwner(address _owner) public view returns (uint[] memory) {
        uint[] memory reposOwned;
        uint256 count = 0;
        uint index = 0;

        // get length necessary for returned array
        for (uint256 i = 0; i < repos.length; i++) {
            if(repos[i].owner == _owner){
                count += 1;
            }
        }

        reposOwned = new uint[](count);

        // get each index of each repo owned by given address
        for (uint256 i = 0; i < repos.length; i++) {
            if(repos[i].owner == _owner) {
                reposOwned[index++] = i;
            }
        }

       return reposOwned;
    }

    /**
     * @notice Returns the repo at the given index
     * @param repoIndex the index of the repo to return
     */
    function getRepoByIndex(uint256 repoIndex) public view returns (uint256, uint256, address) {
        Repo storage repo = repos[repoIndex];

        return (
            repo.collateral,
            repo.putsOutstanding,
            repo.owner
        );
    }

    /**
     * @notice Returns true if the given ERC20 is ETH.
     * @param _ierc20 the ERC20 asset.
     */
    function isETH(IERC20 _ierc20) public pure returns (bool) {
        return _ierc20 == IERC20(0);
    }

    /**
     * @notice opens a repo, adds ETH collateral, and mints new oTokens in one step
     * @param amtToCreate number of oTokens to create
     * @param receiver address to send the Options to
     * @return repoIndex
     */
    function createETHCollateralOptionNewRepo(uint256 amtToCreate, address receiver) external payable returns (uint256) {
        uint256 repoIndex = openRepo();
        createETHCollateralOption(amtToCreate, repoIndex, receiver);
        return repoIndex;
    }

    /**
     * @notice adds ETH collateral, and mints new oTokens in one step
     * @param amtToCreate number of oTokens to create
     * @param repoIndex index of the repo to add collateral to
     * @param receiver address to send the Options to
     */
    function createETHCollateralOption(uint256 amtToCreate, uint256 repoIndex, address receiver) public payable {
        addETHCollateral(repoIndex);
        issueOTokens(repoIndex, amtToCreate, receiver);
    }

    /**
     * @notice opens a repo, adds ERC20 collateral, and mints new putTokens in one step
     * @param amtToCreate number of oTokens to create
     * @param amtCollateral amount of collateral added
     * @param receiver address to send the Options to
     * @return repoIndex
     */
    function createERC20CollateralOptionNewRepo(uint256 amtToCreate, uint256 amtCollateral, address receiver) external returns (uint256) {
        uint256 repoIndex = openRepo();
        createERC20CollateralOption(repoIndex, amtToCreate, amtCollateral, receiver);
        return repoIndex;
    }

    /**
     * @notice adds ERC20 collateral, and mints new putTokens in one step
     * @param amtToCreate number of oTokens to create
     * @param amtCollateral amount of collateral added
     * @param repoIndex index of the repo to add collateral to
     * @param receiver address to send the Options to
     */
    function createERC20CollateralOption(uint256 amtToCreate, uint256 amtCollateral, uint256 repoIndex, address receiver) public {
        addERC20Collateral(repoIndex, amtCollateral);
        issueOTokens(repoIndex, amtToCreate, receiver);
    }

    /**
     * @notice allows the owner to burn their oTokens to increase the collateralization ratio of
     * their repo.
     * @param repoIndex Index of the repo to burn oTokens
     * @param amtToBurn number of oTokens to burn
     * @dev only want to call this function before expiry. After expiry, no benefit to calling it.
     */
    function burnOTokens(uint256 repoIndex, uint256 amtToBurn) public {
        Repo storage repo = repos[repoIndex];
        require(repo.owner == msg.sender, "Not the owner of this repo");
        repo.putsOutstanding = repo.putsOutstanding.sub(amtToBurn);
        _burn(msg.sender, amtToBurn);
     //   emit BurnOTokens (repoIndex, amtToBurn);
    }

    /**
     * @notice allows the owner to transfer ownership of their repo to someone else
     * @param repoIndex Index of the repo to be transferred
     * @param newOwner address of the new owner
     */
    function transferRepoOwnership(uint256 repoIndex, address payable newOwner) public {
        require(repos[repoIndex].owner == msg.sender, "Cannot transferRepoOwnership as non owner");
        repos[repoIndex].owner = newOwner;
        emit TransferRepoOwnership(repos[repoIndex].collateral, msg.sender, newOwner);
    }

    /**
     * @notice allows the owner to remove excess collateral from the repo before expiry. Removing collateral lowers
     * the collateralization ratio of the repo.
     * @param repoIndex: Index of the repo to remove collateral
     * @param amtToRemove: Amount of collateral to remove in 10^-18.
     */
    function removeCollateral(uint256 repoIndex, uint256 amtToRemove) public {

        require(block.timestamp < expiry, "Can only call remove collateral before expiry");
        // check that we are well collateralized enough to remove this amount of collateral
        Repo storage repo = repos[repoIndex];
        require(msg.sender == repo.owner, "Only owner can remove collateral");
        require(amtToRemove <= repo.collateral, "Can't remove more collateral than owned");
        uint256 newRepoCollateralAmt = repo.collateral.sub(amtToRemove);

        require(isSafe(newRepoCollateralAmt, repo.putsOutstanding), "Repo is unsafe");

        repo.collateral = newRepoCollateralAmt;
        transferCollateral(msg.sender, amtToRemove);
        totalCollateral = totalCollateral.sub(amtToRemove);

     //   emit RemoveCollateral(repoIndex, amtToRemove, msg.sender);
    }

    /**
     * @notice after expiry, each repo holder can get back their proportional share of collateral
     * from repos that they own.
     * @dev The amount of collateral any owner gets back is calculated as:
     * repo.collateral / totalCollateral * (totalCollateral - totalExercised)
     * @param repoIndex index of the repo the owner wants to claim collateral from.
     */
    function claimCollateral (uint256 repoIndex) public {
        require(block.timestamp >= expiry, "Can't collect collateral until expiry");

        // pay out people proportional
        Repo storage repo = repos[repoIndex];

        require(msg.sender == repo.owner, "only owner can claim collatera");

        uint256 collateralLeft = totalCollateral.sub(totalExercised);
        uint256 collateralToTransfer = repo.collateral.mul(collateralLeft).div(totalCollateral);
        uint256 underlyingToTransfer = repo.collateral.mul(totalUnderlying).div(totalCollateral);

        repo.collateral = 0;

      //  emit ClaimedCollateral(collateralToTransfer, underlyingToTransfer, repoIndex, msg.sender);

        transferCollateral(msg.sender, collateralToTransfer);
        transferUnderlying(msg.sender, underlyingToTransfer);
    }

    /**
     * @notice This function can be called by anyone if the notice a repo that is undercollateralized.
     * The caller gets a reward for reducing the amount of oTokens in circulation.
     * @dev Liquidator comes with _oTokens. They get _oTokens * strikePrice * (incentive + fee)
     * amount of collateral out. They can liquidate a max of liquidationFactor * repo.collateral out
     * in one function call i.e. partial liquidations.
     * @param repoIndex The index of the repo to be liquidated
     * @param _oTokens The number of oTokens being taken out of circulation
     */
    function liquidate(uint256 repoIndex, uint256 _oTokens) public {
        // can only be called before the options contract expired
        require(block.timestamp < expiry, "Options contract expired");

        Repo storage repo = repos[repoIndex];

        // cannot liquidate a safe repo.
        require(isUnsafe(repoIndex), "Repo is safe");

        // Owner can't liquidate themselves
        require(msg.sender != repo.owner, "Owner can't liquidate themselves");

        uint256 amtCollateral = calculateCollateralToPay(_oTokens, Number(1, 0));
        uint256 amtIncentive = calculateCollateralToPay(_oTokens, liquidationIncentive);
        uint256 amtCollateralToPay = amtCollateral + amtIncentive;

        // Fees
        uint256 protocolFee = calculateCollateralToPay(_oTokens, liquidationFee);
        totalFee = totalFee.add(protocolFee);

        // calculate the maximum amount of collateral that can be liquidated
        uint256 maxCollateralLiquidatable = repo.collateral.mul(liquidationFactor.value);
        if(liquidationFactor.exponent > 0) {
            maxCollateralLiquidatable = maxCollateralLiquidatable.div(10 ** uint32(liquidationFactor.exponent));
        } else {
            maxCollateralLiquidatable = maxCollateralLiquidatable.div(10 ** uint32(-1 * liquidationFactor.exponent));
        }

        require(amtCollateralToPay.add(protocolFee) <= maxCollateralLiquidatable,
        "Can only liquidate liquidation factor at any given time");

        // deduct the collateral and putsOutstanding
        repo.collateral = repo.collateral.sub(amtCollateralToPay.add(protocolFee));
        repo.putsOutstanding = repo.putsOutstanding.sub(_oTokens);

        totalCollateral = totalCollateral.sub(amtCollateralToPay.add(protocolFee));

        // transfer the collateral and burn the _oTokens
         _burn(msg.sender, _oTokens);
         transferCollateral(msg.sender, amtCollateralToPay);

      //  emit Liquidate(amtCollateralToPay, repoIndex, msg.sender);
    }

    /**
     * @notice checks if a repo is unsafe. If so, it can be liquidated
     * @param repoIndex The number of the repo to check
     * @return true or false
     */
    function isUnsafe(uint256 repoIndex) public view returns (bool) {
        Repo storage repo = repos[repoIndex];

        bool isUnsafe = !isSafe(repo.collateral, repo.putsOutstanding);

        return isUnsafe;
    }

    /**
     * @notice adds `_amt` collateral to `_repoIndex` and returns the new balance of the repo
     * @param _repoIndex the index of the repo
     * @param _amt the amount of collateral to add
     */
    function _addCollateral(uint256 _repoIndex, uint256 _amt) private returns (uint256) {
        require(block.timestamp < expiry, "Options contract expired");

        Repo storage repo = repos[_repoIndex];

        repo.collateral = repo.collateral.add(_amt);

        totalCollateral = totalCollateral.add(_amt);

        return repo.collateral;
    }

    /**
     * @notice checks if a hypothetical repo is safe with the given collateralAmt and putsOutstanding
     * @param collateralAmt The amount of collateral the hypothetical repo has
     * @param putsOutstanding The amount of oTokens generated by the hypothetical repo
     * @return true or false
     */
    function isSafe(uint256 collateralAmt, uint256 putsOutstanding) internal view returns (bool) {
        // get price from Oracle
        uint256 ethToCollateralPrice = getPrice(address(collateral));
        uint256 ethToStrikePrice = getPrice(address(strike));

        // check `putsOutstanding * collateralizationRatio * strikePrice <= collAmt * collateralToStrikePrice`
        uint256 leftSideVal = putsOutstanding.mul(collateralizationRatio.value).mul(strikePrice.value);
        int32 leftSideExp = collateralizationRatio.exponent + strikePrice.exponent;

        uint256 rightSideVal = (collateralAmt.mul(ethToStrikePrice)).div(ethToCollateralPrice);
        int32 rightSideExp = collateralExp;

        uint32 exp = 0;
        bool isSafe = false;

        if(rightSideExp < leftSideExp) {
            exp = uint32(leftSideExp - rightSideExp);
            isSafe = leftSideVal.mul(10**exp) <= rightSideVal;
        } else {
            exp = uint32(rightSideExp - leftSideExp);
            isSafe = leftSideVal <= rightSideVal.mul(10 ** exp);
        }

        return isSafe;
    }

    /**
     * @notice This function calculates the amount of collateral to be paid out.
     * @dev The amount of collateral to paid out is determined by:
     * `proportion` * s`trikePrice` * `oTokens` amount of collateral.
     * @param _oTokens The number of oTokens.
     * @param proportion The proportion of the collateral to pay out. If 100% of collateral
     * should be paid out, pass in Number(1, 0). The proportion might be less than 100% if
     * you are calculating fees.
     */
    function calculateCollateralToPay(uint256 _oTokens, Number memory proportion) internal returns (uint256) {
        // Get price from oracle
        uint256 ethToCollateralPrice = getPrice(address(collateral));
        uint256 ethToStrikePrice = getPrice(address(strike));

        // calculate how much should be paid out
        uint256 amtCollateralToPayNum = _oTokens.mul(strikePrice.value).mul(proportion.value).mul(ethToCollateralPrice);
        int32 amtCollateralToPayExp = strikePrice.exponent + proportion.exponent - collateralExp;
        uint256 amtCollateralToPay = 0;
        if(amtCollateralToPayExp > 0) {
            uint32 exp = uint32(amtCollateralToPayExp);
            amtCollateralToPay = amtCollateralToPayNum.mul(10 ** exp).div(ethToStrikePrice);
        } else {
            uint32 exp = uint32(-1 * amtCollateralToPayExp);
            amtCollateralToPay = (amtCollateralToPayNum.div(10 ** exp)).div(ethToStrikePrice);
        }

        return amtCollateralToPay;

    }

    /**
     * @notice This function transfers `amt` collateral to `_addr`
     * @param _addr The address to send the collateral to
     * @param _amt The amount of the collateral to pay out.
     */
    function transferCollateral(address payable _addr, uint256 _amt) internal {
        if (isETH(collateral)){
            _addr.transfer(_amt);
        } else {
            collateral.transfer(_addr, _amt);
        }
    }

    /**
     * @notice This function transfers `amt` underlying to `_addr`
     * @param _addr The address to send the underlying to
     * @param _amt The amount of the underlying to pay out.
     */
    function transferUnderlying(address payable _addr, uint256 _amt) internal {
        if (isETH(underlying)){
            _addr.transfer(_amt);
        } else {
            underlying.transfer(_addr, _amt);
        }
    }

    /**
     * @notice This function gets the price in ETH (wei) of the asset.
     * @param asset The address of the asset to get the price of
     */
    function getPrice(address asset) internal view returns (uint256) {

        if(asset == address(0)) {
            return (10 ** 18);
        } else {
            return COMPOUND_ORACLE.getPrice(asset);
        }
    }

    /**
     * @notice Returns the differnce in precision in decimals between the
     * underlying token and the oToken. If the underlying has a precision of 18 digits
     * and the oTokenExchange is 14 digits of precision, the underlyingExp is 4.
     */
    function underlyingExp() internal returns (uint32) {
        // TODO: change this to be _oTokenExhangeExp - decimals(underlying)
        return uint32(oTokenExchangeRate.exponent - (-18));
    }

    function() external payable {
        // to get ether from uniswap exchanges
    }
}
