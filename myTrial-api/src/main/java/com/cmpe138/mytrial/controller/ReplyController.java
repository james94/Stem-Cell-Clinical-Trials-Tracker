//SJSU CMPE 138 Fall 2021 TEAM1
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
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Reply;
import com.cmpe138.mytrial.service.ReplyService;

@CrossOrigin
@RestController
public class ReplyController {

	@Autowired
	private ReplyService replyService;

	@GetMapping("/researcher/reply")
	public List<Reply> getResearcherReply(@RequestHeader(value = "researcher_id", required = false) String researcher_id) {
		return replyService.getReplyByResearcherId(researcher_id);
	}

	@GetMapping("/reply/{reply_id}")
	public Reply getReply(@PathVariable(value="reply_id") int reply_id) {
		return replyService.getReplyId(reply_id);
	}

	@PostMapping("/reply")
	public Integer addReply(@RequestBody Reply reply) {
		return replyService.addReply(reply.getContent(), reply.getDf_id(), reply.getResearcher_id());
	}
	
	@PutMapping("/reply")
	public Integer updateReply(@RequestBody Reply reply) {
		return replyService.updateReply(reply.getReply_id(), reply.getContent(), reply.getResearcher_id());
	}
	
	@DeleteMapping("/reply/{id}")
	public boolean deleteReply(@PathVariable(value = "id", required = true) Integer reply_id) {
		return replyService.deleteReply(reply_id);
	}
}
