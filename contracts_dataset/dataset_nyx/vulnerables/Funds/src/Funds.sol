
// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/op2/contracts/GSN/Context.sol

pragma solidity ^0.5.8;

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

// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/op2/contracts/token/ERC20/IERC20.sol

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
 //   event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/op2/contracts/math/SafeMath.sol

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

// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/op2/contracts/token/ERC20/ERC20.sol

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
        emit Transfer(account, address(0), amount);
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

// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/Medianizer.sol


contract Medianizer {
    function peek() public returns (bytes32, bool);
    function read() public returns (bytes32);
    function poke(bytes32 wut) public;
    function void() public;
    function push(uint256 amt, ERC20 tok) public;
}

// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/DSMath.sol


contract DSMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x);
    }
    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x);
    }
    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }
    function div(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }

    function min(uint x, uint y) internal pure returns (uint z) {
        return x <= y ? x : y;
    }
    function max(uint x, uint y) internal pure returns (uint z) {
        return x >= y ? x : y;
    }
    function imin(int x, int y) internal pure returns (int z) {
        return x <= y ? x : y;
    }
    function imax(int x, int y) internal pure returns (int z) {
        return x >= y ? x : y;
    }

    uint constant WAD = 10 ** 18;
    uint constant RAY = 10 ** 27;

    function wmul(uint x, uint y) internal pure returns (uint z) {
        z = add(mul(x, y), WAD / 2) / WAD;
    }
    function rmul(uint x, uint y) internal pure returns (uint z) {
        z = add(mul(x, y), RAY / 2) / RAY;
    }
    function wdiv(uint x, uint y) internal pure returns (uint z) {
        z = add(mul(x, WAD), y / 2) / y;
    }
    function rdiv(uint x, uint y) internal pure returns (uint z) {
        z = add(mul(x, RAY), y / 2) / y;
    }

    // This famous algorithm is called "exponentiation by squaring"
    // and calculates x^n with x as fixed-point and n as regular unsigned.
    //
    // It's O(log n), instead of O(n) for naive repeated multiplication.
    //
    // These facts are why it works:
    //
    //  If n is even, then x^n = (x^2)^(n/2).
    //  If n is odd,  then x^n = x * x^(n-1),
    //   and applying the equation for even x gives
    //    x^n = x * (x^2)^((n-1) / 2).
    //
    //  Also, EVM division is flooring and
    //    floor[(n-1) / 2] = floor[n / 2].
    //
    function rpow(uint x, uint n) internal pure returns (uint z) {
        z = n % 2 != 0 ? x : RAY;

        for (n /= 2; n != 0; n /= 2) {
            x = rmul(x, x);

            if (n % 2 != 0) {
                z = rmul(z, x);
            }
        }
    }
}

// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/Vars.sol

contract Vars {
	function APEXT() public returns (uint256);
	function ACEXT() public returns (uint256);
	function BIEXT() public returns (uint256);
	function SALEX() public returns (uint256);
	function SETEX() public returns (uint256);
	function MINBI() public returns (uint256);
}

// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/Sales.sol

contract Sales is DSMath { // Auctions
	Loans loans;
	Medianizer med;

	address public own; // Only the Loans contract can edit data

	mapping (bytes32 => Sale)       public sales; // Auctions
	mapping (bytes32 => ERC20)      public tokes; // Auction token
    mapping (bytes32 => Vars)       public vares; // Vars contract
	mapping (bytes32 => Bsig)       public bsigs; // Borrower Signatures
	mapping (bytes32 => Lsig)       public lsigs; // Lender Signatures
	mapping (bytes32 => Asig)       public asigs; // Lender Signatures
	mapping (bytes32 => Sech)       public sechs; // Auction Secret Hashes
    uint256                         public salei; // Auction Index

    mapping (bytes32 => bytes32[])  public salel; // Loan Auctions (find by loani)

    struct Sale {
        bytes32    loani;  // Loan Index
        uint256    bid;    // Current Bid
        address    bidr;   // Bidder
        address    bor;    // Borrower
        address    lend;   // Lender
        address    agent;  // Optional Automated Agent
        uint256    salex;  // Auction Bidding Expiration
        uint256    setex;  // Auction Settlement Expiration
        bytes20    pbkh;   // Bidder PubKey Hash
        bool       set;    // Sale at index opened
        bool       taken;  // Winning bid accepted
        bool       off;
    }

    struct Bsig {
    	bytes      rsig;  // Borrower Refundable Signature
        bytes      ssig;  // Borrower Seizable Signature
        bytes      rbsig; // Borrower Refundable Back Signature
        bytes      sbsig; // Borrower Seizable Back Signature
    }

    struct Lsig {
    	bytes      rsig;  // Lender Refundable Signature
        bytes      ssig;  // Lender Seizable Signature
        bytes      rbsig; // Lender Refundable Back Signature
        bytes      sbsig; // Lender Seizable Back Signature
    }

    struct Asig {
    	bytes      rsig;  // Agent Refundable Signature
        bytes      ssig;  // Agent Seizable Signature
        bytes      rbsig; // Agent Refundable Back Signature
        bytes      sbsig; // Agent Seizable Back Signature
    }

    struct Sech {
        bytes32    sechA; // Secret Hash A
        bytes32    secA;  // Secret A
        bytes32    sechB; // Secret Hash B
        bytes32    secB;  // Secret B
        bytes32    sechC; // Secret Hash C
        bytes32    secC;  // Secret C
        bytes32    sechD; // Secret Hash D
        bytes32    secD;  // Secret D
    }

    function bid(bytes32 sale) public returns (uint256) {
        return sales[sale].bid;
    }

    function bidr(bytes32 sale) public returns (address) {
        return sales[sale].bidr;
    }

    function bor(bytes32 sale) public returns (address) {
        return sales[sale].bor;
    }

    function lend(bytes32 sale) public returns (address) {
        return sales[sale].lend;
    }

    function agent(bytes32 sale) public returns (address) {
        return sales[sale].agent;
    }

    function salex(bytes32 sale) public returns (uint256) {
        return sales[sale].salex;
    }

    function setex(bytes32 sale) public returns (uint256) {
        return sales[sale].setex;
    }

    function pbkh(bytes32 sale) public returns (bytes20) {
        return sales[sale].pbkh;
    }

    function taken(bytes32 sale) public returns (bool) {
        return sales[sale].taken;
    }

    function off(bytes32 sale) public returns (bool) {
        return sales[sale].off;
    }

    function sechA(bytes32 sale) public returns (bytes32) {
        return sechs[sale].sechA;
    }

    function secA(bytes32 sale) public returns (bytes32) {
        return sechs[sale].secA;
    }

    function sechB(bytes32 sale) public returns (bytes32) {
        return sechs[sale].sechB;
    }

    function secB(bytes32 sale) public returns (bytes32) {
        return sechs[sale].secB;
    }

    function sechC(bytes32 sale) public returns (bytes32) {
        return sechs[sale].sechC;
    }

    function secC(bytes32 sale) public returns (bytes32) {
        return sechs[sale].secC;
    }

    function sechD(bytes32 sale) public returns (bytes32) {
        return sechs[sale].sechD;
    }

    function secD(bytes32 sale) public returns (bytes32) {
        return sechs[sale].secD;
    }

    constructor (address loans_, address med_) public {
    	own   = loans_;
    	loans = Loans(loans_);
    	med   = Medianizer(med_);
    }

    function next(bytes32 loan) public view returns (uint256) {
    	return salel[loan].length;
    }

    function open(
    	bytes32 loani, // Loan Index
    	address bor,   // Address Borrower
    	address lend,  // Address Lender
        address agent, // Optional Address automated agent
    	bytes32 sechA, // Secret Hash A
    	bytes32 sechB, // Secret Hash B
    	bytes32 sechC, // Secret Hash C
    	ERC20   tok,   // Debt Token
        Vars    vars   // Variable contract
	) public returns(bytes32 sale) {
    	require(msg.sender == own);
    	salei = add(salei, 1);
        sale = bytes32(salei);
        sales[sale].loani = loani;
        sales[sale].bor   = bor;
        sales[sale].lend  = lend;
        sales[sale].agent = agent;
        sales[sale].salex = now + vars.SALEX();
        sales[sale].setex = now + vars.SALEX() + vars.SETEX();
        tokes[sale]       = tok;
        vares[sale]       = vars;
        sales[sale].set   = true;
        sechs[sale].sechA = sechA;
        sechs[sale].sechB = sechB;
        sechs[sale].sechC = sechC;
        salel[loani].push(sale);
    }

    function push(     // Bid on Collateral
    	bytes32 sale,  // Auction Index
    	uint256 amt,   // Bid Amount
    	bytes32 sech,  // Secret Hash
    	bytes20 pbkh   // PubKeyHash
	) public {
        require(msg.sender != bor(sale) && msg.sender != lend(sale));
		require(sales[sale].set);
    	require(now < sales[sale].salex);
    	require(amt > sales[sale].bid);
    	require(tokes[sale].balanceOf(msg.sender) >= amt);
    	if (sales[sale].bid > 0) {
    		require(amt > rmul(sales[sale].bid, vares[sale].MINBI())); // Make sure next bid is at least 0.5% more than the last bid
    	}

    	require(tokes[sale].transferFrom(msg.sender, address(this), amt));
    	if (sales[sale].bid > 0) {
    		require(tokes[sale].transfer(sales[sale].bidr, sales[sale].bid));
    	}
    	sales[sale].bidr = msg.sender;
    	sales[sale].bid  = amt;
    	sechs[sale].sechD = sech;
    	sales[sale].pbkh = pbkh;
	}

	function sign(           // Provide Signature to move collateral to collateral swap
		bytes32      sale,   // Auction Index
		bytes memory rsig,   // Refundable Signature
		bytes memory ssig,   // Seizable Signature
		bytes memory rbsig,  // Refundable Back Signature
		bytes memory sbsig   // Seizable Back Signataure
	) public {
		require(sales[sale].set);
		require(now < sales[sale].setex);
		if (msg.sender == sales[sale].bor) {
			bsigs[sale].rsig  = rsig;
			bsigs[sale].ssig  = ssig;
			bsigs[sale].rbsig = rbsig;
			bsigs[sale].sbsig = sbsig;
		} else if (msg.sender == sales[sale].lend) {
			lsigs[sale].rsig  = rsig;
			lsigs[sale].ssig  = ssig;
			lsigs[sale].rbsig = rbsig;
			lsigs[sale].sbsig = sbsig;
		} else if (msg.sender == sales[sale].agent) {
			asigs[sale].rsig  = rsig;
			asigs[sale].ssig  = ssig;
			asigs[sale].rbsig = rbsig;
			asigs[sale].sbsig = sbsig;
		} else {
			revert();
		}
	}

	function sec(bytes32 sale, bytes32 sec_) public { // Provide Secret
		require(sales[sale].set);
		if      (sha256(abi.encodePacked(sec_)) == sechs[sale].sechA) { sechs[sale].secA = sec_; }
        else if (sha256(abi.encodePacked(sec_)) == sechs[sale].sechB) { sechs[sale].secB = sec_; }
        else if (sha256(abi.encodePacked(sec_)) == sechs[sale].sechC) { sechs[sale].secC = sec_; }
        else if (sha256(abi.encodePacked(sec_)) == sechs[sale].sechD) { sechs[sale].secD = sec_; }
        else                                                          { revert(); }
	}

	function hasSecs(bytes32 sale) public view returns (bool) { // 2 of 3 secrets
		uint8 secs = 0;
		if (sha256(abi.encodePacked(sechs[sale].secA)) == sechs[sale].sechA) { secs = secs + 1; }
		if (sha256(abi.encodePacked(sechs[sale].secB)) == sechs[sale].sechB) { secs = secs + 1; }
		if (sha256(abi.encodePacked(sechs[sale].secC)) == sechs[sale].sechC) { secs = secs + 1; }
		return (secs >= 2);
	}

	function take(bytes32 sale) public { // Withdraw Bid (Accept Bid and disperse funds to rightful parties)
        require(!taken(sale));
        require(!off(sale));
		require(now > sales[sale].salex);
		require(hasSecs(sale));
		require(sha256(abi.encodePacked(sechs[sale].secD)) == sechs[sale].sechD);
        sales[sale].taken = true;
        if (sales[sale].bid > (loans.dedu(sales[sale].loani))) {
            require(tokes[sale].transfer(sales[sale].lend, loans.lentb(sales[sale].loani)));
            if (agent(sale) != address(0)) {
                require(tokes[sale].transfer(sales[sale].agent, loans.lfee(sales[sale].loani)));
            }
            require(tokes[sale].approve(address(med), loans.lpen(sales[sale].loani)));
            med.push(loans.lpen(sales[sale].loani), tokes[sale]);
            require(tokes[sale].transfer(sales[sale].bor, add(sub(sales[sale].bid, loans.dedub(sales[sale].loani)), loans.back(sales[sale].loani))));
        } else {
            require(tokes[sale].transfer(sales[sale].lend, sales[sale].bid));
        }
	}

	function unpush(bytes32 sale) public { // Refund Bid
        require(!taken(sale));
        require(!off(sale));
		require(now > sales[sale].setex);
		require(sales[sale].bid > 0);
        sales[sale].off = true;
		require(tokes[sale].transfer(sales[sale].bidr, sales[sale].bid));
        if (next(sales[sale].loani) == 3) {
            require(tokes[sale].transfer(sales[sale].bor, loans.back(sales[sale].loani)));
        }
	}
}
// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/Currency.sol

contract Currency {
	function COL() public returns (uint256);
	function name() public returns (string memory);
	function cmul(uint x, uint y) public pure returns (uint);
	function cdiv(uint x, uint y) public pure returns (uint);
}
// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/Loans.sol

contract Loans is DSMath {
    Funds funds;
    Medianizer med;
    Sales sales;

    mapping (bytes32 => Loan)      public loans;
    mapping (bytes32 => Sechs)     public sechs;  // Secret Hashes
    mapping (bytes32 => Bools)     public bools;  // Boolean state of Loan
    mapping (bytes32 => bytes32)   public fundi;  // Mapping of Loan Index to Fund Index
    mapping (bytes32 => ERC20)     public tokes;  // Mapping of Loan index to Token contract
    mapping (bytes32 => Currency)  public cures;  // Mapping of Loan index to Currency contract
    mapping (bytes32 => Vars)      public vares;  // Mapping of Loan index to Vars contract
    mapping (bytes32 => uint256)   public backs;  // Amount paid back in a Loan
    mapping (bytes32 => uint256)   public asaex;  // All Auction expiration
    uint256                        public loani;  // Current Loan Index

    mapping (address => bool)      public tokas;  // Is ERC20 Token Approved

    bool on; // Ensure that Sales contract is created

    struct Loan {
    	address bor;        // Address Borrower
        address lend;       // Address Lender
        address agent;      // Optional Address automated agent
        uint256 born;       // Created At
        uint256 loex;       // Loan Expiration
        uint256 prin;       // Principal
        uint256 lint;       // Interest
        uint256 lpen;       // Liquidation Penalty
        uint256 lfee;       // Optional fee paid to auto if address not 0x0
        uint256 col;        // Collateral
        uint256 rat;        // Liquidation Ratio
        bytes   bpubk;      // Borrower PubKey
        bytes   lpubk;      // Lender PubKey
    }

    struct Sechs {
    	bytes32    sechA1;  // Secret Hash A1
    	bytes32[3] sechAS;  // Secret Hashes A2, A3, A4
    	bytes32    sechB1;  // Secret Hash B1
    	bytes32[3] sechBS;  // Secret Hashes B2, B3, B4
    	bytes32    sechC1;  // Secret Hash C1
    	bytes32[3] sechCS;  // Secret Hashes C2, C3, C4
    	bool       set;     // Secret Hashes set
    }

    struct Bools {
    	bool pushed;        // Loan Funded
    	bool marked;        // Collateral Marked as Locked
    	bool taken;         // Loan Withdrawn
    	bool sale;          // Collateral Liquidation Started
    	bool paid;          // Loan Repaid
    	bool off;           // Loan Finished (Repayment accepted or cancelled)
    }

    function bor(bytes32 loan)    public view returns (address) {
        return loans[loan].bor;
    }

    function lend(bytes32 loan)   public view returns (address) {
        return loans[loan].lend;
    }

    function agent(bytes32 loan)  public view returns (address) {
        return loans[loan].agent;
    }

    function apex(bytes32 loan)   public returns (uint256) { // Approval Expiration
        return add(loans[loan].born, vares[loan].APEXT());
    }

    function acex(bytes32 loan)   public returns (uint256) { // Acceptance Expiration
        return add(loans[loan].loex, vares[loan].ACEXT());
    }

    function biex(bytes32 loan)   public returns (uint256) { // Bidding Expiration
        return add(loans[loan].loex, vares[loan].BIEXT());
    }

    function prin(bytes32 loan)   public view returns (uint256) {
        return loans[loan].prin;
    }

    function lint(bytes32 loan)   public view returns (uint256) {
        return loans[loan].lint;
    }

    function lfee(bytes32 loan)   public view returns (uint256) {
        return loans[loan].lfee;
    }

    function lpen(bytes32 loan)   public view returns (uint256) {
        return loans[loan].lpen;
    }

    function col(bytes32 loan)    public view returns (uint256) {
        return loans[loan].col;
    }

    function back(bytes32 loan)   public view returns (uint256) { // Amount paid back for loan
        return backs[loan];
    }

    function rat(bytes32 loan)    public view returns (uint256) {
        return loans[loan].rat;
    }

    function lent(bytes32 loan)   public view returns (uint256) { // Amount lent by Lender
        return add(prin(loan), lint(loan));
    }

    function lentb(bytes32 loan)  public view returns (uint256) { // Amount lent by lender minus amount paid back
        return sub(lent(loan), back(loan));
    }

    function owed(bytes32 loan)   public view returns (uint256) { // Amount owed
        return add(lent(loan), lfee(loan));
    }

    function owedb(bytes32 loan)  public view returns (uint256) { // Amount owed minus amount paid back
        return sub(owed(loan), back(loan));
    }

    function dedu(bytes32 loan)   public view returns (uint256) { // Deductible amount from collateral
        return add(owed(loan), lpen(loan));
    }

    function dedub(bytes32 loan)  public view returns (uint256) { // Deductible amount from collateral minus amount paid back
        return sub(dedu(loan), back(loan));
    }

    function pushed(bytes32 loan) public view returns (bool) {
        return bools[loan].pushed;
    }

    function marked(bytes32 loan) public view returns (bool) {
        return bools[loan].marked;
    }

    function taken(bytes32 loan) public view returns (bool) {
        return bools[loan].taken;
    }

    function sale(bytes32 loan) public view returns (bool) {
        return bools[loan].sale;
    }

    function paid(bytes32 loan) public view returns (bool) {
        return bools[loan].paid;
    }

    function off(bytes32 loan)    public view returns (bool) {
        return bools[loan].off;
    }

    function colv(bytes32 loan) public returns (uint256) { // Current Collateral Value
        uint256 val = uint(med.read());
        return cures[loan].cmul(val, col(loan)); // Multiply value dependent on number of decimals with currency
    }

    function min(bytes32 loan) public view returns (uint256) {  // Minimum Collateral Value
        return rmul(sub(prin(loan), back(loan)), rat(loan));
    }

    function safe(bytes32 loan) public returns (bool) { // Loan is safe from Liquidation
        return colv(loan) >= min(loan);
    }

    constructor (address funds_, address med_) public {
    	funds = Funds(funds_);
    	med   = Medianizer(med_);
    }

    function setSales(address sales_) public {
        require(!on);
        sales = Sales(sales_);
        on = true;
    }
    
    function open(                  // Create new Loan
        uint256            loex_,   // Loan Expiration
        address[3] memory  usrs_,   // Borrower, Lender, Optional Automated Agent Addresses
        uint256[6] memory  vals_,   // Principal, Interest, Liquidation Penalty, Optional Automation Fee, Collaateral Amount, Liquidation Ratio
        ERC20              tok_,    // Token contract
        Currency           cur_,    // Currency contract
        Vars               vars_,   // Variable contract
        bytes32            fundi_   // Optional Fund Index
    ) public returns (bytes32 loan) {
        loani = add(loani, 1);
        loan = bytes32(loani);
        loans[loan].born   = now;
        loans[loan].loex   = loex_;
        loans[loan].bor    = usrs_[0];
        loans[loan].lend   = usrs_[1];
        loans[loan].agent  = usrs_[2];
        loans[loan].prin   = vals_[0];
        loans[loan].lint   = vals_[1];
        loans[loan].lpen   = vals_[2];
        loans[loan].lfee   = vals_[3];
        loans[loan].col    = vals_[4];
        loans[loan].rat    = vals_[5];
        tokes[loan]        = tok_;
        cures[loan]        = cur_;
        vares[loan]        = vars_;
        fundi[loan]        = fundi_;
        sechs[loan].set    = false;

        if (fundi_ != bytes32(0) && tokas[address(tok_)] == false) {
            require(tok_.approve(address(funds), 2**256-1));
            tokas[address(tok_)] = true;
        }
    }

    function setSechs(             // Set Secret Hashes for Loan
    	bytes32           loan,    // Loan index
    	bytes32[4] memory bsechs,  // Borrower Secret Hashes
    	bytes32[4] memory lsechs,  // Lender Secret Hashes
    	bytes32[4] memory asechs,  // Agent Secret Hashes
		bytes      memory bpubk_,  // Borrower Pubkey
        bytes      memory lpubk_   // Lender Pubkey
	) public returns (bool) {
		require(!sechs[loan].set);
		require(msg.sender == loans[loan].bor || msg.sender == loans[loan].lend || msg.sender == address(funds));
		sechs[loan].sechA1 = bsechs[0];
		sechs[loan].sechAS = [ bsechs[1], bsechs[2], bsechs[3] ];
		sechs[loan].sechB1 = lsechs[0];
		sechs[loan].sechBS = [ lsechs[1], lsechs[2], lsechs[3] ];
		sechs[loan].sechC1 = asechs[0];
		sechs[loan].sechCS = [ asechs[1], asechs[2], asechs[3] ];
		loans[loan].bpubk  = bpubk_;
		loans[loan].lpubk  = lpubk_;
        sechs[loan].set    = true;
	}

	function push(bytes32 loan) public { // Fund Loan
		require(sechs[loan].set);
    	require(bools[loan].pushed == false);
    	require(tokes[loan].transferFrom(msg.sender, address(this), prin(loan)));
    	bools[loan].pushed = true;
    }

    function mark(bytes32 loan) public { // Mark Collateral as locked
    	require(bools[loan].pushed == true);
    	require(loans[loan].lend   == msg.sender);
    	require(now                <= apex(loan));
    	bools[loan].marked = true;
    }

    function take(bytes32 loan, bytes32 secA1) public { // Withdraw
    	require(!off(loan));
    	require(bools[loan].pushed == true);
    	require(bools[loan].marked == true);
    	require(sha256(abi.encodePacked(secA1)) == sechs[loan].sechA1);
    	require(tokes[loan].transfer(loans[loan].bor, prin(loan)));
    	bools[loan].taken = true;
    }

    function pay(bytes32 loan, uint256 amt) public { // Payback Loan
        // require(msg.sender                == loans[loan].bor); // NOTE: this is not necessary. Anyone can pay off the loan
    	require(!off(loan));
        require(!sale(loan));
    	require(bools[loan].taken         == true);
    	require(now                       <= loans[loan].loex);
    	require(add(amt, backs[loan])     <= owed(loan));

    	require(tokes[loan].transferFrom(loans[loan].bor, address(this), amt));
    	backs[loan] = add(amt, backs[loan]);
    	if (backs[loan] == owed(loan)) {
    		bools[loan].paid = true;
    	}
    }

    function unpay(bytes32 loan) public { // Refund payback
    	require(!off(loan));
        require(!sale(loan));
    	require(now              >  acex(loan));
    	require(bools[loan].paid == true);
    	require(msg.sender       == loans[loan].bor);
        bools[loan].off = true;
    	require(tokes[loan].transfer(loans[loan].bor, owed(loan)));
    }

    function pull(bytes32 loan, bytes32 sec) public {
        pull(loan, sec, true); // Default to true for returning funds to Fund
    }

    function pull(bytes32 loan, bytes32 sec, bool fund) public { // Accept or Cancel // Bool fund set true if lender wants fund to return to fund
        require(!off(loan));
        require(bools[loan].taken == false || bools[loan].paid == true);
        require(sha256(abi.encodePacked(sec)) == sechs[loan].sechB1 || sha256(abi.encodePacked(sec)) == sechs[loan].sechC1);
        require(now                             <= acex(loan));
        require(bools[loan].sale                == false);
        bools[loan].off = true;
        if (bools[loan].taken == false) {
            require(tokes[loan].transfer(loans[loan].lend, loans[loan].prin));
        } else if (bools[loan].taken == true) {
            if (fundi[loan] == bytes32(0) || !fund) {
                require(tokes[loan].transfer(loans[loan].lend, lent(loan)));
            } else {
                funds.push(fundi[loan], lent(loan));
            }
            require(tokes[loan].transfer(loans[loan].agent, lfee(loan)));
        }
    }

    function sechi(bytes32 loan, bytes32 usr) private view returns (bytes32 sech) { // Get Secret Hash for Sale Index
    	if      (usr == 'A') { sech = sechs[loan].sechAS[sales.next(loan)]; }
    	else if (usr == 'B') { sech = sechs[loan].sechBS[sales.next(loan)]; }
    	else if (usr == 'C') { sech = sechs[loan].sechCS[sales.next(loan)]; }
    	else revert();
    }

    function sell(bytes32 loan) public returns (bytes32 sale) { // Start Auction
    	require(!off(loan));
        require(bools[loan].taken  == true);
    	if (sales.next(loan) == 0) {
    		if (now > loans[loan].loex) {
	    		require(bools[loan].paid == false);
			} else {
				require(!safe(loan));
			}
		} else {
			require(sales.next(loan) < 3);
			require(msg.sender == loans[loan].bor || msg.sender == loans[loan].lend);
            require(now > sales.setex(sales.salel(loan, sales.next(loan) - 1))); // Can only start auction after settlement expiration of pervious auction
            require(!sales.taken(sales.salel(loan, sales.next(loan) - 1))); // Can only start auction again if previous auction bid wasn't taken
		}
		sale = sales.open(loan, loans[loan].bor, loans[loan].lend, loans[loan].agent, sechi(loan, 'A'), sechi(loan, 'B'), sechi(loan, 'C'), tokes[loan], vares[loan]);
        if (bools[loan].sale == false) { require(tokes[loan].transfer(address(sales), back(loan))); }
		bools[loan].sale = true;
    }
}

// File: atomicloans-eth-contracts-3f52de0b1612d7da6339560962d463df344ec768/contracts/Funds.sol

contract Funds is DSMath {
    Loans loans;

    mapping (address => bytes32[]) public sechs;  // User secret hashes
    mapping (address => uint256)   public sechi;  // User secret hash index

    mapping (address => bytes)     public pubks;  // User A Coin PubKeys
    
    mapping (bytes32 => Fund)      public funds;  
    uint256                        public fundi;

    mapping (address => bool)      public tokas;  // Is ERC20 Token Approved

    bool on; // Ensure that Loans contract is created

    event DebugSetLoans(bool on);

    struct Fund {
        address  own;   // Loan Fund Owner (Lender)
        uint256  mila;  // Min Loan Amount
        uint256  mala;  // Max Loan Amount
        uint256  mild;  // Min Loan Duration
        uint256  mald;  // Max Loan Duration
        uint256  lint;  // Interest Rate in RAY
        uint256  lpen;  // Liquidation Penalty Rate in RAY
        uint256  lfee;  // Optional Automation Fee in RAY
        uint256  rat;   // Liquidation Ratio in RAY
        address  agent; // Optional Automator Agent
        uint256  bal;   // Locked amount in fund (in TOK)
        ERC20    tok;   // Debt Token
        Currency cur;   // Currency info
        Vars     vars;  // Variable contract
    }

    function setLoans(address loans_) public {
        require(!on);
        loans = Loans(loans_);
        on = true;
        emit DebugSetLoans(on);
    }

    function own(bytes32 fund)   public view returns (address) {
        return funds[fund].own;
    }

    function mila(bytes32 fund)  public view returns (uint256) {
        return funds[fund].mila;
    }

    function mala(bytes32 fund)  public view returns (uint256) {
        return funds[fund].mala;
    }

    function mild(bytes32 fund)  public view returns (uint256) {
        return funds[fund].mild;
    }

    function mald(bytes32 fund)  public view returns (uint256) {
        return funds[fund].mald;
    }

    function lint(bytes32 fund)  public view returns (uint256) {
        return funds[fund].lint;
    }

    function lpen(bytes32 fund)  public view returns (uint256) {
        return funds[fund].lpen;
    }

    function lfee(bytes32 fund)  public view returns (uint256) {
        return funds[fund].lfee;
    }

    function rat(bytes32 fund)   public view returns (uint256) {
        return funds[fund].rat;
    }

    function agent(bytes32 fund) public view returns (address) {
        return funds[fund].agent;
    }

    function bal(bytes32 fund)   public view returns (uint256) {
        return funds[fund].bal;
    }

    function tok(bytes32 fund)   public view returns (address) {
        return address(funds[fund].tok);
    }

    function cur(bytes32 fund)   public view returns (address) {
        return address(funds[fund].cur);
    }

    function vars(bytes32 fund)  public view returns (address) {
        return address(funds[fund].vars);
    }

    function open(
        uint256  mila_,  // Min Loan Amount
        uint256  mala_,  // Max Loan Amount
        uint256  mild_,  // Min Loan Duration
        uint256  mald_,  // Max Loan Duration
        uint256  rat_,   // Liquidation Ratio
        uint256  lint_,  // Interest Rate
        uint256  lpen_,  // Liquidation Penalty Rate
        uint256  lfee_,  // Optional Automation Fee Rate
        address  agent_, // Optional Address Automated Agent
        ERC20    tok_,   // Debt Token
        Currency cur_,   // Currency contract
        Vars     vars_   // Variable contract
    ) public returns (bytes32 fund) {
        fundi = add(fundi, 1);
        fund = bytes32(fundi);
        funds[fund].own   = msg.sender;
        funds[fund].mila  = mila_;
        funds[fund].mala  = mala_;
        funds[fund].mild  = mild_;
        funds[fund].mald  = mald_;
        funds[fund].lint  = lint_;
        funds[fund].lpen  = lpen_;
        funds[fund].lfee  = lfee_;
        funds[fund].rat   = rat_;
        funds[fund].tok   = tok_;
        funds[fund].cur   = cur_;
        funds[fund].vars  = vars_;
        funds[fund].agent = agent_;

        if (tokas[address(tok_)] == false) {
            require(tok_.approve(address(loans), 2**256-1));
            tokas[address(tok_)] = true;
        }
    }

    function push(bytes32 fund, uint256 amt) public { // Push funds to Loan Fund
        // require(msg.sender == own(fund) || msg.sender == address(loans)); // NOTE: this require is not necessary. Anyone can fund someone elses loan fund
        require(funds[fund].tok.transferFrom(msg.sender, address(this), amt));
        funds[fund].bal = add(funds[fund].bal, amt);
    }

    function gen(bytes32[] memory sechs_) public { // Generate secret hashes for Loan Fund
        for (uint i = 0; i < sechs_.length; i++) {
            sechs[msg.sender].push(sechs_[i]);
        }
    }

    function set(bytes memory pubk) public { // Set PubKey for Fund
        pubks[msg.sender] = pubk;
    }

    function set(        // Set Loan Fund details
        bytes32  fund,   // Loan Fund Index
        uint256  mila_,  // Min Loan Amount
        uint256  mala_,  // Max Loan Amount
        uint256  mild_,  // Min Loan Duration
        uint256  mald_,  // Max Loan Duration
        uint256  lint_,  // Interest Rate in RAY
        uint256  lpen_,  // Liquidation Penalty Rate in RAY
        uint256  lfee_,  // Optional Automation Fee in RAY
        uint256  rat_,   // Liquidation Ratio in RAY
        address  agent_  // Optional Automator Agent)
    ) public {
        require(msg.sender == own(fund));
        funds[fund].mila  = mila_;
        funds[fund].mala  = mala_;
        funds[fund].mild  = mild_;
        funds[fund].mald  = mald_;
        funds[fund].lint  = lint_;
        funds[fund].lpen  = lpen_;
        funds[fund].lfee  = lfee_;
        funds[fund].rat   = rat_;
        funds[fund].agent = agent_;
    }

    function req(                 // Request Loan
        bytes32           fund,   // Fund Index
        uint256           amt_,   // Loan Amount
        uint256           col_,   // Collateral Amount in satoshis
        uint256           lodu_,  // Loan Duration in seconds
        bytes32[4] memory sechs_, // Secret Hash A1 & A2
        bytes      memory pubk_   // Pubkey
    ) public returns (bytes32 loani) {
        require(msg.sender != own(fund));
        require(amt_       <= bal(fund));
        require(amt_       >= mila(fund));
        require(amt_       <= mala(fund));
        require(lodu_      >= mild(fund));
        require(lodu_      <= mald(fund));

        loani = lopen(fund, amt_, col_, lodu_);
        lsech(fund, loani, sechs_, pubk_);
        loans.push(loani);
    }

    function pull(bytes32 fund, uint256 amt) public { // Pull funds from Loan Fund
        require(msg.sender == own(fund));
        require(bal(fund)  >= amt);
        funds[fund].bal = sub(funds[fund].bal, amt);
        require(funds[fund].tok.transfer(own(fund), amt));
    }

    function calc(uint256 amt, uint256 rate, uint256 lodu) public pure returns (uint256) { // Calculate interest
        return sub(rmul(amt, rpow(rate, lodu)), amt);
    }

    function lopen(               // Private Open Loan
        bytes32           fund,   // Fund Index
        uint256           amt_,   // Loan Amount
        uint256           col_,   // Collateral Amount in satoshis
        uint256           lodu_   // Loan Duration in seconds
    ) private returns (bytes32 loani) {
        loani = loans.open(
            now + lodu_,
            [ msg.sender, own(fund), funds[fund].agent],
            [ amt_, calc(amt_, lint(fund), lodu_), calc(amt_, lpen(fund), lodu_), calc(amt_, lfee(fund), lodu_), col_, funds[fund].rat],
            funds[fund].tok,
            funds[fund].cur,
            funds[fund].vars,
            fund
        );
    }

    function lsech(                // Loan Set Secret Hashes
        bytes32 fund,              // Fund Index
        bytes32 loan,              // Loan Index
        bytes32[4] memory sechs_,  // 4 Secret Hashes
        bytes memory pubk_         // Public Key
    ) private { // Loan set Secret Hash and PubKey
        loans.setSechs(
            loan,
            sechs_,
            gsech(own(fund)),
            gsech(agent(fund)),
            pubk_,
            pubks[own(fund)]
        );
    }

    function gsech(address addr) private returns (bytes32[4] memory) { // Get 4 secrethashes for loan
        sechi[addr] = add(sechi[addr], 4);
        return [ sechs[addr][sub(sechi[addr], 4)], sechs[addr][sub(sechi[addr], 3)], sechs[addr][sub(sechi[addr], 2)], sechs[addr][sub(sechi[addr], 1)] ];
    }
}
