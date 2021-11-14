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
		String sql = "select * from patient where patient_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<Patient>(Patient.class), patient_id);
	}

	public int createPatient(String disease, String phase, String p_status, String p_username, String p_password, String trial_id, String researcher_id) {
		String sql = "insert patient(disease, phase, p_status, p_username, p_password, trial_id, researcher_id) values (?,?,?,?,?,?,?)";
		return jdbc.update(sql, disease, phase, p_status, p_username, p_password, trial_id, researcher_id);
	}

	public List<Patient> getPatientsByTrialId(String trial_id) {
		String sql = "select * from patient where tiral_id = ?";
		List<Patient> patients = jdbc.query(sql, new BeanPropertyRowMapper<Patient>(Patient.class), trial_id);
		return patients;
	}

	public List<Patient> getPatientsByResearcher_id(String researcher_id) {
		String sql = "select * from patient where researcher_id = ?";
		List<Patient> patients = jdbc.query(sql, new BeanPropertyRowMapper<Patient>(Patient.class), researcher_id);
		return patients;
	}

        // phase: phase,
        // disease: disease,
        // status: status,
        // trial_id: trial_id,
        // researcher_id: researcher_id

	public void updatePatientById(String researcher_id, Patient patient) {
		if(patient.getResearcher_id() == researcher_id) {
			String sql = "update patient set phase = ?, disease = ?, status = ?, trial_id = ? where patient_id = ? and researcher_id = ?";
			jcbc.update(sql, patient.getPhase(), patient.getDisease(), patient.getP_status(), 
				patient.getTrial_id(), patient.getPatient_id(), patient.getResearcher_id());
		}
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
}
