package com.cmpe138.mytrial.controller;

import java.util.ArrayList;
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
	public List<Trial> getTrials(@RequestHeader(value="id", required=false) String researcher_id, @RequestParam(value="trialId", required=false) String trial_id, @RequestParam(value="disease", required=false) String disease_area) {
		if (trial_id != null) {
			List<Trial> res = new ArrayList<>();
			res.add(myTrial.getTrialById(trial_id));
			return res;
		} else if (disease_area != null) {
			return myTrial.getTrialsByDiseaseArea(disease_area);
		} else {
			return myTrial.getTrialsByResearcherId(researcher_id);
		}
	}
	
	@PostMapping("/addtrial")
	public void addTrial(@RequestHeader(value="id") String researcher_id, @RequestBody Trial trial) {
		myTrial.createTrial(researcher_id, trial.getTrial_status(), trial.getTarget_enrollment(), 
				 trial.getNCT_no(), trial.getPhase(), trial.getTitle(), trial.getOrganization_name());
	}
	
}
