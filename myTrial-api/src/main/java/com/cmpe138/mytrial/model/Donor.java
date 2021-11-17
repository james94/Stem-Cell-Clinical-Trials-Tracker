// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.model;

public class Donor {
    public String patient_id;
    public String name;
    public String email;

    public void setPatient_id(String patient_id) {
        this.patient_id = patient_id;
    }

    public String getPatient_id() {
        return patient_id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    @Override
    public String toString() {
        return "Donor{" + "patient_id='" + patient_id + '\'' + ", name='" + name + '\'' + ", email='" + email + '\''
                + '}';
    }
}
