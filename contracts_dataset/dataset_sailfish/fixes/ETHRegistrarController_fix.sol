
// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/introspection/IERC165.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * [EIP](https://eips.ethereum.org/EIPS/eip-165).
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others (`ERC165Checker`).
 *
 * For an implementation, see `ERC165`.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * [EIP section](https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified)
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/token/ERC721/IERC721.sol

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
contract IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of NFTs in `owner`'s account.
     */
    function balanceOf(address owner) public view returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `tokenId`.
     */
    function ownerOf(uint256 tokenId) public view returns (address owner);

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * 
     *
     * Requirements:
     * - `from`, `to` cannot be zero.
     * - `tokenId` must be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this
     * NFT by either `approve` or `setApproveForAll`.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public;
    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - If the caller is not `from`, it must be approved to move this NFT by
     * either `approve` or `setApproveForAll`.
     */
    function transferFrom(address from, address to, uint256 tokenId) public;
    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);


    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
}

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/token/ERC721/IERC721Receiver.sol

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
contract IERC721Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC721 smart contract calls this function on the recipient
     * after a `safeTransfer`. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC721Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC721 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
    public returns (bytes4);
}

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/math/SafeMath.sol

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
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
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

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/utils/Address.sol


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

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/drafts/Counters.sol


/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented or decremented by one. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 * Since it is not possible to overflow a 256 bit integer with increments of one, `increment` can skip the SafeMath
 * overflow check, thereby saving gas. This does assume however correct usage, in that the underlying `_value` is never
 * directly accessed.
 */
library Counters {
    using SafeMath for uint256;

    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/introspection/ERC165.sol


/**
 * @dev Implementation of the `IERC165` interface.
 *
 * Contracts may inherit from this and call `_registerInterface` to declare
 * their support of an interface.
 */
contract ERC165 is IERC165 {
    /*
     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
     */
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

    /**
     * @dev Mapping of interface ids to whether or not it's supported.
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor () internal {
        // Derived contracts need only register support for their own interfaces,
        // we register support for ERC165 itself here
        _registerInterface(_INTERFACE_ID_ERC165);
    }

    /**
     * @dev See `IERC165.supportsInterface`.
     *
     * Time complexity O(1), guaranteed to always use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev Registers the contract as an implementer of the interface defined by
     * `interfaceId`. Support of the actual ERC165 interface is automatic and
     * registering its interface id is not required.
     *
     * See `IERC165.supportsInterface`.
     *
     * Requirements:
     *
     * - `interfaceId` cannot be the ERC165 invalid interface (`0xffffffff`).
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/token/ERC721/ERC721.sol

/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721 is ERC165, IERC721 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping (uint256 => address) private _tokenOwner;

    // Mapping from token ID to approved address
    mapping (uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => Counters.Counter) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    constructor () public {
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721);
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param owner address to query the balance of
     * @return uint256 representing the amount owned by the passed address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");

        return _ownedTokensCount[owner].current();
    }

    /**
     * @dev Gets the owner of the specified token ID.
     * @param tokenId uint256 ID of the token to query the owner of
     * @return address currently marked as the owner of the given token ID
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");

        return owner;
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param to address to be approved for the given token ID
     * @param tokenId uint256 ID of the token to be approved
     */
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
   //    emit Approval(owner, to, tokenId);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf.
     * @param to operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address to, bool approved) public {
        require(to != msg.sender, "ERC721: approve to caller");

        _operatorApprovals[msg.sender][to] = approved;
    // ApprovalForAll(msg.sender, to, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given owner.
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address.
     * Usage of this method is discouraged, use `safeTransferFrom` whenever possible.
     * Requires the msg.sender to be the owner, approved, or operator.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function transferFrom(address from, address to, uint256 tokenId) public {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: transfer caller is not owner nor approved");

        _transferFrom(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Returns whether the specified token exists.
     * @param tokenId uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID.
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the owner, or is the owner of the token
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

    //    emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        require(ownerOf(tokenId) == owner, "ERC721: burn of token that is not own");

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

    //    emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(uint256 tokenId) internal {
        _burn(ownerOf(tokenId), tokenId);
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _clearApproval(tokenId);

        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();

        _tokenOwner[tokenId] = to;

     //   emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Internal function to invoke `onERC721Received` on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * This function is deprecated.
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data)
        internal returns (bool)
    {
        if (!to.isContract()) {
            return true;
        }

        bytes4 retval = IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, _data);
        return (retval == _ERC721_RECEIVED);
    }

    /**
     * @dev Private function to clear current approval of a given token ID.
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

// File: https://github.com/ensdomains/ens/blob/v0.3.0/contracts/ENS.sol

interface ENS {

    // Logged when the owner of a node assigns a new owner to a subnode.
    event NewOwner(bytes32 indexed node, bytes32 indexed label, address owner);

    // Logged when the owner of a node transfers ownership to a new account.
    event Transfer(bytes32 indexed node, address owner);

    // Logged when the resolver for a node changes.
    event NewResolver(bytes32 indexed node, address resolver);

    // Logged when the TTL of a node changes
    event NewTTL(bytes32 indexed node, uint64 ttl);


    function setSubnodeOwner(bytes32 node, bytes32 label, address owner) external;
    function setResolver(bytes32 node, address resolver) external;
    function setOwner(bytes32 node, address owner) external;
    function setTTL(bytes32 node, uint64 ttl) external;
    function owner(bytes32 node) external view returns (address);
    function resolver(bytes32 node) external view returns (address);
    function ttl(bytes32 node) external view returns (uint64);

}

// File: https://github.com/ensdomains/ens/blob/v0.3.0/contracts/Deed.sol

interface Deed {

    function setOwner(address payable newOwner) external;
    function setRegistrar(address newRegistrar) external;
    function setBalance(uint newValue, bool throwOnFailure) external;
    function closeDeed(uint refundRatio) external;
    function destroyDeed() external;

    function owner() external view returns (address);
    function previousOwner() external view returns (address);
    function value() external view returns (uint);
    function creationDate() external view returns (uint);

}

// File: https://github.com/ensdomains/ens/blob/v0.3.0/contracts/DeedImplementation.sol

/**
 * @title Deed to hold ether in exchange for ownership of a node
 * @dev The deed can be controlled only by the registrar and can only send ether back to the owner.
 */
contract DeedImplementation is Deed {

    address payable constant burn = address(0xdead);

    address payable private _owner;
    address private _previousOwner;
    address private _registrar;

    uint private _creationDate;
    uint private _value;

    bool active;

    event OwnerChanged(address newOwner);
    event DeedClosed();

    modifier onlyRegistrar {
        require(msg.sender == _registrar);
        _;
    }

    modifier onlyActive {
        require(active);
        _;
    }

    constructor(address payable initialOwner) public payable {
        _owner = initialOwner;
        _registrar = msg.sender;
        _creationDate = now;
        active = true;
        _value = msg.value;
    }

    function setOwner(address payable newOwner) external onlyRegistrar {
        require(newOwner != address(0x0));
        _previousOwner = _owner;  // This allows contracts to check who sent them the ownership
        _owner = newOwner;
     //   emit OwnerChanged(newOwner);
    }

    function setRegistrar(address newRegistrar) external onlyRegistrar {
        _registrar = newRegistrar;
    }

    function setBalance(uint newValue, bool throwOnFailure) external onlyRegistrar onlyActive {
        // Check if it has enough balance to set the value
        require(_value >= newValue);
        _value = newValue;
        // Send the difference to the owner
        require(_owner.send(address(this).balance - newValue) || !throwOnFailure);
    }

    /**
     * @dev Close a deed and refund a specified fraction of the bid value
     *
     * @param refundRatio The amount*1/1000 to refund
     */
    function closeDeed(uint refundRatio) external onlyRegistrar onlyActive {
        active = false;
        require(burn.send(((1000 - refundRatio) * address(this).balance)/1000));
    //    emit DeedClosed();
        _destroyDeed();
    }

    /**
     * @dev Close a deed and refund a specified fraction of the bid value
     */
    function destroyDeed() external {
        _destroyDeed();
    }

    function owner() external view returns (address) {
        return _owner;
    }

    function previousOwner() external view returns (address) {
        return _previousOwner;
    }

    function value() external view returns (uint) {
        return _value;
    }

    function creationDate() external view returns (uint) {
        _creationDate;
    }

    function _destroyDeed() internal {
        require(!active);

        // Instead of selfdestruct(owner), invoke owner fallback function to allow
        // owner to log an event if desired; but owner should also be aware that
        // its fallback function can also be invoked by setBalance
        if (_owner.send(address(this).balance)) {
            selfdestruct(burn);
        }
    }
}

// File: https://github.com/ensdomains/ens/blob/v0.3.0/contracts/Registrar.sol

interface Registrar {

    enum Mode { Open, Auction, Owned, Forbidden, Reveal, NotYetAvailable }

    event AuctionStarted(bytes32 indexed hash, uint registrationDate);
    event NewBid(bytes32 indexed hash, address indexed bidder, uint deposit);
    event BidRevealed(bytes32 indexed hash, address indexed owner, uint value, uint8 status);
    event HashRegistered(bytes32 indexed hash, address indexed owner, uint value, uint registrationDate);
    event HashReleased(bytes32 indexed hash, uint value);
    event HashInvalidated(bytes32 indexed hash, string indexed name, uint value, uint registrationDate);

    function startAuction(bytes32 _hash) external;
    function startAuctions(bytes32[] calldata _hashes) external;
    function newBid(bytes32 sealedBid) external payable;
    function startAuctionsAndBid(bytes32[] calldata hashes, bytes32 sealedBid) external payable;
    function unsealBid(bytes32 _hash, uint _value, bytes32 _salt) external;
    function cancelBid(address bidder, bytes32 seal) external;
    function finalizeAuction(bytes32 _hash) external;
    function transfer(bytes32 _hash, address payable newOwner) external;
    function releaseDeed(bytes32 _hash) external;
    function invalidateName(string calldata unhashedName) external;
    function eraseNode(bytes32[] calldata labels) external;
    function transferRegistrars(bytes32 _hash) external;
    function acceptRegistrarTransfer(bytes32 hash, Deed deed, uint registrationDate) external;
    function entries(bytes32 _hash) external view returns (Mode, address, uint, uint, uint);
}

// File: https://github.com/ensdomains/ens/blob/v0.3.0/contracts/HashRegistrar.sol

/*

Temporary Hash Registrar
========================

This is a simplified version of a hash registrar. It is purporsefully limited:
names cannot be six letters or shorter, new auctions will stop after 4 years.

The plan is to test the basic features and then move to a new contract in at most
2 years, when some sort of renewal mechanism will be enabled.
*/




/**
 * @title Registrar
 * @dev The registrar handles the auction process for each subnode of the node it owns.
 */
contract HashRegistrar is Registrar {
    ENS public ens;
    bytes32 public rootNode;

    mapping (bytes32 => Entry) _entries;
    mapping (address => mapping (bytes32 => Deed)) public sealedBids;

    uint32 constant totalAuctionLength = 5 days;
    uint32 constant revealPeriod = 48 hours;
    uint32 public constant launchLength = 8 weeks;

    uint constant minPrice = 0.01 ether;
    uint public registryStarted;

    struct Entry {
        Deed deed;
        uint registrationDate;
        uint value;
        uint highestBid;
    }

    modifier inState(bytes32 _hash, Mode _state) {
        require(state(_hash) == _state);
        _;
    }

    modifier onlyOwner(bytes32 _hash) {
        require(state(_hash) == Mode.Owned && msg.sender == _entries[_hash].deed.owner());
        _;
    }

    modifier registryOpen() {
        require(now >= registryStarted && now <= registryStarted + (365 * 4) * 1 days && ens.owner(rootNode) == address(this));
        _;
    }

    /**
     * @dev Constructs a new Registrar, with the provided address as the owner of the root node.
     *
     * @param _ens The address of the ENS
     * @param _rootNode The hash of the rootnode.
     */
    constructor(ENS _ens, bytes32 _rootNode, uint _startDate) public {
        ens = _ens;
        rootNode = _rootNode;
        registryStarted = _startDate > 0 ? _startDate : now;
    }

    /**
     * @dev Start an auction for an available hash
     *
     * @param _hash The hash to start an auction on
     */
    function startAuction(bytes32 _hash) external {
        _startAuction(_hash);
    }

    /**
     * @dev Start multiple auctions for better anonymity
     *
     * Anyone can start an auction by sending an array of hashes that they want to bid for.
     * Arrays are sent so that someone can open up an auction for X dummy hashes when they
     * are only really interested in bidding for one. This will increase the cost for an
     * attacker to simply bid blindly on all new auctions. Dummy auctions that are
     * open but not bid on are closed after a week.
     *
     * @param _hashes An array of hashes, at least one of which you presumably want to bid on
     */
    function startAuctions(bytes32[] calldata _hashes) external {
        _startAuctions(_hashes);
    }

    /**
     * @dev Submit a new sealed bid on a desired hash in a blind auction
     *
     * Bids are sent by sending a message to the main contract with a hash and an amount. The hash
     * contains information about the bid, including the bidded hash, the bid amount, and a random
     * salt. Bids are not tied to any one auction until they are revealed. The value of the bid
     * itself can be masqueraded by sending more than the value of your actual bid. This is
     * followed by a 48h reveal period. Bids revealed after this period will be burned and the ether unrecoverable.
     * Since this is an auction, it is expected that most public hashes, like known domains and common dictionary
     * words, will have multiple bidders pushing the price up.
     *
     * @param sealedBid A sealedBid, created by the shaBid function
     */
    function newBid(bytes32 sealedBid) external payable {
        _newBid(sealedBid);
    }

    /**
     * @dev Start a set of auctions and bid on one of them
     *
     * This method functions identically to calling `startAuctions` followed by `newBid`,
     * but all in one transaction.
     *
     * @param hashes A list of hashes to start auctions on.
     * @param sealedBid A sealed bid for one of the auctions.
     */
    function startAuctionsAndBid(bytes32[] calldata hashes, bytes32 sealedBid) external payable {
        _startAuctions(hashes);
        _newBid(sealedBid);
    }

    /**
     * @dev Submit the properties of a bid to reveal them
     *
     * @param _hash The node in the sealedBid
     * @param _value The bid amount in the sealedBid
     * @param _salt The sale in the sealedBid
     */
    function unsealBid(bytes32 _hash, uint _value, bytes32 _salt) external {
        bytes32 seal = shaBid(_hash, msg.sender, _value, _salt);
        Deed bid = sealedBids[msg.sender][seal];
        require(address(bid) != address(0x0));

        sealedBids[msg.sender][seal] = Deed(address(0x0));
        Entry storage h = _entries[_hash];
        uint value = min(_value, bid.value());
        bid.setBalance(value, true);

        Mode auctionState = state(_hash);
        if (auctionState == Mode.Owned) {
            // Too late! Bidder loses their bid. Gets 0.5% back.
            bid.closeDeed(5);
         //   emit BidRevealed(_hash, msg.sender, value, 1);
        } else if (auctionState != Mode.Reveal) {
            // Invalid phase
            revert();
        } else if (value < minPrice || bid.creationDate() > h.registrationDate - revealPeriod) {
            // Bid too low or too late, refund 99.5%
            bid.closeDeed(995);
         ///   emit BidRevealed(_hash, msg.sender, value, 0);
        } else if (value > h.highestBid) {
            // New winner
            // Cancel the other bid, refund 99.5%
            if (address(h.deed) != address(0x0)) {
                Deed previousWinner = h.deed;
                previousWinner.closeDeed(995);
            }

            // Set new winner
            // Per the rules of a vickery auction, the value becomes the previous highestBid
            h.value = h.highestBid;  // will be zero if there's only 1 bidder
            h.highestBid = value;
            h.deed = bid;
         //   emit BidRevealed(_hash, msg.sender, value, 2);
        } else if (value > h.value) {
            // Not winner, but affects second place
            h.value = value;
            bid.closeDeed(995);
        //    emit BidRevealed(_hash, msg.sender, value, 3);
        } else {
            // Bid doesn't affect auction
            bid.closeDeed(995);
         //   emit BidRevealed(_hash, msg.sender, value, 4);
        }
    }

    /**
     * @dev Cancel a bid
     *
     * @param seal The value returned by the shaBid function
     */
    function cancelBid(address bidder, bytes32 seal) external {
        Deed bid = sealedBids[bidder][seal];
        
        // If a sole bidder does not `unsealBid` in time, they have a few more days
        // where they can call `startAuction` (again) and then `unsealBid` during
        // the revealPeriod to get back their bid value.
        // For simplicity, they should call `startAuction` within
        // 9 days (2 weeks - totalAuctionLength), otherwise their bid will be
        // cancellable by anyone.
        require(address(bid) != address(0x0) && now >= bid.creationDate() + totalAuctionLength + 2 weeks);

        // Send the canceller 0.5% of the bid, and burn the rest.
        bid.setOwner(msg.sender);
        bid.closeDeed(5);
        sealedBids[bidder][seal] = Deed(0);
    //   emit BidRevealed(seal, bidder, 0, 5);
    }

    /**
     * @dev Finalize an auction after the registration date has passed
     *
     * @param _hash The hash of the name the auction is for
     */
    function finalizeAuction(bytes32 _hash) external onlyOwner(_hash) {
        Entry storage h = _entries[_hash];
        
        // Handles the case when there's only a single bidder (h.value is zero)
        h.value = max(h.value, minPrice);
        h.deed.setBalance(h.value, true);

        trySetSubnodeOwner(_hash, h.deed.owner());
    //    emit HashRegistered(_hash, h.deed.owner(), h.value, h.registrationDate);
    }

    /**
     * @dev The owner of a domain may transfer it to someone else at any time.
     *
     * @param _hash The node to transfer
     * @param newOwner The address to transfer ownership to
     */
    function transfer(bytes32 _hash, address payable newOwner) external onlyOwner(_hash) {
        require(newOwner != address(0x0));

        Entry storage h = _entries[_hash];
        h.deed.setOwner(newOwner);
        trySetSubnodeOwner(_hash, newOwner);
    }

    /**
     * @dev After some time, or if we're no longer the registrar, the owner can release
     *      the name and get their ether back.
     *
     * @param _hash The node to release
     */
    function releaseDeed(bytes32 _hash) external onlyOwner(_hash) {
        Entry storage h = _entries[_hash];
        Deed deedContract = h.deed;

        require(now >= h.registrationDate + 365 days || ens.owner(rootNode) != address(this));

        h.value = 0;
        h.highestBid = 0;
        h.deed = Deed(0);

        _tryEraseSingleNode(_hash);
        deedContract.closeDeed(1000);
    // HashReleased(_hash, h.value);        
    }

    /**
     * @dev Submit a name 6 characters long or less. If it has been registered,
     *      the submitter will earn 50% of the deed value. 
     * 
     * We are purposefully handicapping the simplified registrar as a way 
     * to force it into being restructured in a few years.
     *
     * @param unhashedName An invalid name to search for in the registry.
     */
    function invalidateName(string calldata unhashedName)
        external
        inState(keccak256(abi.encode(unhashedName)), Mode.Owned)
    {
        require(strlen(unhashedName) <= 6);
        bytes32 hash = keccak256(abi.encode(unhashedName));

        Entry storage h = _entries[hash];

        _tryEraseSingleNode(hash);

        if (address(h.deed) != address(0x0)) {
            // Reward the discoverer with 50% of the deed
            // The previous owner gets 50%
            h.value = max(h.value, minPrice);
            h.deed.setBalance(h.value/2, false);
            h.deed.setOwner(msg.sender);
            h.deed.closeDeed(1000);
        }

    //    emit HashInvalidated(hash, unhashedName, h.value, h.registrationDate);

        h.value = 0;
        h.highestBid = 0;
        h.deed = Deed(0);
    }

    /**
     * @dev Allows anyone to delete the owner and resolver records for a (subdomain of) a
     *      name that is not currently owned in the registrar. If passing, eg, 'foo.bar.eth',
     *      the owner and resolver fields on 'foo.bar.eth' and 'bar.eth' will all be cleared.
     *
     * @param labels A series of label hashes identifying the name to zero out, rooted at the
     *        registrar's root. Must contain at least one element. For instance, to zero 
     *        'foo.bar.eth' on a registrar that owns '.eth', pass an array containing
     *        [keccak256('foo'), keccak256('bar')].
     */
    function eraseNode(bytes32[] calldata labels) external {
        require(labels.length != 0);
        require(state(labels[labels.length - 1]) != Mode.Owned);

        _eraseNodeHierarchy(labels.length - 1, labels, rootNode);
    }

    /**
     * @dev Transfers the deed to the current registrar, if different from this one.
     *
     * Used during the upgrade process to a permanent registrar.
     *
     * @param _hash The name hash to transfer.
     */
    function transferRegistrars(bytes32 _hash) external onlyOwner(_hash) {
        address registrar = ens.owner(rootNode);
        require(registrar != address(this));

        // Migrate the deed
        Entry storage h = _entries[_hash];
        h.deed.setRegistrar(registrar);

        // Call the new registrar to accept the transfer
        Registrar(registrar).acceptRegistrarTransfer(_hash, h.deed, h.registrationDate);

        // Zero out the Entry
        h.deed = Deed(0);
        h.registrationDate = 0;
        h.value = 0;
        h.highestBid = 0;
    }

    /**
     * @dev Accepts a transfer from a previous registrar; stubbed out here since there
     *      is no previous registrar implementing this interface.
     *
     * @param hash The sha3 hash of the label to transfer.
     * @param deed The Deed object for the name being transferred in.
     * @param registrationDate The date at which the name was originally registered.
     */
    function acceptRegistrarTransfer(bytes32 hash, Deed deed, uint registrationDate) external {
        hash; deed; registrationDate; // Don't warn about unused variables
    }

    function entries(bytes32 _hash) external view returns (Mode, address, uint, uint, uint) {
        Entry storage h = _entries[_hash];
        return (state(_hash), address(h.deed), h.registrationDate, h.value, h.highestBid);
    }

    // State transitions for names:
    //   Open -> Auction (startAuction)
    //   Auction -> Reveal
    //   Reveal -> Owned
    //   Reveal -> Open (if nobody bid)
    //   Owned -> Open (releaseDeed or invalidateName)
    function state(bytes32 _hash) public view returns (Mode) {
        Entry storage entry = _entries[_hash];

        if (!isAllowed(_hash, now)) {
            return Mode.NotYetAvailable;
        } else if (now < entry.registrationDate) {
            if (now < entry.registrationDate - revealPeriod) {
                return Mode.Auction;
            } else {
                return Mode.Reveal;
            }
        } else {
            if (entry.highestBid == 0) {
                return Mode.Open;
            } else {
                return Mode.Owned;
            }
        }
    }

    /**
     * @dev Determines if a name is available for registration yet
     *
     * Each name will be assigned a random date in which its auction
     * can be started, from 0 to 8 weeks
     *
     * @param _hash The hash to start an auction on
     * @param _timestamp The timestamp to query about
     */
    function isAllowed(bytes32 _hash, uint _timestamp) public view returns (bool allowed) {
        return _timestamp > getAllowedTime(_hash);
    }

    /**
     * @dev Returns available date for hash
     *
     * The available time from the `registryStarted` for a hash is proportional
     * to its numeric value.
     *
     * @param _hash The hash to start an auction on
     */
    function getAllowedTime(bytes32 _hash) public view returns (uint) {
        return registryStarted + ((launchLength * (uint(_hash) >> 128)) >> 128);
        // Right shift operator: a >> b == a / 2**b
    }

    /**
     * @dev Hash the values required for a secret bid
     *
     * @param hash The node corresponding to the desired namehash
     * @param value The bid amount
     * @param salt A random value to ensure secrecy of the bid
     * @return The hash of the bid values
     */
    function shaBid(bytes32 hash, address owner, uint value, bytes32 salt) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(hash, owner, value, salt));
    }

    function _tryEraseSingleNode(bytes32 label) internal {
        if (ens.owner(rootNode) == address(this)) {
            ens.setSubnodeOwner(rootNode, label, address(this));
            bytes32 node = keccak256(abi.encodePacked(rootNode, label));
            ens.setResolver(node, address(0x0));
            ens.setOwner(node, address(0x0));
        }
    }

    function _startAuction(bytes32 _hash) internal registryOpen() {
        Mode mode = state(_hash);
        if (mode == Mode.Auction) return;
        require(mode == Mode.Open);

        Entry storage newAuction = _entries[_hash];
        newAuction.registrationDate = now + totalAuctionLength;
        newAuction.value = 0;
        newAuction.highestBid = 0;
    //    emit AuctionStarted(_hash, newAuction.registrationDate);
    }

    function _startAuctions(bytes32[] memory _hashes) internal {
        for (uint i = 0; i < _hashes.length; i ++) {
            _startAuction(_hashes[i]);
        }
    }

    function _newBid(bytes32 sealedBid) internal {
        require(address(sealedBids[msg.sender][sealedBid]) == address(0x0));
        require(msg.value >= minPrice);

        // Creates a new hash contract with the owner
        Deed bid = (new DeedImplementation).value(msg.value)(msg.sender);
        sealedBids[msg.sender][sealedBid] = bid;
     //   emit NewBid(sealedBid, msg.sender, msg.value);
    }

    function _eraseNodeHierarchy(uint idx, bytes32[] memory labels, bytes32 node) internal {
        // Take ownership of the node
        ens.setSubnodeOwner(node, labels[idx], address(this));
        node = keccak256(abi.encodePacked(node, labels[idx]));

        // Recurse if there are more labels
        if (idx > 0) {
            _eraseNodeHierarchy(idx - 1, labels, node);
        }

        // Erase the resolver and owner records
        ens.setResolver(node, address(0x0));
        ens.setOwner(node, address(0x0));
    }

    /**
     * @dev Assign the owner in ENS, if we're still the registrar
     *
     * @param _hash hash to change owner
     * @param _newOwner new owner to transfer to
     */
    function trySetSubnodeOwner(bytes32 _hash, address _newOwner) internal {
        if (ens.owner(rootNode) == address(this))
            ens.setSubnodeOwner(rootNode, _hash, _newOwner);
    }

    /**
     * @dev Returns the maximum of two unsigned integers
     *
     * @param a A number to compare
     * @param b A number to compare
     * @return The maximum of two unsigned integers
     */
    function max(uint a, uint b) internal pure returns (uint) {
        if (a > b)
            return a;
        else
            return b;
    }

    /**
     * @dev Returns the minimum of two unsigned integers
     *
     * @param a A number to compare
     * @param b A number to compare
     * @return The minimum of two unsigned integers
     */
    function min(uint a, uint b) internal pure returns (uint) {
        if (a < b)
            return a;
        else
            return b;
    }

    /**
     * @dev Returns the length of a given string
     *
     * @param s The string to measure the length of
     * @return The length of the input string
     */
    function strlen(string memory s) internal pure returns (uint) {
        s; // Don't warn about unused variables
        // Starting here means the LSB will be the byte we care about
        uint ptr;
        uint end;
        assembly {
            ptr := add(s, 1)
            end := add(mload(s), ptr)
        }
        uint len = 0;
        for (len; ptr < end; len++) {
            uint8 b;
            assembly { b := and(mload(ptr), 0xFF) }
            if (b < 0x80) {
                ptr += 1;
            } else if (b < 0xE0) {
                ptr += 2;
            } else if (b < 0xF0) {
                ptr += 3;
            } else if (b < 0xF8) {
                ptr += 4;
            } else if (b < 0xFC) {
                ptr += 5;
            } else {
                ptr += 6;
            }
        }
        return len;
    }

}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be aplied to your functions to restrict their use to
 * the owner.
 */
contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = msg.sender;
   //     emit OwnershipTransferred(address(0), _owner);
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
        return msg.sender == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * > Note: Renouncing ownership will leave the contract without an owner,
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
    //    emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract BaseRegistrar is ERC721, Ownable {
    uint constant public GRACE_PERIOD = 30 days;

    event ControllerAdded(address indexed controller);
    event ControllerRemoved(address indexed controller);
    event NameMigrated(uint256 indexed id, address indexed owner, uint expires);
    event NameRegistered(uint256 indexed id, address indexed owner, uint expires);
    event NameRenewed(uint256 indexed id, uint expires);

    // Expiration timestamp for migrated domains.
    uint public transferPeriodEnds;

    // The ENS registry
    ENS public ens;

    // The namehash of the TLD this registrar owns (eg, .eth)
    bytes32 public baseNode;

    // The interim registrar
    HashRegistrar public previousRegistrar;

    // A map of addresses that are authorised to register and renew names.
    mapping(address=>bool) public controllers;

    // Authorises a controller, who can register and renew domains.
    function addController(address controller) external;

    // Revoke controller permission for an address.
    function removeController(address controller) external;

    // Returns the expiration timestamp of the specified label hash.
    function nameExpires(uint256 id) external view returns(uint);

    // Returns true iff the specified name is available for registration.
    function available(uint256 id) public view returns(bool);

    /**
     * @dev Register a name.
     */
    function register(uint256 id, address owner, uint duration) external returns(uint);

    function renew(uint256 id, uint duration) external returns(uint);

    /**
     * @dev Reclaim ownership of a name in ENS, if you own it in the registrar.
     */
    function reclaim(uint256 id) external;

    /**
     * @dev Transfers a registration from the initial registrar.
     * This function is called by the initial registrar when a user calls `transferRegistrars`.
     */
    function acceptRegistrarTransfer(bytes32 label, Deed deed, uint) external;
}

library StringUtils {
    /**
     * @dev Returns the length of a given string
     *
     * @param s The string to measure the length of
     * @return The length of the input string
     */
    function strlen(string memory s) internal pure returns (uint) {
        s; // Don't warn about unused variables
        // Starting here means the LSB will be the byte we care about
        uint ptr;
        uint end;
        assembly {
            ptr := add(s, 1)
            end := add(mload(s), ptr)
        }
        uint len;
        for (len = 0; ptr < end; len++) {
            uint8 b;
            assembly { b := and(mload(ptr), 0xFF) }
            if (b < 0x80) {
                ptr += 1;
            } else if (b < 0xE0) {
                ptr += 2;
            } else if (b < 0xF0) {
                ptr += 3;
            } else if (b < 0xF8) {
                ptr += 4;
            } else if (b < 0xFC) {
                ptr += 5;
            } else {
                ptr += 6;
            }
        }
        return len;
    }
}

interface PriceOracle {
    /**
     * @dev Returns the price to register or renew a name.
     * @param name The name being registered or renewed.
     * @param expires When the name presently expires (0 if this is a new registration).
     * @param duration How long the name is being registered or extended for, in seconds.
     * @return The price of this renewal or registration, in wei.
     */
    function price(string calldata name, uint expires, uint duration) external view returns(uint);
}
/**
 * @dev A registrar controller for registering and renewing names at fixed cost.
 */
contract ETHRegistrarController is Ownable {
    using StringUtils for *;

    uint constant public MIN_COMMITMENT_AGE = 1 hours;
    uint constant public MAX_COMMITMENT_AGE = 48 hours;
    uint constant public MIN_REGISTRATION_DURATION = 28 days;

    bytes4 constant private INTERFACE_META_ID = bytes4(keccak256("supportsInterface(bytes4)"));
    bytes4 constant private COMMITMENT_CONTROLLER_ID = bytes4(
        keccak256("rentPrice(string,uint256)") ^
        keccak256("available(string)") ^
        keccak256("makeCommitment(string,address,bytes32)") ^
        keccak256("commit(bytes32)") ^
        keccak256("register(string,address,uint256,bytes32)") ^
        keccak256("renew(string,uint256)")
    );

    BaseRegistrar base;
    PriceOracle prices;

    mapping(bytes32=>uint) public commitments;

    event NameRegistered(string name, bytes32 indexed label, address indexed owner, uint cost, uint expires);
    event NameRenewed(string name, bytes32 indexed label, uint cost, uint expires);
    event NewPriceOracle(address indexed oracle);

    constructor(BaseRegistrar _base, PriceOracle _prices) public {
        base = _base;
        prices = _prices;
    }

    function rentPrice(string memory name, uint duration) view public returns(uint) {
        bytes32 hash = keccak256(bytes(name));
        return prices.price(name, base.nameExpires(uint256(hash)), duration);
    }

    function valid(string memory name) public view returns(bool) {
        return name.strlen() > 6;
    }

    function available(string memory name) public view returns(bool) {
        bytes32 label = keccak256(bytes(name));
        return valid(name) && base.available(uint256(label));
    }

    function makeCommitment(string memory name, address owner, bytes32 secret) pure public returns(bytes32) {
        bytes32 label = keccak256(bytes(name));
        return keccak256(abi.encodePacked(label, owner, secret));
    }

    function commit(bytes32 commitment) public {
        require(commitments[commitment] + MAX_COMMITMENT_AGE < now);
        commitments[commitment] = now;
    }

    function register(string calldata name, address owner, uint duration, bytes32 secret) external payable {
        // Require a valid commitment
        require(owner == msg.sender);
        bytes32 commitment = makeCommitment(name, owner, secret);
        require(commitments[commitment] + MIN_COMMITMENT_AGE <= now);

        // If the commitment is too old, or the name is registered, stop
        if(commitments[commitment] + MAX_COMMITMENT_AGE < now || !available(name))  {
            msg.sender.transfer(msg.value);
            return;
        }
        delete(commitments[commitment]);

        uint cost = rentPrice(name, duration);
        require(duration >= MIN_REGISTRATION_DURATION);
        require(msg.value >= cost);

        bytes32 label = keccak256(bytes(name));
        uint expires = base.register(uint256(label), owner, duration);
        emit NameRegistered(name, label, owner, cost, expires);

        if(msg.value > cost) {
            msg.sender.transfer(msg.value - cost);
        }
    }

    function renew(string calldata name, uint duration) external payable {
        uint cost = rentPrice(name, duration);
        require(msg.value >= cost);

        bytes32 label = keccak256(bytes(name));
        uint expires = base.renew(uint256(label), duration);

        if(msg.value > cost) {
            msg.sender.transfer(msg.value - cost);
        }

    //emit NameRenewed(name, label, cost, expires);
    }

    function setPriceOracle(PriceOracle _prices) public onlyOwner {
        prices = _prices;
    //    emit NewPriceOracle(address(prices));
    }

    function withdraw() public onlyOwner {
        msg.sender.transfer(address(this).balance);
    }

    function supportsInterface(bytes4 interfaceID) external pure returns (bool) {
        return interfaceID == INTERFACE_META_ID ||
               interfaceID == COMMITMENT_CONTROLLER_ID;
    }
}