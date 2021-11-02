package com.cmpe138.mytrial.service;

import java.util.List;

import com.cmpe138.mytrial.model.Reply;
import com.cmpe138.mytrial.model.Trial;

public interface ReplyService {

	List<Reply> getAllReply();

	List<Reply> getReplyByResearcherId(String researcher_id);

	Reply getReplyId(String reply_id);
}
