// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cmpe138.mytrial.model.CTGrant;
import com.cmpe138.mytrial.service.GrantService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

@CrossOrigin
@RestController
public class GrantController {

    @Autowired
    private GrantService grantService;

    @GetMapping("/grants")
    public List<CTGrant> getGrants(@RequestHeader(value = "researcher_id", required = false) String researcher_id,
            @RequestHeader(value = "list_all", required = false) boolean list_all,
            @RequestParam(value = "grant_number", required = false) String grant_number,
            @RequestParam(value = "trial_id", required = false) String trial_id,
            @RequestParam(value = "disease_focus", required = false) String disease_focus,
            @RequestParam(value = "institution", required = false) String institution,
            @RequestParam(value = "stem_cell_use", required = false) String stem_cell_use) {
        if ((researcher_id != null) && list_all == true) {
            return grantService.getAll();
        } else if (grant_number != null) {
            List<CTGrant> res = new ArrayList<>();
            res.add(grantService.getGrantByNumber(grant_number));
            return res;
        } else if (trial_id != null) {
            return grantService.getGrantsByTrialId(trial_id);
        } else if (disease_focus != null) {
            return grantService.getGrantsByDiseaseFocus(disease_focus);
        } else if (institution != null) {
            return grantService.getGrantsByInstitution(institution);
        } else if (stem_cell_use != null) {
            return grantService.getGrantsByStemCellUse(stem_cell_use);
        } else if (researcher_id != null) {
            return grantService.getGrantsByResearcherId(researcher_id);
        } else {
            System.out.println("No valid arguments passed in header or parameter returning null");
            return null;
        }
    }

    // TODO: Add Grant
    @PostMapping("/addgrant")
    public ResponseEntity<String> addGrant(@RequestHeader(value = "id") String researcher_id,
            @RequestBody ObjectNode grant) {
        try {
            grantService.createGrant(researcher_id, grant);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>("Grant creation failed!", HttpStatus.BAD_REQUEST);
        }
        System.out.println("Grant creation success!");
        return new ResponseEntity<>("Grant creation success!", HttpStatus.OK);
    }
}