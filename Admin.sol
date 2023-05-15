pragma solidity ^0.8.0;

contract Admin {
    struct Workplace {
        string name;
        string workAddress;
    }

    struct Medicine {
        uint256 id;
        string name;
        string expiryDate;
        string price;
    }

    Workplace[] public workplaces;



    function createWorkplace(string memory _name, string memory _workAddress) public virtual  {
        Workplace memory newWorkplace = Workplace(_name, _workAddress);
        workplaces.push(newWorkplace);
    }

    function getAllWorkplaces() public view virtual returns (Workplace[] memory) {
        return workplaces;
    }


    function createMedicine() public virtual {} 
}