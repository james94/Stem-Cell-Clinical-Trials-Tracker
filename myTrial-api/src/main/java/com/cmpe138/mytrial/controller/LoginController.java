package com.cmpe138.mytrial.controller;

import java.nio.channels.NonReadableChannelException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.objenesis.instantiator.basic.NewInstanceInstantiator;
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

import ch.qos.logback.core.joran.conditional.IfAction;

@CrossOrigin
@RestController
public class LoginController {
	
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
	
}
