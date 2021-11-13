import axios from 'axios';
const MYTRIAL_API = 'http://127.0.0.1:8080';
const PATIIENT_API_BASE_URL = `${MYTRIAL_API}/patient/`;

class PatientService {
    // config has researcher_id
    getPatients(config) {
        console.log(PATIIENT_API_BASE_URL)
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