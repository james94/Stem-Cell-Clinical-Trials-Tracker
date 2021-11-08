import axios from 'axios';
const MYTRIAL_API = 'http://127.0.0.1:8080';
const DISCUSSION_API_BASE_URL = `${MYTRIAL_API}/discussion`;

class DiscussionService {

    getDiscussions() {
        return axios.get(DISCUSSION_API_BASE_URL);
    }

    createDiscussion(Discussion) {
        return axios.post(DISCUSSION_API_BASE_URL, Discussion);
    }

    getDiscussionById(DiscussionId) {
        return axios.get(DISCUSSION_API_BASE_URL + '/' + DiscussionId);
    }

    updateDiscussion(Discussion, DiscussionId) {
        return axios.put(DISCUSSION_API_BASE_URL + '/' + DiscussionId, Discussion);
    }

    deleteDiscussion(DiscussionId) {
        return axios.delete(DISCUSSION_API_BASE_URL + '/' + DiscussionId);
    }
}

export default new DiscussionService()