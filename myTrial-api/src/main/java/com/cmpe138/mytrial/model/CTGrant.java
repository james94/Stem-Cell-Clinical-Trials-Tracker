// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.model;

import java.util.ArrayList;
import java.util.List;

public class CTGrant {
    private String grant_number;
    private String grant_title;
    private String trial_id;
    private String disease_focus;
    private String start_date;
    private String end_date;
    private String type;
    private String award_status;
    private String institution;
    private String stem_cell_use;
    private double amount;

    public String getGrant_number() {
        return grant_number;
    }

    public void setGrant_number(String grant_number) {
        this.grant_number = grant_number;
    }

    public String getGrant_title() {
        return grant_title;
    }

    public void setGrant_title(String grant_title) {
        this.grant_title = grant_title;
    }

    public String getTrial_id() {
        return trial_id;
    }

    public void setTrial_id(String trial_id) {
        this.trial_id = trial_id;
    }

    public String getDisease_focus() {
        return disease_focus;
    }

    public void setDisease_focus(String disease_focus) {
        this.disease_focus = disease_focus;
    }

    public String getStart_date() {
        return start_date;
    }

    public void setStart_date(String start_date) {
        this.start_date = start_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAward_status() {
        return award_status;
    }

    public void setAward_status(String award_status) {
        this.award_status = award_status;
    }

    public String getInstitution() {
        return institution;
    }

    public void setInstitution(String institution) {
        this.institution = institution;
    }

    public String getStem_cell_use() {
        return stem_cell_use;
    }

    public void setStem_cell_use(String stem_cell_use) {
        this.stem_cell_use = stem_cell_use;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    @Override
    public String toString() {
        return "CTGrant [grant_number=" + grant_number + ", grant_title=" + grant_title + ", trial_id=" + trial_id
                + ", disease_focus=" + disease_focus + ", start_date=" + start_date + ", end_date=" + end_date
                + ", type=" + type + ", award_status=" + award_status + ", institution=" + institution
                + ", stem_cell_use=" + stem_cell_use + ", amount=" + amount + "]";
    }

};
