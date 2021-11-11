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

import com.cmpe138.mytrial.model.PWatchlist;
import com.cmpe138.mytrial.service.PWatchlistService;

@CrossOrigin
@RestController
public class PWatchlistController {
	
	@Autowired
	private PWatchlistService watchlistServ;
	
	@GetMapping("/watchlists")
	public List<PWatchlist> getWatchlists(@RequestHeader(value="id", required=false) String patient_id) {
		return watchlistServ.getAllWatchlists(patient_id);
	}
	
	@PostMapping("/addwatchlist")
	public void addWatchlist(@RequestHeader(value="id", required=false) String patient_id, @RequestBody PWatchlist pWatchlist) {
		watchlistServ.createWatchlist(pWatchlist.getName(), patient_id, pWatchlist.getDiseaseArea());
	}
}
