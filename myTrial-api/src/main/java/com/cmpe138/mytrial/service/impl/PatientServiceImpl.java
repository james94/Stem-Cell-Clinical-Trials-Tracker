package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmpe138.mytrial.model.Patient;
import com.cmpe138.mytrial.repository.PatientRepository;
import com.cmpe138.mytrial.service.PatientService;

@Service
public class PatientServiceImpl implements PatientService {

	@Autowired
	PatientRepository patientRepo;

	@Override
	public List<Patient> getAll() {
		return patientRepo.findAll();
	}

	@Override
	public List<Patient> getPatientByResearcherId(String researcher_id) {
		return patientRepo.getPatientsByResearcher_id(researcher_id);
	}

	@Override
	public Patient getPatientById(String patient_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Patient getPatientById(String researcher_id, String patient_id) {
		Patient p = patientRepo.getPatientById(patient_id);
		System.out.println(p);
//		if (p == null || p.getResearcher_id() != researcher_id)
//			return new Patient();
		return p;
	}

	@Override
	public Patient getPatientByUsernamePassword(String username, String password) {
		return patientRepo.getPatientByUsernamePassword(username, password);
	}

	@Override
	public void updatePatientById(String researcher_id, Patient patient) {
		patientRepo.updatePatientById(researcher_id, patient);
	}

}
