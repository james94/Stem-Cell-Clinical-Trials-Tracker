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

	public Reply getReplyById(int reply_id) {
		String sql = "select * from reply where reply_id = ?";
		return jdbc.queryForObject(sql, this::mapRowToReply, reply_id);
	}

	public List<Reply> getReplyByDf_id(int df_id) {
		String sql = "select * from reply where df_id = ?";
		return jdbc.query(sql, this::mapRowToReply, df_id);
	}

	public int addReply(String content, int df_id, String researcher_id) {
		String sql = "insert reply (content, df_id, researcher_id) values (?, ?, ?)";
		return jdbc.update(sql, content, df_id, researcher_id);
	}

	public int updateReply(int reply_id, String content) {
		String sql = "update reply set content = ? where reply_id = ?";
		return jdbc.update(sql, content, reply_id);
	}

	public int deleteReply(int reply_id) {
		String sql = "delete from reply where reply_id = ? ";
		return jdbc.update(sql, reply_id);
	}

	private Reply mapRowToReply(ResultSet rs, int rowNum) throws SQLException {
		Reply reply = new Reply();
		reply.setReply_id(rs.getInt("reply_id"));
		reply.setR_timestamp(rs.getTimestamp("r_timestamp"));
		reply.setContent(rs.getString("content"));
		reply.setDf_id(rs.getInt("df_id"));
		reply.setResearcher_id(rs.getString("researcher_id"));
		return reply;
	}

}
