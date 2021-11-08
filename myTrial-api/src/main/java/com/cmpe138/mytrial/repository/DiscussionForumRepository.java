package com.cmpe138.mytrial.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cmpe138.mytrial.model.DiscussionForum;

@Repository
public class DiscussionForumRepository {
	@Autowired
	private JdbcTemplate jdbc;

	public List<DiscussionForum> findAll() {
		System.out.println("Reached repo");
		String sql = "select * from discussion_forum";
		List<DiscussionForum> forums = jdbc.query(sql,
				new BeanPropertyRowMapper<DiscussionForum>(DiscussionForum.class));
		return forums;
	}

	public DiscussionForum getDiscussionById(String df_id) {
		System.out.println("Reached repo");
		String sql = "select * from discussion_forum where df_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<DiscussionForum>(DiscussionForum.class), df_id);
	}

}
