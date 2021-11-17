// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Researcher;
import com.cmpe138.mytrial.service.ResearcherService;

@CrossOrigin
@RestController
public class ResearcherController {

	@Autowired
	private ResearcherService researcherService;

	@GetMapping("/researcher")
	public List<Researcher> getResearchers() {
		return researcherService.getAll();
	}

	@GetMapping("/researcher/{researcher_id}")
	public Researcher getResearchersById(@PathVariable(value = "researcher_id") String researcher_id) {
		return researcherService.getResearchertById(researcher_id);
	}

	@GetMapping("/researcher_names")
	public List<String> getResearcherNamesByTrialId(@RequestParam(value = "trialId") String trial_id) {
		return researcherService.getResearcherByTrialId(trial_id);
	}

}
