// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ReputationToken is ERC20, ERC20Permit, ERC20Votes, Ownable {
    constructor()
        ERC20("CertiChain Reputation", "REP")
        ERC20Permit("CertiChain Reputation")
        Ownable(msg.sender)
    {
        _mint(msg.sender, 1_000_000 ether);
    }

    /* -------------------------------------------------------------------------- */
    /*                                 Overrides                                   */
    /* -------------------------------------------------------------------------- */

    // single transfer hook in OZ v5
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Votes)
    {
        super._update(from, to, value);
    }

    // <- **fix**: use ERC20Permit & Nonces here, not ERC20Votes
    function nonces(address owner)
        public
        view
        override(ERC20Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }
}
