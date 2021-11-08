package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.DiscussionForum;
import com.cmpe138.mytrial.service.DiscussionForumService;

@CrossOrigin
@RestController
public class DiscussionForumController {

	@Autowired
	private DiscussionForumService discussionService;

	@GetMapping("/discussion")
	public List<DiscussionForum> getDiscussion() {
		return discussionService.getAll();
	}

	@PostMapping("/discussion")
	public int addDiscussion(@RequestBody DiscussionForum discussion) {
		System.out.println("discussion:"+discussion);
		return discussionService.addDiscussion(discussion.getDf_name(), discussion.getDetails(), discussion.getResearcher_id());
	}

	@GetMapping("/discussion/{id}")
	public DiscussionForum getDiscussionForumById(@RequestHeader(value = "id", required = false) int df_id) {
		return discussionService.getDiscussionById(df_id);
	}

}
