// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.PWatchlist;
import com.cmpe138.mytrial.model.Trial;

@Repository
public class PWatchlistReposiroty {

	@Autowired
	private JdbcTemplate jdbc;

	public void createWatchlist(String name, String p_id, String disease_area) {
		String sql = "INSERT p_watchlist VALUES (?, ?, ?)";
		jdbc.update(sql, name, p_id, disease_area);
	}

	public List<PWatchlist> findAll(String p_id) {
		String sql = "SELECT * FROM p_watchlist WHERE patient_id = " + p_id;
		return jdbc.query(sql, this::mapRowToTrial);
	}

	private PWatchlist mapRowToTrial(ResultSet rs, int rowNum) throws SQLException {
		PWatchlist w = new PWatchlist();
		w.setName(rs.getString("name"));
		w.setPatientId(rs.getString("patient_id"));
		w.setDiseaseArea(rs.getString("disease_area"));
		return w;
	}

}
