package com.cmpe138.mytrial.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.Patient;

@Repository
public class PatientRepository {
	@Autowired
	private JdbcTemplate jdbc;

	public List<Patient> findAll() {
		System.out.println("Reached repo");
		String sql = "select * from patient";
		List<Patient> patients = jdbc.query(sql, new BeanPropertyRowMapper<Patient>(Patient.class));
		return patients;
	}

	public Patient getPatientById(String patient_id) {
		System.out.println("Reached repo");
		String sql = "select * from patient where id = ?";
		jdbc.queryForObject(sql, new BeanPropertyRowMapper<Patient>(Patient.class), patient_id);
		return null;
	}

}
