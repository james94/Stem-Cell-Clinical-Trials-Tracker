//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.model;

import java.util.ArrayList;
import java.util.List;

public class Researcher {
	private String researcher_id;
	private String r_name;
	private String r_username;
	private String r_password;
	private List<RDiseaseArea> RDiseaseAreas = new ArrayList<RDiseaseArea>();
	private List<DiscussionForum> DiscussionForums = new ArrayList<DiscussionForum>();
	private List<Reply> replies = new ArrayList<Reply>();
	private List<Patient> patients = new ArrayList<Patient>();
	private List<Trial> trials = new ArrayList<Trial>();
	private List<Organization> organizations = new ArrayList<Organization>();
//	private List<RWatchList> RWatchLists = new ArrayList<RWatchList>();

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

	public List<RDiseaseArea> getRDiseaseAreas() {
		return RDiseaseAreas;
	}

	public void setRDiseaseAreas(List<RDiseaseArea> rDiseaseAreas) {
		RDiseaseAreas = rDiseaseAreas;
	}

	public List<DiscussionForum> getDiscussionForums() {
		return DiscussionForums;
	}

	public void setDiscussionForums(List<DiscussionForum> discussionForums) {
		DiscussionForums = discussionForums;
	}

	public List<Reply> getReplies() {
		return replies;
	}

	public void setReplies(List<Reply> replies) {
		this.replies = replies;
	}

	public List<Patient> getPatients() {
		return patients;
	}

	public void setPatients(List<Patient> patients) {
		this.patients = patients;
	}

	public List<Trial> getTrials() {
		return trials;
	}

	public void setTrials(List<Trial> trials) {
		this.trials = trials;
	}

	public List<Organization> getOrganizations() {
		return organizations;
	}

	public void setOrganizations(List<Organization> organizations) {
		this.organizations = organizations;
	}

	@Override
	public String toString() {
		return "Researcher [researcher_id=" + researcher_id + ", r_name=" + r_name + ", r_username=" + r_username + 
				", r_password=" + r_password + ", RDiseaseAreas=" + RDiseaseAreas + ", DiscussionForums=" + DiscussionForums + 
				", replies=" + replies + ", patients=" + patients + ", trials=" + trials + ", organizations=" + organizations + "]";
	}

	

}
