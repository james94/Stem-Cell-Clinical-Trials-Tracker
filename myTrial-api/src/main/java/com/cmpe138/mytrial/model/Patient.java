//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.model;

public class Patient {
	private String patient_id;
	private String disease;
	private String phase;
	private String p_status;
	// fk
	private String trial_id;
	private String p_username;
	private String p_password;
	// fk
	private String researcher_id;

	private Trial trial;
	private Researcher researcher;

	public String getPatient_id() {
		return patient_id;
	}

	public void setPatient_id(String patient_id) {
		this.patient_id = patient_id;
	}

	public String getDisease() {
		return disease;
	}

	public void setDisease(String disease) {
		this.disease = disease;
	}

	public String getPhase() {
		return phase;
	}

	public void setPhase(String phase) {
		this.phase = phase;
	}

	public String getP_status() {
		return p_status;
	}

	public void setP_status(String p_status) {
		this.p_status = p_status;
	}

	public String getTrial_id() {
		return trial_id;
	}

	public void setTrial_id(String trial_id) {
		this.trial_id = trial_id;
	}

	public String getP_username() {
		return p_username;
	}

	public void setP_username(String p_username) {
		this.p_username = p_username;
	}

	public String getP_password() {
		return p_password;
	}

	public void setP_password(String p_password) {
		this.p_password = p_password;
	}

	public String getResearcher_id() {
		return researcher_id;
	}

	public void setResearcher_id(String researcher_id) {
		this.researcher_id = researcher_id;
	}

	public Trial getTrial() {
		return trial;
	}

	public void setTrial(Trial trial) {
		this.trial = trial;
	}

	public Researcher getResearcher() {
		return researcher;
	}

	public void setResearcher(Researcher researcher) {
		this.researcher = researcher;
	}

	@Override
	public String toString() {
		return "Patient [patient_id=" + patient_id + ", disease=" + disease + ", phase=" + phase + ", p_status="
				+ p_status + ", trial_id=" + trial_id + ", p_username=" + p_username + ", p_password=" + p_password
				+ ", researcher_id=" + researcher_id + ", trial=" + trial + ", researcher=" + researcher + "]";
	}

}
