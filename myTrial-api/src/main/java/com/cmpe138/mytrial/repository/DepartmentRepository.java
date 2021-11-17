// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import com.cmpe138.mytrial.model.Department;

@Repository
public class DepartmentRepository {
	@Autowired
	private JdbcTemplate jdbc;

	public List<Department> findAll() {
		System.out.println("Reached repo");
		return jdbc.query("select * from department", this::mapRowToDepartment);
	}

	private Department mapRowToDepartment(ResultSet rs, int rowNum) throws SQLException {
		Department d = new Department();
		d.setDname(rs.getString("dname"));
		d.setDnumber(rs.getInt("dnumber"));
		d.setMgrssn(rs.getInt("mgrssn"));
		d.setMgrstartdate(rs.getDate("mgrstartdate"));
		return d;
	}
}
