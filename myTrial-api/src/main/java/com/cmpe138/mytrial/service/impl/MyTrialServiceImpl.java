package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.cmpe138.mytrial.model.Department;
import com.cmpe138.mytrial.model.Trial;
import com.cmpe138.mytrial.repository.DepartmentRepository;
import com.cmpe138.mytrial.repository.TDiseaseAreaRepository;
import com.cmpe138.mytrial.repository.TrialRepository;
import com.cmpe138.mytrial.service.MyTrialService;


@Component
public class MyTrialServiceImpl implements MyTrialService {
	
	@Autowired
	DepartmentRepository departmentRepository;
	
	@Autowired
	TrialRepository trialRepository;
	
	@Autowired
	TDiseaseAreaRepository tDiseaseAreaRepository;

	@Override
	public List<Department> getAllDepartments() {
		return departmentRepository.findAll();
	}
	
	@Override
	public List<Trial> getTrialsByResearcherId(String researcher_id) {
		return trialRepository.findByResearcherId(researcher_id);
	}

	@Override
	public List<Trial> getTrialsByPatientId(String patient_id) {
		return trialRepository.findByPatientId(patient_id);
	}
	
	@Override
	@Transactional
	public void createTrial(String r_id, List<String> diseases, String trial_status, int target_enrollment, String nct_no, String phase, String title, String org_name) {
		String trial_id = String.valueOf((int)(Math.random() * 999999999));
		while (getTrialById(trial_id) != null) {
			trial_id = String.valueOf((int)(Math.random() * 999999999));
		}
		trialRepository.addTrial(r_id, trial_id, trial_status, target_enrollment, 
				nct_no, phase, title, org_name);
		for (String disease : diseases) {
			tDiseaseAreaRepository.addTDisease(trial_id, disease);
		}
	}
	
	@Override
	public Trial getTrialById(String trial_id) {
		return trialRepository.findById(trial_id);
	}
	
	@Override
	public List<Trial> getTrialsByDiseaseArea(String disease_area) {
		return trialRepository.findByDiseaseArea(disease_area);
	}

}
