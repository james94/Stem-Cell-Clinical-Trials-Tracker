package com.cmpe138.mytrial.service;

import java.util.List;

import com.cmpe138.mytrial.model.Researcher;

public interface ResearcherService {

	List<Researcher> getAll();

	Researcher getResearchertById(String researcher_id);
}
