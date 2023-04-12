pragma solidity ^0.5.4;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract ManageableContract {
    address private _managerContract;

    event ContractManagershipTransferred(address indexed previousContract, address indexed newContract);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _managerContract = msg.sender;
        emit ContractManagershipTransferred(address(0), _managerContract);
    }

    /**
     * @dev Returns the address of the current Manager.
     */
    function managerContract() public view returns (address) {
        return _managerContract;
    }

    /**
     * @dev Throws if called by any account other than the Manager.
     */
    modifier onlyManagerContract() {
        require(isManagerContract(), "ManageableContract: caller is not the Manager");
        _;
    }

    /**
     * @dev Returns true if the caller is the current Manager.
     */
    function isManagerContract() public view returns (bool) {
        return msg.sender == _managerContract;
    }

    /**
     * @dev Leaves the contract without manager. It will not be possible to call
     * `onlyManagerContract` functions anymore. Can only be called by the current manager.
     *
     * > Note: Renouncing contractManagership will leave the contract without an managerContract,
     * thereby removing any functionality that is only available to the manager.
     */
    function renounceManagership() public onlyManagerContract {
        emit ContractManagershipTransferred(_managerContract, address(0));
        _managerContract = address(0);
    }

    /**
     * @dev Transfers managership of the contract to a new account (`newManagerContract`).
     * Can only be called by the current manager.
     */
    function transferManagership(address newManagerContract) public onlyManagerContract returns(bool success) {
        return _transferManagership(newManagerContract);
    }

    /**
     * @dev Transfers managership of the contract to a new account (`newManagerContract`).
     */
    function _transferManagership(address newManagerContract) internal returns(bool success) {
        require(newManagerContract != address(0), "Ownable: new owner is the zero address");
        emit ContractManagershipTransferred(_managerContract, newManagerContract);
        _managerContract = newManagerContract;
        return true;
    }
}
