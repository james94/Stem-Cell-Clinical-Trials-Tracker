package com.cmpe138.mytrial.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cmpe138.mytrial.model.Researcher;
import com.cmpe138.mytrial.repository.DiscussionForumRepository;
import com.cmpe138.mytrial.repository.OrganizationRepository;
import com.cmpe138.mytrial.repository.PatientRepository;
import com.cmpe138.mytrial.repository.RDiseaseAreaRepository;
import com.cmpe138.mytrial.repository.ReplyRepository;
import com.cmpe138.mytrial.repository.ResearcherRepository;
import com.cmpe138.mytrial.repository.TrialRepository;
import com.cmpe138.mytrial.repository.WorksForRepository;
import com.cmpe138.mytrial.service.ResearcherService;

@Service
public class ResearcherServiceImpl implements ResearcherService {

	@Autowired
	ResearcherRepository researcherRepository;
	
	@Autowired
	DiscussionForumRepository dfRepo;
	
	@Autowired
	ReplyRepository replyRepo;
	
	@Autowired
	PatientRepository patientRepo;
	
	@Autowired
	TrialRepository trialRepo;
	
	@Autowired
	OrganizationRepository orgRepo;
	
	@Autowired
	RDiseaseAreaRepository rDiseaseRepo;
	
	@Autowired
	WorksForRepository worksForRepository;

	@Override
	public List<Researcher> getAll() {
		return researcherRepository.findAll();
	}

	@Override
	@Transactional
	public Researcher getResearchertById(String researcher_id) {
		Researcher r =  researcherRepository.getResearcherById(researcher_id);
		
		r.setDiscussionForums(dfRepo.getDiscussionByReasercherId(researcher_id));
		r.setReplies(replyRepo.getReplyByResearcherId(researcher_id));
		r.setPatients(patientRepo.getPatientsByResearcher_id(researcher_id));
		r.setTrials(trialRepo.findByResearcherId(researcher_id));
		r.setOrganizations(orgRepo.getOrganizationByResearcherId(researcher_id));
		r.setRDiseaseAreas(rDiseaseRepo.findByResearcherId(researcher_id));
		
		return r;
	}
	
	@Override
	public Researcher getResearcherByUsernamePassword(String username, String password) {
		return researcherRepository.getResearcherByUsernamePassword(username, password);
	}
	
	@Override
	public void createResearcher(String r_name, String r_username, String r_password, List<String> organizations, List<String> disease_areas) {
		String r_id = String.valueOf((int)(Math.random() * 999999999));
		while (getResearchertById(r_id) != null) {
			r_id = String.valueOf((int)(Math.random() * 999999999));
		}
		researcherRepository.createResearcher(r_id, r_name, r_username, r_password);
		for (String org : organizations) {
			worksForRepository.createWorksFor(r_id, org);
		}
		for (String disease : disease_areas) {
			rDiseaseRepo.addRDisease(r_id, disease);
		}
	}

}
