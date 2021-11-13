import axios from 'axios';
const MYTRIAL_API = 'http://127.0.0.1:8080';
const DISCUSSION_API_BASE_URL = `${MYTRIAL_API}/discussion`;

class DiscussionService {

    getDiscussions() {
        return axios.get(DISCUSSION_API_BASE_URL);
    }

    createDiscussion(discussion) {
        return axios.post(DISCUSSION_API_BASE_URL, discussion);
    }

    getDiscussionById(discussionId) {
        return axios.get(DISCUSSION_API_BASE_URL + '/' + discussionId);
    }

    updateDiscussion(discussion) {
        return axios.put(DISCUSSION_API_BASE_URL , discussion);
    }

    deleteDiscussion(discussionId) {
        return axios.delete(DISCUSSION_API_BASE_URL + '/' + discussionId);
    }
}

export default new DiscussionService()