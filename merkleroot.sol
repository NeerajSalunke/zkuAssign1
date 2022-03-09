// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract merkletree {
    function compute(address sender, address receiver, uint256 tokenId, string memory tokenURI) external payable returns(bytes32) {
        
        bytes32 hash1 = keccak256(abi.encodePacked(keccak256(abi.encodePacked(sender)),keccak256(abi.encodePacked(receiver))));
        bytes32 hash2 = keccak256(abi.encodePacked(keccak256(abi.encodePacked(tokenId)),keccak256(abi.encodePacked(tokenURI))));
        return keccak256(abi.encodePacked(hash1,hash2));
        
        

    }
}
