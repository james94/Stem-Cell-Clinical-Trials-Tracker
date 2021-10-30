package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.Reply;

@Repository
public class ReplyRepository {

	@Autowired
	private JdbcTemplate jdbc;

	public List<Reply> findAll() {
		System.out.println("Reached repo");
		return jdbc.query("select * from reply", this::mapRowToReply);
	}

	public List<Reply> getReplyByResearcherId(String researcher_id) {
		String sql = "select * from reply where researcher_id = ?";
		return jdbc.query(sql, this::mapRowToReply, researcher_id);

	}

	public Reply getReplyById(String reply_id) {
		String sql = "select * from reply where reply_id = ?";
		return jdbc.queryForObject(sql, this::mapRowToReply, reply_id);
	}

	private Reply mapRowToReply(ResultSet rs, int rowNum) throws SQLException {
		Reply reply = new Reply();
		reply.setReply_id(rs.getString("reply_id"));
		reply.setR_timestamp(rs.getTimestamp("r_timestamp"));
		reply.setContent(rs.getString("content"));
		reply.setDf_id(rs.getString("df_id"));
		reply.setResearcher_id(rs.getString("researcher_id"));
		return reply;
	}
}
