package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmpe138.mytrial.model.Reply;
import com.cmpe138.mytrial.repository.ReplyRepository;
import com.cmpe138.mytrial.service.ReplyService;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyRepository replyRepo;

	@Override
	public List<Reply> getAllReply() {
		return replyRepo.findAll();
	}

	@Override
	public List<Reply> getReplyByResearcherId(String researcher_id) {
		return replyRepo.getReplyByResearcherId(researcher_id);
	}

	@Override
	public Reply getReplyId(String reply_id) {
		return replyRepo.getReplyById(reply_id);
	}

	@Override
	public int addReply(String content, String df_id, String researcher_id) {
		return replyRepo.addReply(content, df_id, researcher_id);
	}

}
