// SJSU CMPE 138 Fall 2021 TEAM1
import axios from "axios";
import MYTRIAL_API from "../settings/index";
const REPLY_API_BASE_URL = `${MYTRIAL_API}/reply/`;

class ReplyService {
  getReplys() {
    return axios.get(REPLY_API_BASE_URL);
  }

  createReply(reply) {
    return axios.post(REPLY_API_BASE_URL, reply);
  }

  getReplyById(replyId) {
    return axios.get(REPLY_API_BASE_URL + "/" + replyId);
  }

  updateReply(reply) {
    return axios.put(REPLY_API_BASE_URL, reply);
  }

  deleteReply(replyId) {
    return axios.delete(REPLY_API_BASE_URL + "/" + replyId);
  }
}

export default new ReplyService();
