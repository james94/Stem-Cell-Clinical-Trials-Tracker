// SJSU CMPE 138 Fall 2021 TEAM1
import axios from 'axios';
import MYTRIAL_API from '../settings/index'
const RESEARCHER_API_BASE_URL = `${MYTRIAL_API}/researcher`;

class ResearcherService {

    getResearchers() {
        return axios.get(RESEARCHER_API_BASE_URL);
    }

    createResearcher(researcher) {
        return axios.post(RESEARCHER_API_BASE_URL, researcher);
    }

    getResearcherById(researcherId) {
        return axios.get(RESEARCHER_API_BASE_URL + '/' + researcherId);
    }

    updateResearcher(researcher, researcherId) {
        return axios.put(RESEARCHER_API_BASE_URL + '/' + researcherId, researcher);
    }

    deleteResearcher(researcherId) {
        return axios.delete(RESEARCHER_API_BASE_URL + '/' + researcherId);
    }
}

export default new ResearcherService()
