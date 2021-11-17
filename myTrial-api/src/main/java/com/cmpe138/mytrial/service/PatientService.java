// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.service;

import java.util.List;

import com.cmpe138.mytrial.model.Patient;

public interface PatientService {

	List<Patient> getAll();

	List<Patient> getPatientByResearcherId(String researcher_id);

	/**
	 * For manager using, can get any patient using patient id
	 * 
	 * @param patient_id
	 * @return
	 */
	Patient getPatientById(String patient_id);

	/**
	 * For researcher, can get patients under his patient list
	 * 
	 * @param researcher_id
	 * @param patient_id
	 * @return
	 */
	Patient getPatientById(String researcher_id, String patient_id);

	/**
	 * @param username
	 * @param password
	 * @return
	 */
	Patient getPatientByUsernamePassword(String username, String password);

	void updatePatientUsingPatientID(String disease, String phase, String status, String trial_id, String patient_id);

	List<Patient> getPatientByTrialId(String trial_id);

	/**
	 * For researcher, can delete a patient by patient ID
	 * 
	 * @param patient_id
	 * @return
	 */
	boolean deletePatientById(int patient_id);
}
