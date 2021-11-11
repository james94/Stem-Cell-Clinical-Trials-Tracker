package com.cmpe138.mytrial.model;

public class Researcher {
	private String researcher_id;
	private String r_name;
	private String r_username;
	private String r_password;

	public String getResearcher_id() {
		return researcher_id;
	}

	public void setResearcher_id(String researcher_id) {
		this.researcher_id = researcher_id;
	}

	public String getR_name() {
		return r_name;
	}

	public void setR_name(String r_name) {
		this.r_name = r_name;
	}

	public String getR_username() {
		return r_username;
	}

	public void setR_username(String r_username) {
		this.r_username = r_username;
	}

	public String getR_password() {
		return r_password;
	}

	public void setR_password(String r_password) {
		this.r_password = r_password;
	}

	@Override
	public String toString() {
		return "Researcher [researcher_id=" + researcher_id + ", r_name=" + r_name + ", r_username=" + r_username
				+ ", r_password=" + r_password + "]";
	}

}
