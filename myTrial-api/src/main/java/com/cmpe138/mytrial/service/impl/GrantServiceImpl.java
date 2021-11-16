package com.cmpe138.mytrial.service.impl;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.cmpe138.mytrial.model.CTGrant;
import com.cmpe138.mytrial.service.GrantService;
import com.cmpe138.mytrial.repository.GrantRepository;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

@Component
public class GrantServiceImpl implements GrantService {

    @Autowired
    GrantRepository grantRepository;

    public List<CTGrant> getAll() {
        return grantRepository.findAll();
    }
    
    public CTGrant getGrantByNumber(String grant_number) {
        return grantRepository.findByGrantNumber(grant_number);
    }

    public List<CTGrant> getGrantsByTrialId(String trial_id) {
        return grantRepository.findByTrialId(trial_id);
    }

    public List<CTGrant> getGrantsByDiseaseFocus(String disease_focus) {
        return grantRepository.findByDiseaseFocus(disease_focus);
    }

    public List<CTGrant> getGrantsByInstitution(String institution) {
        return grantRepository.findByInstitution(institution);
    }

    public List<CTGrant> getGrantsByStemCellUse(String stem_cell_use) {
        return grantRepository.findByStemCellUse(stem_cell_use);
    }

    public List<CTGrant> getGrantsByResearcherId(String researcher_id) {
        return grantRepository.findByResearcherId(researcher_id);
    }

    public void createGrant(String researcher_id, ObjectNode grant) {
        // grant number primary key [12 letters/numbers - 5 numbers]
        // String first_half = getRandomString(12);
        // String second_half = String.valueOf((int)(Math.random() * 99999));
        String grant_number = getRandomString(12) + "-" + String.valueOf((int)(Math.random() * 99999));
        while(getGrantByNumber(grant_number) != null) {
            grant_number = getRandomString(12) + "-" + String.valueOf((int)(Math.random() * 99999));
        }
        grantRepository.addGrant(researcher_id, grant);
    }

    protected String getRandomString(int required_length) {
        String sampleChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        StringBuilder sample = new StringBuilder();
        Random rand = new Random();
        while(sample.length() < required_length) { // length of random str
            int index = (int)(rand.nextFloat() * sampleChars.length());
            sample.append(sampleChars.charAt(index));
        }
        String sampleStr = sample.toString();
        return sampleStr;
    }
}

