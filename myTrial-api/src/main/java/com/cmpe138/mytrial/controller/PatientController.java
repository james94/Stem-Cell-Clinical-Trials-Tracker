package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Patient;
import com.cmpe138.mytrial.service.PatientService;

@CrossOrigin
@RestController
public class PatientController {

	@Autowired
	private PatientService patientService;

	@GetMapping("/patient}")
	public List<Patient> getPatient() {
		return patientService.getAll();
	}

	@GetMapping("/patient/{id}")
	public Patient getPatientById(@RequestHeader(value = "id", required = false) String patient_id) {
		return patientService.getPatientById(patient_id);
	}
}
