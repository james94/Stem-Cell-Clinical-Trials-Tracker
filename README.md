# Stem Cell Clinical Trials Tracker
<!-- SJSU CMPE 138 Fall 2021 TEAM1 -->

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


## Action Items For Demo

- [x] Set Up Development Environment
  - [x] Integrate Frontend, Middleware & Backend Containers
  - [x] Frontend Docker Container
    - [x] JavaScript React.js
  - [x] Middleware Docker Container
    - [x] Java SpringBoot JDBC
  - [x] Backend Docker Container
    - [x] MySQL

- [x] Create Database: mytrial
- [x] Create Tables and Insert Data for Most: 
  - [x] Grant 
  - [x] Trial
  - [x] Researcher
  - [x] Patient
  - [x] Donor
  - [x] Organization 
  - [x] Watchlist
  - [x] Discussion Forum
- [x] Researcher Planned Functionality:
  - [x] Retrieve information about all his/her past and current trials
  - [x] Create or close description of clinical trial, target enrollment of patients and doctor
  - [x] View the list of patients or individual patient info based on id in one of his/her trial
  - [x] Search for a potential patient who has a particular disease
  - [x] Set up researcher watch list of patients by selecting a disease 
  - [x] Communicate with other researchers in a discussion board
  - [x] Search for existing patients by username
  - [x] Edit and update patient profile 
  - [x] Delete patient from a trial, which also deletes patient
  - [x] Edit and update Donor profile associated with a patient
  - [x] add or remove donor from a patient
  - [x] Register new researcher to system, encrypt password in DB
  - [x] Researcher Login to system with username and password

- [x] Patient Planned Functionality:
  - [x] Set up a patient watch list containing trials for a certain disease
  - [x] MyTrial - Retrieve patient’s certain trial
  - [x] Patient login to system with username and password - encrypted in DB
  - [x] Patient view their own portal

## Queries

- What are the CIRM Clinical Trials with the largest target enrollment of patient groups?
- Which Disease Area (Brain Cancer, Kidney Failure, etc?) has the most CIRM Clinical Trials for it?
- How many CIRM Grants are available that can still be used for allocating money for a CIRM Clinical Trial? 
- Which grants are there for Brain Cancer, Heart Disease, Kidney Failure, etc?
- Can you share a list of all grants that do not focus on using Embryonic Stem Cells?
- Can you list all grants that focus on Induced Pluripotent Stem Cells?
- Which CIRM Clinical Trials are still recruiting for more patients?
- Which CIRM Clinical Trials target Retinitis Pigmentosa? 
