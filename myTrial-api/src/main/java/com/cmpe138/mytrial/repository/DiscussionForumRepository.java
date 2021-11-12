package com.cmpe138.mytrial.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.DiscussionForum;
import com.cmpe138.mytrial.model.Reply;

@Repository
public class DiscussionForumRepository {
	@Autowired
	private JdbcTemplate jdbc;

	public List<DiscussionForum> findAll() {
		System.out.println("Reached repo");
		String sql = "select * from discussion_forum";
		List<DiscussionForum> forums = jdbc.query(sql, new BeanPropertyRowMapper<DiscussionForum>(DiscussionForum.class));
		return forums;
	}

	public DiscussionForum getDiscussionById(int df_id) {
		System.out.println("Reached repo");
		String sql = "select * from discussion_forum d left join reply r on d.df_id = r.df_id where d.df_id = ?";
		return jdbc.query(sql, new ResultSetExtractor<DiscussionForum>() {
			public DiscussionForum extractData(ResultSet rs) throws SQLException, DataAccessException {
				DiscussionForum d = null;
				int row = 0;
				while (rs.next()) {
					if (d == null) {
						d = new DiscussionForumMapper().mapRow(rs, row);
					}
					d.getReplies().add(new ReplyMapper().mapRow(rs, row));
					row++;
				}
				return d;
			}
		}, df_id);
	}

	public List<DiscussionForum> getDiscussionByReasercherId(String researcher_id) {
		List<DiscussionForum> list = new ArrayList<DiscussionForum>();
		String sql = "select * from discussion_forum d left join researcher r on d.researcher_id = r.researcher_id where d.researcher_id = ?";
		list = jdbc.query(sql, new BeanPropertyRowMapper<DiscussionForum>(DiscussionForum.class), researcher_id);
		return list;
	}

	public int addDiscussion(String df_name, String details, String researcher_id) {
		System.out.println("repo: add new discussion topic");
		String sql = "insert discussion_forum (df_name, details, researcher_id) values (?, ?, ?)";
		return jdbc.update(sql, df_name, details, researcher_id);
	}
	
	public int updateDiscussion(int df_id, String df_name, String details) {
		String sql = "update discussion_forum set df_name = ?, details = ? where df_id = ? ";
		return jdbc.update(sql, df_name, details, df_id);
	}
	
	public int deleteDiscussion(int df_id) {
		String sql = "delete from discussion_forum where df_id = ? ";
		return jdbc.update(sql,df_id);
	}

	// RowMapper
	public class DiscussionForumMapper implements RowMapper<DiscussionForum> {
		@Override
		public DiscussionForum mapRow(ResultSet rs, int rowNum) throws SQLException {
			DiscussionForum d = new DiscussionForum();
			d.setDf_id(rs.getInt("df_id"));
			d.setDf_name(rs.getString("df_name"));
			d.setDetails(rs.getString("details"));
			d.setDf_timestamp(rs.getTimestamp("df_timestamp"));
			d.setResearcher_id(rs.getString("researcher_id"));
			return d;
		}
	}

	public class ReplyMapper implements RowMapper<Reply> {
		@Override
		public Reply mapRow(ResultSet rs, int rowNum) throws SQLException {
			Reply r = new Reply();
			r.setReply_id(rs.getInt("reply_id"));
			r.setR_timestamp(rs.getTimestamp("r_timestamp"));
			r.setContent(rs.getString("content"));
			r.setDf_id(rs.getInt("df_id"));
			r.setResearcher_id(rs.getString("researcher_id"));
			return r;
		}
	}

	

}
