// 2.2
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

// interface to call merkletree.sol contract from this contract
interface Imerkletree {
    function compute(address sender, address receiver, uint256 tokenId, string memory tokenURI) external returns(bytes32);
}

contract MyNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // tokURI is string we get after calling callTokenURI function
    string public tokURI;
    bytes32 public root;

    constructor() ERC721("MyNFT", "ITM") {}

    // Inside callTokenURI, we use interface declared above to call tokenURI function.
    // _add is My721Token contracts address
    function callTokenURI(address _add, uint256 _tokenId) external {
        tokURI = IMy721Token(_add).tokenURI(_tokenId);
    }

    // _addr is merkletree.sol contracts address
    function callmerkletree(address _addr, address _sender, address _receiver, uint256 _tokenId, string memory _tokenURI) external payable {
        root = Imerkletree(_addr).compute(_sender,_receiver,_tokenId,_tokenURI);
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
