// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Department;
import com.cmpe138.mytrial.service.MyTrialService;

@RestController
public class testController {
	@Autowired
	private MyTrialService myTrial;

	@GetMapping("/test")
	public String test() {
		return "hello from server";
	}

	@GetMapping("/departments")
	public List<Department> getDepartments() {
		return myTrial.getAllDepartments();
	}
}
