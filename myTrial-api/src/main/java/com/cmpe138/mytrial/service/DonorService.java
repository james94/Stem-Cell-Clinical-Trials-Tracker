//SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.service;

import com.cmpe138.mytrial.model.Donor;

public interface DonorService {
    void createDonor(String patient_id, String name, String email);
    void updateDonorByPatientId(String patient_id, String name, String email);
    Donor getDonorByPatientId(String patient_id);
}
