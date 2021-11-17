//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.DiscussionForum;
import com.cmpe138.mytrial.model.Organization;

@Repository
public class OrganizationRepository {

	@Autowired
	private JdbcTemplate jdbc;

	public List<Organization> findAll() {
		return jdbc.query("select * from org", this::mapRowToOrganization);
	}
	
	public List<Organization> getOrganizationByResearcherId(String researcher_id) {
		return jdbc.query("select * from org o join works_for w on o.org_name = w.org_name where w.researcher_id = ?", new BeanPropertyRowMapper<Organization>(Organization.class), researcher_id);
	}

	private Organization mapRowToOrganization(ResultSet rs, int rowNum) throws SQLException {
		Organization org = new Organization();
		org.setOrg_name(rs.getString("org_name"));
		return org;
	}

}
