package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.cmpe138.mytrial.model.Department;
import com.cmpe138.mytrial.model.Trial;
import com.cmpe138.mytrial.repository.DepartmentRepository;
import com.cmpe138.mytrial.repository.TrialRepository;
import com.cmpe138.mytrial.service.MyTrialService;


@Component
public class MyTrialServiceImpl implements MyTrialService {
	
	@Autowired
	DepartmentRepository departmentRepository;
	
	@Autowired
	TrialRepository trialRepository;

	@Override
	public List<Department> getAllDepartments() {
		return departmentRepository.findAll();
	}
	
	@Override
	public List<Trial> getResearcherTrials(String researcher_id) {
		return trialRepository.findByResearcherId(researcher_id);
	}
	
	@Override
	public void createTrial(String r_id, String trial_status, int target_enrollment, String nct_no, String phase, String title, String org_name) {
		String trial_id = String.valueOf((int)(Math.random() * 999999999));
		while (getTrialById(trial_id) != null) {
			trial_id = String.valueOf((int)(Math.random() * 999999999));
		}
		trialRepository.createNewTrial(r_id, trial_id, trial_status, target_enrollment, nct_no, phase, title, org_name);
	}
	
	@Override
	public Trial getTrialById(String trial_id) {
		return trialRepository.findById(trial_id);
	}

}
