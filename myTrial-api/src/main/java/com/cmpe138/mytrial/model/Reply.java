//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.model;

public class Reply {

	private int reply_id;
	private java.sql.Timestamp r_timestamp;
	private String content;
	private int df_id;
	private String researcher_id;
	private Researcher researcher;

	public int getReply_id() {
		return reply_id;
	}

	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}

	public java.sql.Timestamp getR_timestamp() {
		return r_timestamp;
	}

	public void setR_timestamp(java.sql.Timestamp r_timestamp) {
		this.r_timestamp = r_timestamp;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getDf_id() {
		return df_id;
	}

	public void setDf_id(int df_id) {
		this.df_id = df_id;
	}

	public String getResearcher_id() {
		return researcher_id;
	}

	public void setResearcher_id(String researcher_id) {
		this.researcher_id = researcher_id;
	}

	public Researcher getResearcher() {
		return researcher;
	}

	public void setResearcher(Researcher researcher) {
		this.researcher = researcher;
	}

	@Override
	public String toString() {
		return "Reply [reply_id=" + reply_id + ", r_timestamp=" + r_timestamp + ", content=" + content + ", df_id=" + df_id + ", researcher_id=" + researcher_id + ", researcher=" + researcher + "]";
	}

	
}
