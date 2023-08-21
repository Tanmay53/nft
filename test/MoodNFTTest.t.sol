// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import { Test, console } from "forge-std/Test.sol";
import { MoodNFT } from "../src/MoodNFT.sol";
import { DeployMoodNFT } from "../script/DeployMoodNFT.s.sol";

contract MoodNFTTest is Test {
    MoodNFT public moodNFT;
    DeployMoodNFT public deployer;
    string public constant HAPPY_IMAGE_URI = "data:";

    address public USER;

    function setUp() public {
        deployer = new DeployMoodNFT();
        moodNFT = deployer.run();
        USER = makeAddr('user');
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNFT.mintNFT();

        console.log(moodNFT.tokenURI(0));
    }

    function testFlipTokenToSad() public {
        vm.startPrank(USER);
        moodNFT.mintNFT();

        moodNFT.flipMood(0);

        vm.stopPrank();
    }
}