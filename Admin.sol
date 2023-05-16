//SPDX-License-Identifier:MIT
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
        string dose;
    }

    struct Disease {
        uint256 id;
        string name;
    }
    uint256 medicineCount;
    uint256 diseaseCount; 
    Workplace[] public workplaces;
    mapping(uint256 => Medicine) public medicines;
    Disease[] public diseases;



    function createWorkplace(string memory _name, string memory _workAddress) public virtual  {
        Workplace memory newWorkplace = Workplace(_name, _workAddress);
        workplaces.push(newWorkplace);
    }

    function getAllWorkplaces() public view virtual returns (Workplace[] memory) {
        return workplaces;
    }

    function addMedicine(string memory _name, string memory _expiryDate, string memory _dose, string memory _price) public virtual {
        Medicine memory newMedicine = Medicine({
            id: medicineCount,
            name: _name,
            expiryDate: _expiryDate,
            price: _price,
            dose: _dose
        });
        medicines[medicineCount] = newMedicine;
        medicineCount++;
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

    function checkMedicineExists(uint256 id) public view virtual returns (bool) {
       return bytes(medicines[id].name).length > 0;
    }

    function getMedicine(uint256 id) public view returns (string memory name, string memory expiryDate, string memory dose, string memory price) {
        Medicine memory medicine = medicines[id];
        return (medicine.name, medicine.expiryDate, medicine.dose, medicine.price);
    }

}