package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cmpe138.mytrial.model.Reply;
import com.cmpe138.mytrial.model.Researcher;
import com.cmpe138.mytrial.repository.ReplyRepository;
import com.cmpe138.mytrial.repository.ResearcherRepository;
import com.cmpe138.mytrial.service.ReplyService;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyRepository replyRepo;
	@Autowired
	ResearcherRepository researcherRepo;

	@Override
	public List<Reply> getAllReply() {
		return replyRepo.findAll();
	}

	@Override
	public List<Reply> getReplyByResearcherId(String researcher_id) {
		return replyRepo.getReplyByResearcherId(researcher_id);
	}

	@Transactional
	@Override
	public Reply getReplyId(int reply_id) {
		Reply r;
		r = replyRepo.getReplyById(reply_id);
		if (r == null)
			return null;
		Researcher re = researcherRepo.getResearcherById(r.getResearcher_id());
		r.setResearcher(re);
		return r;
	}

	@Override
	public int addReply(String content, int df_id, String researcher_id) {
		return replyRepo.addReply(content, df_id, researcher_id);
	}

	@Override
	public int updateReply(int reply_id, String content, String researcher_id) {
		Reply data = replyRepo.getReplyById(reply_id);
		if (!data.getResearcher_id().equals(researcher_id))
			return reply_id;
		return replyRepo.updateReply(reply_id, content);
	}

	@Override
	public boolean deleteReply(int reply_id) {
		int res = replyRepo.deleteReply(reply_id);
		return res == 1; // how many rows
	}

}
