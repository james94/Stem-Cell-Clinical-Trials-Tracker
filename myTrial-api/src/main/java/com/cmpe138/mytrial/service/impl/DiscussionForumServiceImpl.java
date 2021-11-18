//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cmpe138.mytrial.model.DiscussionForum;
import com.cmpe138.mytrial.model.Reply;
import com.cmpe138.mytrial.model.Researcher;
import com.cmpe138.mytrial.repository.DiscussionForumRepository;
import com.cmpe138.mytrial.repository.ReplyRepository;
import com.cmpe138.mytrial.repository.ResearcherRepository;
import com.cmpe138.mytrial.service.DiscussionForumService;

@Service
public class DiscussionForumServiceImpl implements DiscussionForumService {

	@Autowired
	DiscussionForumRepository discussionRepo;
	@Autowired
	ResearcherRepository researcherRepo;

	@Autowired
	ReplyRepository replyRepo;

	@Transactional
	@Override
	public List<DiscussionForum> getAll() {
		List<DiscussionForum> l;
		l = discussionRepo.findAll();
		if (l == null || l.size() == 0)
			return null;
		for (DiscussionForum d : l) {
			Researcher r = researcherRepo.getResearcherById(d.getResearcher_id());
			d.setResearcher(r);
		}
		return l;
	}

	@Override
	public List<DiscussionForum> findByResearcherId(String researcher_id) {
		return discussionRepo.getDiscussionByReasercherId(researcher_id);
	}

	@Transactional
	@Override
	public DiscussionForum getDiscussionById(int df_id) {
		DiscussionForum d;
		d = discussionRepo.getDiscussionById(df_id);
		if (d == null)
			return null;
		List<Reply> replies = replyRepo.getReplyByDf_id(df_id);
		for (Reply reply : replies) {
			Researcher researcher = researcherRepo.getResearcherById(reply.getResearcher_id());
			reply.setResearcher(researcher);
		}
		d.setReplies(replies);
		Researcher r = researcherRepo.getResearcherById(d.getResearcher_id());
		d.setResearcher(r);
		return d;
	}

	@Override
	public int addDiscussion(String df_name, String details, String researcher_id) {
		return discussionRepo.addDiscussion(df_name, details, researcher_id);
	}

	@Override
	public int updateDiscussion(int df_id, String df_name, String details, String researcher_id) {
		DiscussionForum data = discussionRepo.getDiscussionById(df_id);
		if (!data.getResearcher_id().equals(researcher_id))
			return df_id;
		return discussionRepo.updateDiscussion(df_id, df_name, details);
	}

	@Override
	public boolean deleteDiscussion(int df_id) {
		int res = discussionRepo.deleteDiscussion(df_id);
		return res == 1; // how many rows
	}

}
