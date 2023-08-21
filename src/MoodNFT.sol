// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { Base64 } from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    error MoodNFT_CantFlipMoodIfNotOwner();

    uint private s_token_counter;
    string private s_happy_image_uri;
    string private s_sad_image_uri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint => Mood) private s_tokenIdToMood;

    constructor(string memory happyImageURI, string memory sadImageURI) ERC721("MoodNFT", "MD") {
        s_happy_image_uri = happyImageURI;
        s_sad_image_uri = sadImageURI;
    }

    function flipMood(uint tokenId) external {
        if( !_isApprovedOrOwner(msg.sender, tokenId) ) {
            revert MoodNFT_CantFlipMoodIfNotOwner();
        }

        if( s_tokenIdToMood[tokenId] == Mood.HAPPY ) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function mintNFT() public {
        _safeMint(msg.sender, s_token_counter);
        s_tokenIdToMood[s_token_counter] = Mood.HAPPY;
        s_token_counter++;
    }

    function tokenURI(uint tokenId) public view override returns(string memory) {
        string memory imageURI;

        if( s_tokenIdToMood[tokenId] == Mood.HAPPY ) {
            imageURI = s_happy_image_uri;
        } else {
            imageURI = s_sad_image_uri;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{ "name": "', name(), ', "description": "An NFT that reflects the owner`s mood", "attributes": [{ "trait_type": "moodiness", value: 100 }], "image": "', imageURI, '"}'
                        )
                    )
                )
            )
        );
    }

    function _baseURI() internal pure override returns(string memory) {
        return "data:application/json;base64,";
    }
}