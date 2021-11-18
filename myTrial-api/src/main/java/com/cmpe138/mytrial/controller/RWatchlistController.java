//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.RWatchlist;
import com.cmpe138.mytrial.service.RWatchlistService;

@CrossOrigin
@RestController
public class RWatchlistController {

    @Autowired
	private RWatchlistService watchlistServ;
	
	@GetMapping("/researcher/watchlists")
	public List<RWatchlist> getWatchlists(@RequestHeader(value="id", required=false) String researcher_id) {
		return watchlistServ.getAllWatchlists(researcher_id);
	}
	
	@PostMapping("/researcher/addwatchlist")
	public void addWatchlist(@RequestHeader(value="id", required=false) String researcher_id, @RequestBody RWatchlist rWatchlist) {
		watchlistServ.createWatchlist(rWatchlist.getName(), researcher_id, rWatchlist.getDiseaseArea());
    }
    
}
