pragma solidity 0.5.9;

import './ChaiToken.sol';

contract MyContract {
    ChaiToken chaitoken;
    address owner;
    bool public claimed = false;
    
    event Log(
        string logText
    );
    
    event LogHash(
        string logText,
        bytes32 hash
    );
    
    event LogAddess(
        address addy
    );
    
    constructor() public {
        chaitoken = ChaiToken(0x06AF07097C9Eeb7fD685c692751D5C66dB49c215);
        owner = msg.sender;
    }
    
    // meatloaf
    bytes32 public answerHash = 0x920471809c0271350ebd869f3fc3d8fa7628405eb649f8d3e15cba0c9845b79a;

    function submit(string memory answer) public {
        if (claimed) {
            emit Log('Sorry, funds already claimed! Brain over man!');
        }
        bytes32 _inputHash = keccak256(abi.encode(answer));
        emit LogHash('Comparing hash', _inputHash);
        bool _isCorrect = _inputHash == answerHash;

        if (_isCorrect) {
            uint256 withdraw_amount = chaitoken.balanceOf(address(this));
            require(
                withdraw_amount > 0,
                "Insufficient balance"
            );
            emit Log('Correct answer! Sending tokens!');
            claimed = true;
            chaitoken.transfer(msg.sender, withdraw_amount);
        } else {
            emit Log('Incorrect answer!');
        }
    }
    
    function () external payable {
        emit Log("Got funds!");
    }
}
