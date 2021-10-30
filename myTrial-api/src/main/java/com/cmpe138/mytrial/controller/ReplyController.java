package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

	@GetMapping("/reply/{id}")
	public Reply getReply(@PathVariable String reply_id) {
		return replyService.getReplyId(reply_id);
	}
}
