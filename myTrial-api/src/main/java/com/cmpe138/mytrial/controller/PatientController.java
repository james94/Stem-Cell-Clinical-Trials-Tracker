package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
=======
>>>>>>> b7d29d6991d8369982754fea1e50c92ef5b726f5
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Patient;
import com.cmpe138.mytrial.model.Trial;
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
<<<<<<< HEAD
	
	@GetMapping({"/patient/{patient_id}", "/editpatient/{patient_id}"})
	public Patient getPatientById(@PathVariable(value = "patient_id") String patient_id) {
		return patientService.getPatientById(patient_id);
	}
	
	@PostMapping("/editpatient/{patient_id}")
	public void updatePatient(@PathVariable(value = "patient_id") String patient_id, @RequestBody Patient p) {
		p.setPatient_id(patient_id);
		patientService.updatePatientUsingPatientID(p.getDisease(), p.getPhase(), p.getP_status(), p.getTrial_id(), p.getPatient_id());
	}
	
=======

	@GetMapping("/patient")
	public List<Patient> getPatientByResearcherId(@RequestHeader(value = "researcher_id", required = false) String researcher_id) {
		return patientService.getPatientByResearcherId(researcher_id);
	}

>>>>>>> b7d29d6991d8369982754fea1e50c92ef5b726f5
}
