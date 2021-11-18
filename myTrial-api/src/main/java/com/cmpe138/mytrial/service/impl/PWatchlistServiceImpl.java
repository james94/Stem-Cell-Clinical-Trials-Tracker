//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.cmpe138.mytrial.model.PWatchlist;
import com.cmpe138.mytrial.repository.PWatchlistReposiroty;
import com.cmpe138.mytrial.service.PWatchlistService;

@Component
public class PWatchlistServiceImpl implements PWatchlistService{
	
	@Autowired
	PWatchlistReposiroty pWatchlistRepository;
	
	@Override
	public List<PWatchlist> getAllWatchlists(String p_id) {
		return pWatchlistRepository.findAll(p_id);
	}
	
	@Override
	public void createWatchlist(String name, String P_id, String disease_area) {
		pWatchlistRepository.createWatchlist(name, P_id, disease_area);
	}
	
}
