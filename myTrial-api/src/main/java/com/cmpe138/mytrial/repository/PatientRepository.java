//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
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
		String sql = "select * from patient";
		List<Patient> patients = jdbc.query(sql, new BeanPropertyRowMapper<Patient>(Patient.class));
		return patients;
	}

	public Patient getPatientById(String patient_id) {
		String sql = "select * from patient where patient_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<Patient>(Patient.class), patient_id);
	}

	public int createPatient(String disease, String phase, String p_status, String p_username, String p_password, String trial_id, String researcher_id) {
		String sql = "insert patient(disease, phase, p_status, p_username, p_password, trial_id, researcher_id) values (?,?,?,?,?,?,?)";
		return jdbc.update(sql, disease, phase, p_status, p_username, p_password, trial_id, researcher_id);
	}

	public List<Patient> getPatientsByTrialId(String trial_id) {
		String sql = "select * from patient where trial_id = ?";
		List<Patient> patients = jdbc.query(sql, new BeanPropertyRowMapper<Patient>(Patient.class), trial_id);
		return patients;
	}

	public List<Patient> getPatientsByResearcher_id(String researcher_id) {
		String sql = "select * from patient where researcher_id = ?";
		List<Patient> patients = jdbc.query(sql, new BeanPropertyRowMapper<Patient>(Patient.class), researcher_id);
		return patients;
	}

	/**
	 * Patient login
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	public Patient getPatientByUsernamePassword(String username, String password) {
		String sql = "select * from patient where p_username = ? and p_password = AES_ENCRYPT(?, SHA2('The secret passphrase',512), RANDOM_BYTES(16))";
		try {
			return jdbc.queryForObject(sql, new BeanPropertyRowMapper<Patient>(Patient.class), username, password);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	/**
	 * Editing Patient Details
	 * 
	 * @param disease
	 * @param phase
	 * @param status
	 * @param trial_id
	 * @param patient_id
	 * @return
	 */
	public void updatePatientUsingPatientID(String disease, String phase,String status,String trial_id, String patient_id) {
		System.out.println("in the repo, about to prepare the statement");
		String sql = "update patient set disease = ?, phase = ?, p_status = ?, trial_id = ? where patient_id = ?";
		try {
			jdbc.update(sql,disease, phase, status, trial_id, patient_id);
		} catch (DataIntegrityViolationException e) {
			System.out.println("Error data integrity constraint violated when updating record for patient_id = " + patient_id);
		}
	}

	/**
	 * For researcher, can delete a patient by patient ID
	 * @param patient_id
	 * @return
	 */
	public int deletePatientById(int patient_id) {
		String delete_query = "delete from patient where patient_id = ?";
		try {
			System.out.println("Calling delete query for patient record for patient_id = " + patient_id);
			int delete_query_res = jdbc.update(delete_query, patient_id);
			System.out.println("delete_query_res = " + delete_query_res);
			return delete_query_res;
		} catch(Exception e) {
			// Check if patient table has dep on other table like a foreign key
			System.out.println(e);
			System.out.println("Error referential integrity constraint violated when removing record for patient_id = " + patient_id);
		}
		return 0; // 0 rows deleted, but need 1 deleted
	}	
}
