// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import { BasicNFT } from "../src/BasicNFT.sol";
import { Script } from "forge-std/Script.sol";

contract DeployBasicNFT is Script {
    function run() public returns(BasicNFT) {
        vm.startBroadcast();
        BasicNFT nft = new BasicNFT();
        vm.stopBroadcast();
        return nft;
    }
}