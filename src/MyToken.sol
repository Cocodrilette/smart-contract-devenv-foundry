// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK", 18) {}
}
