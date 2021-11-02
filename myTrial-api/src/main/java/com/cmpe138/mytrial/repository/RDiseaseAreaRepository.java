package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

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

}
