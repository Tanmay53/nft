// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint private s_token_counter;
    mapping(uint => string) private s_tokenToUri;

    constructor() ERC721("Dogie", "DOG") {
        s_token_counter = 0;
    }

    function mintNFT(string memory tokenUri) public {
        s_tokenToUri[s_token_counter] = tokenUri;
        _safeMint(msg.sender, s_token_counter);
        s_token_counter++;
    }

    function tokenURI(uint tokenId) public view override returns(string memory) {
        return s_tokenToUri[tokenId];
    }
}