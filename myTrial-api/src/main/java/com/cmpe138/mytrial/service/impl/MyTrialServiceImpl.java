package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.cmpe138.mytrial.model.Department;
import com.cmpe138.mytrial.repository.DepartmentRepository;
import com.cmpe138.mytrial.service.MyTrialService;


@Component
public class MyTrialServiceImpl implements MyTrialService {
	
	@Autowired
	DepartmentRepository departmentRepository;

	@Override
	public List<Department> getAllDepartments() {
		return departmentRepository.findAll();
	}

}
