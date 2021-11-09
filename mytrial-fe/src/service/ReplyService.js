import axios from 'axios';
const MYTRIAL_API = 'http://127.0.0.1:8080';
const REPLY_API_BASE_URL = `${MYTRIAL_API}/reply/`;

class ReplyService {

    getReplys() {
        return axios.get(REPLY_API_BASE_URL);
    }

    createReply(reply) {
        return axios.post(REPLY_API_BASE_URL, reply);
    }

    getReplyById(replyId) {
        return axios.get(REPLY_API_BASE_URL + '/' + replyId);
    }

    updateReply(reply, replyId) {
        return axios.put(REPLY_API_BASE_URL + '/' + replyId, reply);
    }

    deleteReply(replyId) {
        return axios.delete(REPLY_API_BASE_URL + '/' + replyId);
    }
}

export default new ReplyService()