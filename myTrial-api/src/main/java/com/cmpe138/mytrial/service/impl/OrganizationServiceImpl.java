// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmpe138.mytrial.model.Organization;
import com.cmpe138.mytrial.repository.OrganizationRepository;
import com.cmpe138.mytrial.service.OrganizationService;

@Service
public class OrganizationServiceImpl implements OrganizationService {

	@Autowired
	OrganizationRepository OrgRepo;

	@Override
	public List<Organization> getAllOrganizations() {
		return OrgRepo.findAll();
	}

}
