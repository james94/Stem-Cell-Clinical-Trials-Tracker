// SJSU CMPE 138 Fall 2021 TEAM1
import axios from "axios";
const MYTRIAL_API = 'http://127.0.0.1:8080';
const ADD_DONOR_API_BASE_URL = `${MYTRIAL_API}/add_donor/`;
const UPDATE_DONOR_API_BASE_URL = `${MYTRIAL_API}/update_donor/`;
const DONOR_API_BASE_URL = `${MYTRIAL_API}/donor/`;

class DonorService {
    CreateDonor(donor, config){
        return axios.post(ADD_DONOR_API_BASE_URL, donor, config);
    }
    UpdateDonor(patient_id, donor, config){
        return axios.post(UPDATE_DONOR_API_BASE_URL + patient_id, donor, config);
    }

    getDonorByPatientId(patient_id){
        return axios.get(DONOR_API_BASE_URL + patient_id);
    }
}
export default new DonorService()
