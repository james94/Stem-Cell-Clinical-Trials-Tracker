package com.cmpe138.mytrial.service;

import java.util.List;

import com.cmpe138.mytrial.model.DiscussionForum;

public interface DiscussionForumService {

	List<DiscussionForum> getAll();

	DiscussionForum getDiscussionById(String df_id);
}
