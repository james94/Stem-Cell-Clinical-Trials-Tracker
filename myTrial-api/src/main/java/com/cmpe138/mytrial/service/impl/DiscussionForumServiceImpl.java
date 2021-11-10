package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmpe138.mytrial.model.DiscussionForum;
import com.cmpe138.mytrial.repository.DiscussionForumRepository;
import com.cmpe138.mytrial.repository.ReplyRepository;
import com.cmpe138.mytrial.service.DiscussionForumService;

@Service
public class DiscussionForumServiceImpl implements DiscussionForumService {

	@Autowired
	DiscussionForumRepository discussionRepo;
	
	@Autowired
	ReplyRepository replyRepo;

	@Override
	public List<DiscussionForum> getAll() {
		return discussionRepo.findAll();
	}

	@Override
	public DiscussionForum getDiscussionById(int df_id) {
		DiscussionForum data;
		data = discussionRepo.getDiscussionById(df_id);
		return data;
	}

	@Override
	public int addDiscussion(String df_name, String details, String researcher_id) {
		return discussionRepo.addDiscussion(df_name, details, researcher_id);
	}

}