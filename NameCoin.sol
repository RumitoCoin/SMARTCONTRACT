pragma solidity ^0.5.4;

import "./ERC20.sol";
import "./ERC20Detailed.sol";
import "./ERC20Burnable.sol";
import "./ERC20Capped.sol";
import "./ERC20Pausable.sol";
import "./Ownable.sol";

contract NameCoin is ERC20, ERC20Pausable, ERC20Detailed, ERC20Capped, ERC20Burnable, Ownable {

  constructor (
      string memory _name,
      string memory _symbol,
      uint8 _decimals,
      uint256 _maxSupply)
    ERC20Capped(_maxSupply)
    ERC20Detailed(_name, _symbol, _decimals)
    public
  {
  }

}
