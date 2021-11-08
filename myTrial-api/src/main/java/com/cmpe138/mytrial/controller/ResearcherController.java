package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
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

	@GetMapping("/researcher/{id}")
	public Researcher getResearchersById(@RequestHeader(value = "id", required = false) String researcher_id) {
		return researcherService.getResearchertById(researcher_id);
	}

}
