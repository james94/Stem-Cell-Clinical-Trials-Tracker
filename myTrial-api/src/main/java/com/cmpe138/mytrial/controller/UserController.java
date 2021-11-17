//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Patient;
import com.cmpe138.mytrial.model.Researcher;
import com.cmpe138.mytrial.model.User;
import com.cmpe138.mytrial.service.PatientService;
import com.cmpe138.mytrial.service.ResearcherService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

@CrossOrigin
@RestController
public class UserController {
	
	@Autowired
	private PatientService patientService;
	
	@Autowired
	private ResearcherService researcherService;
	
	@PostMapping("/login")
	public ResponseEntity<String> getIdByUsernamePassword(@RequestHeader(value="role", required=false) String role, @RequestBody User user) {
		if (role.equals("patient")) {
			Patient p = patientService.getPatientByUsernamePassword(user.getUsername(), user.getPassword());
			if (p != null) {
				return new ResponseEntity<>(p.getPatient_id(), HttpStatus.OK);
			}
		} else {
			Researcher r = researcherService.getResearcherByUsernamePassword(user.getUsername(), user.getPassword());
			if (r != null) {
				return new ResponseEntity<>(r.getResearcher_id(), HttpStatus.OK);
			}
		}
		return new ResponseEntity<>(
		          "Username or password incorrect for selected role", 
		          HttpStatus.UNAUTHORIZED);
	}
	
	@PostMapping("/register")
	public ResponseEntity<String> registerResearcher(@RequestHeader(value="role", required=false) String role, @RequestBody ObjectNode jsonObj) {
		List<String> orgs = new ArrayList<>();
		List<String> diseases = new ArrayList<>();
		try {
			JsonNode orgsNode = jsonObj.get("organization");
			for (JsonNode org : orgsNode) {
				orgs.add(org.asText());
			}
			JsonNode diseasesNode = jsonObj.get("disease_area");
			for (JsonNode disease : diseasesNode) {
				diseases.add(disease.asText());
			}
			researcherService.createResearcher(jsonObj.get("r_name").asText(), 
					jsonObj.get("r_username").asText(), jsonObj.get("r_password").asText(), 
					orgs, diseases);
		} catch (Exception e) {
			System.out.println(e);
			return new ResponseEntity<>("Registration failed!", HttpStatus.BAD_REQUEST);
		}	
		return new ResponseEntity<>("Registration success!", HttpStatus.OK);
	}
	
}
