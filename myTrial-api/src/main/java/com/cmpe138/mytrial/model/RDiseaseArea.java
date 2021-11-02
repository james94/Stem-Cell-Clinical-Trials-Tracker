package com.cmpe138.mytrial.model;

public class RDiseaseArea {

	public String researcher_id;
	public String disease_name;

	public String getResearcher_id() {
		return researcher_id;
	}

	public void setResearcher_id(String researcher_id) {
		this.researcher_id = researcher_id;
	}

	public String getDisease_name() {
		return disease_name;
	}

	public void setDisease_name(String disease_name) {
		this.disease_name = disease_name;
	}

	@Override
	public String toString() {
		return "RDiseaseAreas [researcher_id=" + researcher_id + ", disease_name=" + disease_name + "]";
	}

}
