
pragma solidity ^0.8.18;
contract MedicalRecords {
    address private owner;
    struct Doctor {
        uint id;
        string name;
        string qualification;
        address doctor;
        uint256 workPlace;
    }
    
    struct Patient {
        uint id;
        string name;
        uint age;
        address publicAddress;
        string[] diseases;
        string[] medicines;
        string[] allowedDoctors;
    }
    
    struct Medicine {
        uint id;
        string name;
        uint expiryDate;
        uint dose;
        uint price;
    }

    struct Workplace {
        uint256 id;
        string name;
        string workAddress;
    }
    
    mapping(address => Doctor) public doctors;
    mapping(address => Patient) public patients;
    mapping(uint256 => Medicine) public medicines;
    mapping(uint256 => Workplace) public workplaces;
    
    uint public doctorCount;
    uint public patientCount;
    uint public medicineCount;
    uint public workplaceCount;
    address[] public doctorAddress;
    address[] public patientAddress;
    
     constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action.");
        _;
    }
    event DoctorRegistered(uint256 id, string name, string qualification, address doctor, uint256 workplaceIndex);

    function workplaceExists(uint256 _workplaceIndex) public view returns (bool) {
        return (_workplaceIndex >= 0 && _workplaceIndex <= workplaceCount);
    }

    function doctorNotExists() public view returns (bool) {
        for(uint i=0; i<doctorCount; i++) {
            if(doctorAddress[i] == msg.sender) {
                return false;
            }
        }
        return true;
    }

    function patientNotExists() public view returns (bool) {
        for(uint i=0; i<patientCount; i++) {
            if(patientAddress[i] == msg.sender) {
                return false;
            }
        }
        return true;
    }
    function registerDoctor(string memory _name, string memory _qualification, uint256 _workplaceIndex) public {
        require(workplaceExists(_workplaceIndex), "Workplace does not exist.");
        require(doctorNotExists(), "Doctor already registered");
        doctors[msg.sender] = Doctor(doctorCount, _name, _qualification, msg.sender, _workplaceIndex);
        doctorAddress.push(msg.sender);
        doctorCount++;
        emit DoctorRegistered(doctorCount, _name, _qualification, msg.sender, _workplaceIndex);
    }

    function registerPatient(string memory _name, uint _age) public {
        require(patientNotExists(), "Patient already exists");
        string[] memory diseases;
        string[] memory prescribedMedicines;
        string[] memory allowedDoctors;
        patients[msg.sender] = Patient({id: patientCount, name: _name, age: _age, publicAddress: msg.sender, diseases: diseases, medicines: prescribedMedicines, allowedDoctors: allowedDoctors});
        patientAddress.push(msg.sender);
        patientCount++;
    }

    function createWorkplace(string memory _name, string memory _workAddress) public onlyOwner {
        require(bytes(_name).length > 0, "Workplace name cannot be empty.");
        workplaceCount++;
        workplaces[workplaceCount] = Workplace(workplaceCount, _name, _workAddress);
    }

    function getAllWorkplaces() public view returns (Workplace[] memory) {
        Workplace[] memory result = new Workplace[](workplaceCount);
        for (uint256 i = 1; i <= workplaceCount; i++) {
            result[i - 1] = workplaces[i];
        }
        return result;
    }

    function getAllDoctors() public view returns (Doctor[] memory) {
        Doctor[] memory result = new Doctor[](doctorCount);
        for (uint i = 0; i < doctorCount; i++) {
            result[i] = doctors[doctorAddress[i]];
        }
        return result;
    }

    function getAllPatients() public view returns (Patient[] memory) {
        Patient[] memory result = new Patient[](patientCount);
        for (uint i = 0; i < patientCount; i++) {
            result[i] = patients[patientAddress[i]];
        }
        return result;
    }
}