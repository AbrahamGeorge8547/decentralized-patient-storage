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

    function addMedicine(string memory _name, string memory _expiryDate, string[] memory _doses, string memory _price) public onlyAdmin override  {
        return super.addMedicine(_name, _expiryDate, _doses, _price);
    }

    function getAllMedicines() public view override returns (Admin.Medicine[] memory) {
        return super.getAllMedicines();
    }

    function addDisease(string memory _name) public onlyAdmin override {
        return super.addDisease(_name);
    }

    function getAllDiseases() public view override returns (Admin.Disease[] memory) {
        return super.getAllDiseases();
    }

    function registerDoctor(string memory _name, string memory _qualification, uint256 _workplaceIndex) public {
        address dAddr = msg.sender;
        doctor.registerDoctor(_name, _qualification, _workplaceIndex, dAddr);
    }

    function getAllDoctors() public view returns (Doctor.DoctorDetails[] memory) {
        return doctor.getAllDoctors();
    }

    // Patient functions
    function registerPatient(string memory _name, uint _age) public {
        address pAddr = msg.sender;
        patient.registerPatient(_name, _age, pAddr);
    }

    function getAllPatients() public view returns (Patient.PatientDetails[] memory) {
        return patient.getAllPatients();
    }

    function patientAddDisease(uint256 id) public {
        string memory diseaseName;
        diseaseName = super.getDiseaseById(id);
        patient.patientAddDisease(msg.sender, diseaseName);
    }
}
