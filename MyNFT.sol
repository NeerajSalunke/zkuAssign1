// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// interface to call My721Token.sol contract from this contract
// My721Token is a contract to transform bytes32 data into its Base64 string representation
interface IMy721Token {
    // we will call tokenURI function of My721Token contract
    function tokenURI(uint256 tokenId) external returns (string memory);
}

contract MyNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // tokURI is string we get after calling callTokenURI function
    string public tokURI;

    constructor() ERC721("MyNFT", "ITM") {}

    // Inside callTokenURI, we use interface declared above to call tokenURI function.
    // _add is My721Token contracts address
    function callTokenURI(address _add, uint256 _tokenId) external {
        tokURI = IMy721Token(_add).tokenURI(_tokenId);
    }

    function awardItem(address player, string memory tokenURI)
        public
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
