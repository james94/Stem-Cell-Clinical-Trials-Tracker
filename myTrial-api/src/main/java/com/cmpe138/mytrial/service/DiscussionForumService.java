package com.cmpe138.mytrial.service;

import java.util.List;

import com.cmpe138.mytrial.model.DiscussionForum;

public interface DiscussionForumService {

	List<DiscussionForum> getAll();

	DiscussionForum getDiscussionById(int df_id);

	int addDiscussion(String df_name, String details, String researcher_id);
	
	int updateDiscussion(int df_id, String df_name, String details, String researcher_id);

	boolean deleteDiscussion(int df_id);

	List<DiscussionForum> findByResearcherId(String researcher_id);
}
