//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract Patient {
    struct PatientDetails {
        uint id;
        string name;
        uint age;
        address publicAddress;
        string[] diseases;
        uint256[] medicines;
        string[] allowedDoctors;
    }

    mapping(address => PatientDetails) public patients;
    uint public patientCount;
    address[] public patientAddress;

    function patientNotExists(address pAddr) public view returns (bool) {
        for(uint i=0; i<patientAddress.length; i++) {
            if(patientAddress[i] == pAddr) {
                return false;
            }
        }
        return true;
    }

    function registerPatient(string memory _name, uint _age, address pAddr) public {
        require(patientNotExists(pAddr), "Patient already exists");
        string[] memory diseases;
        uint256[] memory prescribedMedicines;
        string[] memory allowedDoctors;
        patients[pAddr] = PatientDetails({
            id: patientCount, 
            name: _name, 
            age: _age, 
            publicAddress: pAddr, 
            diseases: diseases, 
            medicines: prescribedMedicines, 
            allowedDoctors: allowedDoctors
        });
        patientAddress.push(pAddr);
        patientCount++;
    }

    function getAllPatients() public view returns (PatientDetails[] memory) {
        PatientDetails[] memory result = new PatientDetails[](patientCount);
        for (uint i = 0; i < patientCount; i++) {
            result[i] = patients[patientAddress[i]];
        }
        return result;
    }

    function patientAddDisease(address  pAddr, string memory diseaseName) public {
        patients[pAddr].diseases.push(diseaseName);
    }

    function addMedicineToPatient(uint256 id, address pAddr) public {
        patients[pAddr].medicines.push(id);
    }
}
