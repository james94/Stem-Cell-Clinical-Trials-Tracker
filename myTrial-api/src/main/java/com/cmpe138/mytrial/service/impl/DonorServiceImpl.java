// SJSU CMPE 138 Fall 2021 TEAM1
package com.cmpe138.mytrial.service.impl;

import com.cmpe138.mytrial.model.Donor;
import com.cmpe138.mytrial.repository.DonorRepository;
import com.cmpe138.mytrial.service.DonorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class DonorServiceImpl implements DonorService {
    @Autowired
    DonorRepository donorRepository;
    @Override
    public void createDonor(String patient_id, String name, String email) {
        donorRepository.createNewDonor(patient_id, name, email);
    }
    @Override
    public void updateDonorByPatientId(String patient_id, String name, String email) {
        donorRepository.updateDonorByPatientId(patient_id, name, email);
    }
    @Override
    public Donor getDonorByPatientId(String patient_id) {
        return donorRepository.getDonorByPatientId(patient_id);
    }
}
