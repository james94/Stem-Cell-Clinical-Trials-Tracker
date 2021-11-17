package com.cmpe138.mytrial.service;

import java.util.List;

import com.cmpe138.mytrial.model.RWatchlist;

public interface RWatchlistService {
	List<RWatchlist> getAllWatchlists(String researcher_id);
	void createWatchlist(String name, String researcher_id, String disease_area);
}
