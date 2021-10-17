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
	public List<Trial> getTrials(String researcher_id) {
		return trialRepository.findByResearcherId(researcher_id);
	}

}
