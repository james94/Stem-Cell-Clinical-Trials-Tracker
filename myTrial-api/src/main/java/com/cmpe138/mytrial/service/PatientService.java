package com.cmpe138.mytrial.service;

import java.util.List;

import com.cmpe138.mytrial.model.Patient;

public interface PatientService {

	List<Patient> getAll();

	Patient getPatientById(String patient_id);
	
	Patient getPatientByUsernamePassword(String username, String password);
}
