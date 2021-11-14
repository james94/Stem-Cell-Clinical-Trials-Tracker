package com.cmpe138.mytrial.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cmpe138.mytrial.model.Researcher;

@Repository
public class ResearcherRepository {
	@Autowired
	private JdbcTemplate jdbc;

	public List<Researcher> findAll() {
		System.out.println("Reached repo");
		String sql = "select * from researcher";
		List<Researcher> researchers = jdbc.query(sql, new BeanPropertyRowMapper<Researcher>(Researcher.class));
		return researchers;
	}

	public Researcher getResearcherById(String researcher_id) {
		System.out.println("Reached researcher repo:" + researcher_id);
		String sql = "select * from researcher where researcher_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<Researcher>(Researcher.class), researcher_id);
	}
	
	public Researcher getResearcherByUsernamePassword(String username, String password) {
		// AES_ENCRYPT('MDAwMTIz',@key_str,@init_vector)
		String sql = "select * from researcher where r_username = ? and r_password = AES_ENCRYPT(?, SHA2('The secret passphrase',512), RANDOM_BYTES(16))";
		try {
			return jdbc.queryForObject(sql, new BeanPropertyRowMapper<Researcher>(Researcher.class), username, password);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

}
