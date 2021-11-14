package com.cmpe138.mytrial.service;

import java.util.List;

import com.cmpe138.mytrial.model.Reply;

public interface ReplyService {

	List<Reply> getAllReply();

	List<Reply> getReplyByResearcherId(String researcher_id);

	Reply getReplyId(int reply_id);

	int addReply(String content, int reply_id, String researcher_id);

	int updateReply(int reply_id, String content, String researcher_id);

	boolean deleteReply(int reply_id);

}
