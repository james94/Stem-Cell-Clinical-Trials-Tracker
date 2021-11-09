package com.cmpe138.mytrial.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.Researcher;

@Repository
public class ResearcherRepository {
	@Autowired
	private JdbcTemplate jdbc;

	public List<Researcher> findAll() {
		System.out.println("Reached repo");
		String sql = "select * from researcher";
		List<Researcher> forums = jdbc.query(sql, new BeanPropertyRowMapper<Researcher>(Researcher.class));
		return forums;
	}

	public Researcher getResearcherById(String researcher_id) {
		System.out.println("Reached repo");
		String sql = "select * from researcher where researcher_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<Researcher>(Researcher.class), researcher_id);
	}

}
