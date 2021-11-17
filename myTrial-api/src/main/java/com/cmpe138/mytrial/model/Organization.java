//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.model;

public class Organization {

	public String org_name;

	public String getOrg_name() {
		return org_name;
	}

	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}

	@Override
	public String toString() {
		return "Organization [org_name=" + org_name + "]";
	}

}
