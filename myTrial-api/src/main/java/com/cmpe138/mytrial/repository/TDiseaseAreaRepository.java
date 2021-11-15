package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.TDiseaseArea;


@Repository
public class TDiseaseAreaRepository {
	@Autowired
	private JdbcTemplate jdbc;

	public List<TDiseaseArea> findAll() {
		return jdbc.query("select * from t_disease_area", this::mapRowToTDiseaseArea);
	}

	private TDiseaseArea mapRowToTDiseaseArea(ResultSet rs, int rowNum) throws SQLException {
		TDiseaseArea tDiseaseArea = new TDiseaseArea();
		tDiseaseArea.setTrial_id(rs.getString("trial_id"));
		tDiseaseArea.setDisease_name(rs.getString("disease_name"));
		return tDiseaseArea;
	}

	public List<TDiseaseArea> findByTrialId(String trial_id) {
		String sql = "select * from t_disease_area where trial_id = ?";
		List<TDiseaseArea> list = jdbc.query(sql, new BeanPropertyRowMapper<TDiseaseArea>(TDiseaseArea.class), trial_id);
		return list;
	}
	
	public void addTDisease(String t_id, String disease) {
		String sql = "insert t_disease_area values (?, ?)";
		jdbc.update(sql, t_id, disease);
	}
}
