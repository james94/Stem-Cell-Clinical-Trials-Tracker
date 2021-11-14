import axios from 'axios';
import MYTRIAL_API from '../settings/index'
const PATIIENT_API_BASE_URL = `${MYTRIAL_API}/patient/`;

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