pragma solidity ^0.8.18;

import "./Admin.sol";

contract Doctor is Admin {
    struct DoctorDetails {
        uint id;
        string name;
        string qualification;
        address doctor;
        uint256 workPlace;
    }

    mapping(address => DoctorDetails) public doctors;
    uint public doctorCount;
    address[] public doctorAddress;

    function doctorNotExists(address dAddr) public view returns (bool) {
        for(uint i=0; i<doctorCount; i++) {
            if(doctorAddress[i] == dAddr) {
                return false;
            }
        }
        return true;
    }

    function registerDoctor(string memory _name, string memory _qualification, uint256 _workplaceIndex, address dAddr) public {
        require(doctorNotExists(dAddr), "Doctor already registered");
        doctors[dAddr] = DoctorDetails(doctorCount, _name, _qualification, dAddr, _workplaceIndex);
        doctorAddress.push(dAddr);
        doctorCount++;
    }

    function getAllDoctors() public view returns (DoctorDetails[] memory) {
        DoctorDetails[] memory result = new DoctorDetails[](doctorCount);
        for (uint i = 0; i < doctorCount; i++) {
            result[i] = doctors[doctorAddress[i]];
        }
        return result;
    }
}
