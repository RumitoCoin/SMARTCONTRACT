pragma solidity ^0.5.4;

import "./Roles.sol";

contract ApproverRole {
    using Roles for Roles.Role;

    event ApproverAdded(address indexed account);
    event ApproverRemoved(address indexed account);

    Roles.Role private _approvers;

    constructor () internal {
        _addApprover(msg.sender);
    }

    modifier onlyApprover() {
        require(isApprover(msg.sender), "ApproverRole: caller does not have the Approver role");
        _;
    }

    function isApprover(address account) public view returns (bool) {
        return _approvers.has(account);
    }

    function addApprover(address account) public onlyApprover {
        _addApprover(account);
    }

    function renounceApprover() public {
        _removeApprover(msg.sender);
    }

    function _addApprover(address account) internal {
        _approvers.add(account);
        emit ApproverAdded(account);
    }

    function _removeApprover(address account) internal {
        _approvers.remove(account);
        emit ApproverRemoved(account);
    }
}
