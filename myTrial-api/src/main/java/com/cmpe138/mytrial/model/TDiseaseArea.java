//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.model;

public class TDiseaseArea {
	
	private String trial_id;
	private String disease_name;
	public String getTrial_id() {
		return trial_id;
	}
	public void setTrial_id(String trial_id) {
		this.trial_id = trial_id;
	}
	public String getDisease_name() {
		return disease_name;
	}
	public void setDisease_name(String disease_area) {
		this.disease_name = disease_area;
	}
	@Override
	public String toString() {
		return "TDiseaseArea [trial_id=" + trial_id + ", disease_area=" + disease_name + "]";
	}
	
	
}
