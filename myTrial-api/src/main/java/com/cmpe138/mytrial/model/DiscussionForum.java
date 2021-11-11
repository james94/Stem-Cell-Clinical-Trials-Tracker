package com.cmpe138.mytrial.model;

import java.util.ArrayList;
import java.util.List;

public class DiscussionForum {
	private int df_id;
	private String df_name;
	private java.sql.Timestamp df_timestamp;
	private String details;
	private String researcher_id;
	private List<Reply> replies = new ArrayList<Reply>();

	public int getDf_id() {
		return df_id;
	}

	public void setDf_id(int df_id) {
		this.df_id = df_id;
	}

	public String getDf_name() {
		return df_name;
	}

	public void setDf_name(String df_name) {
		this.df_name = df_name;
	}

	public java.sql.Timestamp getDf_timestamp() {
		return df_timestamp;
	}

	public void setDf_timestamp(java.sql.Timestamp df_timestamp) {
		this.df_timestamp = df_timestamp;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getResearcher_id() {
		return researcher_id;
	}

	public void setResearcher_id(String researcher_id) {
		this.researcher_id = researcher_id;
	}

	public List<Reply> getReplies() {
		return replies;
	}

	public void setReplies(List<Reply> replies) {
		this.replies = replies;
	}

	@Override
	public String toString() {
		return "DiscussionForum [df_id=" + df_id + ", df_name=" + df_name + ", df_timestamp=" + df_timestamp
				+ ", details=" + details + ", researcher_id=" + researcher_id + ", replies=" + replies + "]";
	}

}
