package com.cmpe138.mytrial.model;

public class PWatchlist {
	private String name;
	private String patientId;
	private String diseaseArea;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}
	public String getDiseaseArea() {
		return diseaseArea;
	}
	public void setDiseaseArea(String diseaseArea) {
		this.diseaseArea = diseaseArea;
	}
	@Override
	public String toString() {
		return "PWatchlist [name=" + name + ", patientId=" + patientId + ", diseaseArea=" + diseaseArea + "]";
	}
	
}
