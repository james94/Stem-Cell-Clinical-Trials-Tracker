//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.service;

import java.util.List;
import com.cmpe138.mytrial.model.CTGrant;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

public interface GrantService {
    List<CTGrant> getAll();

    CTGrant getGrantByNumber(String grant_number);

    List<CTGrant> getGrantsByTrialId(String trial_id);

    List<CTGrant> getGrantsByDiseaseFocus(String disease_focus);

    List<CTGrant> getGrantsByInstitution(String institution);

    List<CTGrant> getGrantsByStemCellUse(String stem_cell_use);

    List<CTGrant> getGrantsByResearcherId(String researcher_id);

    void createGrant(String researcher_id, ObjectNode grant);
}