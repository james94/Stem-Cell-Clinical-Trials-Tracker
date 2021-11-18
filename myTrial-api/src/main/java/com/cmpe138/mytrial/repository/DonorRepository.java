//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.repository;

import com.cmpe138.mytrial.model.DiscussionForum;
import com.cmpe138.mytrial.model.Donor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class DonorRepository {
    @Autowired
    private JdbcTemplate jdbc;

    public void createNewDonor(String patient_id, String name, String email) {
        String donor_sql = "INSERT donor VALUES (?, ?, ?)";
        jdbc.update(donor_sql, name, patient_id, email);
    }
    public void updateDonorByPatientId(String patient_id, String name, String email) {
        String donor_sql = "UPDATE donor SET name=?, email=? where patient_id=?";
        jdbc.update(donor_sql, name, email, patient_id);
    }

    // Check if patient_id is in donor list, return that donor if they exist
    public Donor getDonorByPatientId(String patient_id) {
        String sql = "select * from donor where patient_id = ?";
        try {
            return jdbc.queryForObject(sql, new BeanPropertyRowMapper<Donor>(Donor.class), patient_id);
        } catch (EmptyResultDataAccessException e) {
            System.out.println("If you were expecting to retrieve donor, you didn't: " + e);
            return null;
        }

    }
}
