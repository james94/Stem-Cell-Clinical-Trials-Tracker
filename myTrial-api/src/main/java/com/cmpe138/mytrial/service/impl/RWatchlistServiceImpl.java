//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.cmpe138.mytrial.model.RWatchlist;
import com.cmpe138.mytrial.repository.RWatchlistRepository;
import com.cmpe138.mytrial.service.RWatchlistService;

@Component
public class RWatchlistServiceImpl implements RWatchlistService{
	
	@Autowired
	RWatchlistRepository rWatchlistRepository;
	
	@Override
	public List<RWatchlist> getAllWatchlists(String r_id) {
		return rWatchlistRepository.findAll(r_id);
	}
	
	@Override
	public void createWatchlist(String name, String r_id, String disease_area) {
		rWatchlistRepository.createWatchlist(name, r_id, disease_area);
	}
	
}
