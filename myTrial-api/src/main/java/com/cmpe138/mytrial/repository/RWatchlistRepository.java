//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.RWatchlist;
import com.cmpe138.mytrial.model.Trial;

@Repository
public class RWatchlistRepository {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public void createWatchlist(String name, String researcher_id, String disease_area) {
		String sql = "INSERT r_watchlist VALUES (?, ?, ?)";
		jdbc.update(sql, name, researcher_id, disease_area);
	}
	
	public List<RWatchlist> findAll(String researcher_id) {
		String sql = "SELECT * FROM r_watchlist NATURAL JOIN patient WHERE researcher_id = " + researcher_id;
		return jdbc.query(sql, this::mapRowToTrial);
	}
	
	private RWatchlist mapRowToTrial(ResultSet rs, int rowNum) throws SQLException {
		RWatchlist w = new RWatchlist();
		w.setName(rs.getString("name"));
		w.setResearcherId(rs.getString("researcher_id"));
		w.setDiseaseArea(rs.getString("disease_area"));
		w.setPUsername(rs.getString("p_username"));
		w.setPId(rs.getString("patient_id"));
		return w;
	}
	
}
