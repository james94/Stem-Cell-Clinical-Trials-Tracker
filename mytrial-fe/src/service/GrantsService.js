import axios from 'axios';
import MYTRIAL_API from '../settings/index'

const GRANTS_API_BASE_URL = `${MYTRIAL_API}/grants`;

class GrantsService {
    getGrants(config_params) {
        return axios.get(GRANTS_API_BASE_URL, config_params);
    }

    getGrantsByGrantNumber(params) {
        return axios.get(GRANTS_API_BASE_URL, params);
    }
}

export default new GrantsService()