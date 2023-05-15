pragma solidity ^0.8.18;

contract Patient {
    struct PatientDetails {
        uint id;
        string name;
        uint age;
        address publicAddress;
        string[] diseases;
        string[] medicines;
        string[] allowedDoctors;
    }

    mapping(address => PatientDetails) public patients;
    uint public patientCount;
    address[] public patientAddress;

    function patientNotExists() public view returns (bool) {
        for(uint i=0; i<patientCount; i++) {
            if(patientAddress[i] == msg.sender) {
                return false;
            }
        }
        return true;
    }

    function registerPatient(string memory _name, uint _age) public {
        require(patientNotExists(), "Patient already exists");
        string[] memory diseases;
        string[] memory prescribedMedicines;
        string[] memory allowedDoctors;
        patients[msg.sender] = PatientDetails({
            id: patientCount, 
            name: _name, 
            age: _age, 
            publicAddress: msg.sender, 
            diseases: diseases, 
            medicines: prescribedMedicines, 
            allowedDoctors: allowedDoctors
        });
        patientAddress.push(msg.sender);
        patientCount++;
    }

    function getAllPatients() public view returns (PatientDetails[] memory) {
        PatientDetails[] memory result = new PatientDetails[](patientCount);
        for (uint i = 0; i < patientCount; i++) {
            result[i] = patients[patientAddress[i]];
        }
        return result;
    }
}
