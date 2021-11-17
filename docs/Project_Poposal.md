# SJSU CMPE 138 Fall 2021 TEAM1

# CMPE 180B Project: Proposal

**Title: Stem Cell Clinical Trials App**

## Team 1

- James Medel | Mu Chen | Evan Yang |
- Shrisha Hedge | Somil Manishkumar Jain | Anupriya Rentala

## Members working on proposal

- Mu Chen (Purpose of App, Object/Actors/Roles, Planned Functionality, Scenarios, Edit)
- James Medel (Miniworld, Object/Actors/Roles, Planned Functionality, Scenarios, Edit)
- Shrisha Hegde (Reviewing and proofreading, future scope)
- Evan Yang (Reviewing and proofreading, gave feedback in Object/Actors/Roles)
- Anupriya Rentala (Gave Feedback in Planned Functionality during our team meeting)
- Somil Manishkumar Jain(Merging new functionalities, Scenarios, review)

## Miniworld

Bio Regeneration tracks cutting edge stem cell research data involving CIRM Clinical Trials, CIRM Grants, researchers, organizations, patient groups and any donors to assist doctors in helping patients find the best stem cell therapy. These CIRM Clinical Trials funded by CIRM Grants are investigated by researchers, coming from various organizations, who diagnose patient groups for particular stem cell therapies from autologous to allogeneic stem cells, which treat or prevent a disease or condition.

## Purpose of Application and Intended Users

Our application acts as a helping tool for researchers working on stem cell research to manage all the grants, clinical trials, and patient/donor information. It is also used by patients to decide on which organization and which researcher to opt for the trial.

## Object/Actors/Roles

- **Grant**: The institution that funds awards to researchers and trials.
- **Trial**: Clinical trial in stem cell research
- **Researcher**: The doctor, scientist or investigator of an institution responsible for trial
- **Patient**: The person in a group participating in trial
- **Donor**: The allogeneic or autologous person who donates to a patient
- **Organization**: The company sponsoring some clinical trials for some of its researchers
- **Watchlist**: list in which researchers are updated on patients interested in trials, list in which patients are notified when new trials/grants are available
- **Discussion Forum**: discussion board where researchers communicate

## Planned Functionality and Operations

### Researcher

- Retrieve information about all his/her past and current trials
- Create or close description of clinical trial, targeted enrollment of patients and doctor
- View the list of patients or individual patient info based on id in one of his/her trial
- Search for a potential patient who has a particular disease (need consent from patient)
- Set up a watch list that gets updated from patients interested in trials and receive notifications when patients with specific disease/conditions become available
- Communicate with other researchers in a discussion board
- Search for existing patients who are already participating in a doctors trial
- Edit patient profile, add or remove patient in a trial
- Edit allogeneic or autologous donor profile, add or remove donor from a trial
- Register with the site, on the backend, make sure password is encrypted/hashed in DB table, login, create a researcher account by name and organization

### Patient

- Set up a watch list and receive notifications when new trials/grants are available.
- Retrieve information on all past and current trials related to the one they’ll participate in
- View the list of researchers or individual researcher info by id for their trial
- Register on the site, on the backend, make sure password is encrypted/hashed in DB table, login, view their own profile

## Scenarios

Patient Romero Rodriguez browses the Bio Regeneration web site. He finds information on all past and current stem cell clinical trials that combat sickle cell disease through either autologous or allogeneic donor stem cell gene therapy. He sees these trials are promising. Romero sees a list of researchers associated with these trials. Romero views a certain trial description to find the Lead Researcher Donald Kohn from the UCLA organization. Romero then gets Dr. Kohn’s ID to view this researcher's information. Romero registers on the site, logs into and views his profile.

Dr. Kohn has recently created a new trial, entered the description, targeted enrollment and created a watchlist for patients with the particular disease. He receives a notification that a new patient, Romero Rodriguez whose profile matches the criteria on his watchlist is currently available. Dr. Kohn checks Romero’s profile, and emails him. Once the patient consents, he edits the patient’s profile and adds him to the trial. Romero receives a new notification that he has been enrolled into a trial.

Later Marilyn emails Dr. Kohn that she wants to be a donor for the latest trial that happens to be the one Romero is enrolled in. Dr. Kohn invites her for the standard donor tests. Dr. Kohn looks up the list of patients in his latest trial to see if any of the patients align well with the donor. The test results came back very promising so Dr. Kohn adds Marilyn as an allogeneic donor for Romero’s trial.

New researcher David Williams, working in the same organization as Dr. Kohn wants to start new research. He registers with the site, logs in and creates a researcher account with his name and organization. He comes across the discussion forum for the Bio Regeneration website where other researchers inform him that some older trials for sickle cell disease are coming to a close. He starts a new trial and a patient, Mrs. Chloe Singer receives a notification that a new trial matching her criteria of sickle cell disease has popped up on her watchlist. Dr. Williams searches for potential patients who have the sickle cell disease in a table that is generated after Dr. Williams selects that disease in a dropdown menu. Dr. Williams then emails those who are currently not in trials or their trials are ending soon to ask for their participation in a new trial. Then those who give consent are added into Dr. William’s latest trial.
