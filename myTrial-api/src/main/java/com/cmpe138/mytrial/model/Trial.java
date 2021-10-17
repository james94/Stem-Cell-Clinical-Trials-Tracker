package com.cmpe138.mytrial.model;

public class Trial {
	private String trial_id;
	private String trial_status;
	private int target_enrollment;
	private String NCT_no;
	private String phase;
	private String title;
	private String organization_name;
	public String getTrial_id() {
		return trial_id;
	}
	public void setTrial_id(String trial_id) {
		this.trial_id = trial_id;
	}
	public String getTrial_status() {
		return trial_status;
	}
	public void setTrial_status(String trial_status) {
		this.trial_status = trial_status;
	}
	public int getTarget_enrollment() {
		return target_enrollment;
	}
	public void setTarget_enrollment(int target_enrollment) {
		this.target_enrollment = target_enrollment;
	}
	public String getNCT_no() {
		return NCT_no;
	}
	public void setNCT_no(String nCT_no) {
		NCT_no = nCT_no;
	}
	public String getPhase() {
		return phase;
	}
	public void setPhase(String phase) {
		this.phase = phase;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getOrganization_name() {
		return organization_name;
	}
	public void setOrganization_name(String organization_name) {
		this.organization_name = organization_name;
	}
	
	@Override
	public String toString() {
		return "Trial [trial_id=" + trial_id + ", trial_status=" + trial_status + ", target_enrollment="
				+ target_enrollment + ", NCT_no=" + NCT_no + ", phase=" + phase + ", title=" + title
				+ ", organization_name=" + organization_name + "]";
	}
	
}
