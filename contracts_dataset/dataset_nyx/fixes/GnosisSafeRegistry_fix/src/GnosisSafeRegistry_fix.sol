
// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/libraries/token/IERC20.sol

pragma solidity 0.5.10;


contract IERC20 {
    function totalSupply() public view returns (uint256);
    function balanceOf(address owner) public view returns (uint256);
    function transfer(address to, uint256 amount) public returns (bool);
    function transferFrom(address from, address to, uint256 amount) public returns (bool);
    function approve(address spender, uint256 amount) public returns (bool);
    function allowance(address owner, address spender) public view returns (uint256);

    // solhint-disable-next-line no-simple-event-func-name
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/libraries/token/IStandardToken.sol

pragma solidity 0.5.10;


interface IStandardToken {
    function noHooksTransfer(address recipient, uint256 amount) external returns (bool);
}
// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/libraries/ITyped.sol

pragma solidity 0.5.10;


contract ITyped {
    function getTypeName() public view returns (bytes32);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/reporting/IReputationToken.sol

pragma solidity 0.5.10;





contract IReputationToken is IERC20 {
    function migrateOutByPayout(uint256[] memory _payoutNumerators, uint256 _attotokens) public returns (bool);
    function migrateIn(address _reporter, uint256 _attotokens) public returns (bool);
    function trustedReportingParticipantTransfer(address _source, address _destination, uint256 _attotokens) public returns (bool);
    function trustedMarketTransfer(address _source, address _destination, uint256 _attotokens) public returns (bool);
    function trustedUniverseTransfer(address _source, address _destination, uint256 _attotokens) public returns (bool);
    function trustedDisputeWindowTransfer(address _source, address _destination, uint256 _attotokens) public returns (bool);
    function getUniverse() public view returns (IUniverse);
    function getTotalMigrated() public view returns (uint256);
    function getTotalTheoreticalSupply() public view returns (uint256);
    function mintForReportingParticipant(uint256 _amountMigrated) public returns (bool);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/reporting/IV2ReputationToken.sol

pragma solidity 0.5.10;




contract IV2ReputationToken is IReputationToken, IStandardToken {
    function burnForMarket(uint256 _amountToBurn) public returns (bool);
    function mintForWarpSync(uint256 _amountToMint, address _target) public returns (bool);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/libraries/IOwnable.sol

pragma solidity 0.5.10;


contract IOwnable {
    function getOwner() public view returns (address);
    function transferOwnership(address _newOwner) public returns (bool);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/ICash.sol

pragma solidity 0.5.10;



contract ICash is IERC20 {
    function joinMint(address usr, uint wad) public returns (bool);
    function joinBurn(address usr, uint wad) public returns (bool);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/libraries/token/IERC1155.sol

/*

  Copyright 2018 ZeroEx Intl.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

*/

pragma solidity 0.5.10;


/// @title ERC-1155 Multi Token Standard
/// @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1155.md
/// Note: The ERC-165 identifier for this interface is 0xd9b67a26.
interface IERC1155 {

    /// @dev Either TransferSingle or TransferBatch MUST emit when tokens are transferred,
    ///      including zero value transfers as well as minting or burning.
    /// Operator will always be msg.sender.
    /// Either event from address `0x0` signifies a minting operation.
    /// An event to address `0x0` signifies a burning or melting operation.
    /// The total value transferred from address 0x0 minus the total value transferred to 0x0 may
    /// be used by clients and exchanges to be added to the "circulating supply" for a given token ID.
    /// To define a token ID with no initial balance, the contract SHOULD emit the TransferSingle event
    /// from `0x0` to `0x0`, with the token creator as `_operator`.
    event TransferSingle(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256 id,
        uint256 value
    );

    /// @dev Either TransferSingle or TransferBatch MUST emit when tokens are transferred,
    ///      including zero value transfers as well as minting or burning.
    ///Operator will always be msg.sender.
    /// Either event from address `0x0` signifies a minting operation.
    /// An event to address `0x0` signifies a burning or melting operation.
    /// The total value transferred from address 0x0 minus the total value transferred to 0x0 may
    /// be used by clients and exchanges to be added to the "circulating supply" for a given token ID.
    /// To define multiple token IDs with no initial balance, this SHOULD emit the TransferBatch event
    /// from `0x0` to `0x0`, with the token creator as `_operator`.
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    /// @dev MUST emit when an approval is updated.
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    /// @dev MUST emit when the URI is updated for a token ID.
    /// URIs are defined in RFC 3986.
    /// The URI MUST point a JSON file that conforms to the "ERC-1155 Metadata JSON Schema".
    event URI(
        string value,
        uint256 indexed id
    );

    /// @notice Transfers value amount of an _id from the _from address to the _to address specified.
    /// @dev MUST emit TransferSingle event on success.
    /// Caller must be approved to manage the _from account's tokens (see isApprovedForAll).
    /// MUST throw if `_to` is the zero address.
    /// MUST throw if balance of sender for token `_id` is lower than the `_value` sent.
    /// MUST throw on any other error.
    /// When transfer is complete, this function MUST check if `_to` is a smart contract (code size > 0).
    /// If so, it MUST call `onERC1155Received` on `_to` and revert if the return value
    /// is not `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`.
    /// @param from    Source address
    /// @param to      Target address
    /// @param id      ID of the token type
    /// @param value   Transfer amount
    /// @param data    Additional data with no specified format, sent in call to `_to`
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 value,
        bytes calldata data
    )
        external;

    /// @notice Send multiple types of Tokens from a 3rd party in one transfer (with safety call).
    /// @dev MUST emit TransferBatch event on success.
    /// Caller must be approved to manage the _from account's tokens (see isApprovedForAll).
    /// MUST throw if `_to` is the zero address.
    /// MUST throw if length of `_ids` is not the same as length of `_values`.
    ///  MUST throw if any of the balance of sender for token `_ids` is lower than the respective `_values` sent.
    /// MUST throw on any other error.
    /// When transfer is complete, this function MUST check if `_to` is a smart contract (code size > 0).
    /// If so, it MUST call `onERC1155BatchReceived` on `_to` and revert if the return value
    /// is not `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`.
    /// @param from    Source addresses
    /// @param to      Target addresses
    /// @param ids     IDs of each token type
    /// @param values  Transfer amounts per token type
    /// @param data    Additional data with no specified format, sent in call to `_to`
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    )
        external;

    /// @notice Enable or disable approval for a third party ("operator") to manage all of the caller's tokens.
    /// @dev MUST emit the ApprovalForAll event on success.
    /// @param operator  Address to add to the set of authorized operators
    /// @param approved  True if the operator is approved, false to revoke approval
    function setApprovalForAll(address operator, bool approved) external;

    /// @notice Queries the approval status of an operator for a given owner.
    /// @param owner     The owner of the Tokens
    /// @param operator  Address of authorized operator
    /// @return           True if the operator is approved, false if not
    function isApprovedForAll(address owner, address operator) external view returns (bool);

    /// @notice Get the balance of an account's Tokens.
    /// @param owner  The address of the token holder
    /// @param id     ID of the Token
    /// @return        The _owner's balance of the Token type requested
    function balanceOf(address owner, uint256 id) external view returns (uint256);

    /// @notice Get the total supply of a Token.
    /// @param id     ID of the Token
    /// @return        The total supply of the Token type requested
    function totalSupply(uint256 id) external view returns (uint256);

    /// @notice Get the balance of multiple account/token pairs
    /// @param owners The addresses of the token holders
    /// @param ids    ID of the Tokens
    /// @return        The _owner's balance of the Token types requested
    function balanceOfBatch(
        address[] calldata owners,
        uint256[] calldata ids
    )
        external
        view
        returns (uint256[] memory balances_);
}
// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/reporting/IShareToken.sol

pragma solidity 0.5.10;







contract IShareToken is ITyped, IERC1155 {
    function initialize(IAugur _augur) external;
    function initializeMarket(IMarket _market, uint256 _numOutcomes, uint256 _numTicks) public;
    function unsafeTransferFrom(address _from, address _to, uint256 _id, uint256 _value) public;
    function unsafeBatchTransferFrom(address _from, address _to, uint256[] memory _ids, uint256[] memory _values) public;
    function claimTradingProceeds(IMarket _market, address _shareHolder, bytes32 _fingerprint) external returns (uint256[] memory _outcomeFees);
    function getMarket(uint256 _tokenId) external view returns (IMarket);
    function getOutcome(uint256 _tokenId) external view returns (uint256);
    function getTokenId(IMarket _market, uint256 _outcome) public pure returns (uint256 _tokenId);
    function getTokenIds(IMarket _market, uint256[] memory _outcomes) public pure returns (uint256[] memory _tokenIds);
    function buyCompleteSets(IMarket _market, address _account, uint256 _amount) external returns (bool);
    function buyCompleteSetsForTrade(IMarket _market, uint256 _amount, uint256 _longOutcome, address _longRecipient, address _shortRecipient) external returns (bool);
    function sellCompleteSets(IMarket _market, address _holder, address _recipient, uint256 _amount, bytes32 _fingerprint) external returns (uint256 _creatorFee, uint256 _reportingFee);
    function sellCompleteSetsForTrade(IMarket _market, uint256 _outcome, uint256 _amount, address _shortParticipant, address _longParticipant, address _shortRecipient, address _longRecipient, uint256 _price, address _sourceAccount, bytes32 _fingerprint) external returns (uint256 _creatorFee, uint256 _reportingFee);
    function totalSupplyForMarketOutcome(IMarket _market, uint256 _outcome) public view returns (uint256);
    function balanceOfMarketOutcome(IMarket _market, uint256 _outcome, address _account) public view returns (uint256);
    function lowestBalanceOfMarketOutcomes(IMarket _market, uint256[] memory _outcomes, address _account) public view returns (uint256);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/reporting/IReportingParticipant.sol

pragma solidity 0.5.10;




contract IReportingParticipant {
    function getStake() public view returns (uint256);
    function getPayoutDistributionHash() public view returns (bytes32);
    function liquidateLosing() public;
    function redeem(address _redeemer) public returns (bool);
    function isDisavowed() public view returns (bool);
    function getPayoutNumerator(uint256 _outcome) public view returns (uint256);
    function getPayoutNumerators() public view returns (uint256[] memory);
    function getMarket() public view returns (IMarket);
    function getSize() public view returns (uint256);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/reporting/IInitialReporter.sol

pragma solidity 0.5.10;






contract IInitialReporter is IReportingParticipant, IOwnable {
    function initialize(IAugur _augur, IMarket _market, address _designatedReporter) public;
    function report(address _reporter, bytes32 _payoutDistributionHash, uint256[] memory _payoutNumerators, uint256 _initialReportStake) public;
    function designatedReporterShowed() public view returns (bool);
    function designatedReporterWasCorrect() public view returns (bool);
    function getDesignatedReporter() public view returns (address);
    function getReportTimestamp() public view returns (uint256);
    function migrateToNewUniverse(address _designatedReporter) public;
    function returnRepFromDisavow() public;
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/external/IAffiliateValidator.sol

pragma solidity 0.5.10;


contract IAffiliateValidator {
    function validateReference(address _account, address _referrer) external view;
}
// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/reporting/IMarket.sol

pragma solidity 0.5.10;












contract IMarket is IOwnable {
    enum MarketType {
        YES_NO,
        CATEGORICAL,
        SCALAR
    }

    function initialize(IAugur _augur, IUniverse _universe, uint256 _endTime, uint256 _feePerCashInAttoCash, IAffiliateValidator _affiliateValidator, uint256 _affiliateFeeDivisor, address _designatedReporterAddress, address _creator, uint256 _numOutcomes, uint256 _numTicks) public;
    function derivePayoutDistributionHash(uint256[] memory _payoutNumerators) public view returns (bytes32);
    function doInitialReport(uint256[] memory _payoutNumerators, string memory _description, uint256 _additionalStake) public returns (bool);
    function getUniverse() public view returns (IUniverse);
    function getDisputeWindow() public view returns (IDisputeWindow);
    function getNumberOfOutcomes() public view returns (uint256);
    function getNumTicks() public view returns (uint256);
    function getMarketCreatorSettlementFeeDivisor() public view returns (uint256);
    function getForkingMarket() public view returns (IMarket _market);
    function getEndTime() public view returns (uint256);
    function getWinningPayoutDistributionHash() public view returns (bytes32);
    function getWinningPayoutNumerator(uint256 _outcome) public view returns (uint256);
    function getWinningReportingParticipant() public view returns (IReportingParticipant);
    function getReputationToken() public view returns (IV2ReputationToken);
    function getFinalizationTime() public view returns (uint256);
    function getInitialReporter() public view returns (IInitialReporter);
    function getDesignatedReportingEndTime() public view returns (uint256);
    function getValidityBondAttoCash() public view returns (uint256);
    function getAffiliateFeeDivisor() public view returns (uint256);
    function getNumParticipants() public view returns (uint256);
    function getDesignatedReporter() public view returns (address);
    function getDisputePacingOn() public view returns (bool);
    function deriveMarketCreatorFeeAmount(uint256 _amount) public view returns (uint256);
    function recordMarketCreatorFees(uint256 _marketCreatorFees, address _sourceAccount, bytes32 _fingerprint) public returns (bool);
    function isContainerForReportingParticipant(IReportingParticipant _reportingParticipant) public view returns (bool);
    function isInvalid() public view returns (bool);
    function finalize() public returns (bool);
    function designatedReporterWasCorrect() public view returns (bool);
    function designatedReporterShowed() public view returns (bool);
    function isFinalized() public view returns (bool);
    function assertBalances() public view returns (bool);
    function getOpenInterest() public view returns (uint256);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/reporting/IDisputeWindow.sol

pragma solidity 0.5.10;









contract IDisputeWindow is ITyped, IERC20 {
    uint256 public invalidMarketsTotal;
    uint256 public validityBondTotal;

    uint256 public incorrectDesignatedReportTotal;
    uint256 public initialReportBondTotal;

    uint256 public designatedReportNoShowsTotal;
    uint256 public designatedReporterNoShowBondTotal;

    function initialize(IAugur _augur, IUniverse _universe, uint256 _disputeWindowId, bool _participationTokensEnabled, uint256 _duration, uint256 _startTime, address _erc1820RegistryAddress) public;
    function trustedBuy(address _buyer, uint256 _attotokens) public returns (bool);
    function getUniverse() public view returns (IUniverse);
    function getReputationToken() public view returns (IReputationToken);
    function getStartTime() public view returns (uint256);
    function getEndTime() public view returns (uint256);
    function getWindowId() public view returns (uint256);
    function isActive() public view returns (bool);
    function isOver() public view returns (bool);
    function onMarketFinalized() public;
    function redeem(address _account) public returns (bool);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/reporting/IUniverse.sol

pragma solidity 0.5.10;








contract IUniverse {
    uint256 public creationTime;
    mapping(address => uint256) public marketBalance;

    function fork() public returns (bool);
    function updateForkValues() public returns (bool);
    function getParentUniverse() public view returns (IUniverse);
    function createChildUniverse(uint256[] memory _parentPayoutNumerators) public returns (IUniverse);
    function getChildUniverse(bytes32 _parentPayoutDistributionHash) public view returns (IUniverse);
    function getReputationToken() public view returns (IV2ReputationToken);
    function getForkingMarket() public view returns (IMarket);
    function getForkEndTime() public view returns (uint256);
    function getForkReputationGoal() public view returns (uint256);
    function getParentPayoutDistributionHash() public view returns (bytes32);
    function getDisputeRoundDurationInSeconds(bool _initial) public view returns (uint256);
    function getOrCreateDisputeWindowByTimestamp(uint256 _timestamp, bool _initial) public returns (IDisputeWindow);
    function getOrCreateCurrentDisputeWindow(bool _initial) public returns (IDisputeWindow);
    function getOrCreateNextDisputeWindow(bool _initial) public returns (IDisputeWindow);
    function getOrCreatePreviousDisputeWindow(bool _initial) public returns (IDisputeWindow);
    function getOpenInterestInAttoCash() public view returns (uint256);
    function getRepMarketCapInAttoCash() public view returns (uint256);
    function getTargetRepMarketCapInAttoCash() public view returns (uint256);
    function getOrCacheValidityBond() public returns (uint256);
    function getOrCacheDesignatedReportStake() public returns (uint256);
    function getOrCacheDesignatedReportNoShowBond() public returns (uint256);
    function getOrCacheMarketRepBond() public returns (uint256);
    function getOrCacheReportingFeeDivisor() public returns (uint256);
    function getDisputeThresholdForFork() public view returns (uint256);
    function getDisputeThresholdForDisputePacing() public view returns (uint256);
    function getInitialReportMinValue() public view returns (uint256);
    function getPayoutNumerators() public view returns (uint256[] memory);
    function getReportingFeeDivisor() public view returns (uint256);
    function getPayoutNumerator(uint256 _outcome) public view returns (uint256);
    function getWinningChildPayoutNumerator(uint256 _outcome) public view returns (uint256);
    function isOpenInterestCash(address) public view returns (bool);
    function isForkingMarket() public view returns (bool);
    function getCurrentDisputeWindow(bool _initial) public view returns (IDisputeWindow);
    function getDisputeWindowStartTimeAndDuration(uint256 _timestamp, bool _initial) public view returns (uint256, uint256);
    function isParentOf(IUniverse _shadyChild) public view returns (bool);
    function updateTentativeWinningChildUniverse(bytes32 _parentPayoutDistributionHash) public returns (bool);
    function isContainerForDisputeWindow(IDisputeWindow _shadyTarget) public view returns (bool);
    function isContainerForMarket(IMarket _shadyTarget) public view returns (bool);
    function isContainerForReportingParticipant(IReportingParticipant _reportingParticipant) public view returns (bool);
    function migrateMarketOut(IUniverse _destinationUniverse) public returns (bool);
    function migrateMarketIn(IMarket _market, uint256 _cashBalance, uint256 _marketOI) public returns (bool);
    function decrementOpenInterest(uint256 _amount) public returns (bool);
    function decrementOpenInterestFromMarket(IMarket _market) public returns (bool);
    function incrementOpenInterest(uint256 _amount) public returns (bool);
    function getWinningChildUniverse() public view returns (IUniverse);
    function isForking() public view returns (bool);
    function deposit(address _sender, uint256 _amount, address _market) public returns (bool);
    function withdraw(address _recipient, uint256 _amount, address _market) public returns (bool);
    function createScalarMarket(uint256 _endTime, uint256 _feePerCashInAttoCash, IAffiliateValidator _affiliateValidator, uint256 _affiliateFeeDivisor, address _designatedReporterAddress, int256[] memory _prices, uint256 _numTicks, string memory _extraInfo) public returns (IMarket _newMarket);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/libraries/math/SafeMathUint256.sol

pragma solidity 0.5.10;


/**
 * @title SafeMathUint256
 * @dev Uint256 math operations with safety checks that throw on error
 */
library SafeMathUint256 {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }

    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a <= b) {
            return a;
        } else {
            return b;
        }
    }

    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a >= b) {
            return a;
        } else {
            return b;
        }
    }

    function getUint256Min() internal pure returns (uint256) {
        return 0;
    }

    function getUint256Max() internal pure returns (uint256) {
        // 2 ** 256 - 1
        return 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    }

    function isMultipleOf(uint256 a, uint256 b) internal pure returns (bool) {
        return a % b == 0;
    }

    // Float [fixed point] Operations
    function fxpMul(uint256 a, uint256 b, uint256 base) internal pure returns (uint256) {
        return div(mul(a, b), base);
    }

    function fxpDiv(uint256 a, uint256 b, uint256 base) internal pure returns (uint256) {
        return div(mul(a, base), b);
    }
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/trading/IAugurTrading.sol

pragma solidity 0.5.10;




contract IAugurTrading {
    function lookup(bytes32 _key) public view returns (address);
    function logProfitLossChanged(IMarket _market, address _account, uint256 _outcome, int256 _netPosition, uint256 _avgPrice, int256 _realizedProfit, int256 _frozenFunds, int256 _realizedCost) public returns (bool);
    function logOrderCreated(IUniverse _universe, bytes32 _orderId, bytes32 _tradeGroupId) public returns (bool);
    function logOrderCanceled(IUniverse _universe, IMarket _market, address _creator, uint256 _tokenRefund, uint256 _sharesRefund, bytes32 _orderId) public returns (bool);
    function logOrderFilled(IUniverse _universe, address _creator, address _filler, uint256 _price, uint256 _fees, uint256 _amountFilled, bytes32 _orderId, bytes32 _tradeGroupId) public returns (bool);
    function logMarketVolumeChanged(IUniverse _universe, address _market, uint256 _volume, uint256[] memory _outcomeVolumes) public returns (bool);
    function logZeroXOrderFilled(IUniverse _universe, IMarket _market, bytes32 _tradeGroupId, uint8 _orderType, address[] memory _addressData, uint256[] memory _uint256Data) public returns (bool);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/trading/IOrders.sol

pragma solidity 0.5.10;





contract IOrders {
    function saveOrder(uint256[] calldata _uints, bytes32[] calldata _bytes32s, Order.Types _type, IMarket _market, address _sender, IERC20 _kycToken) external returns (bytes32 _orderId);
    function removeOrder(bytes32 _orderId) external returns (bool);
    function getMarket(bytes32 _orderId) public view returns (IMarket);
    function getOrderType(bytes32 _orderId) public view returns (Order.Types);
    function getOutcome(bytes32 _orderId) public view returns (uint256);
    function getAmount(bytes32 _orderId) public view returns (uint256);
    function getPrice(bytes32 _orderId) public view returns (uint256);
    function getOrderCreator(bytes32 _orderId) public view returns (address);
    function getOrderSharesEscrowed(bytes32 _orderId) public view returns (uint256);
    function getOrderMoneyEscrowed(bytes32 _orderId) public view returns (uint256);
    function getOrderDataForCancel(bytes32 _orderId) public view returns (uint256, uint256, Order.Types, IMarket, uint256, address);
    function getOrderDataForLogs(bytes32 _orderId) public view returns (Order.Types, address[] memory _addressData, uint256[] memory _uint256Data);
    function getBetterOrderId(bytes32 _orderId) public view returns (bytes32);
    function getWorseOrderId(bytes32 _orderId) public view returns (bytes32);
    function getKYCToken(bytes32 _orderId) public view returns (IERC20);
    function getBestOrderId(Order.Types _type, IMarket _market, uint256 _outcome, IERC20 _kycToken) public view returns (bytes32);
    function getWorstOrderId(Order.Types _type, IMarket _market, uint256 _outcome, IERC20 _kycToken) public view returns (bytes32);
    function getLastOutcomePrice(IMarket _market, uint256 _outcome) public view returns (uint256);
    function getOrderId(Order.Types _type, IMarket _market, uint256 _amount, uint256 _price, address _sender, uint256 _blockNumber, uint256 _outcome, uint256 _moneyEscrowed, uint256 _sharesEscrowed, IERC20 _kycToken) public pure returns (bytes32);
    function getTotalEscrowed(IMarket _market) public view returns (uint256);
    function isBetterPrice(Order.Types _type, uint256 _price, bytes32 _orderId) public view returns (bool);
    function isWorsePrice(Order.Types _type, uint256 _price, bytes32 _orderId) public view returns (bool);
    function assertIsNotBetterPrice(Order.Types _type, uint256 _price, bytes32 _betterOrderId) public view returns (bool);
    function assertIsNotWorsePrice(Order.Types _type, uint256 _price, bytes32 _worseOrderId) public returns (bool);
    function recordFillOrder(bytes32 _orderId, uint256 _sharesFilled, uint256 _tokensFilled, uint256 _fill) external returns (bool);
    function setPrice(IMarket _market, uint256 _outcome, uint256 _price) external returns (bool);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/trading/Order.sol

// Copyright (C) 2015 Forecast Foundation OU, full GPL notice in LICENSE

// Bid / Ask actions: puts orders on the book
// price is denominated by the specific market's numTicks
// amount is the number of attoshares the order is for (either to buy or to sell).
// price is the exact price you want to buy/sell at [which may not be the cost, for example to short a yesNo market it'll cost numTicks-price, to go long it'll cost price]

pragma solidity 0.5.10;









// CONSIDER: Is `price` the most appropriate name for the value being used? It does correspond 1:1 with the attoCASH per share, but the range might be considered unusual?
library Order {
    using SafeMathUint256 for uint256;

    enum Types {
        Bid, Ask
    }

    enum TradeDirections {
        Long, Short
    }

    struct Data {
        // Contracts
        IMarket market;
        IAugur augur;
        IAugurTrading augurTrading;
        IERC20 kycToken;
        IShareToken shareToken;
        ICash cash;

        // Order
        bytes32 id;
        address creator;
        uint256 outcome;
        Order.Types orderType;
        uint256 amount;
        uint256 price;
        uint256 sharesEscrowed;
        uint256 moneyEscrowed;
        bytes32 betterOrderId;
        bytes32 worseOrderId;
    }

    // No validation is needed here as it is simply a library function for organizing data
    function create(IAugur _augur, IAugurTrading _augurTrading, address _creator, uint256 _outcome, Order.Types _type, uint256 _attoshares, uint256 _price, IMarket _market, bytes32 _betterOrderId, bytes32 _worseOrderId, IERC20 _kycToken) internal view returns (Data memory) {
        require(_outcome < _market.getNumberOfOutcomes(), "Order.create: Outcome is not within market range");
        require(_price != 0, "Order.create: Price may not be 0");
        require(_price < _market.getNumTicks(), "Order.create: Price is outside of market range");
        require(_attoshares > 0, "Order.create: Cannot use amount of 0");
        require(_creator != address(0), "Order.create: Creator is 0x0");

        IShareToken _shareToken = IShareToken(_augur.lookup("ShareToken"));

        return Data({
            market: _market,
            augur: _augur,
            augurTrading: _augurTrading,
            kycToken: _kycToken,
            shareToken: _shareToken,
            cash: ICash(_augur.lookup("Cash")),
            id: 0,
            creator: _creator,
            outcome: _outcome,
            orderType: _type,
            amount: _attoshares,
            price: _price,
            sharesEscrowed: 0,
            moneyEscrowed: 0,
            betterOrderId: _betterOrderId,
            worseOrderId: _worseOrderId
        });
    }

    //
    // "public" functions
    //

    function getOrderId(Order.Data memory _orderData, IOrders _orders) internal view returns (bytes32) {
        if (_orderData.id == bytes32(0)) {
            bytes32 _orderId = calculateOrderId(_orderData.orderType, _orderData.market, _orderData.amount, _orderData.price, _orderData.creator, block.number, _orderData.outcome, _orderData.moneyEscrowed, _orderData.sharesEscrowed, _orderData.kycToken);
            require(_orders.getAmount(_orderId) == 0, "Order.getOrderId: New order had amount. This should not be possible");
            _orderData.id = _orderId;
        }
        return _orderData.id;
    }

    function calculateOrderId(Order.Types _type, IMarket _market, uint256 _amount, uint256 _price, address _sender, uint256 _blockNumber, uint256 _outcome, uint256 _moneyEscrowed, uint256 _sharesEscrowed, IERC20 _kycToken) internal pure returns (bytes32) {
        return sha256(abi.encodePacked(_type, _market, _amount, _price, _sender, _blockNumber, _outcome, _moneyEscrowed, _sharesEscrowed, _kycToken));
    }

    function getOrderTradingTypeFromMakerDirection(Order.TradeDirections _creatorDirection) internal pure returns (Order.Types) {
        return (_creatorDirection == Order.TradeDirections.Long) ? Order.Types.Bid : Order.Types.Ask;
    }

    function getOrderTradingTypeFromFillerDirection(Order.TradeDirections _fillerDirection) internal pure returns (Order.Types) {
        return (_fillerDirection == Order.TradeDirections.Long) ? Order.Types.Ask : Order.Types.Bid;
    }

    function escrowFunds(Order.Data memory _orderData) internal returns (bool) {
        if (_orderData.orderType == Order.Types.Ask) {
            return escrowFundsForAsk(_orderData);
        } else if (_orderData.orderType == Order.Types.Bid) {
            return escrowFundsForBid(_orderData);
        }
    }

    function saveOrder(Order.Data memory _orderData, bytes32 _tradeGroupId, IOrders _orders) internal returns (bytes32) {
        getOrderId(_orderData, _orders);
        uint256[] memory _uints = new uint256[](5);
        _uints[0] = _orderData.amount;
        _uints[1] = _orderData.price;
        _uints[2] = _orderData.outcome;
        _uints[3] = _orderData.moneyEscrowed;
        _uints[4] = _orderData.sharesEscrowed;
        bytes32[] memory _bytes32s = new bytes32[](4);
        _bytes32s[0] = _orderData.betterOrderId;
        _bytes32s[1] = _orderData.worseOrderId;
        _bytes32s[2] = _tradeGroupId;
        _bytes32s[3] = _orderData.id;
        return _orders.saveOrder(_uints, _bytes32s, _orderData.orderType, _orderData.market, _orderData.creator, _orderData.kycToken);
    }

    //
    // Private functions
    //

    function escrowFundsForBid(Order.Data memory _orderData) private returns (bool) {
        require(_orderData.moneyEscrowed == 0, "Order.escrowFundsForBid: New order had money escrowed. This should not be possible");
        require(_orderData.sharesEscrowed == 0, "Order.escrowFundsForBid: New order had shares escrowed. This should not be possible");
        uint256 _attosharesToCover = _orderData.amount;
        uint256 _numberOfShortOutcomes = _orderData.market.getNumberOfOutcomes() - 1;

        uint256[] memory _shortOutcomes = new uint256[](_numberOfShortOutcomes);
        uint256 _indexOutcome = 0;
        for (uint256 _i = 0; _i < _numberOfShortOutcomes; _i++) {
            if (_i == _orderData.outcome) {
                _indexOutcome++;
            }
            _shortOutcomes[_i] = _indexOutcome;
            _indexOutcome++;
        }

        // Figure out how many almost-complete-sets (just missing `outcome` share) the creator has
        uint256 _attosharesHeld = _orderData.shareToken.lowestBalanceOfMarketOutcomes(_orderData.market, _shortOutcomes, _orderData.creator);

        // Take shares into escrow if they have any almost-complete-sets
        if (_attosharesHeld > 0) {
            _orderData.sharesEscrowed = SafeMathUint256.min(_attosharesHeld, _attosharesToCover);
            _attosharesToCover -= _orderData.sharesEscrowed;
            uint256[] memory _values = new uint256[](_numberOfShortOutcomes);
            for (uint256 _i = 0; _i < _numberOfShortOutcomes; _i++) {
                _values[_i] = _orderData.sharesEscrowed;
            }
            _orderData.shareToken.unsafeBatchTransferFrom(_orderData.creator, address(_orderData.augurTrading), _orderData.shareToken.getTokenIds(_orderData.market, _shortOutcomes), _values);
        }

        // If not able to cover entire order with shares alone, then cover remaining with tokens
        if (_attosharesToCover > 0) {
            _orderData.moneyEscrowed = _attosharesToCover.mul(_orderData.price);
            _orderData.cash.transferFrom(_orderData.creator, address(_orderData.augurTrading), _orderData.moneyEscrowed);
        }

        return true;
    }

    function escrowFundsForAsk(Order.Data memory _orderData) private returns (bool) {
        require(_orderData.moneyEscrowed == 0, "Order.escrowFundsForAsk: New order had money escrowed. This should not be possible");
        require(_orderData.sharesEscrowed == 0, "Order.escrowFundsForAsk: New order had shares escrowed. This should not be possible");
        uint256 _attosharesToCover = _orderData.amount;

        // Figure out how many shares of the outcome the creator has
        uint256 _attosharesHeld = _orderData.shareToken.balanceOfMarketOutcome(_orderData.market, _orderData.outcome, _orderData.creator);

        // Take shares in escrow if user has shares
        if (_attosharesHeld > 0) {
            _orderData.sharesEscrowed = SafeMathUint256.min(_attosharesHeld, _attosharesToCover);
            _attosharesToCover -= _orderData.sharesEscrowed;
            _orderData.shareToken.unsafeTransferFrom(_orderData.creator, address(_orderData.augurTrading), _orderData.shareToken.getTokenId(_orderData.market, _orderData.outcome), _orderData.sharesEscrowed);
        }

        // If not able to cover entire order with shares alone, then cover remaining with tokens
        if (_attosharesToCover > 0) {
            _orderData.moneyEscrowed = _orderData.market.getNumTicks().sub(_orderData.price).mul(_attosharesToCover);
            _orderData.cash.transferFrom(_orderData.creator, address(_orderData.augurTrading), _orderData.moneyEscrowed);
        }

        return true;
    }
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/IAugur.sol

pragma solidity 0.5.10;







contract IAugur {
    function createChildUniverse(bytes32 _parentPayoutDistributionHash, uint256[] memory _parentPayoutNumerators) public returns (IUniverse);
    function isKnownUniverse(IUniverse _universe) public view returns (bool);
    function trustedTransfer(IERC20 _token, address _from, address _to, uint256 _amount) public returns (bool);
    function isTrustedSender(address _address) public returns (bool);
    function logCategoricalMarketCreated(uint256 _endTime, string memory _extraInfo, IMarket _market, address _marketCreator, address _designatedReporter, uint256 _feePerCashInAttoCash, bytes32[] memory _outcomes) public returns (bool);
    function logYesNoMarketCreated(uint256 _endTime, string memory _extraInfo, IMarket _market, address _marketCreator, address _designatedReporter, uint256 _feePerCashInAttoCash) public returns (bool);
    function logScalarMarketCreated(uint256 _endTime, string memory _extraInfo, IMarket _market, address _marketCreator, address _designatedReporter, uint256 _feePerCashInAttoCash, int256[] memory _prices, uint256 _numTicks)  public returns (bool);
    function logInitialReportSubmitted(IUniverse _universe, address _reporter, address _market, address _initialReporter, uint256 _amountStaked, bool _isDesignatedReporter, uint256[] memory _payoutNumerators, string memory _description, uint256 _nextWindowStartTime, uint256 _nextWindowEndTime) public returns (bool);
    function disputeCrowdsourcerCreated(IUniverse _universe, address _market, address _disputeCrowdsourcer, uint256[] memory _payoutNumerators, uint256 _size, uint256 _disputeRound) public returns (bool);
    function logDisputeCrowdsourcerContribution(IUniverse _universe, address _reporter, address _market, address _disputeCrowdsourcer, uint256 _amountStaked, string memory description, uint256[] memory _payoutNumerators, uint256 _currentStake, uint256 _stakeRemaining, uint256 _disputeRound) public returns (bool);
    function logDisputeCrowdsourcerCompleted(IUniverse _universe, address _market, address _disputeCrowdsourcer, uint256[] memory _payoutNumerators, uint256 _nextWindowStartTime, uint256 _nextWindowEndTime, bool _pacingOn, uint256 _totalRepStakedInPayout, uint256 _totalRepStakedInMarket, uint256 _disputeRound) public returns (bool);
    function logInitialReporterRedeemed(IUniverse _universe, address _reporter, address _market, uint256 _amountRedeemed, uint256 _repReceived, uint256[] memory _payoutNumerators) public returns (bool);
    function logDisputeCrowdsourcerRedeemed(IUniverse _universe, address _reporter, address _market, uint256 _amountRedeemed, uint256 _repReceived, uint256[] memory _payoutNumerators) public returns (bool);
    function logMarketFinalized(IUniverse _universe, uint256[] memory _winningPayoutNumerators) public returns (bool);
    function logMarketMigrated(IMarket _market, IUniverse _originalUniverse) public returns (bool);
    function logReportingParticipantDisavowed(IUniverse _universe, IMarket _market) public returns (bool);
    function logMarketParticipantsDisavowed(IUniverse _universe) public returns (bool);
    function logCompleteSetsPurchased(IUniverse _universe, IMarket _market, address _account, uint256 _numCompleteSets) public returns (bool);
    function logCompleteSetsSold(IUniverse _universe, IMarket _market, address _account, uint256 _numCompleteSets, uint256 _fees) public returns (bool);
    function logMarketOIChanged(IUniverse _universe, IMarket _market) public returns (bool);
    function logTradingProceedsClaimed(IUniverse _universe, address _sender, address _market, uint256 _outcome, uint256 _numShares, uint256 _numPayoutTokens, uint256 _fees) public returns (bool);
    function logUniverseForked(IMarket _forkingMarket) public returns (bool);
    function logReputationTokensTransferred(IUniverse _universe, address _from, address _to, uint256 _value, uint256 _fromBalance, uint256 _toBalance) public returns (bool);
    function logReputationTokensBurned(IUniverse _universe, address _target, uint256 _amount, uint256 _totalSupply, uint256 _balance) public returns (bool);
    function logReputationTokensMinted(IUniverse _universe, address _target, uint256 _amount, uint256 _totalSupply, uint256 _balance) public returns (bool);
    function logShareTokensBalanceChanged(address _account, IMarket _market, uint256 _outcome, uint256 _balance) public returns (bool);
    function logDisputeCrowdsourcerTokensTransferred(IUniverse _universe, address _from, address _to, uint256 _value, uint256 _fromBalance, uint256 _toBalance) public returns (bool);
    function logDisputeCrowdsourcerTokensBurned(IUniverse _universe, address _target, uint256 _amount, uint256 _totalSupply, uint256 _balance) public returns (bool);
    function logDisputeCrowdsourcerTokensMinted(IUniverse _universe, address _target, uint256 _amount, uint256 _totalSupply, uint256 _balance) public returns (bool);
    function logDisputeWindowCreated(IDisputeWindow _disputeWindow, uint256 _id, bool _initial) public returns (bool);
    function logParticipationTokensRedeemed(IUniverse universe, address _sender, uint256 _attoParticipationTokens, uint256 _feePayoutShare) public returns (bool);
    function logTimestampSet(uint256 _newTimestamp) public returns (bool);
    function logInitialReporterTransferred(IUniverse _universe, IMarket _market, address _from, address _to) public returns (bool);
    function logMarketTransferred(IUniverse _universe, address _from, address _to) public returns (bool);
    function logParticipationTokensTransferred(IUniverse _universe, address _from, address _to, uint256 _value, uint256 _fromBalance, uint256 _toBalance) public returns (bool);
    function logParticipationTokensBurned(IUniverse _universe, address _target, uint256 _amount, uint256 _totalSupply, uint256 _balance) public returns (bool);
    function logParticipationTokensMinted(IUniverse _universe, address _target, uint256 _amount, uint256 _totalSupply, uint256 _balance) public returns (bool);
    function isKnownFeeSender(address _feeSender) public view returns (bool);
    function lookup(bytes32 _key) public view returns (address);
    function getTimestamp() public view returns (uint256);
    function getMaximumMarketEndDate() public returns (uint256);
    function isKnownMarket(IMarket _market) public view returns (bool);
    function derivePayoutDistributionHash(uint256[] memory _payoutNumerators, uint256 _numTicks, uint256 numOutcomes) public view returns (bytes32);
    function logValidityBondChanged(uint256 _validityBond) public returns (bool);
    function logDesignatedReportStakeChanged(uint256 _designatedReportStake) public returns (bool);
    function logNoShowBondChanged(uint256 _noShowBond) public returns (bool);
    function logReportingFeeChanged(uint256 _reportingFee) public returns (bool);
    function getUniverseForkIndex(IUniverse _universe) public view returns (uint256);
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/external/IGnosisSafe.sol

pragma solidity 0.5.10;


contract IGnosisSafe {
    address public masterCopy;
    function getThreshold() public view returns (uint256);
    function getOwners() public view returns (address[] memory);
}
// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/external/IProxyFactory.sol

pragma solidity 0.5.10;

contract IProxyFactory {
    function proxyRuntimeCode() public pure returns (bytes memory);
    function proxyCreationCode() public pure returns (bytes memory);
}
// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/libraries/Initializable.sol

pragma solidity 0.5.10;


contract Initializable {
    bool private initialized = false;

    modifier beforeInitialized {
        require(!initialized);
        _;
    }

    function endInitialization() internal beforeInitialized {
        initialized = true;
    }

    function getInitialized() public view returns (bool) {
        return initialized;
    }
}

// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/external/IProxy.sol

pragma solidity 0.5.10;

/// @title IProxy - Helper interface to access masterCopy of the Proxy on-chain
/// @author Richard Meissner - <richard@gnosis.io>
interface IProxy {
    function masterCopy() external view returns (address);
}
// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/reporting/IAffiliates.sol

pragma solidity 0.5.10;



contract IAffiliates {
    function setFingerprint(bytes32 _fingerprint) external;
    function setReferrer(address _referrer) external;
    function getAccountFingerprint(address _account) external returns (bytes32);
    function getReferrer(address _account) external returns (address);
    function getAndValidateReferrer(address _account, IAffiliateValidator affiliateValidator) external returns (address);
}
// File: augur-67c0fec95e65fca8d27751f28a6c06e5247978c6/packages/augur-core/source/contracts/GnosisSafeRegistry.sol

pragma solidity 0.5.10;











contract GnosisSafeRegistry is Initializable {
    // mapping of user to created safes. The first safe wins but we store additional safes in case a user somehow makes multiple. The current safe may be de-registered by itself and the current safe will simply become the next one in line
    mapping (address => IGnosisSafe[]) public accountSafes;
    mapping (address => uint256) public accountSafeIndexes;

    IAugur public augur;
    bytes32 public proxyCodeHash;
    bytes32 public deploymentData;
    address public gnosisSafeMasterCopy;
    IProxyFactory public proxyFactory;

    address public cash;
    address public affiliates;
    address public shareToken;
    address public createOrder;
    address public fillOrder;

    uint256 private constant MAX_APPROVAL_AMOUNT = 2 ** 256 - 1;

    function initialize(IAugur _augur, IAugurTrading _augurTrading) public beforeInitialized returns (bool) {
        endInitialization();
        augur = _augur;
        gnosisSafeMasterCopy = _augur.lookup("GnosisSafe");
        require(gnosisSafeMasterCopy != address(0));
        proxyFactory = IProxyFactory(_augur.lookup("ProxyFactory"));
        proxyCodeHash = keccak256(proxyFactory.proxyRuntimeCode());
        deploymentData = keccak256(abi.encodePacked(proxyFactory.proxyCreationCode(), uint256(gnosisSafeMasterCopy)));
        cash = _augur.lookup("Cash");
        affiliates = augur.lookup("Affiliates");
        shareToken = augur.lookup("ShareToken");

        createOrder = _augurTrading.lookup("CreateOrder");
        fillOrder = _augurTrading.lookup("FillOrder");
        return true;
    }

    // The misdirection here is because this is called through a delegatecall execution initially. We just direct that into making an actual call to the register method
    function setupForAugur(address _augur, address _createOrder, address _fillOrder, IERC20 _cash, IERC1155 _shareToken, IAffiliates _affiliates, bytes32 _fingerprint, address _referralAddress) public {
        _cash.approve(_augur, MAX_APPROVAL_AMOUNT);

        _cash.approve(_createOrder, MAX_APPROVAL_AMOUNT);
        _shareToken.setApprovalForAll(_createOrder, true);

        _cash.approve(_fillOrder, MAX_APPROVAL_AMOUNT);
        _shareToken.setApprovalForAll(_fillOrder, true);

        _affiliates.setFingerprint(_fingerprint);

        if (_referralAddress != address(0)) {
            _affiliates.setReferrer(_referralAddress);
        }
    }

    event DebugRegister(IGnosisSafe);

    function proxyCreated(address _proxy, address _mastercopy, bytes calldata _initializer, uint256 _saltNonce) external {
        require(msg.sender == address(proxyFactory));
        IGnosisSafe _safe = IGnosisSafe(_proxy);
        bytes32 _codeHash;
        assembly {
            _codeHash := extcodehash(_safe)
        }
        require(_codeHash == proxyCodeHash, "Safe instance does not match expected code hash of the Proxy contract");
        require(_mastercopy == gnosisSafeMasterCopy, "Proxy master contract is not the Gnosis Safe");
        require(_safe.getThreshold() == 1, "Safe may only have a threshold of 1");
        address[] memory _owners = _safe.getOwners();
        require(_owners.length == 1, "Safe may only have 1 user");

        validateSafeCreation(_owners, _proxy, _mastercopy, _initializer, _saltNonce);

        address _owner = _owners[0];
        accountSafes[_owner].push(_safe);

        emit DebugRegister(accountSafes[_owner][0]);

    }

    function validateSafeCreation(address[] memory _owners, address _proxy, address _mastercopy, bytes memory _initializer, uint256 _saltNonce) internal {
        IAffiliates _affilifates = IAffiliates(affiliates);
        bytes32 _fingerprint = _affilifates.getAccountFingerprint(_proxy);
        address _referralAddress = _affilifates.getReferrer(_proxy);
        bytes memory _expectedSetupForAugurData = abi.encodeWithSelector(this.setupForAugur.selector,
            address(augur),
            createOrder,
            fillOrder,
            cash,
            shareToken,
            affiliates,
            _fingerprint,
            _referralAddress
        );
        address _to;
        bytes memory _data;
        assembly {
            // Skip selector and length:
            let _initializerData := add(_initializer, 36)
            // Load the to and data params
            _to := mload(add(_initializerData, 64))
            _data := add(_initializerData, mload(add(_initializerData, 96)))
        }
        require(_to == address(this));
        // Requires the expected and actual data arguments are equal
        require(_data.length == _expectedSetupForAugurData.length && keccak256(_data) == keccak256(_expectedSetupForAugurData));
        // Now validate the address of the safe is what should have been produced via create2
        uint256 _saltNonceWithCallback = uint256(keccak256(abi.encodePacked(_saltNonce, address(this))));
        bytes32 _salt = keccak256(abi.encodePacked(keccak256(_initializer), _saltNonceWithCallback));
        address _expectedAddress = generateCreate2(address(proxyFactory), _salt, deploymentData);
        require(_proxy == _expectedAddress);
    }

    function generateCreate2(address _address, bytes32 _salt, bytes32 _hashedInitCode) public pure returns (address) {
        bytes1 _const = 0xff;
        return address(uint160(uint256(keccak256(abi.encodePacked(
            _const,
            _address,
            _salt,
            _hashedInitCode
        )))));
    }

    function deRegister() external {
        IGnosisSafe _safe = IGnosisSafe(msg.sender);
        address[] memory _owners = _safe.getOwners();
        address _owner = _owners[0];
        require(_safe == getSafe(_owner), "Can only deRegister the current account safe");
        accountSafeIndexes[_owner] += 1;
    }

    function getSafe(address _account) public view returns (IGnosisSafe) {
        uint256 accountSafeIndex = accountSafeIndexes[_account];
        if (accountSafes[_account].length < accountSafeIndex + 1) {
            return IGnosisSafe(0);
        }
        return accountSafes[_account][accountSafeIndex];
    }
}