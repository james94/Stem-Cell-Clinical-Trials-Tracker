package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmpe138.mytrial.model.DiscussionForum;
import com.cmpe138.mytrial.repository.DiscussionForumRepository;
import com.cmpe138.mytrial.service.DiscussionForumService;

@Service
public class DiscussionForumServiceImpl implements DiscussionForumService {

	@Autowired
	DiscussionForumRepository discussionRepo;

	@Override
	public List<DiscussionForum> getAll() {
		return discussionRepo.findAll();
	}

	@Override
	public DiscussionForum getDiscussionById(String df_id) {
		return discussionRepo.getDiscussionById(df_id);
	}

}
