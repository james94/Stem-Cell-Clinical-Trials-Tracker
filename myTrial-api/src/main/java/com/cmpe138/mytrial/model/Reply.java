package com.cmpe138.mytrial.model;

public class Reply {

	public String reply_id;
	public java.sql.Timestamp r_timestamp;
	public String content;
	public String df_id;
	public String researcher_id;

	public String getReply_id() {
		return reply_id;
	}

	public void setReply_id(String reply_id) {
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

	public String getDf_id() {
		return df_id;
	}

	public void setDf_id(String df_id) {
		this.df_id = df_id;
	}

	public String getResearcher_id() {
		return researcher_id;
	}

	public void setResearcher_id(String researcher_id) {
		this.researcher_id = researcher_id;
	}

	@Override
	public String toString() {
		return "Reply [reply_id=" + reply_id + ", r_timestamp=" + r_timestamp + ", content=" + content + ", df_id="
				+ df_id + "]";
	}

}