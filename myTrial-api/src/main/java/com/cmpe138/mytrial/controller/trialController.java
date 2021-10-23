package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Trial;
import com.cmpe138.mytrial.service.MyTrialService;

@CrossOrigin
@RestController
public class trialController {
	
	@Autowired
	private MyTrialService myTrial;
	
	@GetMapping("/trials")
	public List<Trial> getTrials(@RequestHeader("id") String researcher_id) {
		return myTrial.getResearcherTrials(researcher_id);
	}
	
	@PostMapping("/addtrial")
	public void getTrial(@RequestParam String researcher_id, @RequestBody Trial trial) {
		myTrial.createTrial(researcher_id, trial.getTrial_status(), trial.getTarget_enrollment(), 
				 trial.getNCT_no(), trial.getPhase(), trial.getTitle(), trial.getOrganization_name());
	}
}
