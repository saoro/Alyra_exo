// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract findTheWord is Ownable  {

    string private _word;
    string private _hint;
    address public _winner;
    mapping(address => bool) alreadyPlayed;

    modifier isNotAlreadyPlayed{
        require(!alreadyPlayed[msg.sender], "player has already played");
        _;
    }
    function compare(string memory str1, string memory str2) private pure returns (bool) {
        if (bytes(str1).length != bytes(str2).length) {
            return false;
        }
        return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
    }

    function setWord(string calldata word) public onlyOwner {
        _word = word;
    }

    function sethint(string calldata hint) public onlyOwner {
        _hint = hint;

    }

    function proposeWord(string memory word) public isNotAlreadyPlayed {

        require(address(0x0) == _winner, "game already winning");
        alreadyPlayed[msg.sender] = true;
        if(compare(_word, word))
        {
            _winner = msg.sender;
        }
    }

}