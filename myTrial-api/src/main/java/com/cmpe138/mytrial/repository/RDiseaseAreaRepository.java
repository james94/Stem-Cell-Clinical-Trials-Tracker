package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.DiscussionForum;
import com.cmpe138.mytrial.model.RDiseaseArea;

@Repository
public class RDiseaseAreaRepository {

	@Autowired
	private JdbcTemplate jdbc;

	public List<RDiseaseArea> findAll() {
		System.out.println("Reached repo");
		return jdbc.query("select * from r_disease_area", this::mapRowToRDiseaseArea);
	}

	private RDiseaseArea mapRowToRDiseaseArea(ResultSet rs, int rowNum) throws SQLException {
		RDiseaseArea rDiseaseArea = new RDiseaseArea();
		rDiseaseArea.setResearcher_id(rs.getString("researcher_id"));
		rDiseaseArea.setDisease_name(rs.getString("disease_name"));
		return rDiseaseArea;
	}

	public List<RDiseaseArea> findByResearcherId(String researcher_id) {
		String sql = "select * from r_disease_area where researcher_id = ?";
		List<RDiseaseArea> list = jdbc.query(sql, new BeanPropertyRowMapper<RDiseaseArea>(RDiseaseArea.class), researcher_id);
		return list;
	}
	
	public void addRDisease(String r_id, String disease) {
		String sql = "insert r_disease_area values (?, ?)";
		jdbc.update(sql, r_id, disease);
	}

}
