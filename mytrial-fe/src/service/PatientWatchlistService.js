import axios from 'axios';
import { PWATCHLISTS_API_BASE_URL } from "../settings";

class PatientWatchlistService {
    getPatientWatchlistById(config) {
        console.log(PWATCHLISTS_API_BASE_URL)
        return axios.post(PWATCHLISTS_API_BASE_URL, config);
    }

    createPatientWatchlist(watchlist) {
        return axios.post(PWATCHLISTS_API_BASE_URL, watchlist);
    }

    deletePatientWatchlist(watchlistId) {
        return axios.delete(PWATCHLISTS_API_BASE_URL + '/' + watchlistId)
    }
}

export default new PatientWatchlistService()

