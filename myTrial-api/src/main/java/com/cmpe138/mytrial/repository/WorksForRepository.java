package com.cmpe138.mytrial.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class WorksForRepository {
	@Autowired
	private JdbcTemplate jdbc;
	
	public void createWorksFor(String r_id, String org_name) {
		String sql = "insert works_for values (?, ?)";
		jdbc.update(sql, r_id, org_name);
	}
}
