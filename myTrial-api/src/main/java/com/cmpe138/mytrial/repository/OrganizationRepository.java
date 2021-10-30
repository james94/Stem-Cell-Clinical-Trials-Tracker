package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.Organization;

@Repository
public class OrganizationRepository {

	@Autowired
	private JdbcTemplate jdbc;

	public List<Organization> findAll() {
		System.out.println("Reached repo");
		return jdbc.query("select * from organization", this::mapRowToOrganization);
	}

	private Organization mapRowToOrganization(ResultSet rs, int rowNum) throws SQLException {
		Organization org = new Organization();
		org.setOrg_name(rs.getString("org_name"));
		return org;
	}

}
