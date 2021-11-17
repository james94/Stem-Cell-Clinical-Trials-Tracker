// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.model;

public class RWatchlist {
	private String name;
	private String researcherId;
	private String diseaseArea;
	private String pUsername;
	private String pId;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getResearcherId() {
		return researcherId;
	}

	public void setResearcherId(String researcherId) {
		this.researcherId = researcherId;
	}

	public String getPUsername() {
		return pUsername;
	}

	public void setPUsername(String pUsername) {
		this.pUsername = pUsername;
	}

	public String getPId() {
		return pId;
	}

	public void setPId(String pId) {
		this.pId = pId;
	}

	public String getDiseaseArea() {
		return diseaseArea;
	}

	public void setDiseaseArea(String diseaseArea) {
		this.diseaseArea = diseaseArea;
	}

	@Override
	public String toString() {
		return "RWatchlist [name=" + name + ", researcherId=" + researcherId + ", diseaseArea=" + diseaseArea
				+ ", pUsername=" + pUsername + ", pId=" + pId + "]";
	}

}
