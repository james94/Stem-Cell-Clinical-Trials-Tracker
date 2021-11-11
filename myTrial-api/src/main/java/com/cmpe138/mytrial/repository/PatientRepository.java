package com.cmpe138.mytrial.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
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
	
	public Patient getPatientByUsernamePassword(String username, String password) {
		String sql = "select * from patient where p_username = ? and p_password = AES_ENCRYPT(?, SHA2('The secret passphrase',512), RANDOM_BYTES(16))";
		try {
			return jdbc.queryForObject(sql, new BeanPropertyRowMapper<Patient>(Patient.class), username, password);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
		
	}
}
