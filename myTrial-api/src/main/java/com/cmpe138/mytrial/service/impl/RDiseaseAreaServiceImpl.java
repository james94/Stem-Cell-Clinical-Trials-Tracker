package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmpe138.mytrial.model.RDiseaseArea;
import com.cmpe138.mytrial.repository.RDiseaseAreaRepository;
import com.cmpe138.mytrial.service.RDiseaseAreaService;

@Service
public class RDiseaseAreaServiceImpl implements RDiseaseAreaService {

	@Autowired
	RDiseaseAreaRepository RDiseaseAreaRepo;

	@Override
	public List<RDiseaseArea> getAllRDiseaseArea() {
		return RDiseaseAreaRepo.findAll();
	}

}
