package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmpe138.mytrial.model.Patient;
import com.cmpe138.mytrial.model.Researcher;
import com.cmpe138.mytrial.model.Trial;
import com.cmpe138.mytrial.repository.PatientRepository;
import com.cmpe138.mytrial.repository.ResearcherRepository;
import com.cmpe138.mytrial.repository.TrialRepository;
import com.cmpe138.mytrial.service.PatientService;

@Service
public class PatientServiceImpl implements PatientService {

	@Autowired
	PatientRepository patientRepo;
	@Autowired
	TrialRepository trialRepo;
	@Autowired
	ResearcherRepository researcherRepo;

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
		Patient p = patientRepo.getPatientById(patient_id);
		System.out.println(p);
		return p;
	}

	@Override
	public Patient getPatientById(String researcher_id, String patient_id) {
		Patient p = patientRepo.getPatientById(patient_id);
//		if (p == null || p.getResearcher_id() != researcher_id)
//			return new Patient();
		// add Trial
		Trial t = trialRepo.findById(p.getTrial_id());

		// add Researcher
		Researcher r = researcherRepo.getResearcherById(p.getResearcher_id());

		p.setTrial(t);
		p.setResearcher(r);

		return p;
	}

	@Override
	public Patient getPatientByUsernamePassword(String username, String password) {
		return patientRepo.getPatientByUsernamePassword(username, password);
	}
	
	@Override
	public void updatePatientUsingPatientID(String disease, String phase,String status,String trial_id, String patient_id) {
		patientRepo.updatePatientUsingPatientID(disease, phase, status, trial_id, patient_id);
		System.out.println("Completed calling the repo function from updatePatientUsingPatientID, service file");
	}

	@Override
	public List<Patient> getPatientByTrialId(String trial_id) {
		return patientRepo.getPatientsByTrialId(trial_id);
	}

}
