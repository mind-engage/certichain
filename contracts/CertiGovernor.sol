// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";

contract CertiGovernor is
    Governor,
    GovernorSettings,
    GovernorCountingSimple,
    GovernorVotes,
    GovernorVotesQuorumFraction
{
    constructor(IVotes _token)
        Governor("CertiGovernor")
        GovernorSettings(1, 45818, 0)
        GovernorVotes(_token)
        GovernorVotesQuorumFraction(4) {}

    /* -------------------------------------------------------------------------- */
    /*                                  Overrides                                 */
    /* -------------------------------------------------------------------------- */

    function votingDelay()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    { return super.votingDelay(); }

    function votingPeriod()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    { return super.votingPeriod(); }

    function proposalThreshold()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    { return super.proposalThreshold(); }

    function quorum(uint256 blockNumber)
        public
        view
        override(Governor, GovernorVotesQuorumFraction)
        returns (uint256)
    { return super.quorum(blockNumber); }

    function _getVotes(address acct, uint256 blk, bytes memory params)
        internal
        view
        override(Governor, GovernorVotes)
        returns (uint256)
    { return super._getVotes(acct, blk, params); }

    function supportsInterface(bytes4 id)
        public
        view
        override(Governor)
        returns (bool)
    { return super.supportsInterface(id); }
}
