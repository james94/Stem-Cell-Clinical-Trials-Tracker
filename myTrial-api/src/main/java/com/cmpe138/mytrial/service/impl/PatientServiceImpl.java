package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmpe138.mytrial.model.Patient;
import com.cmpe138.mytrial.model.Reply;
import com.cmpe138.mytrial.repository.PatientRepository;
import com.cmpe138.mytrial.repository.ReplyRepository;
import com.cmpe138.mytrial.service.PatientService;
import com.cmpe138.mytrial.service.ReplyService;

@Service
public class PatientServiceImpl implements PatientService {

	@Autowired
	PatientRepository patientRepo;

	@Override
	public List<Patient> getAll() {
		return patientRepo.findAll();
	}

	@Override
	public Patient getPatientById(String patient_id) {
		return patientRepo.getPatientById(patient_id);
	}

}
