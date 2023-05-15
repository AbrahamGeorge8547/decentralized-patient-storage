pragma solidity ^0.8.0;

import "./Admin.sol";
import "./Doctor.sol";
import "./Patient.sol";

contract MedicalRecords is Admin {
    Doctor private doctor;
    Patient private patient;
    address public owner;

    constructor() {
        doctor = new Doctor();
        patient = new Patient();
        owner = msg.sender; // Set the owner in the constructor
    }

    modifier onlyAdmin() {
        require(msg.sender == owner, "Only admin can call this function");
        _;
    }

    function createWorkplace(string memory _name, string memory _workAddress) public onlyAdmin override {
        super.createWorkplace(_name, _workAddress);
    }

    function getAllWorkplaces() public view override returns (Admin.Workplace[] memory) {
        return super.getAllWorkplaces();
    }

    function registerDoctor(string memory _name, string memory _qualification, uint256 _workplaceIndex) public {
        doctor.registerDoctor(_name, _qualification, _workplaceIndex);
    }

    function getAllDoctors() public view returns (Doctor.DoctorDetails[] memory) {
        return doctor.getAllDoctors();
    }

    // Patient functions
    function registerPatient(string memory _name, uint _age) public {
        patient.registerPatient(_name, _age);
    }

    function getAllPatients() public view returns (Patient.PatientDetails[] memory) {
        return patient.getAllPatients();
    }
}
