// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	public Patient getPatientById(@RequestHeader(value = "researcher_id", required = false) String researcher_id,
			@PathVariable(value = "patient_id") String patient_id) {
		return patientService.getPatientById(researcher_id, patient_id);
	}

	@GetMapping("/patient")
	public List<Patient> getPatientByHeaderId(@RequestHeader(value = "trial_id", required = false) String trial_id,
			@RequestHeader(value = "researcher_id", required = false) String researcher_id,
			@RequestHeader(value = "search", required = false) boolean search) {
		try {
			if ((!researcher_id.isEmpty()) && search == true) {
				return patientService.getAll();
			} else if (!trial_id.isEmpty()) {
				return patientService.getPatientByTrialId(trial_id);
			} else {
				return patientService.getPatientByResearcherId(researcher_id);
			}
		} catch (Exception e) {
			System.err.println(e);
			System.err.println(
					"Failed to Get Patients! At least one header arg 'trial_id' or 'researcher_id' or 'search' needs to be passed in header!");
			return null;
		}
	}

	@PostMapping("/editpatient/{patient_id}")
	public void updatePatient(@PathVariable(value = "patient_id") String patient_id, @RequestBody Patient p) {
		p.setPatient_id(patient_id);
		patientService.updatePatientUsingPatientID(p.getDisease(), p.getPhase(), p.getP_status(), p.getTrial_id(),
				p.getPatient_id());
	}

	@DeleteMapping("/patient/{patient_id}")
	public boolean deletePatientById(@PathVariable(value = "patient_id", required = true) Integer patient_id) {
		return patientService.deletePatientById(patient_id);
	}

}
