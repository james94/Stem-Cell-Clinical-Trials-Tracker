// SJSU CMPE 138 Fall 2021 TEAM1
import axios from 'axios';
import { PATIIENT_API_BASE_URL } from '../settings/index'

class PatientService {
    // config has researcher_id
    getPatients(config) {
        return axios.get(PATIIENT_API_BASE_URL, config);
    }

    createPatient(patient) {
        return axios.post(PATIIENT_API_BASE_URL, patient);
    }

    getPatientById(patientId, config) {
        return axios.get(PATIIENT_API_BASE_URL + '/' + patientId, config);
    }

    updatePatient(patient, patientId) {
        return axios.put(PATIIENT_API_BASE_URL + '/' + patientId, patient);
    }

    deletePatient(patientId) {
        return axios.delete(PATIIENT_API_BASE_URL + '/' + patientId);
    }
}

export default new PatientService()
