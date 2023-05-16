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
        string[] doses;
    }

    struct Disease {
        uint256 id;
        string name;
    }
    uint256 medicineCount;
    uint256 diseaseCount; 
    Workplace[] public workplaces;
    Medicine[] public medicines;
    Disease[] public diseases;



    function createWorkplace(string memory _name, string memory _workAddress) public virtual  {
        Workplace memory newWorkplace = Workplace(_name, _workAddress);
        workplaces.push(newWorkplace);
    }

    function getAllWorkplaces() public view virtual returns (Workplace[] memory) {
        return workplaces;
    }

    function addMedicine(string memory _name, string memory _expiryDate, string[] memory _doses, string memory _price) public virtual {
        Medicine memory newMedicine = Medicine({
            id: medicineCount,
            name: _name,
            expiryDate: _expiryDate,
            price: _price,
            doses: _doses
        });
        medicineCount++;
        medicines.push(newMedicine);
    }

    function getAllMedicines() public view virtual returns(Medicine[] memory) {
        return medicines;
    }

    function addDisease(string memory _name) public virtual {
        Disease memory newDisease = Disease({
            id: diseaseCount,
            name: _name
        });
        diseaseCount++;
        diseases.push(newDisease);
    }

    function getAllDiseases() public view virtual returns(Disease[] memory) {
        return diseases;
    }

    function getDiseaseById(uint256 id) public view virtual returns(string memory) {
        return diseases[id].name;
    }

}