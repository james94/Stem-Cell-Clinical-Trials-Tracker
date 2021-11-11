package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmpe138.mytrial.model.Patient;
import com.cmpe138.mytrial.model.Researcher;
import com.cmpe138.mytrial.repository.ResearcherRepository;
import com.cmpe138.mytrial.service.ResearcherService;

@Service
public class ResearcherServiceImpl implements ResearcherService {

	@Autowired
	ResearcherRepository researcherRepository;

	@Override
	public List<Researcher> getAll() {
		return researcherRepository.findAll();
	}

	@Override
	public Researcher getResearchertById(String researcher_id) {
		return researcherRepository.getResearcherById(researcher_id);
	}
	
	@Override
	public Researcher getResearcherByUsernamePassword(String username, String password) {
		return researcherRepository.getResearcherByUsernamePassword(username, password);
	}

}
