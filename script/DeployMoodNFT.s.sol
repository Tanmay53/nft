// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import { MoodNFT } from "../src/MoodNFT.sol";
import { Base64 } from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    function run() public returns(MoodNFT) {
        string memory happySVG = vm.readFile("./images/happy.svg");
        string memory sadSVG = vm.readFile("./images/sad.svg");

        vm.startBroadcast();
        MoodNFT moodNFT = new MoodNFT(svgToImageURI(happySVG), svgToImageURI(sadSVG));
        vm.stopBroadcast();

        return moodNFT;
    }

    function svgToImageURI(string memory svg) public pure returns(string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory base64Encoded = Base64.encode(bytes(svg));

        return string(
            abi.encodePacked(
                baseURL,
                base64Encoded
            )
        );
    }
}