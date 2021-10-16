drop database if exists mytrial;
create database mytrial;
-- use mytrial;

-- CREATE Database Objects

-- NOTE: I see NCT_no link to specific CT title
CREATE TABLE trial (
	trial_id varchar(9) not null,
    trial_status varchar(25) not null,
    target_enrollment integer,
    NCT_no char(11),
    phase varchar(5) not null,
    title varchar(300) not null,
    primary key (trial_id)
);

-- NOTE: On CIRM and clinicaltrials.gov, I am seeing each researcher link to a trial
-- by way of NCT_no as the foreign key. Also they can have multiple NCT_nos. For now, using trial_id as fk
-- Ex: https://www.cirm.ca.gov/clinical-trial/phase-3-randomized-placebo-controlled-multicenter-study-evaluate-efficacy-safety
-- Ex: https://clinicaltrials.gov/ct2/show/record/NCT03280056
CREATE TABLE researcher (
    researcher_id varchar(9) not null,
    rname varchar(25) not null,
    trial_id varchar(11) not null,
    primary key (researcher_id),
    foreign key (trial_id) references trial (trial_id)
);

CREATE TABLE p_watchlist (
	patient_id varchar(9) not null,
    name varchar(50) not null,
    primary key (patient_id, name),
    foreign key (patient_id) references patient (patient_id)
);

CREATE TABLE discussion_forum (
    dfname varchar(60) not null,
    df_id varchar(9) not null,
    df_timestamp varchar(10) not null,
    details varchar(600) not null,
    primary key (df_id)
);

CREATE TABLE investigates (
	researcher_id varchar(9) not null,
    trial_id varchar(9) not null,
    primary key (researcher_id, trial_id),
    foreign key (researcher_id) references researcher (researcher_id),
    foreign key (trial_id) references trial (trial_id)
);

CREATE TABLE awards (
    researcher_id varchar(9) not null,
    grant_number varchar(11) not null,
    primary key (researcher_id, grant_number),
    foreign key (researcher_id) references researcher (researcher_id),
    foreign key (grant_number) references cirm_grant (grant_number)
);

--  organization is a reserved word
CREATE TABLE org (
    org_name varchar(300) not null,
    researcher_number int default 0,
    primary key (org_name)
);

CREATE TABLE disease_area (
    researcher_id varchar(9) not null,
    disease_name varchar(300) not null,
    primary key (researcher_id, disease_name),
    foreign key (researcher_id) references researcher (researcher_id)
);

-- INSERT into Database TABLES


-- Gathered researcher rnames, nct_no for trial_id from clinical trials excel sheet
-- NOTE: I did notice a researcher can have multi-value attr for NCT Number
-- They can also work for multiple organizations
INSERT researcher VALUES
('000000001', 'Mark Humayun', 'TID02590692'),
('000000002', 'Tippi MacKenzie', 'TID02986698'),
('000000003', 'Ralph Kern', 'TID03280056'),
('000000004', 'Clive Svendsen', 'TID02943850'),
('000000005', 'Crystal Mackall', 'TID03233854'),
('000000006', 'Thomas  Kipps', 'TID03088878'),
('000000007', 'Bettina Cockroft', 'TID03432364'),
('000000008', 'Edward Kavalerchik', 'TID03925935'),
('000000009', 'Michael Pulsipher', 'TID03475212'),
('000000010', 'Irving Weissman', 'TID02216409'),
('000000011', 'Thomas  Kipps', 'TID02222688'),
('000000012', 'Gayatri Rao', 'TID04525352'),
('000000013', 'Christine Brown', 'TID02208362'),
('000000014', 'Saul Priceman', 'TID03696030'),
('000000015', 'Leo Wang', 'TID04510051'),
('000000016', 'Anthony Gringeri', 'TID02546102'),
('000000017', 'Mark Chao', 'TID02953782'),
('000000018', 'Sophie Deng', 'TID03957954'),
('000000019', 'Xiaokui Zhang', 'TID04365101'),
('000000020', 'Michael Matthay', 'TID03818854'),
('000000021', 'Linda Marban', 'TID02485938'),
('000000022', 'Rachel Smith', 'TID01458405'),
('000000023', 'Mehrdad Abedi', 'TID02797470'),
('000000024', 'Geoff Symonds', 'TID01734850'),
('000000025', 'John Zaia', 'TID02500849'),
('000000026', 'Steven Deeks', 'TID04648046'),
('000000027', 'Vicki Wheelock', 'TID01937923'),
('000000028', 'Jeffrey Lawson', 'TID02644941'),
('000000029', 'Daniel Brennan', 'TID03363945'),
('000000030', 'Everett Meyer', 'TID03943238'),
('000000031', 'Samuel Strober', 'TID00319657'),
('000000032', 'Stephanie Cherqui', 'TID03897361'),
('000000033', 'Joseph Woodard', 'TID04372433'),
('000000034', 'Colleen Delaney', 'TID03301597'),
('000000035', 'Kinnari Patel', 'TID03812263'),
('000000036', 'Steven Dubinett', 'TID03546361'),
('000000037', 'Robert  Dillman', 'TID01875653'),
('000000038', 'Antoni Ribas', 'TID03240861'),
('000000039', 'Matthew Spear', 'TID03288493'),
('000000040', 'Kristen Johnson', 'TID03133676'),
('000000041', 'Nancy Lane', 'TID03197623'),
('000000042', 'Krystof Bankiewicz', 'TID04167540'),
('000000043', 'Michael Lewis', 'TID03145298'),
('000000044', 'Clive Svendsen', 'TID04284293'),
('000000045', 'Henry Klassen', 'TID03073733'),
('000000046', 'Donald Kohn', 'TID02999984'),
('000000047', 'Morton Cowan', 'TID03538899'),
('000000048', 'Stephen Gottschalk', 'TID01512888'),
('000000049', 'Judith  Shizuru', 'TID02963064'),
('000000050', 'David  Williams', 'TID03282656'),
('000000051', 'Joseph Rosenthal', 'TID03249831'),
('000000052', 'Pierre Caudrelier', 'TID04594031'),
('000000053', 'Dennis Slamon', 'TID01954316'),
('000000054', 'Diana Farmer', 'TID04652908'),
('000000055', 'Jane Lebkowski', 'TID01217008'),
('000000056', 'Francois Binette', 'TID02302157'),
('000000057', 'Bijan Nejadnik', 'TID02448641'),
('000000058', 'William Sietsema', 'TID02691247'),
('000000059', 'Peter Stock', 'TID03977662'),
('000000060', 'Howard Foyt', 'TID03163511');

-- Based on NCT_no from CIRM, grabbed dfname from each clinical trial disease area, df_id is from research trial_id
-- df_timestamp is from study actual start date, details from each title of clinicaltrials.gov or title of cirm
INSERT discussion_forum VALUES
('Age-related macular degeneration', 'TID02590692', '2016-02-16', 'Study of Subretinal Implantation of Human Embryonic Stem Cell-Derived RPE Cells in Advanced Dry AMD'),
('Alpha Thalassemia Major', 'TID02986698', '2017-10-05', 'In Utero Hematopoietic Stem Cell Transplantation for Alpha-thalassemia Major (ATM)'),
('Amyotrophic Lateral Sclerosis', 'TID03280056', '2017-08-28', 'Safety and Efficacy of Repeated Administrations of NurOwn in ALS Patients'),
('Amyotrophic Lateral Sclerosis', 'TID02943850', '2017-04-01', 'CNS10-NPC-GDNF for the Treatment of ALS'),
('B cell cancers Leukemia', 'TID03088878', '2018-01-03', 'A Study of Cirmtuzumab and Ibrutinib in Patients With B-Cell Lymphoid Malignancies'),
('Beta Thalassemia', 'TID03432364', '2018-03-29', 'A Study to Assess the Safety, Tolerability, and Efficacy of ST-400 for Treatment of Transfusion-Dependent Beta-thalassemia (TDT)'),
('Blood Cancer', 'TID03925935', '2018-04-24', 'Trial of AB-110 in Adults With Hematologic Malignancies Undergoing Cord Blood Transplantation'),
('Blood Cancer, Bone Marrow Transplant and Viral Infection', 'TID03475212', '2018-06-20', 'Antiviral Cellular Therapy for Enhancing T-cell Reconstitution Before or After Hematopoietic Stem Cell Transplantation (ACES)'),
('Blood Cancer, Solid Tumors', 'TID02216409', '2014-10', 'Clinical Investigation of a Humanized Anti-CD47 Antibody in Targeting Cancer Stem Cells in Hematologic Malignancies and Solid Tumors'),
('Blood Cancer', 'TID02222688', '2014-08-08', 'UC-961 (Cirmtuzumab) in Relapsed or Refractory Chronic Lymphocytic Leukemia'),
('Bone or Cartilage Disease', 'TID04525352', '2021-02-01', 'A Phase I Clinical Trial for a Lentiviral Gene Therapy Targeting the TCIRG1 Gene for Infantile Malignant Osteopetrosis (IMO)'),
('Brain Cancer', 'TID02208362', '2015-05-18', 'Genetically Modified T-cells in Treating Patients With Recurrent or Refractory Malignant Glioma'),
('Brain Cancer, Breast Cancer', 'TID03696030', '2018-08-31', 'HER2-CAR T Cells in Treating Patients With Recurrent Brain or Leptomeningeal Metastases'),
('Brain Cancer', 'TID04510051', '2020-12-04', 'CAR T Cells After Lymphodepletion for the Treatment of IL13Rα2 Positive Recurrent or Refractory Brain Tumors in Children'),
('Brain Cancer' ,'TID02546102', '2015-12', 'Phase 3 Randomized, Double-blind, Controlled Study of ICT-107 in Glioblastoma'),
('Colon Cancer', 'TID02953782', '2016-11-02', 'Study of Magrolimab (Hu5F9-G4) in Combination With Cetuximab in Participants With Solid Tumors and Advanced Colorectal Cancer'),
('Corneal Damage', 'TID03957954', '2020-09-30', 'Stem Cell Therapy for Limbal Stem Cell Deficiency'),
('COVID-19', 'TID04365101', '2020-05-13', 'Natural Killer Cell (CYNK-001) Infusions in Adults With COVID-19 (CYNKCOVID)'),
('COVID-19', 'TID03818854', '2019-11-26', 'Mesenchymal Stromal Cells For Acute Respiratory Distress Syndrome (STAT)'),
('Heart disease associated with Duchenne muscular dystrophy', 'TID02485938', '2016-01', 'Allogeneic Cardiosphere-Derived Cells for Duchenne Muscular Dystrophy Cardiomyopathy'),
('Heart failure', 'TID01458405', '2012-11-13', 'Allogeneic Heart Stem Cells to Achieve Myocardial Regeneration (ALLSTAR)'),
('HIV-related Lymphoma HIV/AIDS', 'TID02797470', '2016-06-23', 'Gene Therapy in Treating Patients With Human Immunodeficiency Virus-Related Lymphoma Receiving Stem Cell Transplant'),
('HIV/AIDS', 'TID01734850', '2013-04', 'Safety Study of a Dual Anti-HIV Gene Transfer Construct to Treat HIV-1 Infection'),
('HIV/AIDS', 'TID02500849', '2016-03-10', 'Safety Study of Zinc Finger Nuclease CCR5-modified Hematopoietic Stem/Progenitor Cells in HIV-1 Infected Patients'),
('HIV/AIDS', 'TID04648046', '2021-03-01', 'Anti-HIV duoCAR-T cell therapy for HIV infection'),
("Huntington's Disease", 'TID01937923', '2013-08', "A Pre-Cellular Therapy Observational Study in Early Huntington's Disease (PRE-CELL)"),
('Kidney Failure', 'TID02644941', '2016-05-24', 'Comparison of the Human Acellular Vessel (HAV) With ePTFE Grafts as Conduits for Hemodialysis'),
('Kidney Failure', 'TID03363945', '2018-03-15', 'Cellular Immunotherapy in Recipients of HLA-matched, Living Donor Kidney Transplants'),
('Kidney Failure', 'TID03943238', '2020-02-01', 'TLI, ATG & Hematopoietic Stem Cell Transplantation and Recipient T Regs Therapy in Living Donor Kidney Transplantation'),
('Kidney Failure', 'TID00319657', '2004-07', 'Kidney and Blood Stem Cell Transplantation That Eliminates Requirement for Immunosuppressive Drugs'),
('Kidney Failure', 'TID03897361', '2019-07-08', 'Stem Cell Gene Therapy for Cystinosis'),
('Leukemia, Acute Myeloid (AML)', 'TID04372433', '2020-09-14', 'IO-202 as Monotherapy in Patients in AML and CMML'),
('Leukemia, Acute Myeloid (AML)', 'TID03301597', '2018-01-24', 'NLA101 in Adults Receiving High Dose Chemotherapy for AML (LAUNCH)'),
('Leukocyte Adhesion Deficiency', 'TID03812263', '2019-08-30', 'A Clinical Trial to Evaluate the Safety and Efficacy of RP-L201 in Subjects With Leukocyte Adhesion Deficiency-I'),
('Lung Cancer', 'TID03546361', '2019-07-08', 'CCL21-Gene Modified Dendritic Cell Vaccine and Pembrolizumab in Treating Patients With Stage IV Non-small Cell Lung Cancer'),
('Melanoma', 'TID01875653', '2014-10', 'Autologous Dendritic Cell-Tumor Cell Immunotherapy for Metastatic Melanoma'),
('Melanoma, Skin cancer', 'TID03240861', '2017-07-26', 'Genetic Re-programming of Stem Cells to Fight Cancer'),
('Multiple Myeloma', 'TID03288493', '2017-09-20', 'P-BCMA-101 Tscm CAR-T Cells in the Treatment of Patients With Multiple Myeloma (MM)'),
('Osteoarthritis', 'TID03133676', '2018-05-02', 'A Study Evaluating the Safety, Pharmacokinetics, and Pharmacodynamics of KA34 in Subjects With Knee Osteoarthritis'),
('Osteonecrosis', 'TID03197623', '2016-10-14', 'Safety and Tolerability of Intravenous LLP2A-Alendronate for Osteopenia Secondary to Glucocorticoids'),
("Parkinson's Disease", 'TID04167540', '2020-04-01', "GDNF Gene Therapy for Parkinson's Disease"),
('Pulmonary Hypertension', 'TID03145298', '2017-10-01', 'Pulmonary Arterial Hypertension Treated with Cardiosphere-Derived Allogeneic Stem Cells'),
('Retinitis Pigmentosa', 'TID04284293', '2021-08', 'Clinical Study to Assess Safety and Efficacy of Subretinal Injection of Human Neural Progenitor Cells for Treatment of Retinitis Pigmentosa'),
('Retinitis Pigmentosa', 'TID03073733', '2020-03-01', 'Safety and Efficacy of Intravitreal Injection of Human Retinal Progenitor Cells in Adults With Retinitis Pigmentosa'),
('ADA-SCID', 'TID02999984', '2016-12-16', 'Efficacy and safety of cryopreserved autologous CD34+ HSC transduced with EFS lentiviral vector encoding for human ADA gene in ADA-SCID subjects'),
('ART-SCID', 'TID03538899', '2018-05-31', 'Autologous Gene Therapy for Artemis-Deficient SCID'),
('Severe Combined Immunodeficiency, X-linked (X-SCID)', 'TID01512888', '2016-08-17', 'Gene Transfer for X-Linked Severe Combined Immunodeficiency in Newly Diagnosed Infants (LVXSCID-ND)'),
('Severe Combined Immunodeficiency, X-linked (X-SCID)', 'TID02963064', '2017-05-20', 'A monoclonal antibody that depletes blood stem cells and enables chemotherapy free transplants'),
('Sickle Cell Disease', 'TID03282656', '2018-02-13', 'Phase 2 Study of Hematopoietic Stem Cell Gene Transfer Inducing Fetal Hemoglobin in Sickle Cell Disease'),
('Sickle Cell Disease', 'TID03249831', '2019-01-04', 'A Blood Stem Cell Transplant for Sickle Cell Disease'),
('Sickle Cell Disease', 'TID04594031', '2021-09-01', 'A Phase 1 Study of ECT-001 Expanded Cord Blood and Myeloablative Regimen with Reduced Toxicity in Patients with Severe Sickle Cell Disease'),
('Solid Tumors', 'TID01954316', '2014-03', 'A Study of CFI-400945 Fumarate in Patients With Advanced Cancer'),
('Spina Bifida', 'TID04652908', '2021-06-21', 'Cellular Therapy for In Utero Repair of Myelomeningocele - The CuRe Trial (CuRe)'),
('Spinal Cord Injury', 'TID01217008', '2010-10', 'Evaluation of Safety and Preliminary Efficacy of Escalating Doses of GRNOPC1 in Subacute Spinal Cord Injury'),
('Spinal Cord Injury', 'TID02302157', '2015-03', 'Dose Escalation Study of AST-OPC1 in Spinal Cord Injury'),
('Stroke', 'TID02448641', '2016-03-08', 'Study of Modified Stem Cells (SB623) in Patients With Chronic Motor Deficit From Ischemic Stroke (ACTIsSIMA)'),
('Type 1 diabetes', 'TID02691247', '2016-02', 'Safety and Efficacy of CLBS03 in Adolescents With Recent Onset Type 1 Diabetes (The Sanford Project T-Rex Study)'),
('Type 1 diabetes', 'TID03977662', '2019-07-01', 'Pancreatic Islets and Parathyroid Gland Co-transplantation for Treatment of Type 1 Diabetes (PARADIGM)'),
('Type 1 diabetes', 'TID03163511', '2017-07-06', 'A Safety, Tolerability, and Efficacy Study of VC-02™ Combination Product in Subjects With Type 1 Diabetes Mellitus and Hypoglycemia Unawareness');
