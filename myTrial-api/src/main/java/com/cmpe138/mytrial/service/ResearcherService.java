// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.service;

import java.util.ArrayList;
import java.util.List;

import com.cmpe138.mytrial.model.Patient;
import com.cmpe138.mytrial.model.Researcher;

public interface ResearcherService {

	List<Researcher> getAll();

	Researcher getResearchertById(String researcher_id);
	
	Researcher getResearcherByUsernamePassword(String username, String password);
	
	List<String> getResearcherByTrialId(String trial_id);
	
	void createResearcher(String r_name, String r_username, String r_password, List<String> organizations, List<String> disease_areas);
}
