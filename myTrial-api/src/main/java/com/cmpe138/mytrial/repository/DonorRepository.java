package com.cmpe138.mytrial.repository;

import com.cmpe138.mytrial.model.DiscussionForum;
import com.cmpe138.mytrial.model.Donor;
import org.springframework.beans.factory.annotation.Autowired;
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
    public Donor getDonorByPatientId(String patient_id) {
        String donor_sql = "SELECT * WHERE patient_id=?";
        return jdbc.queryForObject(donor_sql, new BeanPropertyRowMapper<Donor>(Donor.class), patient_id);
    }
}
