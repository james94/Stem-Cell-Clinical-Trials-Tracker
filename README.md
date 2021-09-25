# Stem Cell Clinical Trials Tracker

Regenerative Medicine Stem Cell Clinical Trials Tracker Database Application.

## Team

- Mu Chen
- James Medel
- Shrisha Hedge
- Evan Yang
- Anupriya Rentala
- Somil Manishkumar Jain

## Data Source

California Institute of Regenerative Medicine

- Small Data Set CIRM Clinical Trials: https://www.cirm.ca.gov/clinical-trials
    - Dataset: Contains 72 records
    - Disease Areas: 19% Blood, 15% Blood Cancers, 14% Neuro, 13% Solid Cancers, 9% Eye
    - Categorical Variables: Disease Areas, Title, Investigator, Organization, Phase, Trial Status, NCT Number, Grant Number, Grant Status, Award Value
    - Continuous Variables: Targeted Enrollment

- Large Data Set CIRM Grants: https://www.cirm.ca.gov/grants


## Action Items

- [ ] Set Up Development Environment
  - [ ] Integrate Frontend & Backend Containers
  - [ ] Frontend Docker Container
    - [ ] JavaScript React.js
  - [ ] Backend Docker Container
    - [ ] Java ODBC
    - [ ] MySQL

- [ ] Create Database: RMSC_Clinical_Trials
- [ ] Create Tables: 
  - [ ] Grant 
  - [ ] Trial
  - [ ] Researcher
  - [ ] Patient
  - [ ] Donor
  - [ ] Organization 
  - [ ] Watchlist
  - [ ] Discussion Forum
- [ ] Researcher Planned Functionality:
  - [ ] Retrieve information about all his/her past and current trials
  - [ ] Create or close description of clinical trial, target enrollment of patients and doctor
  - [ ] View the list of patients or individual patient info based on id in one of his/her trial
  - [ ] Search for a potential patient who has a particular disease (need consent from patient)
  - [ ] Set up a watch list that gets updated from patients interested in trials and receive notifications when patients with specific disease/conditions become available 
  - [ ] Communicate with other researchers in a discussion board
  - [ ] Search for existing patients who are already participating in a doctors trial
  - [ ] Edit patient profile, add or remove patient in a trial
  - [ ] Edit allogeneic or autologous donor profile, add or remove donor from a trial
  - [ ] Register with the site, on the backend, make sure password is encrypted/hashed in DB table, login, create a researcher account by name and organization 

- [ ] Patient Planned Functionality:
  - [ ] Set up a watch list and receive notifications when new trials/grants are available.
  - [ ] Retrieve information on all past and current trials related to the one they’ll participate in
  - [ ] View the list of researchers or individual researcher info by id for their trial
  - [ ] Register on the site, on the backend, make sure password is encrypted/hashed in DB table, login, view their own profile

## Queries

- What are the CIRM Clinical Trials with the largest target enrollment of patient groups?
- Which Disease Area (Brain Cancer, Kidney Failure, etc?) has the most CIRM Clinical Trials for it?
- How many CIRM Grants are available that can still be used for allocating money for a CIRM Clinical Trial? 
- Which grants are there for Brain Cancer, Heart Disease, Kidney Failure, etc?
- Can you share a list of all grants that do not focus on using Embryonic Stem Cells?
- Can you list all grants that focus on Induced Pluripotent Stem Cells?
- Which CIRM Clinical Trials are still recruiting for more patients?
- Which CIRM Clinical Trials target Retinitis Pigmentosa? 
