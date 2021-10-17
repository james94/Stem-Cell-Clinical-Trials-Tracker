package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Trial;
import com.cmpe138.mytrial.service.MyTrialService;

@RestController
public class trialController {
	
	@Autowired
	private MyTrialService myTrial;
	
	@GetMapping("/trials")
	public List<Trial> getTrials(@RequestParam String researcher_id) {
		return myTrial.getTrials(researcher_id);
	}
}
