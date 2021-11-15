package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Patient;
import com.cmpe138.mytrial.model.Researcher;
import com.cmpe138.mytrial.service.PatientService;

@CrossOrigin
@RestController
public class PatientController {

	@Autowired
	private PatientService patientService;

	@GetMapping("/patient/{patient_id}")
	public Patient getPatientById(@RequestHeader(value = "researcher_id", required = false) String researcher_id, @PathVariable(value = "patient_id") String patient_id) {
		return patientService.getPatientById(researcher_id, patient_id);
	}

	@GetMapping("/patient")
	public List<Patient> getPatientByHeaderId(@RequestHeader(value = "trial_id", required = false) String trial_id, @RequestHeader(value = "researcher_id", required = false) String researcher_id) {
		if (!trial_id.isEmpty()) {
			return patientService.getPatientByTrialId(trial_id);
		} else {
			return patientService.getPatientByResearcherId(researcher_id);
		}
	}

}

