// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
		return discussionService.addDiscussion(discussion.getDf_name(), discussion.getDetails(), discussion.getResearcher_id());
	}

	@PutMapping("/discussion")
	public int updateDiscussion(@RequestBody DiscussionForum discussion) {
		return discussionService.updateDiscussion(discussion.getDf_id(), discussion.getDf_name(), discussion.getDetails(), discussion.getResearcher_id());
	}

	@DeleteMapping("/discussion/{id}")
	public boolean deleteDiscussion(@PathVariable(value = "id", required = true) Integer df_id) {
		return discussionService.deleteDiscussion(df_id);
	}

	@GetMapping("/discussion/{id}")
	public DiscussionForum getDiscussionForumById(@PathVariable(value = "id", required = true) Integer df_id) {
		return discussionService.getDiscussionById(df_id);
	}

}
