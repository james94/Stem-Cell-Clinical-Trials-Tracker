package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cmpe138.mytrial.model.CTGrant;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

@Repository
public class GrantRepository {
	@Autowired
	private JdbcTemplate jdbc;

    public List<CTGrant> findAll() {
        String sql = "select * from ct_grant";
        return jdbc.query(sql, this::mapRowToGrant);
    }

    public CTGrant findByGrantNumber(String grant_number) {
        String sql = "select * from ct_grant where grant_number = '" + grant_number + "'";
        List<CTGrant> res = jdbc.query(sql, this::mapRowToGrant);
        if(res.size() == 0) return null;
        return res.get(0);
    }

    public List<CTGrant> findByTrialId(String trial_id) {
        String sql = "select * from ct_grant where trial_id = " + trial_id;
        return jdbc.query(sql, this::mapRowToGrant);
    }

    public List<CTGrant> findByDiseaseFocus(String disease_focus) {
        String sql = "select * from ct_grant where disease_focus = '" + disease_focus + "'";
        return jdbc.query(sql, this::mapRowToGrant);
    }

    public List<CTGrant> findByInstitution(String institution) {
        String sql = "select * from ct_grant where institution = '" + institution + "'";
        return jdbc.query(sql, this::mapRowToGrant);
    }

    public List<CTGrant> findByStemCellUse(String stem_cell_use) {
        String sql = "select * from ct_grant where stem_cell_use = '" + stem_cell_use + "'";
        return jdbc.query(sql, this::mapRowToGrant);
    }

    public List<CTGrant> findByResearcherId(String researcher_id) {
        String sql = "select * from ct_grant G where G.grant_number in (select A.grant_no from awards A where A.researcher_id = " + researcher_id + ")";
        return jdbc.query(sql, this::mapRowToGrant);
    }

    public void addGrant(String researcher_id, ObjectNode grant) {
        String grant_sql = "insert ct_grant values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbc.update(grant_sql,
            grant.get("grant_number").asText(),
            grant.get("grant_title").asText(),
            grant.get("trial_id").asText(),
            grant.get("disease_focus").asText(),
            grant.get("start_date").asText(),
            grant.get("end_date").asText(),
            grant.get("type").asText(),
            grant.get("award_status").asText(),
            grant.get("institution").asText(),
            grant.get("stem_cell_use").asText(),
            grant.get("amount").asDouble());

        // when we add a grant, we also have to take into account adding to awards table due to N to M relationship
        String awards_sql = "insert awards values (?, ?)";
        jdbc.update(awards_sql, grant.get("grant_number").asText(), researcher_id);
    }

    // ResultSet getter strings are the exact column names in schema.sql
    private CTGrant mapRowToGrant(ResultSet rs, int rowNum) throws SQLException {
        CTGrant g = new CTGrant();
        g.setGrant_number(rs.getString("grant_number"));
        g.setGrant_title(rs.getString("grant_title"));
        g.setTrial_id(rs.getString("trial_id"));
        g.setDisease_focus(rs.getString("disease_focus"));
        g.setStart_date(rs.getString("start_date"));
        g.setEnd_date(rs.getString("end_date"));
        g.setType(rs.getString("type"));
        g.setAward_status(rs.getString("award_status"));
        g.setInstitution(rs.getString("institution"));
        g.setStem_cell_use(rs.getString("stem_cell_use"));
        g.setAmount(rs.getDouble("amount"));
        return g;
    }
}