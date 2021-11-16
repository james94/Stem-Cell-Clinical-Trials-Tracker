package com.cmpe138.mytrial.controller;

import com.cmpe138.mytrial.model.Donor;
import com.cmpe138.mytrial.service.DonorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
public class DonorController {
    @Autowired
    private DonorService myDonor;
    @PostMapping("/add_donor")
    public void createDonor(@RequestHeader(value = "researcher_id", required = false) String researcher_id, @RequestBody Donor donor){
        if(!researcher_id.isEmpty())
            myDonor.createDonor(donor.getPatient_id(), donor.getName(), donor.getEmail());
        else
            System.out.println("Failed to create donor");
    }
    @PostMapping("/update_donor/{patient_id}")
    public void updateDonor(@RequestHeader(value = "researcher_id", required = false) String researcher_id, @PathVariable(value = "patient_id") String patient_id, @RequestBody Donor donor){
        if(!researcher_id.isEmpty())
            myDonor.updateDonorByPatientId(patient_id, donor.getName(), donor.getEmail());
        else
            System.out.println("Failed to create donor");
    }
    @GetMapping("/donor/{patient_id}")
    public Donor getDonor(@PathVariable(value = "patient_id") String patient_id){
        if(!patient_id.isEmpty()) {
            return myDonor.getDonorByPatientId(patient_id);
        } else
            return null;
    }
}
