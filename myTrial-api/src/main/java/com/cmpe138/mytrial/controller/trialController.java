// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Trial;
import com.cmpe138.mytrial.service.MyTrialService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

@CrossOrigin
@RestController
public class trialController {

	@Autowired
	private MyTrialService myTrial;

	@GetMapping("/trials")
	public List<Trial> getTrials(@RequestHeader(value = "id", required = false) String researcher_id,
			@RequestHeader(value = "patient_id", required = false) String patient_id,
			@RequestParam(value = "trialId", required = false) String trial_id,
			@RequestParam(value = "disease", required = false) String disease_area) {
		if (trial_id != null) {
			List<Trial> res = new ArrayList<>();
			res.add(myTrial.getTrialById(trial_id));
			return res;
		} else if (disease_area != null) {
			return myTrial.getTrialsByDiseaseArea(disease_area);
		} else if (patient_id != null) {
			return myTrial.getTrialsByPatientId(patient_id);
		} else {
			return myTrial.getTrialsByResearcherId(researcher_id);
		}
	}

	@PostMapping("/addtrial")
	public ResponseEntity<String> addTrial(@RequestHeader(value = "id") String researcher_id,
			@RequestBody ObjectNode trial) {
		List<String> diseases = new ArrayList<>();
		try {
			JsonNode diseasesNode = trial.get("diseases");
			for (JsonNode disease : diseasesNode) {
				diseases.add(disease.asText());
			}
			myTrial.createTrial(researcher_id, diseases, trial.get("trial_status").asText(),
					trial.get("target_enrollment").asInt(), trial.get("nct_no").asText(), trial.get("phase").asText(),
					trial.get("title").asText(), trial.get("organization_name").asText());
		} catch (Exception e) {
			System.out.println(e);
			return new ResponseEntity<>("Trial creation failed!", HttpStatus.BAD_REQUEST);
		}
		System.out.println("Trial creation success!");
		return new ResponseEntity<>("Trial creation success!", HttpStatus.OK);
	}

}
