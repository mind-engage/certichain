// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title NFT credential representing a passed CertiChain exam.
contract CredentialNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;                          // simple counter
    mapping(uint256 => uint256) public tokenExam;       // tokenId → examId

    constructor() ERC721("CertiChain Credential", "CERT") Ownable(msg.sender) {}

    function mint(
        address to,
        uint256 examId,
        string calldata uri
    ) external onlyOwner returns (uint256) {
        uint256 newId = ++_tokenIds;                    // pre-increment
        _safeMint(to, newId);
        _setTokenURI(newId, uri);
        tokenExam[newId] = examId;
        return newId;
    }
}
