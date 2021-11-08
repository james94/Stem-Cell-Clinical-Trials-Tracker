package com.cmpe138.mytrial.controller;

import java.util.List;
import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.Department;
import com.cmpe138.mytrial.model.Organization;
import com.cmpe138.mytrial.service.MyTrialService;
import com.cmpe138.mytrial.service.OrganizationService;

@RestController
public class testOrgController {
	@Autowired

    private OrganizationService myOrg;
	
	@GetMapping("/test2")
	public String test() {
		return "hello testing trial and org from server";
	}

	@GetMapping("/organizations")
	public List<Organization> getOrganizations() {
		return myOrg.getAllOrganizations();				
	}

}
