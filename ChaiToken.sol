pragma solidity 0.5.9;

interface ChaiToken {
    function transfer(address dst, uint256 wad) external returns (bool);
    function balanceOf(address guy) external view returns (uint);
}
