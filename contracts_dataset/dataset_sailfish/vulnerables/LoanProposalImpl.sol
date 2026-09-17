
// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/op/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
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

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

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
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/op/contracts/token/ERC20/extensions/IERC20Metadata.sol


// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.0;


/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/op/contracts/token/ERC20/extensions/draft-IERC20Permit.sol


// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/draft-IERC20Permit.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on {IERC20-approve}, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 */
interface IERC20Permit {
    /**
     * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
     * given ``owner``'s signed approval.
     *
     * IMPORTANT: The same issues {IERC20-approve} has related to transaction
     * ordering also apply here.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `deadline` must be a timestamp in the future.
     * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
     * over the EIP712-formatted function arguments.
     * - the signature must use ``owner``'s current nonce (see {nonces}).
     *
     * For more information on the signature format, see the
     * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
     * section].
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be
     * included whenever a signature is generated for {permit}.
     *
     * Every successful call to {permit} increases ``owner``'s nonce by one. This
     * prevents a signature from being used multiple times.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/op/contracts/utils/Address.sol


// OpenZeppelin Contracts (last updated v4.8.0) (utils/Address.sol)

pragma solidity ^0.8.1;

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
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
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
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verify that a low level call to smart-contract was successful, and revert (either by bubbling
     * the revert reason or using the provided one) in case of unsuccessful call or if target was not a contract.
     *
     * _Available since v4.8._
     */
    function verifyCallResultFromTarget(
        address target,
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        if (success) {
            if (returndata.length == 0) {
                // only check isContract if the call was successful and the return data is empty
                // otherwise we already know that it was a contract
                require(isContract(target), "Address: call to non-contract");
            }
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    /**
     * @dev Tool to verify that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason or using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    function _revert(bytes memory returndata, string memory errorMessage) private pure {
        // Look for revert reason and bubble it up if present
        if (returndata.length > 0) {
            // The easiest way to bubble the revert reason is using memory via assembly
            /// @solidity memory-safe-assembly
            assembly {
                let returndata_size := mload(returndata)
                revert(add(32, returndata), returndata_size)
            }
        } else {
            revert(errorMessage);
        }
    }
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/op/contracts/token/ERC20/utils/SafeERC20.sol


// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC20/utils/SafeERC20.sol)

pragma solidity ^0.8.0;




/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    function safePermit(
        IERC20Permit token,
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal {
        uint256 nonceBefore = token.nonces(owner);
        token.permit(owner, spender, value, deadline, v, r, s);
        uint256 nonceAfter = token.nonces(owner);
        require(nonceAfter == nonceBefore + 1, "SafeERC20: permit did not succeed");
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/op/contracts/proxy/utils/Initializable.sol


// OpenZeppelin Contracts (last updated v4.8.0) (proxy/utils/Initializable.sol)

pragma solidity ^0.8.2;


/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since proxied contracts do not make use of a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * The initialization functions use a version number. Once a version number is used, it is consumed and cannot be
 * reused. This mechanism prevents re-execution of each "step" but allows the creation of new initialization steps in
 * case an upgrade adds a module that needs to be initialized.
 *
 * For example:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * contract MyToken is ERC20Upgradeable {
 *     function initialize() initializer public {
 *         __ERC20_init("MyToken", "MTK");
 *     }
 * }
 * contract MyTokenV2 is MyToken, ERC20PermitUpgradeable {
 *     function initializeV2() reinitializer(2) public {
 *         __ERC20Permit_init("MyToken");
 *     }
 * }
 * ```
 *
 * TIP: To avoid leaving the proxy in an uninitialized state, the initializer function should be called as early as
 * possible by providing the encoded function call as the `_data` argument to {ERC1967Proxy-constructor}.
 *
 * CAUTION: When used with inheritance, manual care must be taken to not invoke a parent initializer twice, or to ensure
 * that all initializers are idempotent. This is not verified automatically as constructors are by Solidity.
 *
 * [CAUTION]
 * ====
 * Avoid leaving a contract uninitialized.
 *
 * An uninitialized contract can be taken over by an attacker. This applies to both a proxy and its implementation
 * contract, which may impact the proxy. To prevent the implementation contract from being used, you should invoke
 * the {_disableInitializers} function in the constructor to automatically lock it when it is deployed:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * /// @custom:oz-upgrades-unsafe-allow constructor
 * constructor() {
 *     _disableInitializers();
 * }
 * ```
 * ====
 */
abstract contract Initializable {
    /**
     * @dev Indicates that the contract has been initialized.
     * @custom:oz-retyped-from bool
     */
    uint8 private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Triggered when the contract has been initialized or reinitialized.
     */
    event Initialized(uint8 version);

    /**
     * @dev A modifier that defines a protected initializer function that can be invoked at most once. In its scope,
     * `onlyInitializing` functions can be used to initialize parent contracts.
     *
     * Similar to `reinitializer(1)`, except that functions marked with `initializer` can be nested in the context of a
     * constructor.
     *
     * Emits an {Initialized} event.
     */
    modifier initializer() {
        bool isTopLevelCall = !_initializing;
        require(
            (isTopLevelCall && _initialized < 1) || (!Address.isContract(address(this)) && _initialized == 1),
            "Initializable: contract is already initialized"
        );
        _initialized = 1;
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
        //    emit Initialized(1);
        }
    }

    /**
     * @dev A modifier that defines a protected reinitializer function that can be invoked at most once, and only if the
     * contract hasn't been initialized to a greater version before. In its scope, `onlyInitializing` functions can be
     * used to initialize parent contracts.
     *
     * A reinitializer may be used after the original initialization step. This is essential to configure modules that
     * are added through upgrades and that require initialization.
     *
     * When `version` is 1, this modifier is similar to `initializer`, except that functions marked with `reinitializer`
     * cannot be nested. If one is invoked in the context of another, execution will revert.
     *
     * Note that versions can jump in increments greater than 1; this implies that if multiple reinitializers coexist in
     * a contract, executing them in the right order is up to the developer or operator.
     *
     * WARNING: setting the version to 255 will prevent any future reinitialization.
     *
     * Emits an {Initialized} event.
     */
    modifier reinitializer(uint8 version) {
        require(!_initializing && _initialized < version, "Initializable: contract is already initialized");
        _initialized = version;
        _initializing = true;
        _;
        _initializing = false;
    //    emit Initialized(version);
    }

    /**
     * @dev Modifier to protect an initialization function so that it can only be invoked by functions with the
     * {initializer} and {reinitializer} modifiers, directly or indirectly.
     */
    modifier onlyInitializing() {
        require(_initializing, "Initializable: contract is not initializing");
        _;
    }

    /**
     * @dev Locks the contract, preventing any future reinitialization. This cannot be part of an initializer call.
     * Calling this in the constructor of a contract will prevent that contract from being initialized or reinitialized
     * to any version. It is recommended to use this to lock implementation contracts that are designed to be called
     * through proxies.
     *
     * Emits an {Initialized} event the first time it is successfully executed.
     */
    function _disableInitializers() internal virtual {
        require(!_initializing, "Initializable: contract is initializing");
        if (_initialized < type(uint8).max) {
            _initialized = type(uint8).max;
       //     emit Initialized(type(uint8).max);
        }
    }

    /**
     * @dev Internal function that returns the initialized version. Returns `_initialized`
     */
    function _getInitializedVersion() internal view returns (uint8) {
        return _initialized;
    }

    /**
     * @dev Internal function that returns the initialized version. Returns `_initializing`
     */
    function _isInitializing() internal view returns (bool) {
        return _initializing;
    }
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/peer-to-pool/DataTypes.sol


pragma solidity 0.8.19;

library DataTypes {
    struct Repayment {
        // The loan token amount due for given period; initially, expressed in relative terms (100%=BASE), once finalized in absolute terms (in loan token)
        uint128 loanTokenDue;
        // The coll token amount that can be converted for given period; initially, expressed in relative terms w.r.t. loanTokenDue (100%=BASE), once finalized in absolute terms (in loan token)
        uint128 collTokenDueIfConverted;
        // Timestamp when repayment is due
        uint40 dueTimestamp;
        // Grace period during which lenders can convert, i.e., between [dueTimeStamp, dueTimeStamp+conversionGracePeriod]
        uint40 conversionGracePeriod;
        // Grace period during which the borrower can repay, i.e., between [dueTimeStamp+conversionGracePeriod, dueTimeStamp+conversionGracePeriod+repaymentGracePeriod]
        uint40 repaymentGracePeriod;
        // Flag whether given period is considered repaid
        bool repaid;
    }

    struct LoanTerms {
        // Borrower who can accept given loan proposal
        address borrower;
        // Min loan amount (in loan token) that the borrower intends to borrow
        uint128 minLoanAmount;
        // Max loan amount (in loan token) that the borrower intends to borrow
        uint128 maxLoanAmount;
        // The number of collateral tokens the borrower pledges per loan token borrowed as collateral for default case
        uint128 collPerLoanToken;
        // Array of scheduled repayments
        Repayment[] repaymentSchedule;
    }

    struct StaticLoanProposalData {
        // Funding pool address that is associated with given loan proposal and from which loan liquidity can be sourced
        address fundingPool;
        // Address of collateral token to be used for given loan proposal
        address collToken;
        // Address of arranger who can manage the loan proposal contract
        address arranger;
        // Lender grace period (in seconds), i.e., after acceptance by borrower lenders can unsubscribe and remove liquidity for this duration before being locked-in
        uint256 lenderGracePeriod;
    }

    struct DynamicLoanProposalData {
        // Arranger fee charged on final loan amount, initially in relative terms (100%=BASE), and after finalization in absolute terms (in loan token)
        uint256 arrangerFee;
        // Final loan amount; initially this is zero and gets set once loan proposal got accepted and finalized
        uint256 finalLoanAmount;
        // Final collateral amount reserved for defaults; initially this is zero and gets set once loan proposal got accepted and finalized
        uint256 finalCollAmountReservedForDefault;
        // Final collateral amount reserved for conversions; initially this is zero and gets set once loan proposal got accepted and finalized
        uint256 finalCollAmountReservedForConversions;
        // Timestamp when the loan terms get accepted by borrower and after which they cannot be changed anymore
        uint256 loanTermsLockedTime;
        // Current repayment index (see repayment schedule array)
        uint256 currentRepaymentIdx;
        // Status of current loan proposal
        DataTypes.LoanStatus status;
    }

    enum LoanStatus {
        WITHOUT_LOAN_TERMS,
        IN_NEGOTIATION,
        BORROWER_ACCEPTED,
        READY_TO_EXECUTE,
        ROLLBACK,
        LOAN_DEPLOYED,
        DEFAULTED
    }
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/peer-to-pool/interfaces/ILoanProposalImpl.sol


pragma solidity 0.8.19;


interface ILoanProposalImpl {
    /**
     * @notice Initializes loan proposal
     * @param _arranger Address of the arranger of the proposal
     * @param _fundingPool Address of the funding pool to be used to source liquidity, if successful
     * @param _collToken Address of collateral token to be used in loan
     * @param _arrangerFee Arranger fee in percent (where 100% = BASE)
     * @param _lenderGracePeriod If lenders subscribe and proposal gets they can still unsubscribe from the deal for this time period before being locked-in
     */
    function initialize(
        address _arranger,
        address _fundingPool,
        address _collToken,
        uint256 _arrangerFee,
        uint256 _lenderGracePeriod
    ) external;

    /**
     * @notice Propose new loan terms
     * @param newLoanTerms The new loan terms
     * @dev Can only be called by the arranger
     */
    function proposeLoanTerms(
        DataTypes.LoanTerms calldata newLoanTerms
    ) external;

    /**
     * @notice Accept loan terms
     * @dev Can only be called by the borrower
     */
    function acceptLoanTerms() external;

    /**
     * @notice Finalize the loan terms and transfer final collateral amount
     * @param expectedTransferFee The expected transfer fee (if any) of the collateral token
     * @dev Can only be called by the borrower
     */
    function finalizeLoanTermsAndTransferColl(
        uint256 expectedTransferFee
    ) external;

    /**
     * @notice Rolls back the loan proposal
     * @dev Can be called by borrower during the lender grace period or by anyone in case the total subscribed fell below the minLoanAmount
     */
    function rollback() external;

    /**
     * @notice Checks and updates the status of the loan proposal from 'READY_TO_EXECUTE' to 'LOAN_DEPLOYED'
     * @dev Can only be called by funding pool in conjunction with executing the loan proposal and settling amounts, i.e., sending loan amount to borrower and fees
     */
    function checkAndupdateStatus() external;

    /**
     * @notice Allows lenders to exercise their conversion right for given repayment period
     * @dev Can only be called by entitled lenders and during conversion grace period of given repayment period
     */
    function exerciseConversion() external;

    /**
     * @notice Allows borrower to repay
     * @param expectedTransferFee The expected transfer fee (if any) of the loan token
     * @dev Can only be called by borrower and during repayment grace period of given repayment period. If borrower doesn't repay in time the loan can be marked as defaulted and borrowers loses control over pledged collateral. Note that the repayment amount can be lower than the loanTokenDue if lenders convert (potentially 0 if all convert, in which case borrower still needs to call the repay function to not default). Also note that on repay any unconverted collateral token reserved for conversions for that period get transferred back to borrower.
     */
    function repay(uint256 expectedTransferFee) external;

    /**
     * @notice Allows lenders to claim any repayments for given repayment period
     * @param repaymentIdx the given repayment period index
     * @dev Can only be called by entitled lenders and if they didn't make use of their conversion right
     */
    function claimRepayment(uint256 repaymentIdx) external;

    /**
     * @notice Marks loan proposal as defaulted
     * @dev Can be called by anyone but only if borrower failed to repay during repayment grace period
     */
    function markAsDefaulted() external;

    /**
     * @notice Allows lenders to claim default proceeds
     * @dev Can only be called if borrower defaulted and loan proposal was marked as defaulted; default proceeds are whatever is left in collateral token in loan proposal contract; proceeds are splitted among all lenders taking into account any conversions lenders already made during the default period.
     */
    function claimDefaultProceeds() external;

    /**
     * @notice Returns the amount of subscriptions that converted for given repayment period
     * @param repaymentIdx The respective repayment index of given period
     * @return The total amount of subscriptions that converted for given repayment period
     */
    function totalConvertedSubscriptionsPerIdx(
        uint256 repaymentIdx
    ) external view returns (uint256);

    /**
     * @notice Returns the amount of collateral tokens that were converted during given repayment period
     * @param repaymentIdx The respective repayment index of given period
     * @return The total amount of collateral tokens that were converted during given repayment period
     */
    function collTokenConverted(
        uint256 repaymentIdx
    ) external view returns (uint256);

    /**
     * @notice Returns core dynamic data for given loan proposal
     * @return arrangerFee The arranger fee, which initially is expressed in relative terms (i.e., 100% = BASE) and once the proposal gets finalized is in absolute terms (e.g., 1000 USDC)
     * @return finalLoanAmount The final loan amount, which initially is zero and gets set once the proposal gets finalized
     * @return finalCollAmountReservedForDefault The final collateral amount reserved for default case, which initially is zero and gets set once the proposal gets finalized.
     * @return finalCollAmountReservedForConversions The final collateral amount reserved for lender conversions, which initially is zero and gets set once the proposal gets finalized
     * @return loanTermsLockedTime The timestamp when loan terms got locked in, which initially is zero and gets set once the proposal gets finalized
     * @return currentRepaymentIdx The current repayment index, which gets incremented on every repay
     * @return status The current loan proposal status.
     * @dev Note that finalCollAmountReservedForDefault is a lower bound for the collateral amount that lenders can claim in case of a default. This means that in case all lenders converted and the borrower defaults then this amount will be distributed as default recovery value on a pro-rata basis to lenders. In the other case where no lenders converted then finalCollAmountReservedForDefault plus finalCollAmountReservedForConversions will be available as default recovery value for lenders, hence finalCollAmountReservedForDefault is a lower bound for a lender's default recovery value.
     */
    function dynamicData()
        external
        view
        returns (
            uint256 arrangerFee,
            uint256 finalLoanAmount,
            uint256 finalCollAmountReservedForDefault,
            uint256 finalCollAmountReservedForConversions,
            uint256 loanTermsLockedTime,
            uint256 currentRepaymentIdx,
            DataTypes.LoanStatus status
        );

    /**
     * @notice Returns core static data for given loan proposal
     * @return fundingPool The address of the funding pool from which lenders can subscribe, and from which -upon acceptance- the final loan amount gets sourced
     * @return collToken The address of the collateral token to be provided by the borrower
     * @return arranger The address of the arranger of the proposal
     * @return lenderGracePeriod The lender grace period until which lenders can unsubscribe after a loan proposal got accepted by the borrower
     */
    function staticData()
        external
        view
        returns (
            address fundingPool,
            address collToken,
            address arranger,
            uint256 lenderGracePeriod
        );

    /**
     * @notice Returns the current loan terms
     * @return The current loan terms
     */
    function loanTerms() external view returns (DataTypes.LoanTerms memory);

    /**
     * @notice Returns flag indicating whether lenders can currently unsubscribe from loan proposal
     * @return Flag indicating whether lenders can currently unsubscribe from loan proposal
     */
    function canUnsubscribe() external view returns (bool);

    /**
     * @notice Returns flag indicating whether lenders can currently subscribe to loan proposal
     * @return Flag indicating whether lenders can currently subscribe to loan proposal
     */
    function canSubscribe() external view returns (bool);

    /**
     * @notice Returns indicative final loan terms
     * @param _tmpLoanTerms The current (or assumed) relative loan terms
     * @param totalSubscribed The current (or assumed) total subscribed amount
     * @param loanTokenDecimals The loan token decimals
     * @return loanTerms The loan terms in absolute terms
     * @return absArrangerFee The arranger fee in absolute terms
     * @return absLoanAmount The loan amount in absolute terms
     * @return absCollAmountReservedForDefault The collateral token amount reserved for default claims in absolute terms
     * @return absCollAmountReservedForConversions The collateral token amount reserved for lender conversions
     */
    function getAbsoluteLoanTerms(
        DataTypes.LoanTerms memory _tmpLoanTerms,
        uint256 totalSubscribed,
        uint256 loanTokenDecimals
    )
        external
        view
        returns (
            DataTypes.LoanTerms memory loanTerms,
            uint256 absArrangerFee,
            uint256 absLoanAmount,
            uint256 absCollAmountReservedForDefault,
            uint256 absCollAmountReservedForConversions
        );
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/peer-to-pool/interfaces/IEvents.sol



pragma solidity 0.8.19;


interface IEvents {
    event LoanProposalExecuted(address indexed loanProposalAddr);
    event LoanProposalCreated(
        address indexed loanProposalAddr,
        address indexed fundingPool,
        address indexed sender,
        address collToken,
        uint256 arrangerFee,
        uint256 lenderGracePeriod
    );
    event Subscribed(address indexed loanProposalAddr, uint256 amount);
    event Unsubscribed(address indexed loanProposalAddr, uint256 amount);
    event LoanTermsProposed(DataTypes.LoanTerms loanTerms);
    event LoanTermsAccepted();

    event DebugLoanTermsAccepted(
        address borrower,
        uint256 minLoanAmount,
        uint256 maxLoanAmount,
        uint256 collPerLoanToken,
        uint256 repaymentScheduleLength
    );

    event LoanTermsAndTransferCollFinalized(
        uint256 finalLoanAmount,
        uint256 _finalCollAmountReservedForDefault,
        uint256 _finalCollAmountReservedForConversions,
        uint256 _arrangerFee
    );
    event Rollback();
    event LoanDeployed();
    event ConversionExercised(
        address indexed sender,
        uint256 repaymentIdx,
        uint256 amount
    );
    event ClaimRepayment(address indexed sender, uint256 amount);
    event Repay(
        uint256 remainingLoanTokenDue,
        uint256 collTokenLeftUnconverted
    );
    event LoanDefaulted();
    event DefaultProceedsClaimed(address indexed sender);
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/peer-to-pool/interfaces/IFundingPool.sol


pragma solidity 0.8.19;

interface IFundingPool {
    /**
     * @notice function allows users to deposit into funding pool
     * @param amount amount to deposit
     * @param transferFee this accounts for any transfer fee token may have (e.g. paxg token)
     */
    function deposit(uint256 amount, uint256 transferFee) external;

    /**
     * @notice function allows users to withdraw from funding pool
     * @param amount amount to withdraw
     */
    function withdraw(uint256 amount) external;

    /**
     * @notice function allows users from funding pool to subscribe as lenders to a proposal
     * @param loanProposal address of the proposal to which user wants to subscribe
     * @param amount amount of subscription
     */
    function subscribe(address loanProposal, uint256 amount) external;

    /**
     * @notice function allows subscribed lenders to unsubscribe from a proposal
     * @dev there is a cooldown period after subscribing to mitigate possible griefing attacks
     * of subscription followed by quick unsubscription
     * @param loanProposal address of the proposal to which user wants to unsubscribe
     * @param amount amount of subscription removed
     */
    function unsubscribe(address loanProposal, uint256 amount) external;

    /**
     * @notice function allows execution of a proposal
     * @param loanProposal address of the proposal executed
     */
    function executeLoanProposal(address loanProposal) external;

    /**
     * @notice function returns factory address for loan proposals
     */
    function loanProposalFactory() external view returns (address);

    /**
     * @notice function returns address of deposit token for pool
     */
    function depositToken() external view returns (address);

    /**
     * @notice function returns balance deposited into pool
     * note: balance is tracked only through using deposit function
     * direct transfers into pool are not credited
     */
    function balanceOf(address) external view returns (uint256);

    /**
     * @notice function tracks total subscription amount for a given proposal address
     */
    function totalSubscribed(address) external view returns (uint256);

    /**
     * @notice function tracks if subscription is deployed for a given proposal address
     */
    function totalSubscribedIsDeployed(address) external view returns (bool);

    /**
     * @notice function tracks subscription amounts for a given proposal address and subsciber address
     */
    function subscribedBalanceOf(
        address,
        address
    ) external view returns (uint256);
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/Constants.sol


pragma solidity 0.8.19;

library Constants {
    uint256 internal constant YEAR_IN_SECONDS = 31_536_000; // 365*24*3600
    uint256 internal constant BASE = 1e18;
    uint256 internal constant MAX_FEE_PER_ANNUM = 5e16; // 5% max in base
    uint256 internal constant MAX_ARRANGER_SPLIT = 5e17; // 50% max in base
    uint256 internal constant MIN_LENDER_UNSUBSCRIBE_GRACE_PERIOD = 1800; // min 30 minutes
    uint256 internal constant MIN_CONVERSION_GRACE_PERIOD = 1800; // min 30 minutes
    uint256 internal constant MIN_REPAYMENT_GRACE_PERIOD = 1800; // min 30 minutes
    uint256 internal constant MIN_TIME_UNTIL_FIRST_DUE_DATE = 1440; // min 1 day
    uint256 internal constant MIN_TIME_BETWEEN_DUE_DATES = 1440; // min 1 day
    uint256 internal constant MIN_WAIT_UNTIL_EARLIEST_UNSUBSCRIBE = 60; // 60 seconds
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/Errors.sol


pragma solidity 0.8.19;

library Errors {
    error AlreadyInitialized();
    error AlreadyRegisteredVault();
    error UnregisteredVault();
    error InvalidDelegatee();
    error InvalidSender();
    error InvalidFee();
    error InsufficientSendAmount();
    error InvalidOraclePair();
    error InvalidOracleAnswer();
    error InvalidOracleDecimals();
    error InvalidOracleVersion();
    error InvalidBTCOracle();
    error InvalidAddress();
    error InvalidArrayLength();
    error InvalidQuote();
    error InvalidOffChainSignature();
    error InvalidOffChainMerkleProof();
    error InvalidCollUnlock();
    error UnknownOnChainQuote();
    error NeitherTokenIsGOHM();
    error NoLpTokens();
    error IncorrectGaugeForLpToken();
    error InvalidGaugeIndex();
    error AlreadyStaked();
    error InvalidWithdrawAmount();
    error InvalidBorrower();
    error OutsideValidRepayWindow();
    error InvalidRepayAmount();
    error UnregisteredGateway();
    error NonWhitelistedOracle();
    error NonWhitelistedCompartment();
    error NonWhitelistedCallback();
    error NonWhitelistedToken();
    error LTVHigherThanMax();
    error InsufficientVaultFunds();
    error NegativeRepaymentAmount();
    error OverflowUint128();
    error InconsistentUnlockTokenAddresses();
    error ExpiresBeforeRepayAllowed();
    error InvalidNewMinNumOfSigners();
    error AlreadySigner();
    error InvalidArrayIndex();
    error InvalidSignerRemoveInfo();
    error InvalidSendAmount();
    error TooSmallLoanAmount();
    error DeadlinePassed();
    error WithdrawEntered();
    error DuplicateAddresses();
    error OnChainQuoteAlreadyAdded();
    error OffChainQuoteHasBeenInvalidated();
    error Uninitialized();
    error EmptyRepaymentSchedule();
    error FirstDueDateTooClose();
    error DueDatesTooClose();
    error UnsubscribeGracePeriodTooShort();
    error UnregisteredLoanProposal();
    error NotInSubscriptionPhase();
    error NotInUnsubscriptionPhase();
    error InsufficientBalance();
    error SubscriptionAmountTooHigh();
    error BeforeEarliestUnsubscribe();
    error TotalSubscribedTooLow();
    error InvalidActionForCurrentStatus();
    error TotalSubscribedNotTargetInRange();
    error InvalidRollBackRequest();
    error UnsubscriptionAmountTooLarge();
    error InvalidNewLoanTerms();
    error OutsideConversionTimeWindow();
    error OutsideRepaymentTimeWindow();
    error NoDefault();
    error LoanIsFullyRepaid();
    error RepaymentIdxTooLarge();
    error AlreadyClaimed();
    error AlreadyConverted();
    error InvalidRepaymentSchedule();
}

// File: v2-4ff4e1ee98278eca953ce6a412c57664937d11c0/contracts/peer-to-pool/LoanProposalImpl.sol


pragma solidity 0.8.19;










contract LoanProposalImpl is Initializable, IEvents, ILoanProposalImpl {
    using SafeERC20 for IERC20Metadata;

    mapping(uint256 => uint256) public totalConvertedSubscriptionsPerIdx; // denominated in loan Token
    mapping(uint256 => uint256) public collTokenConverted;
    DataTypes.DynamicLoanProposalData public dynamicData;
    DataTypes.StaticLoanProposalData public staticData;
    uint256 internal totalSubscriptionsThatClaimedOnDefault;
    mapping(address => mapping(uint256 => bool))
        internal lenderExercisedConversion;
    mapping(address => mapping(uint256 => bool))
        internal lenderClaimedRepayment;
    mapping(address => bool) internal lenderClaimedCollateralOnDefault;
    DataTypes.LoanTerms internal _loanTerms;
    mapping(uint256 => uint256) internal loanTokenRepaid;

    constructor() {
        _disableInitializers();
    }

    function initialize(
        address _arranger,
        address _fundingPool,
        address _collToken,
        uint256 _arrangerFee,
        uint256 _lenderGracePeriod
    ) external initializer {
        if (_fundingPool == address(0) || _collToken == address(0)) {
            revert Errors.InvalidAddress();
        }
        if (_arrangerFee == 0) {
            revert Errors.InvalidFee();
        }
        if (
            _lenderGracePeriod < Constants.MIN_LENDER_UNSUBSCRIBE_GRACE_PERIOD
        ) {
            revert Errors.UnsubscribeGracePeriodTooShort();
        }
        staticData.fundingPool = _fundingPool;
        staticData.collToken = _collToken;
        staticData.arranger = _arranger;
        staticData.lenderGracePeriod = _lenderGracePeriod;
        dynamicData.arrangerFee = _arrangerFee;
    }

    function proposeLoanTerms(
        DataTypes.LoanTerms calldata newLoanTerms
    ) external {
        if (msg.sender != staticData.arranger) {
            revert Errors.InvalidSender();
        }
        DataTypes.LoanStatus status = dynamicData.status;
        if (
            status != DataTypes.LoanStatus.WITHOUT_LOAN_TERMS &&
            status != DataTypes.LoanStatus.IN_NEGOTIATION
        ) {
            revert Errors.InvalidActionForCurrentStatus();
        }
        address fundingPool = staticData.fundingPool;
        repaymentScheduleCheck(newLoanTerms.repaymentSchedule);
        uint256 totalSubscribed = IFundingPool(fundingPool).totalSubscribed(
            address(this)
        );
        (, , uint256 _finalLoanAmount, , ) = getAbsoluteLoanTerms(
            newLoanTerms,
            totalSubscribed,
            IERC20Metadata(IFundingPool(fundingPool).depositToken()).decimals()
        );
        if (_finalLoanAmount > newLoanTerms.maxLoanAmount) {
            revert Errors.InvalidNewLoanTerms();
        }
        _loanTerms = newLoanTerms;
        dynamicData.status = DataTypes.LoanStatus.IN_NEGOTIATION;

     //   emit LoanTermsProposed(newLoanTerms);
    }

    function acceptLoanTerms() external {
        if (msg.sender != _loanTerms.borrower) {
            revert Errors.InvalidSender();
        }
        if (dynamicData.status != DataTypes.LoanStatus.IN_NEGOTIATION) {
            revert Errors.InvalidActionForCurrentStatus();
        }
        address fundingPool = staticData.fundingPool;
        uint256 totalSubscribed = IFundingPool(fundingPool).totalSubscribed(
            address(this)
        );
        // check if enough subscriptions
        // note: no need to check if subscriptions are > maxLoanAmount as
        // this is already done in funding pool
        if (totalSubscribed < _loanTerms.minLoanAmount) {
            revert Errors.TotalSubscribedTooLow();
        }
        dynamicData.loanTermsLockedTime = block.timestamp;
        dynamicData.status = DataTypes.LoanStatus.BORROWER_ACCEPTED;

        emit DebugLoanTermsAccepted(msg.sender, _loanTerms.minLoanAmount, _loanTerms.maxLoanAmount, _loanTerms.collPerLoanToken, _loanTerms.repaymentSchedule.length);
    }

    function finalizeLoanTermsAndTransferColl(
        uint256 expectedTransferFee
    ) external {
        DataTypes.LoanTerms memory _unfinalizedLoanTerms = _loanTerms;
        if (msg.sender != _unfinalizedLoanTerms.borrower) {
            revert Errors.InvalidSender();
        }
        if (
            dynamicData.status != DataTypes.LoanStatus.BORROWER_ACCEPTED ||
            block.timestamp < timeUntilLendersCanUnsubscribe()
        ) {
            revert Errors.InvalidActionForCurrentStatus();
        }
        address fundingPool = staticData.fundingPool;
        uint256 totalSubscribed = IFundingPool(fundingPool).totalSubscribed(
            address(this)
        );
        if (
            totalSubscribed < _unfinalizedLoanTerms.minLoanAmount ||
            totalSubscribed > _unfinalizedLoanTerms.maxLoanAmount
        ) {
            revert Errors.TotalSubscribedNotTargetInRange();
        }
        if (
            _unfinalizedLoanTerms.repaymentSchedule[0].dueTimestamp <=
            block.timestamp + Constants.MIN_TIME_UNTIL_FIRST_DUE_DATE
        ) {
            revert Errors.DueDatesTooClose();
        }
        dynamicData.status = DataTypes.LoanStatus.READY_TO_EXECUTE;
        // note: now that final subscription amounts are known, convert relative values
        // to absolute, i.e.:
        // i) loanTokenDue from relative (e.g., 25% of final loan amount) to absolute (e.g., 25 USDC),
        // ii) collTokenDueIfConverted from relative (e.g., convert every
        // 1 loanToken for 8 collToken) to absolute (e.g., 200 collToken)
        (
            DataTypes.LoanTerms memory _finalizedLoanTerms,
            uint256 _arrangerFee,
            uint256 _finalLoanAmount,
            uint256 _finalCollAmountReservedForDefault,
            uint256 _finalCollAmountReservedForConversions
        ) = getAbsoluteLoanTerms(
                _unfinalizedLoanTerms,
                totalSubscribed,
                IERC20Metadata(IFundingPool(fundingPool).depositToken())
                    .decimals()
            );
        for (uint256 i = 0; i < _loanTerms.repaymentSchedule.length; ) {
            _loanTerms.repaymentSchedule[i].loanTokenDue = _finalizedLoanTerms
                .repaymentSchedule[i]
                .loanTokenDue;
            _loanTerms
                .repaymentSchedule[i]
                .collTokenDueIfConverted = _finalizedLoanTerms
                .repaymentSchedule[i]
                .collTokenDueIfConverted;
            unchecked {
                i++;
            }
        }
        dynamicData.arrangerFee = _arrangerFee;
        dynamicData.finalLoanAmount = _finalLoanAmount;
        dynamicData
            .finalCollAmountReservedForDefault = _finalCollAmountReservedForDefault;
        dynamicData
            .finalCollAmountReservedForConversions = _finalCollAmountReservedForConversions;
        // note: final collToken amount that borrower needs to transfer is sum of:
        // 1) amount reserved for lenders in case of default, and
        // 2) amount reserved for lenders in case all convert
        address collToken = staticData.collToken;
        uint256 preBal = IERC20Metadata(collToken).balanceOf(address(this));
        IERC20Metadata(collToken).safeTransferFrom(
            msg.sender,
            address(this),
            _finalCollAmountReservedForDefault +
                _finalCollAmountReservedForConversions +
                expectedTransferFee
        );
        if (
            IERC20Metadata(collToken).balanceOf(address(this)) - preBal !=
            _finalCollAmountReservedForDefault +
                _finalCollAmountReservedForConversions
        ) {
            revert Errors.InvalidSendAmount();
        }

       // emit LoanTermsAndTransferCollFinalized(
        //    _finalLoanAmount,
       //     _finalCollAmountReservedForDefault,
       //     _finalCollAmountReservedForConversions,
       //     _arrangerFee
       // );
    }

    function rollback() external {
        // cannot be called anymore once lockInFinalAmountsAndProvideCollateral() called
        if (dynamicData.status != DataTypes.LoanStatus.BORROWER_ACCEPTED) {
            revert Errors.InvalidActionForCurrentStatus();
        }
        uint256 totalSubscribed = IFundingPool(staticData.fundingPool)
            .totalSubscribed(address(this));
        uint256 _timeUntilLendersCanUnsubscribe = timeUntilLendersCanUnsubscribe();
        if (
            (msg.sender == _loanTerms.borrower &&
                block.timestamp < _timeUntilLendersCanUnsubscribe) ||
            (block.timestamp >= _timeUntilLendersCanUnsubscribe &&
                totalSubscribed < _loanTerms.minLoanAmount)
        ) {
            dynamicData.status = DataTypes.LoanStatus.ROLLBACK;
            address collToken = staticData.collToken;
            // transfer any previously provided collToken back to borrower
            IERC20Metadata(collToken).safeTransfer(
                msg.sender,
                IERC20Metadata(collToken).balanceOf(address(this))
            );
        } else {
            revert Errors.InvalidRollBackRequest();
        }

     //   emit Rollback();
    }

    function checkAndupdateStatus() external {
        address fundingPool = staticData.fundingPool;
        if (msg.sender != fundingPool) {
            revert Errors.InvalidSender();
        }
        if (dynamicData.status != DataTypes.LoanStatus.READY_TO_EXECUTE) {
            revert Errors.InvalidActionForCurrentStatus();
        }
        dynamicData.status = DataTypes.LoanStatus.LOAN_DEPLOYED;

    //    emit LoanDeployed();
    }

    function exerciseConversion() external {
        address fundingPool = staticData.fundingPool;
        uint256 lenderContribution = IFundingPool(fundingPool)
            .subscribedBalanceOf(address(this), msg.sender);
        if (lenderContribution == 0) {
            revert Errors.InvalidSender();
        }
        if (dynamicData.status != DataTypes.LoanStatus.LOAN_DEPLOYED) {
            revert Errors.InvalidActionForCurrentStatus();
        }
        uint256 repaymentIdx = dynamicData.currentRepaymentIdx;
        checkCurrRepaymentIdx(repaymentIdx);
        if (lenderExercisedConversion[msg.sender][repaymentIdx]) {
            revert Errors.AlreadyConverted();
        }
        // must be after when the period of this loan is due, but before borrower can repay
        if (
            block.timestamp <
            _loanTerms.repaymentSchedule[repaymentIdx].dueTimestamp ||
            block.timestamp >
            _loanTerms.repaymentSchedule[repaymentIdx].dueTimestamp +
                _loanTerms.repaymentSchedule[repaymentIdx].conversionGracePeriod
        ) {
            revert Errors.OutsideConversionTimeWindow();
        }
        uint256 conversionAmount = (_loanTerms
            .repaymentSchedule[repaymentIdx]
            .collTokenDueIfConverted * lenderContribution) /
            IFundingPool(fundingPool).totalSubscribed(address(this));
        collTokenConverted[repaymentIdx] += conversionAmount;
        totalConvertedSubscriptionsPerIdx[repaymentIdx] += lenderContribution;
        lenderExercisedConversion[msg.sender][repaymentIdx] = true;
        IERC20Metadata(staticData.collToken).safeTransfer(
            msg.sender,
            conversionAmount
        );

   //     emit ConversionExercised(msg.sender, repaymentIdx, conversionAmount);
    }

    function repay(uint256 expectedTransferFee) external {
        if (msg.sender != _loanTerms.borrower) {
            revert Errors.InvalidSender();
        }
        if (dynamicData.status != DataTypes.LoanStatus.LOAN_DEPLOYED) {
            revert Errors.InvalidActionForCurrentStatus();
        }
        uint256 repaymentIdx = dynamicData.currentRepaymentIdx++;
        checkCurrRepaymentIdx(repaymentIdx);
        // must be after when the period of this loan when lenders can convert,
        // but before default period for this period
        uint256 currConversionCutoffTime = _loanTerms
            .repaymentSchedule[repaymentIdx]
            .dueTimestamp +
            _loanTerms.repaymentSchedule[repaymentIdx].conversionGracePeriod;
        uint256 currRepaymentCutoffTime = currConversionCutoffTime +
            _loanTerms.repaymentSchedule[repaymentIdx].repaymentGracePeriod;
        if (
            (block.timestamp < currConversionCutoffTime) ||
            (block.timestamp > currRepaymentCutoffTime)
        ) {
            revert Errors.OutsideRepaymentTimeWindow();
        }
        address fundingPool = staticData.fundingPool;
        address loanToken = IFundingPool(fundingPool).depositToken();
        uint256 collTokenDueIfAllConverted = _loanTerms
            .repaymentSchedule[repaymentIdx]
            .collTokenDueIfConverted;
        uint256 collTokenLeftUnconverted = collTokenDueIfAllConverted -
            collTokenConverted[repaymentIdx];
        uint256 remainingLoanTokenDue = (_loanTerms
            .repaymentSchedule[repaymentIdx]
            .loanTokenDue * collTokenLeftUnconverted) /
            collTokenDueIfAllConverted;
        loanTokenRepaid[repaymentIdx] = remainingLoanTokenDue;
        _loanTerms.repaymentSchedule[repaymentIdx].repaid = true;
        uint256 preBal = IERC20Metadata(loanToken).balanceOf(address(this));
        IERC20Metadata(loanToken).safeTransferFrom(
            msg.sender,
            address(this),
            remainingLoanTokenDue + expectedTransferFee
        );
        if (
            IERC20Metadata(loanToken).balanceOf(address(this)) - preBal !=
            remainingLoanTokenDue
        ) {
            revert Errors.InvalidSendAmount();
        }
        // if final repayment, send all remaining coll token back to borrower
        // else send only unconverted coll token back to borrower
        address collToken = staticData.collToken;
        uint256 collSendAmount = _loanTerms.repaymentSchedule.length - 1 ==
            repaymentIdx
            ? IERC20Metadata(collToken).balanceOf(address(this))
            : collTokenLeftUnconverted;
        IERC20Metadata(collToken).safeTransfer(msg.sender, collSendAmount);

     //   emit Repay(remainingLoanTokenDue, collSendAmount);
    }

    function claimRepayment(uint256 repaymentIdx) external {
        address fundingPool = staticData.fundingPool;
        uint256 lenderContribution = IFundingPool(fundingPool)
            .subscribedBalanceOf(address(this), msg.sender);
        if (lenderContribution == 0) {
            revert Errors.InvalidSender();
        }
        // iff there's a repay, currentRepaymentIdx (initially 0) gets incremented;
        // hence any `repaymentIdx` smaller than `currentRepaymentIdx` will always
        // map to a valid repayment claim; no need to check `repaymentSchedule[repaymentIdx].repaid`
        if (repaymentIdx >= dynamicData.currentRepaymentIdx) {
            revert Errors.RepaymentIdxTooLarge();
        }
        // note: users can claim as soon as repaid, no need to check getRepaymentCutoffTime(...)
        if (
            lenderClaimedRepayment[msg.sender][repaymentIdx] ||
            lenderExercisedConversion[msg.sender][repaymentIdx]
        ) {
            revert Errors.AlreadyClaimed();
        }
        // repaid amount for that period split over those who didn't convert in that period
        uint256 subscriptionsEntitledToRepayment = (IFundingPool(fundingPool)
            .totalSubscribed(address(this)) -
            totalConvertedSubscriptionsPerIdx[repaymentIdx]);
        uint256 claimAmount = (loanTokenRepaid[repaymentIdx] *
            lenderContribution) / subscriptionsEntitledToRepayment;
        lenderClaimedRepayment[msg.sender][repaymentIdx] = true;
        IERC20Metadata(IFundingPool(fundingPool).depositToken()).safeTransfer(
            msg.sender,
            claimAmount
        );

     ///   emit ClaimRepayment(msg.sender, claimAmount);
    }

    function markAsDefaulted() external {
        if (dynamicData.status != DataTypes.LoanStatus.LOAN_DEPLOYED) {
            revert Errors.InvalidActionForCurrentStatus();
        }
        uint256 repaymentIdx = dynamicData.currentRepaymentIdx;
        // this will check if loan has been fully repaid yet in this instance
        checkCurrRepaymentIdx(repaymentIdx);
        if (block.timestamp <= getRepaymentCutoffTime(repaymentIdx)) {
            revert Errors.NoDefault();
        }
        dynamicData.status = DataTypes.LoanStatus.DEFAULTED;
      //  emit LoanDefaulted();
    }

    function claimDefaultProceeds() external {
        if (dynamicData.status != DataTypes.LoanStatus.DEFAULTED) {
            revert Errors.InvalidActionForCurrentStatus();
        }
        address fundingPool = staticData.fundingPool;
        uint256 lenderContribution = IFundingPool(fundingPool)
            .subscribedBalanceOf(address(this), msg.sender);
        if (lenderContribution == 0) {
            revert Errors.InvalidSender();
        }
        if (lenderClaimedCollateralOnDefault[msg.sender]) {
            revert Errors.AlreadyClaimed();
        }
        uint256 lastPeriodIdx = dynamicData.currentRepaymentIdx;
        address collToken = staticData.collToken;
        uint256 totalSubscribed = IFundingPool(fundingPool).totalSubscribed(
            address(this)
        );
        uint256 stillToBeConvertedCollTokens = _loanTerms
            .repaymentSchedule[lastPeriodIdx]
            .collTokenDueIfConverted - collTokenConverted[lastPeriodIdx];

        // if only some lenders converted, then split 'stillToBeConvertedCollTokens'
        // fairly among lenders who didn't already convert in default period to not
        // put them at an unfair disadvantage
        uint256 totalUnconvertedSubscriptionsFromLastIdx = totalSubscribed -
            totalConvertedSubscriptionsPerIdx[lastPeriodIdx];
        uint256 totalCollTokenClaim;
        if (!lenderExercisedConversion[msg.sender][lastPeriodIdx]) {
            totalCollTokenClaim =
                (stillToBeConvertedCollTokens * lenderContribution) /
                totalUnconvertedSubscriptionsFromLastIdx;
            collTokenConverted[lastPeriodIdx] += totalCollTokenClaim;
            totalConvertedSubscriptionsPerIdx[
                lastPeriodIdx
            ] += lenderContribution;
        }
        // determine pro-rata share on remaining non-conversion related collToken balance
        totalCollTokenClaim +=
            ((IERC20Metadata(collToken).balanceOf(address(this)) -
                stillToBeConvertedCollTokens) * lenderContribution) /
            (totalSubscribed - totalSubscriptionsThatClaimedOnDefault);
        lenderClaimedCollateralOnDefault[msg.sender] = true;
        totalSubscriptionsThatClaimedOnDefault += lenderContribution;

        IERC20Metadata(collToken).safeTransfer(msg.sender, totalCollTokenClaim);

     //   emit DefaultProceedsClaimed(msg.sender);
    }

    function loanTerms() external view returns (DataTypes.LoanTerms memory) {
        return _loanTerms;
    }

    function canUnsubscribe() external view returns (bool) {
        return
            canSubscribe() ||
            dynamicData.status == DataTypes.LoanStatus.ROLLBACK;
    }

    function canSubscribe() public view returns (bool) {
        return
            (dynamicData.status != DataTypes.LoanStatus.WITHOUT_LOAN_TERMS &&
                dynamicData.loanTermsLockedTime == 0) ||
            block.timestamp < timeUntilLendersCanUnsubscribe();
    }

    function getAbsoluteLoanTerms(
        DataTypes.LoanTerms memory _tmpLoanTerms,
        uint256 totalSubscribed,
        uint256 loanTokenDecimals
    )
        public
        view
        returns (DataTypes.LoanTerms memory, uint256, uint256, uint256, uint256)
    {
        uint256 _arrangerFee = (dynamicData.arrangerFee * totalSubscribed) /
            Constants.BASE;
        uint256 _finalLoanAmount = toUint128(totalSubscribed - _arrangerFee);
        uint256 _finalCollAmountReservedForDefault = (_finalLoanAmount *
            _tmpLoanTerms.collPerLoanToken) / (10 ** loanTokenDecimals);
        // note: convert relative terms into absolute values, i.e.:
        // i) loanTokenDue relative to finalLoanAmount (e.g., 25% of final loan amount),
        // ii) collTokenDueIfConverted relative to loanTokenDue (e.g., convert every
        // 1 loanToken for 8 collToken)
        uint256 _finalCollAmountReservedForConversions;
        for (uint256 i = 0; i < _tmpLoanTerms.repaymentSchedule.length; ) {
            _tmpLoanTerms.repaymentSchedule[i].loanTokenDue = toUint128(
                (_finalLoanAmount *
                    _tmpLoanTerms.repaymentSchedule[i].loanTokenDue) /
                    Constants.BASE
            );
            _tmpLoanTerms
                .repaymentSchedule[i]
                .collTokenDueIfConverted = toUint128(
                (_tmpLoanTerms.repaymentSchedule[i].loanTokenDue *
                    _tmpLoanTerms
                        .repaymentSchedule[i]
                        .collTokenDueIfConverted) / (10 ** loanTokenDecimals)
            );
            _finalCollAmountReservedForConversions += _tmpLoanTerms
                .repaymentSchedule[i]
                .collTokenDueIfConverted;
            unchecked {
                i++;
            }
        }
        return (
            _tmpLoanTerms,
            _arrangerFee,
            _finalLoanAmount,
            _finalCollAmountReservedForDefault,
            _finalCollAmountReservedForConversions
        );
    }

    function checkCurrRepaymentIdx(uint256 repaymentIdx) internal view {
        // currentRepaymentIdx increments on every repay; iff full repay then currentRepaymentIdx == _loanTerms.repaymentSchedule.length
        if (repaymentIdx == _loanTerms.repaymentSchedule.length) {
            revert Errors.LoanIsFullyRepaid();
        }
    }

    function timeUntilLendersCanUnsubscribe() internal view returns (uint256) {
        return dynamicData.loanTermsLockedTime + staticData.lenderGracePeriod;
    }

    function repaymentScheduleCheck(
        DataTypes.Repayment[] calldata repaymentSchedule
    ) internal view {
        if (repaymentSchedule.length == 0) {
            revert Errors.EmptyRepaymentSchedule();
        }
        if (
            repaymentSchedule[0].dueTimestamp <
            block.timestamp + Constants.MIN_TIME_UNTIL_FIRST_DUE_DATE
        ) {
            revert Errors.FirstDueDateTooClose();
        }
        uint256 prevPeriodEnd;
        uint256 currPeriodStart;
        for (uint i = 0; i < repaymentSchedule.length; ) {
            currPeriodStart = repaymentSchedule[i].dueTimestamp;
            if (
                (currPeriodStart <= prevPeriodEnd ||
                    currPeriodStart - prevPeriodEnd <
                    Constants.MIN_TIME_BETWEEN_DUE_DATES) ||
                (repaymentSchedule[i].conversionGracePeriod <
                    Constants.MIN_CONVERSION_GRACE_PERIOD ||
                    repaymentSchedule[i].repaymentGracePeriod <
                    Constants.MIN_REPAYMENT_GRACE_PERIOD) ||
                repaymentSchedule[i].repaid
            ) {
                revert Errors.InvalidRepaymentSchedule();
            }
            prevPeriodEnd =
                currPeriodStart +
                repaymentSchedule[i].conversionGracePeriod +
                repaymentSchedule[i].repaymentGracePeriod;
            unchecked {
                i++;
            }
        }
    }

    function getRepaymentCutoffTime(
        uint256 repaymentIdx
    ) internal view returns (uint256 repaymentCutoffTime) {
        repaymentCutoffTime =
            _loanTerms.repaymentSchedule[repaymentIdx].dueTimestamp +
            _loanTerms.repaymentSchedule[repaymentIdx].conversionGracePeriod +
            _loanTerms.repaymentSchedule[repaymentIdx].repaymentGracePeriod;
    }

    function toUint128(uint256 x) internal pure returns (uint128 y) {
        y = uint128(x);
        if (y != x) {
            revert Errors.OverflowUint128();
        }
    }
}
