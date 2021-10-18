package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;								
import com.cmpe138.mytrial.model.Trial;

@Repository
public class TrialRepository {
	@Autowired
	private JdbcTemplate jdbc;
	
	public List<Trial> findByResearcherId(String id) {
		String sql = "select * from trial T where T.trial_id in "
				+ "(select I.trial_id from investigates I where I.researcher_id = " + id + ")";
		return jdbc.query(sql, this::mapRowToTrial);
	}
	
	private Trial mapRowToTrial(ResultSet rs, int rowNum) throws SQLException {
		Trial t =  new Trial();
		t.setTrial_id(rs.getString("trial_id"));
		t.setTrial_status(rs.getString("trial_status"));
		t.setTarget_enrollment(rs.getInt("target_enrollment"));
		t.setNCT_no(rs.getString("NCT_no"));
		t.setPhase(rs.getString("phase"));
		t.setTitle(rs.getString("title"));
		t.setOrganization_name(rs.getString("org_name"));
		return t;
}
}
