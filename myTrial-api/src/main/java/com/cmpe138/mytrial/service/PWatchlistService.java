//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.service;

import java.util.List;

import com.cmpe138.mytrial.model.PWatchlist;

public interface PWatchlistService {
	List<PWatchlist> getAllWatchlists(String p_id);
	void createWatchlist(String name, String P_id, String disease_area);
}
