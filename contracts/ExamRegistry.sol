// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./CredentialNFT.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ExamRegistry is Ownable {
    struct Exam {
        bytes32  ipfsHash;
        uint16   passScore;   // 0-100
        uint256  fee;         // optional fee in wei
        address  educator;
        bool     active;
    }

    uint256 private _examIds;
    mapping(uint256 => Exam) public exams;

    CredentialNFT public immutable credentialNFT;
    address public gradingOracle;

    event ExamCreated(uint256 indexed examId, address indexed educator);
    event ExamResult(uint256 indexed examId, address indexed student, uint16 score, bool passed);

    modifier onlyOracle() {
        require(msg.sender == gradingOracle, "Not oracle");
        _;
    }

    constructor(address _credentialNFT) Ownable(msg.sender) {
        credentialNFT = CredentialNFT(_credentialNFT);
    }

    function setOracle(address _oracle) external onlyOwner {
        gradingOracle = _oracle;
    }

    function createExam(bytes32 ipfsHash, uint16 passScore, uint256 fee) external returns (uint256) {
        uint256 newId = ++_examIds;
        exams[newId] = Exam(ipfsHash, passScore, fee, msg.sender, true);
        emit ExamCreated(newId, msg.sender);
        return newId;
    }

    /// Oracle pushes the final score; mints credential if passed.
    function submitScore(
        uint256 examId,
        address student,
        uint16 score,
        string calldata credentialURI
    ) external onlyOracle {
        Exam memory e = exams[examId];
        require(e.active, "Exam inactive");

        bool passed = score >= e.passScore;
        if (passed) credentialNFT.mint(student, examId, credentialURI);

        emit ExamResult(examId, student, score, passed);
    }
}
