package com.cmpe138.mytrial.service;

import java.util.List;
import com.cmpe138.mytrial.model.*;


public interface MyTrialService {
	List<Department> getAllDepartments();
	
	List<Trial> getResearcherTrials(String researcher_id);
	
	void createTrial(String r_id, String trial_status, int target_enrollment, 
			String nct_no, String phase, String title, String org_name);
	
	Trial getTrialById(String t_id);
}

