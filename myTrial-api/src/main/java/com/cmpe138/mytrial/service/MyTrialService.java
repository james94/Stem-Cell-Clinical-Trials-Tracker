package com.cmpe138.mytrial.service;

import java.util.List;
import com.cmpe138.mytrial.model.*;


public interface MyTrialService {
	List<Department> getAllDepartments();
	
	List<Trial> getTrialsByResearcherId(String researcher_id);

	List<Trial> getTrialsByPatientId(String patient_id);
	
	void createTrial(String r_id, List<String> diseases, String trial_status, int target_enrollment, 
			String nct_no, String phase, String title, String org_name);
	
	Trial getTrialById(String t_id);
	
	List<Trial> getTrialsByDiseaseArea(String disease_area);
}

