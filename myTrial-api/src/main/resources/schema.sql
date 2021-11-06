drop database if exists mytrial;
create database mytrial;
use mytrial;

-- CREATE Database Objects

--  organization is a reserved word
CREATE TABLE org (
    org_name varchar(300) not null,
    primary key (org_name)
);

-- NOTE: I see NCT_no link to specific CT title
CREATE TABLE trial (
	trial_id varchar(9) not null,
    trial_status varchar(25) not null,
    target_enrollment integer,
    NCT_no char(11),
    phase varchar(10) not null,
    title varchar(300) not null,
    org_name varchar(300),
    primary key (trial_id),
    foreign key (org_name) references org (org_name)
);

CREATE TABLE researcher (
    researcher_id varchar(9) not null,
    r_name varchar(50) not null,
    r_username varchar(30) not null,
    r_password varchar(20) not null,
    primary key (researcher_id)
);

CREATE TABLE patient (
    patient_id varchar(300) not null,
    disease varchar(300) not null,
    phase varchar(20) not null,
    p_status varchar(30) not null,
    trial_id varchar(9) not null,
    p_username varchar(30) not null,
    p_password varchar(20) not null,
    researcher_id varchar(9) not null,
    primary key (patient_id),
    foreign key (trial_id) references trial (trial_id),
    foreign key (researcher_id) references researcher (researcher_id)
);

CREATE TABLE donor (
    patient_id varchar(9) not null,
    name varchar(50) not null,
    email varchar(50),
    primary key (patient_id, name),
    foreign key (patient_id) references patient (patient_id)
);

CREATE TABLE p_watchlist (
    name varchar(50) not null,
    patient_id varchar(9) not null,
    disease_area varchar(300) not null,
    primary key (patient_id, name),
    foreign key (patient_id) references patient (patient_id)
);

CREATE TABLE discussion_forum (
    df_id varchar(9) not null,
    df_name varchar(60) not null,
    df_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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

-- CREATE TABLE awards (
--     grant_no varchar(11) not null,
--     researcher_id varchar(9) not null,
--     primary key (researcher_id, grant_no),
--     foreign key (researcher_id) references researcher (researcher_id),
--     foreign key (grant_no) references ct_grant (grant_no)
-- );

CREATE TABLE r_disease_area (
    researcher_id varchar(9) not null,
    disease_name varchar(300) not null,
    primary key (researcher_id, disease_name),
    foreign key (researcher_id) references researcher (researcher_id)
);

CREATE TABLE reply (
    reply_id      INT NOT NULL AUTO_INCREMENT,
    r_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content       VARCHAR(300),
    df_id         VARCHAR(9),
    researcher_id VARCHAR(9) NOT NULL,
    PRIMARY KEY (reply_id),
    FOREIGN KEY (df_id) REFERENCES discussion_forum(df_id),
    FOREIGN KEY (researcher_id) REFERENCES researcher(researcher_id)
);



CREATE TABLE works_for (
    researcher_id varchar(9) not null,
    org_name varchar(300) not null,
    primary key (researcher_id, org_name),
    foreign key (researcher_id) references researcher (researcher_id),
    foreign key (org_name) references org (org_name)
);

CREATE TABLE t_disease_area (
    trial_id varchar(9) not null,
    disease_name varchar(300) not null,
    primary key (trial_id, disease_name),
    foreign key (trial_id) references trial (trial_id)
);

-- CREATE TABLE ct_grant (
--     grant_number	varchar(8), 
-- 	grant_title		varchar(20), 
--     trial_id		varchar(9) DEFAULT -1, 
-- 	disease_focus	varchar(20),
--     start_date		date,
--     end_date		date,
--     type			varchar(20), 
--     award_status	varchar(20),
--     institution		varchar(20),
--     stem_cell_use	varchar(30),
--     amount			decimal(10,2) check (amount > 0),		
--     primary key (grant_number),
-- 	foreign key (trial_id) references trial(trial_id)
-- 	on delete set default
-- );
-- Changed the datatype for the table as per the input data
CREATE TABLE ct_grant (
    grant_number	varchar(50), 
	grant_title		varchar(100), 
    trial_id		varchar(10) DEFAULT null, 
	disease_focus	varchar(100),
    start_date		date DEFAULT NULL,
    end_date		date DEFAULT NULL,
    type			varchar(50), 
    award_status	varchar(18),
    institution		varchar(50),
    stem_cell_use	varchar(40),
    amount			decimal(15,2) check (amount > 0),
	primary key (grant_number),
	foreign key (trial_id) references trial(trial_id)
	on delete set default);
	
CREATE TABLE r_watchlist (
    name			    varchar(20), 
	researcher_id		varchar(9) DEFAULT -1, 
	disease_area		varchar(20),
	primary key (name, researcher_id),
	foreign key (researcher_id) references researcher(researcher_id)
	on delete set default
);

-- INSERT into Database TABLES
INSERT org VALUES 
       ('Aspen Neuroscience'),
       ('Semma Therapeutics'),
       ('Cal State Univ, Sacramento'),
       ('Lineage Cell Therapeutics Inc.'),
       ('BioTime, Inc.'),
       ('Ankasa Regenerative Therapeutics'),
       ('University of California, San Diego'),
       ('International Society for Stem Cell Research'),
       ('Mosaic Event Management, Inc.'),
       ('Cedars-Sinai Medical Center'),
       ('City College Of San Francisco'),
       ('Human Organ Project'),
       ('Caladrius Biosciences'),
       ('TriFoil Imaging, Inc.'),
       ('Cal State Univ, Long Beach'),
       ('Pasadena City College'),
       ('Humacyte, Inc.'),
       ('Fluidigm Corporation'),
       ('Cellular Dynamics International'),
       ('Capricor, Inc'),
       ('Parkinson\'s Institute'),
       ('GMR Epigenetics'),
       ('Scripps Research Institute'),
       ('Immune-Onc Therapeutics'),
       ('X-Therma Inc.'),
       ('La Jolla Institute for Allergy and Immunology'),
       ('University of California, Riverside'),
       ('International Society for Experimental Hematology'),
       ('International Symposium on Neural Regeneration, Inc.'),
       ('Tippi C. Mackenzie'),
       ('University of California, San Francisco'),
       ('Children\'s Neurobiological Solutions (CNS) Foundation'),
       ('Neurona Therapeutics'),
       ('Keystone Symposia on Molecular and Cellular Biology'),
       ('Numerate, Inc.'),
       ('Palo Alto Veterans Institute for Research'),
       ('Gordon Research Conferences'),
       ('Zenobia Therapeutics'),
       ('SanBio, Inc.'),
       ('Poseida Therapeutics, Inc.'),
       ('University of California, Irvine'),
       ('Benjamin D. Yu'),
       ('The University Corporation at California State University, Northridge'),
       ('University of California, Los Angeles'),
       ('Sanford Burnham Prebys Medical Discovery Institute'),
       ('Stanford University'),
       ('OncoMed Pharmaceuticals, Inc.'),
       ('ImmunoCellular Therapeutics'),
       ('Western University of Health Sciences'),
       ('University of Southern California'),
       ('Cal State Univ, San Bernadino'),
       ('Rumi Scientific CA'),
       ('St. Jude Children\'s Research Hospital'),
       ('Alliance Forum Foundation'),
       ('University of California, Merced'),
       ('Vala Sciences, Inc.'),
       ('Gladstone Institutes, J. David'),
       ('San Diego State University Foundation'),
       ('Loma Linda University'),
       ('Calimmune, Inc.'),
       ('Scaled Biolabs Inc.'),
       ('Lundquist Institute for Biomedical Innovation'),
       ('Biocom Institute'),
       ('Angiocrine Bioscience, Inc.'),
       ('Pathways to Stem Cell Science'),
       ('jCyte, Inc'),
       ('Nohla Therapeutics Inc'),
       ('California Institute of Technology'),
       ('Research for Cure'),
       ('RUNX1 Research Program'),
       ('Buck Institute for Age Research'),
       ('Escape Therapeutics, Inc'),
       ('Children\'s Hospital of Orange County'),
       ('StemCells, Inc.'),
       ('MAX BioPharma, Inc.'),
       ('Sangamo BioSciences, Inc.'),
       ('Cal Poly Pomona'),
       ('ExCellThera Inc.'),
       ('Celularity Inc'),
       ('Scripps Health'),
       ('Gamma Medica-Ideas, Inc.'),
       ('ViaCyte, Inc.'),
       ('Cal Poly Corporation, an Auxiliary of California Polytechnic State University, San Luis Obispo'),
       ('University of California, Santa Barbara'),
       ('International Alliance for Biological Standardization'),
       ('Jasper Therapeutics, Inc.'),
       ('Sanford Consortium for Regenerative Medicine'),
       ('Orchard Therapeutics plc'),
       ('FUJIFILM Cellular Dynamics'),
       ('Samumed, LLC'),
       ('Berkeley City College'),
       ('Humboldt State University Sponsored Programs Foundation'),
       ('Lundquist Institute for Biomedical Innovation at Harbor - UCLA Medical Center'),
       ('Cellular Biomedicine Group, Inc.'),
       ('Ocular Research Symposia Foundation, Inc.'),
       ('Human BioMolecular Research Institute'),
       ('VistaGen Therapeutics, Inc.'),
       ('University of California, Berkeley'),
       ('Children\'s Hospital of Los Angeles'),
       ('San Francisco State University'),
       ('Mohammad Pashmforoush'),
       ('Ali Nsair'),
       ('Medeor Therapeutics, Inc.'),
       ('Boston Children\'s Hospital'),
       ('JDRF International'),
       ('OCTANe Foundation for Innovation'),
       ('UCSF Benioff Children’s Hospital Oakland'),
       ('Calibr'),
       ('BrainStorm Cell Therapeutics'),
       ('Cellerant Therapeutics, Inc.'),
       ('Midwinter Conference of Immunologists'),
       ('Fate Therapeutics, Inc.'),
       ('SJSU Research Foundation'),
       ('University of California, Santa Cruz'),
       ('Vitalant Research Institute'),
       ('Brain Neurotherapy Bio'),
       ('Brain Mapping Foundation'),
       ('The Scintillon Institute'),
       ('Cal State Univ, San Marcos'),
       ('iPierian, Inc.'),
       ('Jackson Labs'),
       ('Reza Ardehali'),
       ('California State University, Channel Islands'),
       ('University of California, Davis'),
       ('City of Hope, Beckman Research Institute'),
       ('American Association of Blood Banks'),
       ('Vitabolus, Inc.'),
       ('Salk Institute for Biological Studies'),
       ('Cal State Univ, Fullerton'),
       ('Rocket Pharmaceuticals, Inc.'),
       ('IQVIA, Inc.'),
       ('Ludwig Institute for Cancer Research'),
       ('Forty Seven Inc.'),
       ('Geron Corporation'),
       ('Childrens Hospital of Oakland Research Institute'),
       ('Cal State Univ, Northridge'),
       ('Humboldt State University'),
       ('Cal State Univ, Channel Island'),
       ('San Jose State University');

       
INSERT trial VALUES
('000000001','Active, not recruiting',16,'NCT02590692','Phase 1','Phase 1 Safety Assessment of CPCB-RPE1, hESC-derived RPE Cell Coated Parylene Membrane Implants, in Patients with Advanced Dry Age Related Macular Degeneration','University of Southern California'),													
('000000002','Recruiting',10,'NCT02986698','Phase 1','In Utero Hematopoietic Stem Cell Transplantation For The Treatment Of Fetuses With Alpha Thalassemia Major','University of California, San Francisco'),													
('000000003','Completed',261,'NCT03280056','Phase 3','A Phase 3, Randomized, Placebo-controlled Multicenter Study to Evaluate Efficacy & Safety of Repeated Administrations of NurOwn® in Patients with ALS','BrainStorm Cell Therapeutics'),													
('000000004','Completed',18,'NCT02943850','Phase 1/2','Progenitor Cells Secreting GDNF for the Treatment of ALS','Cedars-Sinai Medical Center'),													
('000000005','Recruiting',57,'NCT03233854','Phase 1','Phase 1 Study of CD19/CD22 Chimeric Antigen Receptor (CAR) T Cells in Adults with Recurrent or Refractory B Cell Malignancies','Stanford University'),													
('000000006','Recruiting',156,'NCT03088878','Phase 1/2','A Phase 1b/2a Study of the ROR1-Targeting Monoclonal Antibody, Cirmtuzumab, and the Bruton Tyrosine Kinase Inhibitor, Ibrutinib, in B-Cell Cancers','University of California, San Diego'),													
('000000007','Active, not recruiting',6,'NCT03432364','Phase 1/2','A Phase 1/2 Study to Assess the Safety, Tolerability, and Efficacy of ST-400 Autologous HSPC Transplant in Transfusion-dependent β-Thalassemia','Sangamo BioSciences, Inc.'),													
('000000008','Active, not recruiting',10,'NCT03483324','Phase 1','AB-110-001 Phase 1b Trial and Related Activities to Support Clinical Development of AB-110','Angiocrine Bioscience, Inc.'),													
('000000009','Active, not recruiting',42,'NCT03925935','Phase 1','Trial of AB-205 in Adults With Lymphoma Undergoing High-Dose Therapy and Autologous Stem Cell Transplantation','Angiocrine Bioscience, Inc.'),													
('000000010','Active, not recruiting',60,'NCT03475212','Phase 1/2','Antiviral Cellular Therapy for Enhancing T-cell Reconstitution Before or After Hematopoietic Stem Cell Transplantation (ACES)','Children''s Hospital of Los Angeles'),													
('000000011','Completed',88,'NCT02216409','Phase 1','Clinical Investigation of a Humanized Anti-CD47 Antibody in Targeting Cancer Stem Cells in Hematologic Malignancies and Solid Tumors','Stanford University'),													
('000000012','Completed',26,'NCT02222688','Phase 1','Therapeutic Eradication of Cancer Stem Cells with UC-961 (Cirmtuzumab)','University of California, San Diego'),													
('000000013','Recruiting',2,'NCT04525352','Phase 1','A Phase I Clinical Trial for a Lentiviral Gene Therapy Targeting the TCIRG1 Gene for Infantile Malignant Osteopetrosis (IMO)','Rocket Pharmaceuticals, Inc.'),													
('000000014','Recruiting',92,'NCT02208362','Phase 1','Phase I Study of Chimeric Antigen Receptor Engineered Central Memory T cells for the Treatment of Malignant Glioma','City of Hope, Beckman Research Institute'),													
('000000015','Recruiting',39,'NCT03696030','Phase 1','A Phase I Study of Chimeric Antigen Receptor Engineered Stem/Memory T Cells for the Treatment of HER2-Positive Brain Metastases','City of Hope, Beckman Research Institute'),													
('000000016','Recruiting',18,'NCT04510051','Phase 1','Phase I Study of IL13Rα2-Targeting CAR T Cells After Lymphodepletion for Children with Refractory or Recurrent Malignant Brain Tumors','City of Hope, Beckman Research Institute'),													
('000000017','Suspended',414,'NCT02546102','Phase 3','A Phase III randomized double-blind, controlled study of ICT 107 with maintenance temozolomide (TMZ) in newly diagnosed glioblastoma following resection and concomitant TMZ chemoradiotherapy','ImmunoCellular Therapeutics'),													
('000000018','Completed',78,'NCT02953782','Phase 1/2','A Phase 1b/2 Trial of the Anti-CD47 Antibody Hu5F9-G4 in Combination with Cetuximab in Patients with Solid Tumors and Advanced Colorectal Cancer','Forty Seven Inc.'),													
('000000019','Recruiting',20,'NCT03957954','Phase 1','Safety and Feasibility of Cultivated Autologous Limbal Stem Cells for Limbal Stem Cell Deficiency','University of California, Los Angeles'),													
('000000020','Active, not recruiting',86,'NCT04365101','Phase 1/2','A phase I/II study of human placental hematopoietic stem cell derived natural killer cells (CYNK-001) for the treatment of adults with COVID-19','Celularity Inc'),													
('000000021','Launching',null,'','Phase 1','Evaluation and Characterization of SARS-CoV-2 Antibody in Convalescent Volunteer Plasma Donors for Potential Therapeutic Use','City of Hope, Beckman Research Institute'),													
('000000022','Recruiting',120,'NCT03818854','Phase 2','Mesenchymal Stromal Cells for ARDS (COVID positive and COVID negative)','University of California, San Francisco'),													
('000000023','Completed',25,'NCT02485938','Phase 2','Allogeneic Cardiosphere-Derived Cells for Duchenne Muscular Dystrophy Cardiomyopathy','Capricor, Inc'),													
('000000024','Closed',156,'NCT01458405','Phase 2','Allogeneic Cardiac-Derived Stem Cells for Patients Following a Myocardial Infarction','Capricor, Inc'),													
('000000025','Recruiting',18,'NCT02797470','Phase 1/2','Stem Cell Gene Therapy for HIV Mediated by Lentivector Transduced, Pre-selected CD34+ Cells in AIDS lymphoma patients','University of California, Davis'),													
('000000026','Completed',13,'NCT01734850','Phase 1/2','GENE-MODIFIED HEMATOPOIETIC STEM/PROGENITOR CELL BASED THERAPY FOR HIV DISEASE','Calimmune, Inc.'),													
('000000027','Active, not recruiting',12,'NCT02500849','Phase 1','A Phase I, Open-Label Study To Assess The Safety, Feasibility and Engraftment of Zinc Finger Nucleases (ZFN) CCR5 Modified Autologous CD34+ Hematopoietic Stem/Progenitor Cells (SB-728MR-HSPC) with Escalating Doses of Busulfan In HIV-1 (R5) Infected Subjec','City of Hope, Beckman Research Institute'),													
('000000028','Launching',null,'NCT04648046','Phase 1/2','Anti-HIV duoCAR-T cell therapy for HIV infection','University of California, San Francisco'),													
('000000029','Completed',29,'NCT01937923','Phase 1/2','MSC engineered to produce BDNF for the treatment of Huntington''s disease','University of California, Davis'),													
('000000030','Active, not recruiting',355,'NCT02644941','Phase 3','A Human Acellular Vessel in Patients Needing Renal Replacement Therapy: A Comparison with ePTFE Grafts as Conduits for Hemodialysis (HUMANITY)','Humacyte, Inc.'),													
('000000031','Recruiting',240,'NCT03183245','Phase 3','A Phase 3 Study Comparing the Utility of Human Acellular Vessels  to Arteriovenous Fistula in Subjects with End-Stage Renal Disease (California Sites)','Humacyte, Inc.'),													
('000000032','Active, not recruiting',30,'NCT03363945','Phase 3','Cellular Immunotherapy for Induction of Immune Tolerance in HLA Matched Living Donor Kidney Transplant Recipients','Medeor Therapeutics, Inc.'),													
('000000033','Recruiting',22,'NCT03943238','Phase 1','Induction of Tolerance by Combinatorial Therapy w/ Donor Stem Cells and Expanded Recipient Treg cells in HLA-mismatched Kidney Transplant Recipients','Stanford University'),													
('000000034','Active, not recruiting',15,'NCT00319657','Phase 1','Induction of Tolerance to Combined Kidney and Hematopoietic Progenitor Cell Transplants from HLA Haplotype Matched Living Donors','Stanford University'),													
('000000035','Recruiting',6,'NCT03897361','Phase 1/2','Phase 1/2 study for autologous human CD34+ hematopoietic stem cells ex vivo transduced with pCCL-CTNS lentiviral vector for treatment of Cystinosis.','University of California, San Diego'),													
('000000036','Recruiting',287,'NCT03248479','Phase 1','A Phase 1b Trial of Hu5F9-G4 Monotherapy or Hu5F9-G4 in Combination with Azacitidine in Patients with Acute Myeloid Leukemia','Forty Seven Inc.'),													
('000000037','Recruiting',44,'NCT04372433','Phase 1','Phase 1 Clinical Development of IO-202, A First-in-Class Antibody Targeting LILRB4, for the Treatment of AML with Monocytic Differentiation and CMML','Immune-Onc Therapeutics'),													
('000000038','Closed',146,'NCT03301597','Phase 2','A Phase 2 Open-Label, Multi-Center, Randomized, Controlled, Optimal Dose-Finding Study of DCC-UCB in Adults Receiving High Dose Chemotherapy for AML','Nohla Therapeutics Inc'),													
('000000039','Recruiting',9,'NCT03812263','Phase 1/2','A Clinical Trial to Evaluate the Safety and Efficacy of RP-L201 in Subjects With Leukocyte Adhesion Deficiency-I','Rocket Pharmaceuticals, Inc.'),													
('000000040','Recruiting',24,'NCT03546361','Phase 1','A phase I trial of intratumoral administration of CCL21-gene modified dendritic cell (DC) combined with intravenous pembrolizumab for advanced NSCLC','University of California, Los Angeles'),													
('000000041','Closed',4,'NCT01875653','Phase 3','Tumor stem cell-targeted immunotherapy for metastatic melanoma –a randomized phase 3 clinical trial.','Caladrius Biosciences'),													
('000000042','Recruiting',12,'NCT03240861','Phase 1','Genetic Re-programming of Stem Cells to Fight Cancer','University of California, Los Angeles'),													
('000000043','Recruiting',220,'NCT03288493','Phase 1','Clinical Study of T stem cell memory (Tscm)-based CAR-T cells in Patients with Multiple Myeloma','Poseida Therapeutics, Inc.'),													
('000000044','Completed',60,'NCT03133676','Phase 1','Evaluation of the Safety and Tolerability of KA34 in a Phase 1, Double-Blind, Dose Escalation Trial in Patients with Knee Osteoarthritis','Calibr'),													
('000000045','Active, not recruiting',59,'NCT03197623','Phase 1/2','Treatment of non-traumatic osteonecrosis with endogenous Mesenchymal stem cells','University of California, Davis'),													
('000000046','Recruiting',12,'NCT04167540','Phase 1','A Phase 1b Safety Study for MRI guided delivery of AAV2-GDNF for the treatment of Parkinson’s disease','Brain Neurotherapy Bio'),													
('000000047','Recruiting',26,'NCT03145298','Phase 1/2','Pulmonary Arterial Hypertension Treated with Cardiosphere-Derived Allogeneic Stem Cells','Cedars-Sinai Medical Center'),													
('000000048','Recruiting',16,'NCT04284293','Phase 1','Clinical Study to Assess Safety and Efficacy of Subretinal Injection of Human Neural Progenitor Cells for Treatment of Retinitis Pigmentosa','Cedars-Sinai Medical Center'),													
('000000049','Completed',84,'NCT03073733','Phase 2','A Phase 2 Study of the Safety of Repeat Intravitreal Injection of Human Retinal Progenitor Cells (jCell) in Adult Subjects with Retinitis Pigmentosa','jCyte, Inc'),													
('000000050','Completed',84,'NCT03073733','Phase 2','Phase 2b Clinical Study of Safety and Efficacy of Intravitreal Injection of Retinal Progenitor Cells (jCell)  for Treatment of Retinitis Pigmentosa','jCyte, Inc'),													
('000000051','Completed',28,'NCT02320812','Phase 1/2','Retinal progenitor cells for treatment of retinitis pigmentosa','University of California, Irvine'),																									
('000000053','Completed',10,'NCT02999984','Phase 2','Efficacy and safety of cryopreserved autologous CD34+ HSC transduced with EFS lentiviral vector encoding for human ADA gene in ADA-SCID subjects','University of California, Los Angeles'),													
('000000054','Recruiting',15,'NCT03538899','Phase 1','Gene Transfer for Artemis-Deficient Severe Combined Immunodeficiency Using a Lentiviral Vector to Transduce Autologous CD34 Hematopoietic Stem Cells','University of California, San Francisco'),													
('000000055','Recruiting',28,'NCT01512888','Phase 1/2','Lentiviral Gene Therapy for Infants with X-linked Severe Combined Immunodeficiency using Autologous Bone Marrow Stem Cells and Busulfan Conditioning','St. Jude Children''s Research Hospital'),													
('000000056','Recruiting',40,'NCT02963064','Phase 1/2','A monoclonal antibody that depletes blood stem cells and enables chemotherapy free transplants','Stanford University'),													
('000000057','Suspended',15,'NCT03282656','Phase 2','Phase 2 Study of Hematopoietic Stem Cell Gene Transfer Inducing Fetal Hemoglobin in Sickle Cell Disease','Boston Children''s Hospital'),													
('000000058','Recruiting',6,'NCT03249831','Phase 1','Treatment of sickle cell disease by induction of  mixed chimerism and immune tolerance using CD4+ T-depleted haploidentical blood stem cell transplant','City of Hope, Beckman Research Institute'),													
('000000059','Not yet recruiting',12,'NCT04594031','Phase 1','A Phase 1 Study of ECT-001 Expanded Cord Blood and Myeloablative Regimen with Reduced Toxicity in Patients with Severe Sickle Cell Disease','ExCellThera Inc.'),													
('000000060','Active, not recruiting',6,'NCT02247843','Phase 1','Clinical Trial of Stem Cell Gene Therapy for Sickle Cell Disease','University of California, Los Angeles'),													
('000000061','Active, not recruiting',48,'NCT01954316','Phase 1','A Phase I dose escalation and expansion clinical trial of the novel first-in-class Polo-like Kinase 4 (PLK4) inhibitor, CFI-400945 in patients with advanced solid tumors','University of California, Los Angeles'),													
('000000062','Recruiting',35,'NCT04652908','Phase 1','The CuRe Trial: Cellular Therapy for In Utero Myelomeningocele Repair','University of California, Davis'),													
('000000063','Completed',5,'NCT01217008','Phase 1','Evaluation of Safety and Preliminary Efficacy of Escalating Doses of GRNOPC1 in Subacute Spinal Cord Injury','Geron Corporation'),													
('000000064','Completed',25,'NCT02302157','Phase 1/2','A Phase I/IIa Dose Escalation Safety Study of AST-OPC1 in Patients with Cervical Sensorimotor Complete Spinal Cord Injury','Lineage Cell Therapeutics Inc.'),													
('000000065','Completed',163,'NCT02448641','Phase 2','A Double-Blind, Controlled Ph 2b Study of the Safety and Efficacy of Modified Stem Cells in Patients with Chronic Motor Deficit from Ischemic Stroke','SanBio, Inc.'),													
('000000066','Completed',113,'NCT02691247','Phase 2','Phase 2 Safety and Efficacy Study of CLBS03 Autologous T-Regulatory Cells in Adolescents with Recent Onset Type 1 Diabetes Mellitus','Caladrius Biosciences'),													
('000000067','Recruiting',8,'NCT03977662','Phase 1/2','Pancreatic Islet and PARAthyroid Co-Transplantation for Treatment of Diabetes in IntraMuscular Site: PARADIGM','University of California, San Francisco'),													
('000000068','Active, not recruiting',69,'NCT02239354','Phase 1/2','Preclinical and clinical testing of a stem cell-based combination product for insulin-dependent diabetes','ViaCyte, Inc.'),													
('000000069','Recruiting',75,'NCT03163511','Phase 1/2','Clinical trial of directly vascularized islet cell replacement therapy for high-risk type 1 diabetes','ViaCyte, Inc.'),													
('000000070','Active, not recruiting',10,'NCT02234934','Phase 1/2','A Phase I/II, Non Randomized, Multicenter, Open-Label Study of G1XCGD (Lentiviral Vector Transduced CD34+ Cells) in Patients With X-Linked Chronic Granulomatous Disease','University of California, Los Angeles');												


INSERT researcher VALUES
('000000001','Hideho Okada','HidehoOkada','MDAwMTIz'),				
('000000002','Lili Yang','LiliYang','MDAwMTIz'),				
('000000003','Cristina Puig Saus','CristinaPuigSaus','MDAwMTIz'),				
('000000004','Leo Wang','LeoWang','MDAwMTIz'),				
('000000005','Joseph Woodard','JosephWoodard','MDAwMTIz'),				
('000000006','Diana Farmer','DianaFarmer','MDAwMTIz'),				
('000000007','Dan Kaufman','DanKaufman','MDAwMTIz'),				
('000000008','Donald Kohn','DonaldKohn','MDAwMTIz'),				
('000000009','Eiji Yoshihara','EijiYoshihara','MDAwMTIz'),				
('000000010','Aline Betancourt','AlineBetancourt','MDAwMTIz'),				
('000000011','Mathew Blurton-Jones','MathewBlurton-Jones','MDAwMTIz'),				
('000000012','Justin Ichida','JustinIchida','MDAwMTIz'),				
('000000013','Robert Hunt','RobertHunt','MDAwMTIz'),				
('000000014','Stanley Carmichael','StanleyCarmichael','MDAwMTIz'),				
('000000015','Tariq Rana','TariqRana','MDAwMTIz'),				
('000000016','Yanhong Shi','YanhongShi','MDAwMTIz'),				
('000000017','David  Williams','DavidWilliams','MDAwMTIz'),				
('000000018','Steven Deeks','StevenDeeks','MDAwMTIz'),				
('000000019','Gayatri Rao','GayatriRao','MDAwMTIz'),				
('000000020','Mark  Tuszynski','MarkTuszynski','MDAwMTIz'),				
('000000021','Helen Blau','HelenBlau','MDAwMTIz'),				
('000000022','Kevin Healy','KevinHealy','MDAwMTIz'),				
('000000023','Brian Cummings','BrianCummings','MDAwMTIz'),				
('000000024','Karen Christman','KarenChristman','MDAwMTIz'),				
('000000025','Cory Nicholas','CoryNicholas','MDAwMTIz'),				
('000000026','Daniela Bota','DanielaBota','MDAwMTIz'),				
('000000027','Evan Snyder','EvanSnyder','MDAwMTIz'),				
('000000028','Steve Dowdy','SteveDowdy','MDAwMTIz'),				
('000000029','Xiaokui Zhang','XiaokuiZhang','MDAwMTIz'),				
('000000030','PREET Chaudhary','PREETChaudhary','MDAwMTIz'),				
('000000031','Song  Li','SongLi','MDAwMTIz'),				
('000000032','Vaithilingaraja Arumugaswami','VaithilingarajaArumugaswami','MDAwMTIz'),				
('000000033','Jianhua Yu','JianhuaYu','MDAwMTIz'),				
('000000034','Albert Wong','AlbertWong','MDAwMTIz'),				
('000000035','Caroline Kuo','CarolineKuo','MDAwMTIz'),				
('000000036','Stuart Lipton','StuartLipton','MDAwMTIz'),				
('000000037','Michael Matthay','MichaelMatthay','MDAwMTIz'),				
('000000038','Pierre Caudrelier','PierreCaudrelier','MDAwMTIz'),				
('000000039','Brigitte Gomperts','BrigitteGomperts','MDAwMTIz'),				
('000000040','Gay Crooks','GayCrooks','MDAwMTIz'),				
('000000041','John Zaia','JohnZaia','MDAwMTIz'),				
('000000042','Hiromitsu Nakauchi','HiromitsuNakauchi','MDAwMTIz'),				
('000000043','Gerhard Bauer','GerhardBauer','MDAwMTIz'),				
('000000044','Yvonne Chen','YvonneChen','MDAwMTIz'),				
('000000045','Rosa Bacchetta','RosaBacchetta','MDAwMTIz'),				
('000000046','Henry Klassen','HenryKlassen','MDAwMTIz'),				
('000000047','Clive Svendsen','CliveSvendsen','MDAwMTIz'),				
('000000048','Sophie Deng','SophieDeng','MDAwMTIz'),				
('000000049','Krystof Bankiewicz','KrystofBankiewicz','MDAwMTIz'),				
('000000050','Karen Aboody','KarenAboody','MDAwMTIz'),				
('000000051','Saul Priceman','SaulPriceman','MDAwMTIz'),				
('000000052','Mark Humayun','MarkHumayun','MDAwMTIz'),				
('000000053','Mehrdad Abedi','MehrdadAbedi','MDAwMTIz'),				
('000000054','Stephanie Cherqui','StephanieCherqui','MDAwMTIz'),				
('000000055','Peter Stock','PeterStock','MDAwMTIz'),				
('000000056','Andres Bratt-Leal','AndresBratt-Leal','MDAwMTIz'),				
('000000057','Mark Walters','MarkWalters','MDAwMTIz'),				
('000000058','Theodore  Nowicki','TheodoreNowicki','MDAwMTIz'),				
('000000059','Kinnari Patel','KinnariPatel','MDAwMTIz'),				
('000000060','Bianca Mothe','BiancaMothe','MDAwMTIz'),				
('000000061','Ying Zhu','YingZhu','MDAwMTIz'),				
('000000062','Judith  Shizuru','JudithShizuru','MDAwMTIz'),				
('000000063','Wendy Pang','WendyPang','MDAwMTIz'),				
('000000064','Leslie Thompson','LeslieThompson','MDAwMTIz'),				
('000000065','Everett Meyer','EverettMeyer','MDAwMTIz'),				
('000000066','Edward Kavalerchik','EdwardKavalerchik','MDAwMTIz'),				
('000000067','Victoria Fox','VictoriaFox','MDAwMTIz'),				
('000000068','Karin Gaensler','KarinGaensler','MDAwMTIz'),				
('000000069','Steven Schwartz','StevenSchwartz','MDAwMTIz'),				
('000000070','Theodore Leng','TheodoreLeng','MDAwMTIz'),				
('000000071','Jonathan Lin','JonathanLin','MDAwMTIz'),				
('000000072','Tracy  Grikscheit','TracyGrikscheit','MDAwMTIz'),				
('000000073','Philip Beachy','PhilipBeachy','MDAwMTIz'),				
('000000074','Neil Segil','NeilSegil','MDAwMTIz'),				
('000000075','Alan Cheng','AlanCheng','MDAwMTIz'),				
('000000076','Xiuli  Wang','XiuliWang','MDAwMTIz'),				
('000000077','Devon Shedlock','DevonShedlock','MDAwMTIz'),				
('000000078','Katja Weinacht','KatjaWeinacht','MDAwMTIz'),				
('000000079','Eric Adler','EricAdler','MDAwMTIz'),				
('000000080','Li Gan','LiGan','MDAwMTIz'),				
('000000081','Ronald Evans','RonaldEvans','MDAwMTIz'),				
('000000082','Steven Dubinett','StevenDubinett','MDAwMTIz'),				
('000000083','Farhad Parhami','FarhadParhami','MDAwMTIz'),				
('000000084','Bertha Chen','BerthaChen','MDAwMTIz'),				
('000000085','Magdalene Seiler','MagdaleneSeiler','MDAwMTIz'),				
('000000086','Henry Erlich','HenryErlich','MDAwMTIz'),				
('000000087','Steven Mack','StevenMack','MDAwMTIz'),				
('000000088','Morton Cowan','MortonCowan','MDAwMTIz'),				
('000000089','Crystal Mackall','CrystalMackall','MDAwMTIz'),				
('000000090','Bettina Cockroft','BettinaCockroft','MDAwMTIz'),				
('000000091','Bob Valamehr','BobValamehr','MDAwMTIz'),				
('000000092','Joseph Rosenthal','JosephRosenthal','MDAwMTIz'),				
('000000093','Daniel Brennan','DanielBrennan','MDAwMTIz'),				
('000000094','Thale Jarvis','ThaleJarvis','MDAwMTIz'),				
('000000095','David Rowitch','DavidRowitch','MDAwMTIz'),				
('000000096','Glori Rosenson','GloriRosenson','MDAwMTIz'),				
('000000097','Cathy Vijeh','CathyVijeh','MDAwMTIz'),				
('000000098','Joseph Wu','JosephWu','MDAwMTIz'),				
('000000099','Xiaoping Hu','XiaopingHu','MDAwMTIz'),				
('000000100','John Adams','JohnAdams','MDAwMTIz'),				
('000000101','Tannishtha Reya','TannishthaReya','MDAwMTIz'),				
('000000102','Scott Kitchen','ScottKitchen','MDAwMTIz'),				
('000000103','Shuvo Roy','ShuvoRoy','MDAwMTIz'),				
('000000104','Aileen Anderson','AileenAnderson','MDAwMTIz'),				
('000000105','Saswati Chatterjee','SaswatiChatterjee','MDAwMTIz'),				
('000000106','Yang Xu','YangXu','MDAwMTIz'),				
('000000107','Alan Agulnick','AlanAgulnick','MDAwMTIz'),				
('000000108','Kyle Loh','KyleLoh','MDAwMTIz'),				
('000000109','April Pyle','AprilPyle','MDAwMTIz'),				
('000000110','Julia Unternaehrer-Hamm','JuliaUnternaehrer-Hamm','MDAwMTIz'),				
('000000111','Alice Tarantal','AliceTarantal','MDAwMTIz'),				
('000000112','Ngan Huang','NganHuang','MDAwMTIz'),				
('000000113','David Baylink','DavidBaylink','MDAwMTIz'),				
('000000114','Dmitriy Sheyn','DmitriySheyn','MDAwMTIz'),				
('000000115','Vicki Nienaber','VickiNienaber','MDAwMTIz'),				
('000000116','Alireza Moshaverinia','AlirezaMoshaverinia','MDAwMTIz'),				
('000000117','Anthony Oro','AnthonyOro','MDAwMTIz'),				
('000000118','Karl Wahlin','KarlWahlin','MDAwMTIz'),				
('000000119','Catriona Jamieson','CatrionaJamieson','MDAwMTIz'),				
('000000120','Semil Choksi','SemilChoksi','MDAwMTIz'),				
('000000121','Guillem Pratx','GuillemPratx','MDAwMTIz'),				
('000000122','Alyssa Panitch','AlyssaPanitch','MDAwMTIz'),				
('000000123','Gerald Morris','GeraldMorris','MDAwMTIz'),				
('000000124','John Cashman','JohnCashman','MDAwMTIz'),				
('000000125','Kristen Johnson','KristenJohnson','MDAwMTIz'),				
('000000126','Michael Pulsipher','MichaelPulsipher','MDAwMTIz'),				
('000000127','Matthew Spear','MatthewSpear','MDAwMTIz'),				
('000000128','Timothy Babich','TimothyBabich','MDAwMTIz'),				
('000000129','George Hara','GeorgeHara','MDAwMTIz'),				
('000000130','Matthew Porteus','MatthewPorteus','MDAwMTIz'),				
('000000131','Colleen Delaney','ColleenDelaney','MDAwMTIz'),				
('000000132','Howard Foyt','HowardFoyt','MDAwMTIz'),				
('000000133','Jeffrey Lawson','JeffreyLawson','MDAwMTIz'),				
('000000134','Christine Brown','ChristineBrown','MDAwMTIz'),				
('000000135','Thomas  Kipps','ThomasKipps','MDAwMTIz'),				
('000000136','Anthony Lubiniecki','AnthonyLubiniecki','MDAwMTIz'),				
('000000137','Ezra Cohen','EzraCohen','MDAwMTIz'),				
('000000138','Ralph Kern','RalphKern','MDAwMTIz'),				
('000000139','Esther Latres','EstherLatres','MDAwMTIz'),				
('000000140','Holger Willenbring','HolgerWillenbring','MDAwMTIz'),				
('000000141','Bijan Nejadnik','BijanNejadnik','MDAwMTIz'),				
('000000142','Tippi MacKenzie','TippiMacKenzie','MDAwMTIz'),				
('000000143','Yuan Chen','YuanChen','MDAwMTIz'),				
('000000144','Mark Mercola','MarkMercola','MDAwMTIz'),				
('000000145','Deborah Lieu','DeborahLieu','MDAwMTIz'),				
('000000146','Xiaoxi Wei','XiaoxiWei','MDAwMTIz'),				
('000000147','Ali Brivanlou','AliBrivanlou','MDAwMTIz'),				
('000000148','Markus Müschen','MarkusMüschen','MDAwMTIz'),				
('000000149','Gary  Steinberg','GarySteinberg','MDAwMTIz'),				
('000000150','Justin Cooper-White','JustinCooper-White','MDAwMTIz'),				
('000000151','Swapna Panuganti','SwapnaPanuganti','MDAwMTIz'),				
('000000152','Biju Thomas','BijuThomas','MDAwMTIz'),				
('000000153','Sonja Schrepfer','SonjaSchrepfer','MDAwMTIz'),				
('000000154','Alessandra Sacco','AlessandraSacco','MDAwMTIz'),				
('000000155','Janet Baulch','JanetBaulch','MDAwMTIz'),				
('000000156','Naynesh Kamani','NayneshKamani','MDAwMTIz'),				
('000000157','Samuel Strober','SamuelStrober','MDAwMTIz'),				
('000000158','Song Li','SongLi','MDAwMTIz'),				
('000000159','Jack Wang','JackWang','MDAwMTIz'),				
('000000160','William Sietsema','WilliamSietsema','MDAwMTIz'),				
('000000161','Stephen Gottschalk','StephenGottschalk','MDAwMTIz'),				
('000000162','Tejal Desai','TejalDesai','MDAwMTIz'),				
('000000163','Roel Nusse','RoelNusse','MDAwMTIz'),				
('000000164','Deepak Srivastava','DeepakSrivastava','MDAwMTIz'),				
('000000165','Birgitt Schuele','BirgittSchuele','MDAwMTIz'),				
('000000166','John Chute','JohnChute','MDAwMTIz'),				
('000000167','Julie Sneddon','JulieSneddon','MDAwMTIz'),				
('000000168','Alysson Muotri','AlyssonMuotri','MDAwMTIz'),				
('000000169','Denis Evseenko','DenisEvseenko','MDAwMTIz'),				
('000000170','Yadong Huang','YadongHuang','MDAwMTIz'),				
('000000171','Paul Salvaterra','PaulSalvaterra','MDAwMTIz'),				
('000000172','Michael Lewis','MichaelLewis','MDAwMTIz'),				
('000000173','Leslie Meltzer','LeslieMeltzer','MDAwMTIz'),				
('000000174','Ralph Feuer','RalphFeuer','MDAwMTIz'),				
('000000175','Eugene Brandon','EugeneBrandon','MDAwMTIz'),				
('000000176','Christel Uittenbogaart','ChristelUittenbogaart','MDAwMTIz'),				
('000000177','Robert Sah','RobertSah','MDAwMTIz'),				
('000000178','Shibani Pati','ShibaniPati','MDAwMTIz'),				
('000000179','David Schaffer','DavidSchaffer','MDAwMTIz'),				
('000000180','David Segal','DavidSegal','MDAwMTIz'),				
('000000181','Jeanne Loring','JeanneLoring','MDAwMTIz'),				
('000000182','David Baltimore','DavidBaltimore','MDAwMTIz'),				
('000000183','Kevin D''Amour','KevinD''Amour','MDAwMTIz'),				
('000000184','Peter Robinson','PeterRobinson','MDAwMTIz'),				
('000000185','Jacob Corn','JacobCorn','MDAwMTIz'),				
('000000186','Arjun Deb','ArjunDeb','MDAwMTIz'),				
('000000187','Linda Cambier','LindaCambier','MDAwMTIz'),				
('000000188','Phillip Yang','PhillipYang','MDAwMTIz'),				
('000000189','Bennett Novitch','BennettNovitch','MDAwMTIz'),				
('000000190','Andrew Brack','AndrewBrack','MDAwMTIz'),				
('000000191','Owen Witte','OwenWitte','MDAwMTIz'),				
('000000192','Jeffrey Goldberg','JeffreyGoldberg','MDAwMTIz'),				
('000000193','Marcus Muench','MarcusMuench','MDAwMTIz'),				
('000000194','Senta Georgia','SentaGeorgia','MDAwMTIz'),				
('000000195','Dionicio Siegel','DionicioSiegel','MDAwMTIz'),				
('000000196','David Traver','DavidTraver','MDAwMTIz'),				
('000000197','Peter  Butler','PeterButler','MDAwMTIz'),				
('000000198','Joseph Anderson','JosephAnderson','MDAwMTIz'),				
('000000199','Linda Marban','LindaMarban','MDAwMTIz'),				
('000000200','Lawrence Goldstein','LawrenceGoldstein','MDAwMTIz'),				
('000000201','Felicia Pagliuca','FeliciaPagliuca','MDAwMTIz'),				
('000000202','Jennifer Puck','JenniferPuck','MDAwMTIz'),				
('000000203','Ron Johnson','RonJohnson','MDAwMTIz'),				
('000000204','Paul Finnegan','PaulFinnegan','MDAwMTIz'),				
('000000205','Nitika Parmar','NitikaParmar','MDAwMTIz'),				
('000000206','Katherine Nielsen','KatherineNielsen','MDAwMTIz'),				
('000000207','Nilay Patel','NilayPatel','MDAwMTIz'),				
('000000208','Paul Utz','PaulUtz','MDAwMTIz'),				
('000000209','Henry Lester','HenryLester','MDAwMTIz'),				
('000000210','Lisa Klig','LisaKlig','MDAwMTIz'),				
('000000211','Trevor Cardinal','TrevorCardinal','MDAwMTIz'),				
('000000212','Lisa Hammersley','LisaHammersley','MDAwMTIz'),				
('000000213','Lily Chen','LilyChen','MDAwMTIz'),				
('000000214','Tzvia Abramson','TzviaAbramson','MDAwMTIz'),				
('000000215','Jacob Varkey','JacobVarkey','MDAwMTIz'),				
('000000216','Pamela Eversole-Cire','PamelaEversole-Cire','MDAwMTIz'),				
('000000217','Carin Zimmerman','CarinZimmerman','MDAwMTIz'),				
('000000218','Cindy Malone','CindyMalone','MDAwMTIz'),				
('000000219','Nicole Bournias-Vardiabasis','NicoleBournias-Vardiabasis','MDAwMTIz'),				
('000000220','Ellen Fung','EllenFung','MDAwMTIz'),				
('000000221','Wafa Tawackoli','WafaTawackoli','MDAwMTIz'),				
('000000222','John Ravits','JohnRavits','MDAwMTIz'),				
('000000223','Fouad  Kandeel','FouadKandeel','MDAwMTIz'),				
('000000224','Ophir Klein','OphirKlein','MDAwMTIz'),				
('000000225','Anthony Gringeri','AnthonyGringeri','MDAwMTIz'),				
('000000226','Edward Holmes','EdwardHolmes','MDAwMTIz'),				
('000000227','Sidney Golub','SidneyGolub','MDAwMTIz'),				
('000000228','Peter Schultz','PeterSchultz','MDAwMTIz'),				
('000000229','Shaomei Wang','ShaomeiWang','MDAwMTIz'),				
('000000230','Robert  Dillman','RobertDillman','MDAwMTIz'),				
('000000231','David Schubert','DavidSchubert','MDAwMTIz'),				
('000000232','Roslyn Isseroff','RoslynIsseroff','MDAwMTIz'),				
('000000233','Darryl D''Lima','DarrylD''Lima','MDAwMTIz'),				
('000000234','Qing Liu-Michael','QingLiu-Michael','MDAwMTIz'),				
('000000235','Gerald Chader','GeraldChader','MDAwMTIz'),				
('000000236','Randi Hagerman','RandiHagerman','MDAwMTIz'),				
('000000237','James Dunn','JamesDunn','MDAwMTIz'),				
('000000238','Joseph Gold','JosephGold','MDAwMTIz'),				
('000000239','Toshio Miki','ToshioMiki','MDAwMTIz'),				
('000000240','Hanna Mikkola','HannaMikkola','MDAwMTIz'),				
('000000241','Shaochen Chen','ShaochenChen','MDAwMTIz'),				
('000000242','Sarah Heilshorn','SarahHeilshorn','MDAwMTIz'),				
('000000243','Shyni Varghese','ShyniVarghese','MDAwMTIz'),				
('000000244','Irving Weissman','IrvingWeissman','MDAwMTIz'),				
('000000245','Paula Cannon','PaulaCannon','MDAwMTIz'),				
('000000246','J.  Leach','J.Leach','MDAwMTIz'),				
('000000247','Qilong Ying','QilongYing','MDAwMTIz'),				
('000000248','Laura Marcu','LauraMarcu','MDAwMTIz'),				
('000000249','Andrew Leavitt','AndrewLeavitt','MDAwMTIz'),				
('000000250','Fan Yang','FanYang','MDAwMTIz'),				
('000000251','Carla Koehler','CarlaKoehler','MDAwMTIz'),				
('000000252','Leif Havton','LeifHavton','MDAwMTIz'),				
('000000253','Leonard Zon','LeonardZon','MDAwMTIz'),				
('000000254','Steven Finkbeiner','StevenFinkbeiner','MDAwMTIz'),				
('000000255','Susan Fisher','SusanFisher','MDAwMTIz'),				
('000000256','Diana Laird','DianaLaird','MDAwMTIz'),				
('000000257','Xavier Darzacq','XavierDarzacq','MDAwMTIz'),				
('000000258','Todd McDevitt','ToddMcDevitt','MDAwMTIz'),				
('000000259','Francois Binette','FrancoisBinette','MDAwMTIz'),				
('000000260','Michelle Khine','MichelleKhine','MDAwMTIz'),				
('000000261','Jennifer Landress','JenniferLandress','MDAwMTIz'),				
('000000262','Kara McCloskey','KaraMcCloskey','MDAwMTIz'),				
('000000263','Sheng Ding','ShengDing','MDAwMTIz'),				
('000000264','Valerie Weaver','ValerieWeaver','MDAwMTIz'),				
('000000265','Dianne McKay','DianneMcKay','MDAwMTIz'),				
('000000266','Michael Snyder','MichaelSnyder','MDAwMTIz'),				
('000000267','David Cheresh','DavidCheresh','MDAwMTIz'),				
('000000268','Peter Donovan','PeterDonovan','MDAwMTIz'),				
('000000269','Joseph Ecker','JosephEcker','MDAwMTIz'),				
('000000270','Andrew Dillin','AndrewDillin','MDAwMTIz'),				
('000000271','Joshua Stuart','JoshuaStuart','MDAwMTIz'),				
('000000272','Miles  Wilkinson','MilesWilkinson','MDAwMTIz'),				
('000000273','Maike Sander','MaikeSander','MDAwMTIz'),				
('000000274','Wei Wang','WeiWang','MDAwMTIz'),				
('000000275','Marius Wernig','MariusWernig','MDAwMTIz'),				
('000000276','Xinnan Wang','XinnanWang','MDAwMTIz'),				
('000000277','David Tirrell','DavidTirrell','MDAwMTIz'),				
('000000278','Lisa Flanagan','LisaFlanagan','MDAwMTIz'),				
('000000279','Christian Metallo','ChristianMetallo','MDAwMTIz'),				
('000000280','Paul Noble','PaulNoble','MDAwMTIz'),				
('000000281','Samantha Butler','SamanthaButler','MDAwMTIz'),				
('000000282','Cornelis Murre','CornelisMurre','MDAwMTIz'),				
('000000283','Mark Anderson','MarkAnderson','MDAwMTIz'),				
('000000284','Thomas Rando','ThomasRando','MDAwMTIz'),				
('000000285','Jason Rock','JasonRock','MDAwMTIz'),				
('000000286','Anita Caufield','AnitaCaufield','MDAwMTIz'),				
('000000287','Peter Belafsky','PeterBelafsky','MDAwMTIz'),				
('000000288','Dennis Slamon','DennisSlamon','MDAwMTIz'),				
('000000289','Mark Yarborough','MarkYarborough','MDAwMTIz'),				
('000000290','Jeffrey Rosenfeld','JeffreyRosenfeld','MDAwMTIz'),				
('000000291','Dana Jones','DanaJones','MDAwMTIz'),				
('000000292','Regis Kelly','RegisKelly','MDAwMTIz'),				
('000000293','Stuart  Lipton','StuartLipton','MDAwMTIz'),				
('000000294','Michele Calos','MicheleCalos','MDAwMTIz'),				
('000000295','Robert Reiter','RobertReiter','MDAwMTIz'),				
('000000296','Zack Jerome','ZackJerome','MDAwMTIz'),				
('000000297','Inder  Verma','InderVerma','MDAwMTIz'),				
('000000298','Gerald Lipshutz','GeraldLipshutz','MDAwMTIz'),				
('000000299','Dan Gazit','DanGazit','MDAwMTIz'),				
('000000300','John Griffin','JohnGriffin','MDAwMTIz'),				
('000000301','Julien Sage','JulienSage','MDAwMTIz'),				
('000000302','Matthew Jenusaitis','MatthewJenusaitis','MDAwMTIz'),				
('000000303','Joan  Heller Brown','JoanHellerBrown','MDAwMTIz'),				
('000000304','Barry Stripp','BarryStripp','MDAwMTIz'),				
('000000305','Eric Ahrens','EricAhrens','MDAwMTIz'),				
('000000306','Fyodor Urnov','FyodorUrnov','MDAwMTIz'),				
('000000307','Camilla Forsberg','CamillaForsberg','MDAwMTIz'),				
('000000308','Shu  Chien','ShuChien','MDAwMTIz'),				
('000000309','Joachim Hallmayer','JoachimHallmayer','MDAwMTIz'),				
('000000310','Kang Zhang','KangZhang','MDAwMTIz'),				
('000000311','Joseph Gleeson','JosephGleeson','MDAwMTIz'),				
('000000312','Jacquelyn Maher','JacquelynMaher','MDAwMTIz'),				
('000000313','James Brewer','JamesBrewer','MDAwMTIz'),				
('000000314','Thomas Novak','ThomasNovak','MDAwMTIz'),				
('000000315','Deborah Requesens','DeborahRequesens','MDAwMTIz'),				
('000000316','Tatiana Segura','TatianaSegura','MDAwMTIz'),				
('000000317','Fouad Kandeel','FouadKandeel','MDAwMTIz'),				
('000000318','Michelle Monje','MichelleMonje','MDAwMTIz'),				
('000000319','Robert Baloh','RobertBaloh','MDAwMTIz'),				
('000000320','Reza Ardehali','RezaArdehali','MDAwMTIz'),				
('000000321','Emanual Maverakis','EmanualMaverakis','MDAwMTIz'),				
('000000322','Ali Nsair','AliNsair','MDAwMTIz'),				
('000000323','Mana Parast','ManaParast','MDAwMTIz'),				
('000000324','Jason Pomerantz','JasonPomerantz','MDAwMTIz'),				
('000000325','Ann Zovein','AnnZovein','MDAwMTIz'),				
('000000326','Alex Richmond','AlexRichmond','MDAwMTIz'),				
('000000327','Marilyn Smith','MarilynSmith','MDAwMTIz'),				
('000000328','Anne Brunet','AnneBrunet','MDAwMTIz'),				
('000000329','Michael Cleary','MichaelCleary','MDAwMTIz'),				
('000000330','Miguel Ramalho-Santos','MiguelRamalho-Santos','MDAwMTIz'),				
('000000331','Deepak Lamba','DeepakLamba','MDAwMTIz'),				
('000000332','Jeremy Reiter','JeremyReiter','MDAwMTIz'),				
('000000333','Huei-sheng Chen','Huei-shengChen','MDAwMTIz'),				
('000000334','Alexander Dunn','AlexanderDunn','MDAwMTIz'),				
('000000335','Howard Chang','HowardChang','MDAwMTIz'),				
('000000336','George Sen','GeorgeSen','MDAwMTIz'),				
('000000337','Kathrin Plath','KathrinPlath','MDAwMTIz'),				
('000000338','Benoit Bruneau','BenoitBruneau','MDAwMTIz'),				
('000000339','Gerald Crabtree','GeraldCrabtree','MDAwMTIz'),				
('000000340','Ananda Goldrath','AnandaGoldrath','MDAwMTIz'),				
('000000341','Eugene Yeo','EugeneYeo','MDAwMTIz'),				
('000000342','Eduardo Marbán','EduardoMarbán','MDAwMTIz'),				
('000000343','Barbara Panning','BarbaraPanning','MDAwMTIz'),				
('000000344','Robert Tjian','RobertTjian','MDAwMTIz'),				
('000000345','Antoni Ribas','AntoniRibas','MDAwMTIz'),				
('000000346','John Laird','JohnLaird','MDAwMTIz'),				
('000000347','Nancy Lane','NancyLane','MDAwMTIz'),				
('000000348','Vicki Wheelock','VickiWheelock','MDAwMTIz'),				
('000000349','Andrew McMahon','AndrewMcMahon','MDAwMTIz'),				
('000000350','Stanley Nelson','StanleyNelson','MDAwMTIz'),				
('000000351','Alexandra Capela','AlexandraCapela','MDAwMTIz'),				
('000000352','Rachel Smith','RachelSmith','MDAwMTIz'),				
('000000353','Kyriacos Athanasiou','KyriacosAthanasiou','MDAwMTIz'),				
('000000354','Stephen Forman','StephenForman','MDAwMTIz'),				
('000000355','Juan Carlos Izpisua Belmonte','JuanCarlosIzpisuaBelmonte','MDAwMTIz'),				
('000000356','Craig Walsh','CraigWalsh','MDAwMTIz'),				
('000000357','Walter Boyd','WalterBoyd','MDAwMTIz'),				
('000000358','Arnold Kriegstein','ArnoldKriegstein','MDAwMTIz'),				
('000000359','Philip Schwartz','PhilipSchwartz','MDAwMTIz'),				
('000000360','Kathy Rich','KathyRich','MDAwMTIz'),				
('000000361','Vasanthy Narayanaswami','VasanthyNarayanaswami','MDAwMTIz'),				
('000000362','James Williamson','JamesWilliamson','MDAwMTIz'),				
('000000363','Shannon  Noonan','ShannonNoonan','MDAwMTIz'),				
('000000364','Roberta Brinton','RobertaBrinton','MDAwMTIz'),				
('000000365','Lina Kim','LinaKim','MDAwMTIz'),				
('000000366','Victoria Lunyak','VictoriaLunyak','MDAwMTIz'),				
('000000367','Roger Madison','RogerMadison','MDAwMTIz'),				
('000000368','Richard Jove','RichardJove','MDAwMTIz'),				
('000000369','Paul Patterson','PaulPatterson','MDAwMTIz'),				
('000000370','Martin Birchall','MartinBirchall','MDAwMTIz'),				
('000000371','Timothy Hoey','TimothyHoey','MDAwMTIz'),				
('000000372','Marcel Daadi','MarcelDaadi','MDAwMTIz'),				
('000000373','John Hood','JohnHood','MDAwMTIz'),				
('000000374','Robert Robbins','RobertRobbins','MDAwMTIz'),				
('000000375','Martina Wiedau-Pazos','MartinaWiedau-Pazos','MDAwMTIz'),				
('000000376','Dong-Er Zhang','Dong-ErZhang','MDAwMTIz'),				
('000000377','David McGee','DavidMcGee','MDAwMTIz'),				
('000000378','Karin Immergluck','KarinImmergluck','MDAwMTIz'),				
('000000379','Bernadette McCafferty','BernadetteMcCafferty','MDAwMTIz'),				
('000000380','Rubén Flores','RubénFlores','MDAwMTIz'),				
('000000381','Katharine Ku','KatharineKu','MDAwMTIz'),				
('000000382','Adele Rennie','AdeleRennie','MDAwMTIz'),				
('000000383','Ronnie Hanecak','RonnieHanecak','MDAwMTIz'),				
('000000384','Babak Kateb','BabakKateb','MDAwMTIz'),				
('000000385','Anirvan Ghosh','AnirvanGhosh','MDAwMTIz'),				
('000000386','Aaron Hsueh','AaronHsueh','MDAwMTIz'),				
('000000387','Joanna Wysocka','JoannaWysocka','MDAwMTIz'),				
('000000388','Farah Sheikh','FarahSheikh','MDAwMTIz'),				
('000000389','Charles King','CharlesKing','MDAwMTIz'),				
('000000390','Sean Wu','SeanWu','MDAwMTIz'),				
('000000391','Joel Gottesfeld','JoelGottesfeld','MDAwMTIz'),				
('000000392','William Lowry','WilliamLowry','MDAwMTIz'),				
('000000393','Yi  Sun','YiSun','MDAwMTIz'),				
('000000394','Shuo Lin','ShuoLin','MDAwMTIz'),				
('000000395','Binhai Zheng','BinhaiZheng','MDAwMTIz'),				
('000000396','Michael Clarke','MichaelClarke','MDAwMTIz'),				
('000000397','Kristin Baldwin','KristinBaldwin','MDAwMTIz'),				
('000000398','Deborah Spector','DeborahSpector','MDAwMTIz'),				
('000000399','John Murnane','JohnMurnane','MDAwMTIz'),				
('000000400','Kun Zhang','KunZhang','MDAwMTIz'),				
('000000401','Michael Rape','MichaelRape','MDAwMTIz'),				
('000000402','Jiing-Kuan Yee','Jiing-KuanYee','MDAwMTIz'),				
('000000403','R. Jeremy Nichols','R.JeremyNichols','MDAwMTIz'),				
('000000404','Francis Doyle','FrancisDoyle','MDAwMTIz'),				
('000000405','John Yu','JohnYu','MDAwMTIz'),				
('000000406','Joann Zhang','JoannZhang','MDAwMTIz'),				
('000000407','Steven Conolly','StevenConolly','MDAwMTIz'),				
('000000408','Karl Willert','KarlWillert','MDAwMTIz'),				
('000000409','Theo Palmer','TheoPalmer','MDAwMTIz'),				
('000000410','Richard Gatti','RichardGatti','MDAwMTIz'),				
('000000411','Jifan Hu','JifanHu','MDAwMTIz'),				
('000000412','Daniel Lim','DanielLim','MDAwMTIz'),				
('000000413','Martin Martin','MartinMartin','MDAwMTIz'),				
('000000414','Brian Rutt','BrianRutt','MDAwMTIz'),				
('000000415','Marc Unger','MarcUnger','MDAwMTIz'),				
('000000416','Irvin Chen','IrvinChen','MDAwMTIz'),				
('000000417','John Dimos','JohnDimos','MDAwMTIz'),				
('000000418','Markus Muschen','MarkusMuschen','MDAwMTIz'),				
('000000419','Arturo Alvarez-Buylla','ArturoAlvarez-Buylla','MDAwMTIz'),				
('000000420','Bruno  Peault','BrunoPeault','MDAwMTIz'),				
('000000421','Peter Coffey','PeterCoffey','MDAwMTIz'),				
('000000422','Xianmin Zeng','XianminZeng','MDAwMTIz'),				
('000000423','Mark Zern','MarkZern','MDAwMTIz'),				
('000000424','Fred Gage','FredGage','MDAwMTIz'),				
('000000425','Noriyuki Kasahara','NoriyukiKasahara','MDAwMTIz'),				
('000000426','David DiGiusto','DavidDiGiusto','MDAwMTIz'),				
('000000427','Elizabeth Read','ElizabethRead','MDAwMTIz'),				
('000000428','Emmanuelle Passegue','EmmanuellePassegue','MDAwMTIz'),				
('000000429','Robert Wechsler-Reya','RobertWechsler-Reya','MDAwMTIz'),				
('000000430','William Murphy','WilliamMurphy','MDAwMTIz'),				
('000000431','Irene Griswold-Prenner','IreneGriswold-Prenner','MDAwMTIz'),				
('000000432','Robert Negrin','RobertNegrin','MDAwMTIz'),				
('000000433','Eric Kurzrock','EricKurzrock','MDAwMTIz'),				
('000000434','Anjana Rao','AnjanaRao','MDAwMTIz'),				
('000000435','David Raulet','DavidRaulet','MDAwMTIz'),				
('000000436','Tony Wyss-Coray','TonyWyss-Coray','MDAwMTIz'),				
('000000437','Ellen Robey','EllenRobey','MDAwMTIz'),				
('000000438','Douglas Black','DouglasBlack','MDAwMTIz'),				
('000000439','Yong Kim','YongKim','MDAwMTIz'),				
('000000440','Terrence Town','TerrenceTown','MDAwMTIz'),				
('000000441','Steven Artandi','StevenArtandi','MDAwMTIz'),				
('000000442','Jeffrey Bluestone','JeffreyBluestone','MDAwMTIz'),				
('000000443','Kenneth Weinberg','KennethWeinberg','MDAwMTIz'),				
('000000444','Christopher Contag','ChristopherContag','MDAwMTIz'),				
('000000445','John Rubenstein','JohnRubenstein','MDAwMTIz'),				
('000000446','Garry Nolan','GarryNolan','MDAwMTIz'),				
('000000447','Nicholas Gascoigne','NicholasGascoigne','MDAwMTIz'),				
('000000448','Husein Hadeiba','HuseinHadeiba','MDAwMTIz'),				
('000000449','Marian Waterman','MarianWaterman','MDAwMTIz'),				
('000000450','Basil Hantash','BasilHantash','MDAwMTIz'),				
('000000451','Kun-Liang Guan','Kun-LiangGuan','MDAwMTIz'),				
('000000452','Benhur Lee','BenhurLee','MDAwMTIz'),				
('000000453','Martin Marsala','MartinMarsala','MDAwMTIz'),				
('000000454','Mitchel Berger','MitchelBerger','MDAwMTIz'),				
('000000455','Dennis Carson','DennisCarson','MDAwMTIz'),				
('000000456','Alfred Lane','AlfredLane','MDAwMTIz'),				
('000000457','Geoff Symonds','GeoffSymonds','MDAwMTIz'),				
('000000458','Allan Robins','AllanRobins','MDAwMTIz'),				
('000000459','Robb Maclellan','RobbMaclellan','MDAwMTIz'),				
('000000460','Min Zhao','MinZhao','MDAwMTIz'),				
('000000461','Wange Lu','WangeLu','MDAwMTIz'),				
('000000462','Luisa  Iruela-Arispe','LuisaIruela-Arispe','MDAwMTIz'),				
('000000463','Martin  Pera','MartinPera','MDAwMTIz'),				
('000000464','Michael Teitell','MichaelTeitell','MDAwMTIz'),				
('000000465','Susan  McConnell','SusanMcConnell','MDAwMTIz'),				
('000000466','Hank Greely','HankGreely','MDAwMTIz'),				
('000000467','Olivia Kelly','OliviaKelly','MDAwMTIz'),				
('000000468','Martin Friedlander','MartinFriedlander','MDAwMTIz'),				
('000000469','Warner Greene','WarnerGreene','MDAwMTIz'),				
('000000470','Pali Kaur','PaliKaur','MDAwMTIz'),				
('000000471','J. William Langston','J.WilliamLangston','MDAwMTIz'),				
('000000472','Jill Helms','JillHelms','MDAwMTIz'),				
('000000473','Gabriel Travis','GabrielTravis','MDAwMTIz'),				
('000000474','Michael West','MichaelWest','MDAwMTIz'),				
('000000475','Jan Nolta','JanNolta','MDAwMTIz'),				
('000000476','Frank LaFerla','FrankLaFerla','MDAwMTIz'),				
('000000477','Brian Black','BrianBlack','MDAwMTIz'),				
('000000478','Barbara Des Rochers','BarbaraDesRochers','MDAwMTIz'),				
('000000479','Michael Barish','MichaelBarish','MDAwMTIz'),				
('000000480','Kenneth Dorshkind','KennethDorshkind','MDAwMTIz'),				
('000000481','Dennis Clegg','DennisClegg','MDAwMTIz'),				
('000000482','Jill Adler-Moore','JillAdler-Moore','MDAwMTIz'),				
('000000483','Sylvia Evans','SylviaEvans','MDAwMTIz'),				
('000000484','David Haussler','DavidHaussler','MDAwMTIz'),				
('000000485','Robert Mahley','RobertMahley','MDAwMTIz'),				
('000000486','Robert Maxson','RobertMaxson','MDAwMTIz'),				
('000000487','Frederick Meyers','FrederickMeyers','MDAwMTIz'),				
('000000488','Carmen Domingo','CarmenDomingo','MDAwMTIz'),				
('000000489','Ulrich Mueller','UlrichMueller','MDAwMTIz'),				
('000000490','David  Warburton','DavidWarburton','MDAwMTIz'),				
('000000491','Kristina Bonham','KristinaBonham','MDAwMTIz'),				
('000000492','Carlos Barbas','CarlosBarbas','MDAwMTIz'),				
('000000493','Ying Liu','YingLiu','MDAwMTIz'),				
('000000494','Hsian-Rong Tseng','Hsian-RongTseng','MDAwMTIz'),				
('000000495','Orhan NALCIOGLU','OrhanNALCIOGLU','MDAwMTIz'),				
('000000496','Michael Phelps','MichaelPhelps','MDAwMTIz'),				
('000000497','Douglas Wagenaar','DouglasWagenaar','MDAwMTIz'),				
('000000498','Patrick McDonough','PatrickMcDonough','MDAwMTIz'),				
('000000499','Pin Wang','PinWang','MDAwMTIz'),				
('000000500','Larry Couture','LarryCouture','MDAwMTIz'),				
('000000501','Evert Kroon','EvertKroon','MDAwMTIz'),				
('000000502','Joel Kubby','JoelKubby','MDAwMTIz'),				
('000000503','Kit Lam','KitLam','MDAwMTIz'),				
('000000504','Bing Ren','BingRen','MDAwMTIz'),				
('000000505','Robert Blelloch','RobertBlelloch','MDAwMTIz'),				
('000000506','Edwin Monuki','EdwinMonuki','MDAwMTIz'),				
('000000507','Gage DeKoeyer Crump','GageDeKoeyerCrump','MDAwMTIz'),				
('000000508','Benjamin  Yu','BenjaminYu','MDAwMTIz'),				
('000000509','Ching-Pin  Chang','Ching-PinChang','MDAwMTIz'),				
('000000510','Paul Knoepfler','PaulKnoepfler','MDAwMTIz'),				
('000000511','Lin He','LinHe','MDAwMTIz'),				
('000000512','Ricardo Zayas','RicardoZayas','MDAwMTIz'),				
('000000513','David Woodley','DavidWoodley','MDAwMTIz'),				
('000000514','Long-cheng Li','Long-chengLi','MDAwMTIz'),				
('000000515','Jeffrey Lotz','JeffreyLotz','MDAwMTIz'),				
('000000516','Michael Longaker','MichaelLongaker','MDAwMTIz'),				
('000000517','Samuel Pfaff','SamuelPfaff','MDAwMTIz'),				
('000000518','Renee Reijo Pera','ReneeReijoPera','MDAwMTIz'),				
('000000519','Emmanuel Baetge','EmmanuelBaetge','MDAwMTIz'),				
('000000520','Zhuohua Zhang','ZhuohuaZhang','MDAwMTIz'),				
('000000521','Julie Baker','JulieBaker','MDAwMTIz'),				
('000000522','Webster Cavenee','WebsterCavenee','MDAwMTIz'),				
('000000523','Amander Clark','AmanderClark','MDAwMTIz'),				
('000000524','Bruce Conklin','BruceConklin','MDAwMTIz'),				
('000000525','Robert  Farese','RobertFarese','MDAwMTIz'),				
('000000526','Mary McEachron','MaryMcEachron','MDAwMTIz'),				
('000000527','John Hennessy','JohnHennessy','MDAwMTIz'),				
('000000528','George Breslauer','GeorgeBreslauer','MDAwMTIz'),				
('000000529','Larry Vanderhoef','LarryVanderhoef','MDAwMTIz'),				
('000000530','Michael Drake','MichaelDrake','MDAwMTIz'),				
('000000531','Gene Block','GeneBlock','MDAwMTIz'),				
('000000532','John White','JohnWhite','MDAwMTIz'),				
('000000533','Glenn Lucas','GlennLucas','MDAwMTIz'),				
('000000534','Margaret Delaney','MargaretDelaney','MDAwMTIz'),				
('000000535','A. Washington','A.Washington','MDAwMTIz'),				
('000000536','Chrysostomos Nikias','ChrysostomosNikias','MDAwMTIz'),				
('000000537','Mohammad Pashmforoush','MohammadPashmforoush','MDAwMTIz'),				
('000000538','Douglas Ethell','DouglasEthell','MDAwMTIz'),				
('000000539','Siavash Kurdistani','SiavashKurdistani','MDAwMTIz'),				
('000000540','Jennifer Manilay','JenniferManilay','MDAwMTIz'),				
('000000541','Chong-Xian Pan','Chong-XianPan','MDAwMTIz'),				
('000000542','Andrew Putnam','AndrewPutnam','MDAwMTIz'),				
('000000543','Tiziano Barberi','TizianoBarberi','MDAwMTIz'),				
('000000544','Songtao Shi','SongtaoShi','MDAwMTIz'),				
('000000545','Lei Wang','LeiWang','MDAwMTIz'),				
('000000546','Bin Chen','BinChen','MDAwMTIz'),				
('000000547','Irina Conboy','IrinaConboy','MDAwMTIz'),				
('000000548','Karl Deisseroth','KarlDeisseroth','MDAwMTIz'),				
('000000549','Lindsay Hinck','LindsayHinck','MDAwMTIz'),				
('000000550','Prudence Talbot','PrudenceTalbot','MDAwMTIz'),				
('000000551','Linda Giudice','LindaGiudice','MDAwMTIz'),				
('000000552','Vittorio Sebastiano','VittorioSebastiano','MDAwMTIz'),				
('000000553','Garry Van Gerpen','GarryVanGerpen','MDAwMTIz'),				
('000000554','Scott Waugh','ScottWaugh','MDAwMTIz'),				
('000000555','Carolyn Lutzko','CarolynLutzko','MDAwMTIz'),				
('000000556','Christopher Zarins','ChristopherZarins','MDAwMTIz'),				
('000000557','Hans Keirstead','HansKeirstead','MDAwMTIz'),				
('000000558','Douglas Wallace','DouglasWallace','MDAwMTIz'),				
('000000559','Guoping Fan','GuopingFan','MDAwMTIz'),				
('000000560','Stefan Heller','StefanHeller','MDAwMTIz'),				
('000000561','Randall Lee','RandallLee','MDAwMTIz'),				
('000000562','Harold Bernstein','HaroldBernstein','MDAwMTIz'),				
('000000563','Samuel Pleasure','SamuelPleasure','MDAwMTIz'),				
('000000564','Senyon Choe','SenyonChoe','MDAwMTIz'),				
('000000565','Michael Pirrung','MichaelPirrung','MDAwMTIz'),				
('000000566','Heike Daldrup-Link','HeikeDaldrup-Link','MDAwMTIz'),				
('000000567','Thomas Wandless','ThomasWandless','MDAwMTIz'),				
('000000568','Gregg Duester','GreggDuester','MDAwMTIz'),				
('000000569','Zoran Galic','ZoranGalic','MDAwMTIz'),				
('000000570','Timothy O''Connor','TimothyO''Connor','MDAwMTIz'),				
('000000571','Elizabeth Lawlor','ElizabethLawlor','MDAwMTIz'),				
('000000572','John Cooke','JohnCooke','MDAwMTIz'),				
('000000573','David Feldheim','DavidFeldheim','MDAwMTIz'),				
('000000574','Eric Verdin','EricVerdin','MDAwMTIz'),				
('000000575','Thea Tlsty','TheaTlsty','MDAwMTIz'),				
('000000576','Su Guo','SuGuo','MDAwMTIz'),				
('000000577','Ziwei Huang','ZiweiHuang','MDAwMTIz'),				
('000000578','David Hinton','DavidHinton','MDAwMTIz'),				
('000000579','Alexey Terskikh','AlexeyTerskikh','MDAwMTIz'),				
('000000580','Mark Kay','MarkKay','MDAwMTIz'),				
('000000581','Carolyn Bertozzi','CarolynBertozzi','MDAwMTIz'),				
('000000582','Beverly Emerson','BeverlyEmerson','MDAwMTIz'),				
('000000583','Hudson Freeze','HudsonFreeze','MDAwMTIz'),				
('000000584','Krishna Shenoy','KrishnaShenoy','MDAwMTIz'),				
('000000585','Frank Sauer','FrankSauer','MDAwMTIz'),				
('000000586','Calvin Kuo','CalvinKuo','MDAwMTIz'),				
('000000587','Peter Laird','PeterLaird','MDAwMTIz'),				
('000000588','Vincent Procaccio','VincentProcaccio','MDAwMTIz'),				
('000000589','Didier Stainier','DidierStainier','MDAwMTIz'),				
('000000590','Thomas  Lane','ThomasLane','MDAwMTIz'),				
('000000591','Charles Limoli','CharlesLimoli','MDAwMTIz'),				
('000000592','A.  Reddi','A.Reddi','MDAwMTIz'),				
('000000593','Ebenezer Yamoah','EbenezerYamoah','MDAwMTIz'),				
('000000594','Dale Bredesen','DaleBredesen','MDAwMTIz'),				
('000000595','Kyoko Yokomori','KyokoYokomori','MDAwMTIz'),				
('000000596','Robert Oshima','RobertOshima','MDAwMTIz'),				
('000000597','Grant MacGregor','GrantMacGregor','MDAwMTIz'),				
('000000598','Fen-Biao Gao','Fen-BiaoGao','MDAwMTIz'),				
('000000599','Randy Schekman','RandySchekman','MDAwMTIz'),				
('000000600','Peter Bryant','PeterBryant','MDAwMTIz'),				
('000000601','Mark Chao','MarkChao','MDAwMTIz'),				
('000000602','Jane Lebkowski','JaneLebkowski','MDAwMTIz');	

INSERT investigates VALUES
('000000052','000000001'),													
('000000142','000000002'),													
('000000138','000000003'),													
('000000047','000000004'),													
('000000089','000000005'),													
('000000135','000000006'),													
('000000090','000000007'),													
('000000066','000000008'),													
('000000066','000000009'),													
('000000126','000000010'),													
('000000244','000000011'),													
('000000135','000000012'),													
('000000019','000000013'),													
('000000134','000000014'),													
('000000051','000000015'),													
('000000004','000000016'),													
('000000225','000000017'),													
('000000601','000000018'),													
('000000048','000000019'),													
('000000029','000000020'),													
('000000041','000000021'),													
('000000037','000000022'),													
('000000199','000000023'),													
('000000352','000000024'),													
('000000053','000000025'),													
('000000457','000000026'),													
('000000041','000000027'),													
('000000018','000000028'),													
('000000348','000000029'),													
('000000133','000000030'),													
('000000133','000000031'),													
('000000093','000000032'),													
('000000065','000000033'),													
('000000157','000000034'),													
('000000054','000000035'),													
('000000601','000000036'),													
('000000005','000000037'),													
('000000131','000000038'),													
('000000059','000000039'),													
('000000082','000000040'),													
('000000230','000000041'),													
('000000345','000000042'),													
('000000127','000000043'),													
('000000125','000000044'),													
('000000347','000000045'),													
('000000049','000000046'),													
('000000172','000000047'),													
('000000047','000000048'),													
('000000046','000000049'),													
('000000046','000000050'),													
('000000046','000000051'),													
('000000058','000000042'),													
('000000008','000000053'),													
('000000088','000000054'),													
('000000161','000000055'),													
('000000062','000000056'),													
('000000017','000000057'),													
('000000092','000000058'),													
('000000038','000000059'),													
('000000008','000000060'),													
('000000288','000000061'),													
('000000006','000000062'),													
('000000602','000000063'),													
('000000259','000000064'),													
('000000141','000000065'),													
('000000160','000000066'),													
('000000055','000000067'),													
('000000132','000000068'),													
('000000132','000000069'),													
('000000008','000000070');																			


       
INSERT r_disease_area VALUES
('000000001','Brain Cancer'),
('000000001','Cancer'),
('000000001','Solid Tumors'),
('000000002','Acute Myeloid Leukemia'),
('000000002','Blood Cancer'),
('000000002','Blood Disorders'),
('000000002','Cancer'),
('000000002','COVID-19'),
('000000002','Infectious Disease'),
('000000002','Multiple Myeloma'),
('000000003','Cancer'),
('000000003','Melanoma'),
('000000003','Solid Tumors'),
('000000004','Brain Cancer'),
('000000004','Cancer'),
('000000004','Solid Tumors'),
('000000005','Acute Myeloid Leukemia'),
('000000005','Blood Cancer'),
('000000005','Cancer'),
('000000006','Neurological Disorders'),
('000000006','Pediatrics'),
('000000006','Spina Bifida'),
('000000007','Acute Myeloid Leukemia'),
('000000007','Blood Cancer'),
('000000007','Cancer'),
('000000007','Ovarian Cancer'),
('000000007','Solid Tumors'),
('000000008','Adenosine deaminase-deficient (ADA-SCID)'),
('000000008','Blood Disorders'),
('000000008','Genetic Disorder'),
('000000008','Immune Disease'),
('000000008','Pediatrics'),
('000000008','Severe Combined Immunodeficiency'),
('000000008','Sickle Cell Disease'),
('000000008','X-linked Chronic Granulomatous Disease'),
('000000009','Diabetes'),
('000000009','Metabolic Disorders'),
('000000009','Type 1 diabetes'),
('000000010','Inflammatory bowel disease'),
('000000010','Intestinal Disease'),
('000000010','Metabolic Disorders'),
('000000011','Alzheimer\'s Disease'),
('000000011','Neurological Disorders'),
('000000012','Amyotrophic Lateral Sclerosis'),
('000000012','COVID-19'),
('000000012','Infectious Disease'),
('000000012','Neurological Disorders'),
('000000013','Neurological Disorders'),
('000000013','Traumatic Brain Injury'),
('000000014','Neurological Disorders'),
('000000014','Stroke'),
('000000015','COVID-19'),
('000000015','Infectious Disease'),
('000000016','Canavan Disease'),
('000000016','COVID-19'),
('000000016','Genetic Disorder'),
('000000016','Infectious Disease'),
('000000016','Neurological Disorders'),
('000000016','Pediatrics'),
('000000017','Blood Disorders'),
('000000017','Sickle Cell Disease'),
('000000018','HIV/AIDS'),
('000000018','Immune Disease'),
('000000018','Infectious Disease'),
('000000019','Bone or Cartilage Disease'),
('000000020','Neurological Disorders'),
('000000020','Spinal Cord Injury'),
('000000021','Aging'),
('000000021','COVID-19'),
('000000021','Infectious Disease'),
('000000021','Skeletal/Smooth Muscle disorders'),
('000000022','COVID-19'),
('000000022','Heart Disease'),
('000000022','Infectious Disease'),
('000000022','Toxicity'),
('000000023','Neurological Disorders'),
('000000023','Spinal Cord Injury'),
('000000023','Trauma'),
('000000023','Traumatic Brain Injury'),
('000000024','COVID-19'),
('000000024','Infectious Disease'),
('000000024','Respiratory Disorders'),
('000000024','Vascular Disease'),
('000000025','Epilepsy'),
('000000025','Neurological Disorders'),
('000000027','Brain Injury'),
('000000027','COVID-19'),
('000000027','hypoxic'),
('000000027','Infectious Disease'),
('000000027','ischemic'),
('000000027','Neurological Disorders'),
('000000027','Parkinson\'s Disease'),
('000000027','Pediatrics'),
('000000027','Respiratory Disorders'),
('000000028','COVID-19'),
('000000028','Infectious Disease'),
('000000029','COVID-19'),
('000000029','Infectious Disease'),
('000000029','Respiratory Disorders'),
('000000030','COVID-19'),
('000000030','Infectious Disease'),
('000000030','Respiratory Disorders'),
('000000031','COVID-19'),
('000000031','Infectious Disease'),
('000000032','COVID-19'),
('000000032','Infectious Disease'),
('000000032','Neurological Disorders'),
('000000033','COVID-19'),
('000000033','Infectious Disease'),
('000000034','Brain Cancer'),
('000000034','Cancer'),
('000000034','COVID-19'),
('000000034','Infectious Disease'),
('000000035','Blood Disorders'),
('000000035','Hyper IgM Syndrome'),
('000000035','Immune Disease'),
('000000036','Autism'),
('000000036','COVID-19'),
('000000036','Infectious Disease'),
('000000036','Neurological Disorders'),
('000000036','Stroke'),
('000000037','COVID-19'),
('000000037','Infectious Disease'),
('000000038','Blood Disorders'),
('000000038','Sickle Cell Disease'),
('000000039','Cancer'),
('000000039','COVID-19'),
('000000039','Infectious Disease'),
('000000039','Lung Cancer'),
('000000039','Respiratory Disorders'),
('000000039','Solid Tumors'),
('000000040','Blood Disorders'),
('000000040','Cancer'),
('000000040','COVID-19'),
('000000040','Immune Disease'),
('000000040','Infectious Disease'),
('000000040','Respiratory Disorders'),
('000000041','Brain Cancer'),
('000000041','Cancer'),
('000000041','COVID-19'),
('000000041','HIV/AIDS'),
('000000041','Immune Disease'),
('000000041','Infectious Disease'),
('000000041','Multiple Indications (Alpha Clinics)'),
('000000041','Respiratory Disorders'),
('000000042','Blood Disorders'),
('000000042','Cancer'),
('000000042','Lung Cancer'),
('000000044','Blood Cancer'),
('000000044','Cancer'),
('000000044','Multiple Myeloma'),
('000000045','Blood Disorders'),
('000000045','Immune Disease'),
('000000045','IPEX Syndrome'),
('000000046','Retinitis Pigmentosa'),
('000000046','Vision Loss'),
('000000047','Amyotrophic Lateral Sclerosis'),
('000000047','Huntington\'s Disease'),
('000000047','Neurological Disorders'),
('000000047','Pediatrics'),
('000000047','Retinitis Pigmentosa'),
('000000047','Vision Loss'),
('000000048','Corneal Damage'),
('000000048','Vision Loss'),
('000000049','Neurological Disorders'),
('000000049','Parkinson\'s Disease'),
('000000050','Brain Cancer'),
('000000050','Cancer'),
('000000050','Ovarian Cancer'),
('000000050','Solid Tumors'),
('000000051','Brain Cancer'),
('000000051','Breast Cancer'),
('000000051','Cancer'),
('000000051','Ovarian Cancer'),
('000000052','Age-related macular degeneration'),
('000000052','Vision Loss'),
('000000053','Blood Cancer'),
('000000053','Cancer'),
('000000053','HIV-related Lymphoma'),
('000000053','HIV/AIDS'),
('000000053','Infectious Disease'),
('000000053','Multiple Indications (Alpha Clinics)'),
('000000054','Cystinosis'),
('000000054','Genetic Disorder'),
('000000054','Kidney Disease'),
('000000054','Kidney Failure'),
('000000054','Metabolic Disorders'),
('000000054','Pediatrics'),
('000000055','Diabetes'),
('000000055','Metabolic Disorders'),
('000000056','Neurological Disorders'),
('000000056','Parkinson\'s Disease'),
('000000057','Blood Disorders'),
('000000057','Multiple Indications (Alpha Clinics)'),
('000000057','Sickle Cell Disease'),
('000000058','Cancer'),
('000000058','Sarcoma'),
('000000059','Blood Disorders'),
('000000059','Immune Disease'),
('000000061','Bone or Cartilage Disease'),
('000000061','Intervertebral disc degeneration'),
('000000061','Osteonecrosis'),
('000000062','Blood Disorders'),
('000000062','Immune Disease'),
('000000062','Muscular Dystrophy'),
('000000062','Pediatrics'),
('000000062','Severe Combined Immunodeficiency'),
('000000062','Skeletal/Smooth Muscle disorders'),
('000000062','X-linked (X-SCID)'),
('000000063','Blood Disorders'),
('000000063','Severe Combined Immunodeficiency'),
('000000064','Huntington\'s Disease'),
('000000064','Neurological Disorders'),
('000000065','Kidney Disease'),
('000000065','Kidney Failure'),
('000000066','Blood Cancer'),
('000000066','Cancer'),
('000000068','Acute Myeloid Leukemia'),
('000000068','Blood Cancer'),
('000000069','Age-related macular degeneration'),
('000000069','Vision Loss'),
('000000070','Age-related macular degeneration'),
('000000070','Vision Loss'),
('000000071','Vision Loss'),
('000000072','Intestinal Disease'),
('000000072','Liver Disease'),
('000000072','Metabolic Disorders'),
('000000072','Neurological Disorders'),
('000000072','Pediatrics'),
('000000073','Bladder or Urinary Tract Disorder'),
('000000073','Cancer'),
('000000073','Skeletal/Smooth Muscle disorders'),
('000000073','Solid Tumors'),
('000000074','Hearing Loss'),
('000000075','Hearing Loss'),
('000000076','HIV/AIDS'),
('000000076','Infectious Disease'),
('000000077','Cancer'),
('000000077','Prostate Cancer'),
('000000078','Immune Disease'),
('000000078','Thymic Disorder'),
('000000079','Danon Disease'),
('000000079','Heart Disease'),
('000000079','Pediatrics'),
('000000080','Dementia'),
('000000080','Neurological Disorders'),
('000000081','Diabetes'),
('000000081','Metabolic Disorders'),
('000000082','Cancer'),
('000000082','Lung Cancer'),
('000000083','Bone or Cartilage Disease'),
('000000084','Bladder or Urinary Tract Disorder'),
('000000084','Incontinence'),
('000000084','Skeletal/Smooth Muscle disorders'),
('000000085','Retinitis Pigmentosa'),
('000000085','Vision Loss'),
('000000086','Beta Thalassemia'),
('000000086','Blood Disorders'),
('000000087','Beta Thalassemia'),
('000000087','Blood Disorders'),
('000000088','Blood Disorders'),
('000000088','Immune Disease'),
('000000088','Pediatrics'),
('000000088','Severe Combined Immunodeficiency'),
('000000089','B cell cancers'),
('000000089','Blood Cancer'),
('000000089','Cancer'),
('000000089','Leukemia'),
('000000090','Beta Thalassemia'),
('000000090','Blood Disorders'),
('000000091','Cancer'),
('000000091','Solid Tumors'),
('000000092','Blood Disorders'),
('000000092','Sickle Cell Disease'),
('000000093','Kidney Disease'),
('000000093','Kidney Failure'),
('000000095','Neurological Disorders'),
('000000098','Blood Disorders'),
('000000098','Heart Disease'),
('000000098','Toxicity'),
('000000100','Multiple Indications (Alpha Clinics)'),
('000000101','Acute Myeloid Leukemia'),
('000000101','Blood Cancer'),
('000000101','Blood Disorders'),
('000000102','HIV/AIDS'),
('000000102','Infectious Disease'),
('000000103','Diabetes'),
('000000103','Metabolic Disorders'),
('000000104','Neurological Disorders'),
('000000104','Spinal Cord Injury'),
('000000105','Blood Disorders'),
('000000105','Hemophilia A'),
('000000106','Cancer'),
('000000106','Diabetes'),
('000000106','Genetic Disorder'),
('000000106','Heart Disease'),
('000000106','Immune Disease'),
('000000106','Metabolic Disorders'),
('000000107','Diabetes'),
('000000107','Metabolic Disorders'),
('000000108','Liver Disease'),
('000000108','Metabolic Disorders'),
('000000109','Muscular Dystrophy'),
('000000109','Skeletal/Smooth Muscle disorders'),
('000000110','Cancer'),
('000000110','Ovarian Cancer'),
('000000111','Blood Disorders'),
('000000111','Heart Disease'),
('000000111','Kidney Disease'),
('000000112','Vascular Disease'),
('000000113','Acute Myeloid Leukemia'),
('000000113','Blood Cancer'),
('000000114','Bone or Cartilage Disease'),
('000000115','Neurological Disorders'),
('000000115','Parkinson\'s Disease'),
('000000116','Bone or Cartilage Disease'),
('000000117','Epidermolysis Bullosa'),
('000000117','Skin Disease'),
('000000118','Age-related macular degeneration'),
('000000118','Vision Loss'),
('000000119','Acute Myeloid Leukemia'),
('000000119','Blood Cancer'),
('000000119','Cancer'),
('000000119','Multiple Indications (Alpha Clinics)'),
('000000120','Respiratory Disorders'),
('000000121','Other'),
('000000122','Vascular Disease'),
('000000123','Other'),
('000000124','Cancer'),
('000000124','Heart Disease'),
('000000124','Pancreatic Cancer'),
('000000125','Arthritis'),
('000000125','Bone or Cartilage Disease'),
('000000126','Blood Cancer'),
('000000126','Blood Disorders'),
('000000126','Bone Marrow Transplant and Viral Infection'),
('000000126','Cancer'),
('000000127','Blood Cancer'),
('000000127','Cancer'),
('000000130','Blood Disorders'),
('000000130','Cystic Fibrosis'),
('000000130','Genetic Disorder'),
('000000130','Immune Disease'),
('000000130','Pediatrics'),
('000000130','Respiratory Disorders'),
('000000130','Severe Combined Immunodeficiency'),
('000000130','Sickle Cell Disease'),
('000000130','X-linked (X-SCID)'),
('000000131','Acute Myeloid Leukemia'),
('000000131','Blood Cancer'),
('000000132','Diabetes'),
('000000132','Metabolic Disorders'),
('000000133','Kidney Disease'),
('000000133','Kidney Failure'),
('000000134','Brain Cancer'),
('000000134','Cancer'),
('000000135','B cell cancers'),
('000000135','Blood Cancer'),
('000000135','Cancer'),
('000000135','Leukemia'),
('000000137','Blood Cancer'),
('000000137','Cancer'),
('000000138','Amyotrophic Lateral Sclerosis'),
('000000138','Neurological Disorders'),
('000000139','Diabetes'),
('000000139','Metabolic Disorders'),
('000000140','Liver Disease'),
('000000140','Metabolic Disorders'),
('000000141','Neurological Disorders'),
('000000141','Stroke'),
('000000142','Alpha Thalassemia Major'),
('000000142','Blood Disorders'),
('000000142','Immune Disease'),
('000000142','Pediatrics'),
('000000143','Cancer'),
('000000143','Colon Cancer'),
('000000144','Heart Disease'),
('000000144','Heart failure'),
('000000145','Heart Disease'),
('000000146','Other'),
('000000147','Huntington\'s Disease'),
('000000147','Neurological Disorders'),
('000000148','B cell cancers'),
('000000148','Blood Cancer'),
('000000148','Cancer'),
('000000148','Leukemia'),
('000000149','Neurological Disorders'),
('000000149','Stroke'),
('000000150','Neurological Disorders'),
('000000150','Parkinson\'s Disease'),
('000000151','Acute Myeloid Leukemia'),
('000000151','Blood Cancer'),
('000000152','Vision Loss'),
('000000153','Heart Disease'),
('000000154','Muscular Dystrophy'),
('000000154','Skeletal/Smooth Muscle disorders'),
('000000155','Alzheimer\'s Disease'),
('000000155','Neurological Disorders'),
('000000156','Blood Disorders'),
('000000157','Kidney Disease'),
('000000157','Kidney Failure'),
('000000158','Neurological Disorders'),
('000000158','Neuropathy'),
('000000159','Bone or Cartilage Disease'),
('000000159','Osteoarthritis'),
('000000160','Diabetes'),
('000000160','Metabolic Disorders'),
('000000161','Blood Disorders'),
('000000161','Immune Disease'),
('000000161','Severe Combined Immunodeficiency'),
('000000161','X-linked (X-SCID)'),
('000000162','Diabetes'),
('000000162','Metabolic Disorders'),
('000000163','Liver Disease'),
('000000163','Metabolic Disorders'),
('000000164','Heart Disease'),
('000000164','Vascular Disease'),
('000000165','Neurological Disorders'),
('000000165','Parkinson\'s Disease'),
('000000166','Blood Cancer'),
('000000166','Blood Disorders'),
('000000166','Cancer'),
('000000166','Leukemia'),
('000000167','Diabetes'),
('000000167','Metabolic Disorders'),
('000000168','Autism'),
('000000168','Infectious Disease'),
('000000168','Neurological Disorders'),
('000000168','Pediatrics'),
('000000168','Rett\'s Syndrome'),
('000000169','Arthritis'),
('000000169','Bone or Cartilage Disease'),
('000000170','Alzheimer\'s Disease'),
('000000170','Neurological Disorders'),
('000000172','Heart Disease'),
('000000172','Pulmonary Hypertension'),
('000000173','Adenosine deaminase-deficient (ADA-SCID)'),
('000000173','Blood Disorders'),
('000000173','Genetic Disorder'),
('000000173','Immune Disease'),
('000000173','Pediatrics'),
('000000173','Severe Combined Immunodeficiency'),
('000000175','Multiple Indications (Alpha Clinics)'),
('000000178','Trauma'),
('000000179','Neurological Disorders'),
('000000179','Parkinson\'s Disease'),
('000000179','Spinal Cord Injury'),
('000000180','Autism'),
('000000180','Neurological Disorders'),
('000000181','Immune Disease'),
('000000181','Neurological Disorders'),
('000000181','Parkinson\'s Disease'),
('000000182','HIV/AIDS'),
('000000182','Infectious Disease'),
('000000183','Diabetes'),
('000000183','Metabolic Disorders'),
('000000184','Multiple Indications (Alpha Clinics)'),
('000000185','Blood Cancer'),
('000000185','Cancer'),
('000000186','Heart Disease'),
('000000187','Heart Disease'),
('000000188','Heart Disease'),
('000000189','Amyotrophic Lateral Sclerosis'),
('000000189','Genetic Disorder'),
('000000189','Neurological Disorders'),
('000000189','Pediatrics'),
('000000189','Spinal Cord Injury'),
('000000189','Spinal Muscular Atrophy'),
('000000190','Aging'),
('000000190','Skeletal/Smooth Muscle disorders'),
('000000191','Cancer'),
('000000191','Prostate Cancer'),
('000000192','Vision Loss'),
('000000193','Blood Disorders'),
('000000193','Hemophilia A'),
('000000194','Diabetes'),
('000000194','Metabolic Disorders'),
('000000195','Blood Disorders'),
('000000196','Blood Disorders'),
('000000197','Diabetes'),
('000000197','Metabolic Disorders'),
('000000198','Metabolic Disorders'),
('000000198','Neurological Disorders'),
('000000199','Heart disease associated with Duchenne muscular dystrophy'),
('000000199','Heart Disease'),
('000000200','Aging'),
('000000200','Alzheimer\'s Disease'),
('000000200','Amyotrophic Lateral Sclerosis'),
('000000200','Genetic Disorder'),
('000000200','Neurological Disorders'),
('000000201','Diabetes'),
('000000201','Metabolic Disorders'),
('000000202','Artemis deficient (ART-SCID)'),
('000000202','Blood Disorders'),
('000000202','Immune Disease'),
('000000202','Severe Combined Immunodeficiency'),
('000000204','Blood Cancer'),
('000000204','Cancer'),
('000000222','Amyotrophic Lateral Sclerosis'),
('000000222','Neurological Disorders'),
('000000224','Developmental Disorders'),
('000000224','Intestinal Disease'),
('000000224','Metabolic Disorders'),
('000000225','Brain Cancer'),
('000000225','Cancer'),
('000000228','Arthritis'),
('000000228','Bone or Cartilage Disease'),
('000000228','Multiple Sclerosis'),
('000000228','Neurological Disorders'),
('000000229','Vision Loss'),
('000000230','Cancer'),
('000000230','Melanoma'),
('000000231','Alzheimer\'s Disease'),
('000000231','Neurological Disorders'),
('000000232','Diabetes'),
('000000232','Diabetic Wounds'),
('000000232','Metabolic Disorders'),
('000000232','Skin Disease'),
('000000233','Arthritis'),
('000000233','Bone or Cartilage Disease'),
('000000237','Intestinal Disease'),
('000000237','Metabolic Disorders'),
('000000237','Neurological Disorders'),
('000000237','Pediatrics'),
('000000238','Heart Disease'),
('000000239','Liver Disease'),
('000000239','Metabolic Disorders'),
('000000240','Anemia'),
('000000240','Blood Cancer'),
('000000240','Blood Disorders'),
('000000240','Cancer'),
('000000241','Heart Disease'),
('000000242','Neurological Disorders'),
('000000242','Spinal Cord Injury'),
('000000243','Muscular Dystrophy'),
('000000243','Skeletal/Smooth Muscle disorders'),
('000000244','Blood Cancer'),
('000000244','Blood Disorders'),
('000000244','Cancer'),
('000000244','Heart Disease'),
('000000244','Liver Disease'),
('000000244','Metabolic Disorders'),
('000000245','HIV/AIDS'),
('000000245','Infectious Disease'),
('000000246','Bone or Cartilage Disease'),
('000000247','Other'),
('000000248','Vascular Disease'),
('000000249','Blood Disorders'),
('000000250','Bone or Cartilage Disease'),
('000000251','Other'),
('000000252','Amyotrophic Lateral Sclerosis'),
('000000252','Neurological Disorders'),
('000000252','Spinal Cord Injury'),
('000000252','Spinal Muscular Atrophy'),
('000000254','Amyotrophic Lateral Sclerosis'),
('000000254','Huntington\'s Disease'),
('000000254','Neurological Disorders'),
('000000257','Other'),
('000000258','Heart Disease'),
('000000258','Neurological Disorders'),
('000000259','Neurological Disorders'),
('000000259','Spinal Cord Injury'),
('000000260','Heart Disease'),
('000000262','Heart Disease'),
('000000262','Vascular Disease'),
('000000263','Heart Disease'),
('000000264','Other'),
('000000265','Blood Disorders'),
('000000266','Multiple Indications (Alpha Clinics)'),
('000000267','Cancer'),
('000000267','Solid Tumors'),
('000000269','Multiple Indications (Alpha Clinics)'),
('000000271','Multiple Indications (Alpha Clinics)'),
('000000272','Neurological Disorders'),
('000000273','Diabetes'),
('000000273','Metabolic Disorders'),
('000000275','Autism'),
('000000275','Neurological Disorders'),
('000000275','Pediatrics'),
('000000275','Rett\'s Syndrome'),
('000000276','Neurological Disorders'),
('000000276','Parkinson\'s Disease'),
('000000277','Diabetes'),
('000000277','Metabolic Disorders'),
('000000278','Neurological Disorders'),
('000000279','Heart Disease'),
('000000281','Neurological Disorders'),
('000000281','Spinal Cord Injury'),
('000000282','Blood Disorders'),
('000000283','Diabetes'),
('000000283','HIV/AIDS'),
('000000283','Immune Disease'),
('000000283','Infectious Disease'),
('000000283','Metabolic Disorders'),
('000000283','Pediatrics'),
('000000284','Aging'),
('000000284','Skeletal/Smooth Muscle disorders'),
('000000287','Respiratory Disorders'),
('000000288','Cancer'),
('000000288','Solid Tumors'),
('000000293','Neurological Disorders'),
('000000293','Parkinson\'s Disease'),
('000000293','Stroke'),
('000000294','Immune Disease'),
('000000294','Muscular Dystrophy'),
('000000294','Neurological Disorders'),
('000000294','Parkinson\'s Disease'),
('000000294','Pediatrics'),
('000000295','Cancer'),
('000000295','Prostate Cancer'),
('000000296','Amyotrophic Lateral Sclerosis'),
('000000296','Cancer'),
('000000296','HIV/AIDS'),
('000000296','Immune Disease'),
('000000296','Infectious Disease'),
('000000296','Melanoma'),
('000000296','Muscular Dystrophy'),
('000000296','Neurological Disorders'),
('000000296','Skeletal/Smooth Muscle disorders'),
('000000297','Blood Disorders'),
('000000297','Immune Disease'),
('000000297','Liver Disease'),
('000000297','Metabolic Disorders'),
('000000297','Pediatrics'),
('000000298','Genetic Disorder'),
('000000298','Liver Disease'),
('000000298','Metabolic Disorders'),
('000000298','Pediatrics'),
('000000299','Arthritis'),
('000000299','Bone or Cartilage Disease'),
('000000300','Huntington\'s Disease'),
('000000300','Neurological Disorders'),
('000000301','Cancer'),
('000000304','Respiratory Disorders'),
('000000305','Amyotrophic Lateral Sclerosis'),
('000000305','Neurological Disorders'),
('000000306','Blood Disorders'),
('000000306','Pediatrics'),
('000000307','Aging'),
('000000309','Autism'),
('000000309','Neurological Disorders'),
('000000310','Vision Loss'),
('000000311','Neurological Disorders'),
('000000311','Pediatrics'),
('000000312','Infectious Disease'),
('000000312','Liver Disease'),
('000000313','Alzheimer\'s Disease'),
('000000313','Neurological Disorders'),
('000000314','Multiple Indications (Alpha Clinics)'),
('000000315','Multiple Indications (Alpha Clinics)'),
('000000317','Diabetes'),
('000000317','Metabolic Disorders'),
('000000318','Brain Cancer'),
('000000318','Cancer'),
('000000318','Neurological Disorders'),
('000000318','Pediatrics'),
('000000318','Solid Tumors'),
('000000319','Neurological Disorders'),
('000000319','Neuropathy'),
('000000320','Heart Disease'),
('000000321','Skin Disease'),
('000000322','Heart Disease'),
('000000323','Fertility'),
('000000324','Muscular Dystrophy'),
('000000324','Skeletal/Smooth Muscle disorders'),
('000000325','Blood Cancer'),
('000000325','Blood Disorders'),
('000000326','Neurological Disorders'),
('000000326','Pediatrics'),
('000000328','Aging'),
('000000328','Neurological Disorders'),
('000000329','Blood Cancer'),
('000000329','Cancer'),
('000000331','Vision Loss'),
('000000332','Amyotrophic Lateral Sclerosis'),
('000000332','Neurological Disorders'),
('000000332','Neuropathy'),
('000000333','Heart Disease'),
('000000333','Pediatrics'),
('000000336','Skin Disease'),
('000000337','Neurological Disorders'),
('000000337','Rett\'s Syndrome'),
('000000338','Heart Disease'),
('000000339','Neurological Disorders'),
('000000341','Amyotrophic Lateral Sclerosis'),
('000000341','Dementia'),
('000000341','Neurological Disorders'),
('000000342','Heart Disease'),
('000000345','Cancer'),
('000000345','Melanoma'),
('000000345','Skin cancer'),
('000000345','Solid Tumors'),
('000000346','Heart Disease'),
('000000346','Vascular Disease'),
('000000347','Bone or Cartilage Disease'),
('000000347','Osteonecrosis'),
('000000348','Huntington\'s Disease'),
('000000348','Neurological Disorders'),
('000000349','Kidney Disease'),
('000000350','Muscular Dystrophy'),
('000000350','Pediatrics'),
('000000350','Skeletal/Smooth Muscle disorders'),
('000000351','Alzheimer\'s Disease'),
('000000351','Neurological Disorders'),
('000000352','Heart Disease'),
('000000352','Heart failure'),
('000000353','Bone or Cartilage Disease'),
('000000354','Brain Cancer'),
('000000354','Cancer'),
('000000355','Vascular Disease'),
('000000356','Multiple Sclerosis'),
('000000356','Neurological Disorders'),
('000000357','Heart Disease'),
('000000358','Epilepsy'),
('000000358','Neurological Disorders'),
('000000358','Spinal Cord Injury'),
('000000359','Neurological Disorders'),
('000000359','Pediatrics'),
('000000364','Alzheimer\'s Disease'),
('000000364','Neurological Disorders'),
('000000366','Aging'),
('000000367','Neurological Disorders'),
('000000368','Diabetes'),
('000000368','Metabolic Disorders'),
('000000370','Respiratory Disorders'),
('000000371','Cancer'),
('000000372','Neurological Disorders'),
('000000372','Parkinson\'s Disease'),
('000000373','Bone or Cartilage Disease'),
('000000374','Heart Disease'),
('000000375','Amyotrophic Lateral Sclerosis'),
('000000375','Neurological Disorders'),
('000000384','Neurological Disorders'),
('000000385','Aging'),
('000000385','Alzheimer\'s Disease'),
('000000385','Autism'),
('000000385','Neurological Disorders'),
('000000386','Fertility'),
('000000388','Heart Disease'),
('000000388','Pediatrics'),
('000000389','Diabetes'),
('000000389','Metabolic Disorders'),
('000000390','Heart Disease'),
('000000391','Huntington\'s Disease'),
('000000391','Neurological Disorders'),
('000000393','Autism'),
('000000393','Neurological Disorders'),
('000000393','Pediatrics'),
('000000393','Rett\'s Syndrome'),
('000000395','Amyotrophic Lateral Sclerosis'),
('000000395','Neurological Disorders'),
('000000396','Genetic Disorder'),
('000000398','Infectious Disease'),
('000000398','Neurological Disorders'),
('000000402','Neurological Disorders'),
('000000402','Pediatrics'),
('000000403','Neurological Disorders'),
('000000403','Parkinson\'s Disease'),
('000000405','Neurological Disorders'),
('000000409','Autism'),
('000000409','Neurological Disorders'),
('000000409','Trauma'),
('000000410','Neurological Disorders'),
('000000410','Pediatrics'),
('000000412','Neurological Disorders'),
('000000412','Parkinson\'s Disease'),
('000000413','Genetic Disorder'),
('000000413','Intestinal Disease'),
('000000413','Metabolic Disorders'),
('000000413','Pediatrics'),
('000000414','Neurological Disorders'),
('000000414','Stroke'),
('000000416','HIV/AIDS'),
('000000416','Immune Disease'),
('000000416','Infectious Disease'),
('000000417','Neurological Disorders'),
('000000417','Pediatrics'),
('000000418','Blood Cancer'),
('000000418','Cancer'),
('000000419','Epilepsy'),
('000000419','Neurological Disorders'),
('000000420','Bone or Cartilage Disease'),
('000000421','Vision Loss'),
('000000422','Neurological Disorders'),
('000000422','Parkinson\'s Disease'),
('000000423','Liver Disease'),
('000000423','Metabolic Disorders'),
('000000424','Amyotrophic Lateral Sclerosis'),
('000000424','Autism'),
('000000424','Blood Disorders'),
('000000424','Genetic Disorder'),
('000000424','Neurological Disorders'),
('000000424','Parkinson\'s Disease'),
('000000424','Pediatrics'),
('000000424','Rett\'s Syndrome'),
('000000425','Brain Cancer'),
('000000425','Cancer'),
('000000426','HIV/AIDS'),
('000000426','Immune Disease'),
('000000428','Blood Cancer'),
('000000428','Cancer'),
('000000429','Brain Cancer'),
('000000429','Cancer'),
('000000431','Neurological Disorders'),
('000000433','Pediatrics'),
('000000434','Immune Disease'),
('000000435','Blood Disorders'),
('000000436','Alzheimer\'s Disease'),
('000000436','Neurological Disorders'),
('000000437','Immune Disease'),
('000000440','Neurological Disorders'),
('000000441','Blood Disorders'),
('000000441','Pediatrics'),
('000000442','Diabetes'),
('000000442','Immune Disease'),
('000000442','Metabolic Disorders'),
('000000443','Immune Disease'),
('000000443','Pediatrics'),
('000000445','Epilepsy'),
('000000445','Neurological Disorders'),
('000000447','Blood Disorders'),
('000000447','Immune Disease'),
('000000448','Immune Disease'),
('000000453','Neurological Disorders'),
('000000453','Spinal Cord Injury'),
('000000454','Brain Cancer'),
('000000454','Cancer'),
('000000455','Blood Cancer'),
('000000455','Cancer'),
('000000456','Epidermolysis Bullosa'),
('000000456','Pediatrics'),
('000000457','HIV/AIDS'),
('000000457','Infectious Disease'),
('000000458','Diabetes'),
('000000458','Metabolic Disorders'),
('000000459','Heart Disease'),
('000000462','Blood Disorders'),
('000000465','Neurological Disorders'),
('000000465','Parkinson\'s Disease'),
('000000467','Diabetes'),
('000000467','Metabolic Disorders'),
('000000468','Aging'),
('000000468','Vision Loss'),
('000000469','Cancer'),
('000000471','Neurological Disorders'),
('000000471','Parkinson\'s Disease'),
('000000472','Bone or Cartilage Disease'),
('000000473','Vision Loss'),
('000000475','Huntington\'s Disease'),
('000000475','Neurological Disorders'),
('000000476','Aging'),
('000000476','Alzheimer\'s Disease'),
('000000476','Neurological Disorders'),
('000000477','Blood Disorders'),
('000000477','Heart Disease'),
('000000479','Brain Cancer'),
('000000479','Cancer'),
('000000483','Heart Disease'),
('000000491','Liver Disease'),
('000000491','Metabolic Disorders'),
('000000493','Amyotrophic Lateral Sclerosis'),
('000000493','Neurological Disorders'),
('000000498','Heart Disease'),
('000000501','Diabetes'),
('000000501','Metabolic Disorders'),
('000000506','Neurological Disorders'),
('000000507','Bone or Cartilage Disease'),
('000000507','Trauma'),
('000000509','Heart Disease'),
('000000516','Heart Disease'),
('000000517','Amyotrophic Lateral Sclerosis'),
('000000517','Neurological Disorders'),
('000000518','Fertility'),
('000000520','Neurological Disorders'),
('000000520','Parkinson\'s Disease'),
('000000521','Genetic Disorder'),
('000000521','Muscular Dystrophy'),
('000000521','Pediatrics'),
('000000521','Skeletal/Smooth Muscle disorders'),
('000000523','Genetic Disorder'),
('000000523','Pediatrics'),
('000000524','Heart Disease'),
('000000524','Toxicity'),
('000000525','Dementia'),
('000000525','Neurological Disorders'),
('000000537','Heart Disease'),
('000000538','Aging'),
('000000538','Alzheimer\'s Disease'),
('000000539','Cancer'),
('000000539','Solid Tumors'),
('000000541','Blood Cancer'),
('000000541','Cancer'),
('000000542','Heart Disease'),
('000000543','Muscular Dystrophy'),
('000000543','Skeletal/Smooth Muscle disorders'),
('000000544','Bone or Cartilage Disease'),
('000000545','Neurological Disorders'),
('000000545','Parkinson\'s Disease'),
('000000546','Amyotrophic Lateral Sclerosis'),
('000000546','Neurological Disorders'),
('000000547','Aging'),
('000000547','Muscular Dystrophy'),
('000000547','Pediatrics'),
('000000547','Skeletal/Smooth Muscle disorders'),
('000000547','Trauma'),
('000000551','Fertility'),
('000000556','Heart Disease'),
('000000557','Amyotrophic Lateral Sclerosis'),
('000000557','Neurological Disorders'),
('000000557','Spinal Cord Injury'),
('000000557','Spinal Muscular Atrophy'),
('000000559','Neurological Disorders'),
('000000559','Stroke'),
('000000560','Hearing Loss'),
('000000561','Heart Disease'),
('000000562','Heart Disease'),
('000000563','Immune Disease'),
('000000563','Multiple Sclerosis'),
('000000563','Neurological Disorders'),
('000000563','Stroke'),
('000000569','Cancer'),
('000000569','Melanoma'),
('000000570','Cancer'),
('000000571','Cancer'),
('000000571','Pediatrics'),
('000000572','Vascular Disease'),
('000000575','Cancer'),
('000000576','Neurological Disorders'),
('000000576','Parkinson\'s Disease'),
('000000577','Neurological Disorders'),
('000000577','Spinal Cord Injury'),
('000000577','Stroke'),
('000000577','Trauma'),
('000000578','Aging'),
('000000578','Vision Loss'),
('000000584','Heart Disease'),
('000000586','Intestinal Disease'),
('000000586','Metabolic Disorders'),
('000000586','Pediatrics'),
('000000586','Trauma'),
('000000587','Cancer'),
('000000589','Diabetes'),
('000000589','Metabolic Disorders'),
('000000590','Immune Disease'),
('000000590','Multiple Sclerosis'),
('000000591','Cancer'),
('000000591','Neurological Disorders'),
('000000592','Bone or Cartilage Disease'),
('000000593','Hearing Loss'),
('000000595','Genetic Disorder'),
('000000595','Muscular Dystrophy'),
('000000596','Fertility'),
('000000598','Autism'),
('000000598','Developmental Disorders');

INSERT works_for VALUES
('000000592','University of California, Davis'),
('000000535','University of California, San Francisco'),
('000000386','Stanford University'),
('000000382','University of California, Los Angeles'),
('000000104','University of California, Irvine'),
('000000107','ViaCyte, Inc.'),
('000000075','Stanford University'),
('000000034','Stanford University'),
('000000154','Sanford Burnham Prebys Medical Discovery Institute'),
('000000326','Children\'s Neurobiological Solutions (CNS) Foundation'),
('000000334','Stanford University'),
('000000351','StemCells, Inc.'),
('000000579','Sanford Burnham Prebys Medical Discovery Institute'),
('000000456','Stanford University'),
('000000147','Rumi Scientific CA'),
('000000322','University of California, Los Angeles'),
('000000111','University of California, Davis'),
('000000010','Vitabolus, Inc.'),
('000000116','University of California, Los Angeles'),
('000000458','ViaCyte, Inc.'),
('000000122','University of California, Davis'),
('000000168','University of California, San Diego'),
('000000523','University of California, Los Angeles'),
('000000340','University of California, San Diego'),
('000000056','Aspen Neuroscience'),
('000000190','University of California, San Francisco'),
('000000270','University of California, Berkeley'),
('000000249','University of California, San Francisco'),
('000000349','University of Southern California'),
('000000542','University of California, Irvine'),
('000000385','University of California, San Diego'),
('000000286','Human Organ Project'),
('000000434','La Jolla Institute for Allergy and Immunology'),
('000000325','University of California, San Francisco'),
('000000328','Stanford University'),
('000000225','ImmunoCellular Therapeutics'),
('000000136','International Alliance for Biological Standardization'),
('000000117','Stanford University'),
('000000345','University of California, Los Angeles'),
('000000109','University of California, Los Angeles'),
('000000186','University of California, Los Angeles'),
('000000358','University of California, San Francisco'),
('000000419','University of California, San Francisco'),
('000000384','Brain Mapping Foundation'),
('000000478','Berkeley City College'),
('000000343','University of California, San Francisco'),
('000000304','Cedars-Sinai Medical Center'),
('000000450','Escape Therapeutics, Inc'),
('000000452','University of California, Los Angeles'),
('000000508','University of California, San Diego'),
('000000189','University of California, Los Angeles'),
('000000338','Gladstone Institutes, J. David'),
('000000379','University of California, Santa Barbara'),
('000000084','Stanford University'),
('000000090','Sangamo BioSciences, Inc.'),
('000000582','Salk Institute for Biological Studies'),
('000000060','Cal State Univ, San Marcos'),
('000000141','SanBio, Inc.'),
('000000152','University of Southern California'),
('000000546','University of California, Santa Cruz'),
('000000504','Ludwig Institute for Cancer Research'),
('000000395','University of California, San Diego'),
('000000165','Parkinson\'s Institute'),
('000000091','Fate Therapeutics, Inc.'),
('000000477','University of California, San Francisco'),
('000000023','University of California, Irvine'),
('000000414','Stanford University'),
('000000039','University of California, Los Angeles'),
('000000524','Gladstone Institutes, J. David'),
('000000420','University of California, Los Angeles'),
('000000586','Stanford University'),
('000000307','University of California, Santa Cruz'),
('000000217','City College Of San Francisco'),
('000000251','University of California, Los Angeles'),
('000000492','Scripps Research Institute'),
('000000488','San Francisco State University'),
('000000035','University of California, Los Angeles'),
('000000581','University of California, Berkeley'),
('000000555','Children\'s Hospital of Los Angeles'),
('000000097','International Society for Stem Cell Research'),
('000000119','University of California, San Diego'),
('000000389','University of California, San Diego'),
('000000591','University of California, Irvine'),
('000000509','Stanford University'),
('000000541','University of California, Davis'),
('000000176','Midwinter Conference of Immunologists'),
('000000279','University of California, San Diego'),
('000000134','City of Hope, Beckman Research Institute'),
('000000444','Stanford University'),
('000000556','Stanford University'),
('000000536','University of Southern California'),
('000000218','Cal State Univ, Northridge'),
('000000047','Cedars-Sinai Medical Center'),
('000000131','Nohla Therapeutics Inc'),
('000000282','University of California, San Diego'),
('000000025','Neurona Therapeutics'),
('000000356','University of California, Irvine'),
('000000003','University of California, Los Angeles'),
('000000089','Stanford University'),
('000000594','Buck Institute for Age Research'),
('000000299','Cedars-Sinai Medical Center'),
('000000007','University of California, San Diego'),
('000000291','University of California, Los Angeles'),
('000000093','Medeor Therapeutics, Inc.'),
('000000412','University of California, San Francisco'),
('000000026','University of California, Irvine'),
('000000233','Scripps Health'),
('000000490','Children\'s Hospital of Los Angeles'),
('000000017','Boston Children\'s Hospital'),
('000000182','California Institute of Technology'),
('000000113','Loma Linda University'),
('000000267','University of California, San Diego'),
('000000426','City of Hope, Beckman Research Institute'),
('000000573','University of California, Santa Cruz'),
('000000484','University of California, Santa Cruz'),
('000000578','University of Southern California'),
('000000377','University of California, Davis'),
('000000435','University of California, Berkeley'),
('000000095','University of California, San Francisco'),
('000000179','University of California, Berkeley'),
('000000231','Salk Institute for Biological Studies'),
('000000180','University of California, Davis'),
('000000277','California Institute of Technology'),
('000000196','International Society for Experimental Hematology'),
('000000513','University of Southern California'),
('000000145','University of California, Davis'),
('000000315','FUJIFILM Cellular Dynamics'),
('000000398','University of California, San Diego'),
('000000331','Buck Institute for Age Research'),
('000000164','Gladstone Institutes, J. David'),
('000000169','University of Southern California'),
('000000455','University of California, San Diego'),
('000000481','University of California, Santa Barbara'),
('000000288','University of California, Los Angeles'),
('000000077','Poseida Therapeutics, Inc.'),
('000000006','University of California, Davis'),
('000000256','University of California, San Francisco'),
('000000265','University of California, San Diego'),
('000000589','University of California, San Francisco'),
('000000195','University of California, San Diego'),
('000000114','Cedars-Sinai Medical Center'),
('000000008','University of California, Los Angeles'),
('000000376','University of California, San Diego'),
('000000438','University of California, Los Angeles'),
('000000538','Western University of Health Sciences'),
('000000497','Gamma Medica-Ideas, Inc.'),
('000000558','University of California, Irvine'),
('000000593','University of California, Davis'),
('000000342','Cedars-Sinai Medical Center'),
('000000226','Sanford Consortium for Regenerative Medicine'),
('000000066','Angiocrine Bioscience, Inc.'),
('000000506','University of California, Irvine'),
('000000009','Lundquist Institute for Biomedical Innovation at Harbor - UCLA Medical Center'),
('000000571','Children\'s Hospital of Los Angeles'),
('000000427','Vitalant Research Institute'),
('000000220','Childrens Hospital of Oakland Research Institute'),
('000000437','University of California, Berkeley'),
('000000321','University of California, Davis'),
('000000519','ViaCyte, Inc.'),
('000000428','University of California, San Francisco'),
('000000079','University of California, San Diego'),
('000000305','University of California, San Diego'),
('000000433','University of California, Davis'),
('000000574','Gladstone Institutes, J. David'),
('000000139','JDRF International'),
('000000175','IQVIA, Inc.'),
('000000341','University of California, San Diego'),
('000000027','Sanford Burnham Prebys Medical Discovery Institute'),
('000000065','Stanford University'),
('000000501','ViaCyte, Inc.'),
('000000137','University of California, San Diego'),
('000000250','Stanford University'),
('000000388','University of California, San Diego'),
('000000083','MAX BioPharma, Inc.'),
('000000201','Semma Therapeutics'),
('000000598','Gladstone Institutes, J. David'),
('000000223','City of Hope, Beckman Research Institute'),
('000000317','City of Hope, Beckman Research Institute'),
('000000404','University of California, Santa Barbara'),
('000000259','Lineage Cell Therapeutics Inc.'),
('000000476','University of California, Irvine'),
('000000585','University of California, Riverside'),
('000000424','Salk Institute for Biological Studies'),
('000000487','University of California, Davis'),
('000000306','Sangamo BioSciences, Inc.'),
('000000473','University of California, Los Angeles'),
('000000507','University of Southern California'),
('000000446','Stanford University'),
('000000553','Salk Institute for Biological Studies'),
('000000149','Stanford University'),
('000000040','University of California, Los Angeles'),
('000000019','Rocket Pharmaceuticals, Inc.'),
('000000531','University of California, Los Angeles'),
('000000457','Calimmune, Inc.'),
('000000528','University of California, Berkeley'),
('000000129','Alliance Forum Foundation'),
('000000336','University of California, San Diego'),
('000000235','Ocular Research Symposia Foundation, Inc.'),
('000000339','Stanford University'),
('000000298','University of California, Los Angeles'),
('000000123','University of California, San Diego'),
('000000043','University of California, Davis'),
('000000533','University of California, Santa Barbara'),
('000000096','International Society for Stem Cell Research'),
('000000597','University of California, Irvine'),
('000000568','Sanford Burnham Prebys Medical Discovery Institute'),
('000000121','Stanford University'),
('000000559','University of California, Los Angeles'),
('000000466','Stanford University'),
('000000240','University of California, Los Angeles'),
('000000557','University of California, Irvine'),
('000000562','University of California, San Francisco'),
('000000566','University of California, San Francisco'),
('000000021','Stanford University'),
('000000086','Childrens Hospital of Oakland Research Institute'),
('000000046','jCyte, Inc'),
('000000209','California Institute of Technology'),
('000000001','University of California, San Francisco'),
('000000042','Stanford University'),
('000000140','University of California, San Francisco'),
('000000335','Stanford University'),
('000000132','ViaCyte, Inc.'),
('000000494','University of California, Los Angeles'),
('000000583','Sanford Burnham Prebys Medical Discovery Institute'),
('000000333','Sanford Burnham Prebys Medical Discovery Institute'),
('000000448','Palo Alto Veterans Institute for Research'),
('000000297','Salk Institute for Biological Studies'),
('000000431','iPierian, Inc.'),
('000000547','University of California, Berkeley'),
('000000416','University of California, Los Angeles'),
('000000244','Stanford University'),
('000000246','University of California, Davis'),
('000000471','Parkinson\'s Institute'),
('000000159','Cellular Biomedicine Group, Inc.'),
('000000185','University of California, Berkeley'),
('000000215','Humboldt State University'),
('000000312','University of California, San Francisco'),
('000000313','University of California, San Diego'),
('000000237','Stanford University'),
('000000362','Scripps Research Institute'),
('000000475','University of California, Davis'),
('000000602','Geron Corporation'),
('000000155','University of California, Irvine'),
('000000324','University of California, San Francisco'),
('000000285','University of California, San Francisco'),
('000000181','Scripps Research Institute'),
('000000442','University of California, San Francisco'),
('000000192','Stanford University'),
('000000133','Humacyte, Inc.'),
('000000515','University of California, San Francisco'),
('000000290','University of California, San Francisco'),
('000000261','Biocom Institute'),
('000000540','University of California, Merced'),
('000000202','University of California, San Francisco'),
('000000332','University of California, San Francisco'),
('000000033','City of Hope, Beckman Research Institute'),
('000000411','GMR Epigenetics'),
('000000402','City of Hope, Beckman Research Institute'),
('000000482','Cal Poly Pomona'),
('000000472','Stanford University'),
('000000309','Stanford University'),
('000000303','University of California, San Diego'),
('000000406','TriFoil Imaging, Inc.'),
('000000387','Stanford University'),
('000000391','Scripps Research Institute'),
('000000502','University of California, Santa Cruz'),
('000000100','University of California, Los Angeles'),
('000000124','Human BioMolecular Research Institute'),
('000000166','University of California, Los Angeles'),
('000000572','Stanford University'),
('000000417','iPierian, Inc.'),
('000000300','Numerate, Inc.'),
('000000527','Stanford University'),
('000000373','Samumed, LLC'),
('000000346','University of California, Davis'),
('000000399','University of California, San Francisco'),
('000000222','University of California, San Diego'),
('000000445','University of California, San Francisco'),
('000000532','University of California, Merced'),
('000000405','Cedars-Sinai Medical Center'),
('000000041','City of Hope, Beckman Research Institute'),
('000000071','University of California, San Diego'),
('000000198','University of California, Davis'),
('000000269','Salk Institute for Biological Studies'),
('000000311','University of California, San Diego'),
('000000238','City of Hope, Beckman Research Institute'),
('000000092','City of Hope, Beckman Research Institute'),
('000000005','Immune-Onc Therapeutics'),
('000000098','Stanford University'),
('000000271','University of California, Santa Cruz'),
('000000355','Salk Institute for Biological Studies'),
('000000062','Stanford University'),
('000000110','Loma Linda University'),
('000000521','Stanford University'),
('000000167','University of California, San Francisco'),
('000000301','Stanford University'),
('000000150','Scaled Biolabs Inc.'),
('000000012','University of Southern California'),
('000000310','University of California, San Diego'),
('000000262','University of California, Merced'),
('000000050','City of Hope, Beckman Research Institute'),
('000000024','University of California, San Diego'),
('000000068','University of California, San Francisco'),
('000000378','University of California, San Francisco'),
('000000548','Stanford University'),
('000000118','University of California, San Diego'),
('000000408','University of California, San Diego'),
('000000381','Stanford University'),
('000000206','University of California, San Francisco'),
('000000337','University of California, Los Angeles'),
('000000360','University of Southern California'),
('000000078','Stanford University'),
('000000480','University of California, Los Angeles'),
('000000443','Stanford University'),
('000000183','ViaCyte, Inc.'),
('000000022','University of California, Berkeley'),
('000000059','Rocket Pharmaceuticals, Inc.'),
('000000503','University of California, Davis'),
('000000584','Stanford University'),
('000000125','Calibr'),
('000000397','Scripps Research Institute'),
('000000491','VistaGen Therapeutics, Inc.'),
('000000049','Brain Neurotherapy Bio'),
('000000400','University of California, San Diego'),
('000000451','University of California, San Diego'),
('000000108','Stanford University'),
('000000595','University of California, Irvine'),
('000000353','University of California, Davis'),
('000000500','City of Hope, Beckman Research Institute'),
('000000529','University of California, Davis'),
('000000248','University of California, Davis'),
('000000200','University of California, San Diego'),
('000000545','Salk Institute for Biological Studies'),
('000000252','University of California, Los Angeles'),
('000000004','City of Hope, Beckman Research Institute'),
('000000253','Gordon Research Conferences'),
('000000173','Orchard Therapeutics plc'),
('000000064','University of California, Irvine'),
('000000080','Gladstone Institutes, J. David'),
('000000002','University of California, Los Angeles'),
('000000213','San Francisco State University'),
('000000511','University of California, Berkeley'),
('000000365','University of California, Santa Barbara'),
('000000187','Cedars-Sinai Medical Center'),
('000000551','University of California, San Francisco'),
('000000199','Capricor, Inc'),
('000000549','University of California, Santa Cruz'),
('000000278','University of California, Irvine'),
('000000212','Cal State Univ, Sacramento'),
('000000210','Cal State Univ, Long Beach'),
('000000514','University of California, San Francisco'),
('000000462','University of California, Los Angeles'),
('000000085','University of California, Irvine'),
('000000273','University of California, San Diego'),
('000000323','University of California, San Diego'),
('000000415','Fluidigm Corporation'),
('000000372','Sanford Burnham Prebys Medical Discovery Institute'),
('000000193','Vitalant Research Institute'),
('000000534','University of California, Santa Cruz'),
('000000449','University of California, Irvine'),
('000000327','Research for Cure'),
('000000275','Stanford University'),
('000000020','University of California, San Diego'),
('000000283','University of California, San Francisco'),
('000000601','Forty Seven Inc.'),
('000000052','University of Southern California'),
('000000580','Stanford University'),
('000000144','Stanford University'),
('000000057','University of California, San Francisco'),
('000000289','University of California, Davis'),
('000000423','University of California, Davis'),
('000000148','Children\'s Hospital of Los Angeles'),
('000000418','City of Hope, Beckman Research Institute'),
('000000463','University of Southern California'),
('000000370','University of California, Davis'),
('000000468','Scripps Research Institute'),
('000000453','University of California, San Diego'),
('000000413','University of California, Los Angeles'),
('000000375','University of California, Los Angeles'),
('000000526','Buck Institute for Age Research'),
('000000011','University of California, Irvine'),
('000000302','OCTANe Foundation for Innovation'),
('000000130','Stanford University'),
('000000127','Poseida Therapeutics, Inc.'),
('000000053','University of California, Davis'),
('000000479','City of Hope, Beckman Research Institute'),
('000000396','Stanford University'),
('000000329','Stanford University'),
('000000530','University of California, Irvine'),
('000000172','Cedars-Sinai Medical Center'),
('000000516','Stanford University'),
('000000037','University of California, San Francisco'),
('000000496','University of California, Los Angeles'),
('000000565','University of California, Riverside'),
('000000126','Children\'s Hospital of Los Angeles'),
('000000401','University of California, Berkeley'),
('000000266','Stanford University'),
('000000464','University of California, Los Angeles'),
('000000474','BioTime, Inc.'),
('000000294','Stanford University'),
('000000260','University of California, Irvine'),
('000000318','Stanford University'),
('000000330','University of California, San Francisco'),
('000000272','University of California, San Diego'),
('000000460','University of California, Davis'),
('000000454','University of California, San Francisco'),
('000000537','Mohammad Pashmforoush'),
('000000088','University of California, San Francisco'),
('000000347','University of California, Davis'),
('000000156','American Association of Blood Banks'),
('000000074','University of Southern California'),
('000000112','Palo Alto Veterans Institute for Research'),
('000000447','Scripps Research Institute'),
('000000219','Cal State Univ, San Bernadino'),
('000000207','Cal State Univ, Fullerton'),
('000000205','Cal State Univ, Channel Island'),
('000000425','University of California, Los Angeles'),
('000000467','ViaCyte, Inc.'),
('000000224','Gordon Research Conferences'),
('000000495','University of California, Irvine'),
('000000191','University of California, Los Angeles'),
('000000470','Jackson Labs'),
('000000216','Pasadena City College'),
('000000498','Vala Sciences, Inc.'),
('000000204','Angiocrine Bioscience, Inc.'),
('000000510','University of California, Davis'),
('000000280','Cedars-Sinai Medical Center'),
('000000369','California Institute of Technology'),
('000000171','City of Hope, Beckman Research Institute'),
('000000208','Stanford University'),
('000000245','University of Southern California'),
('000000197','University of California, Los Angeles'),
('000000287','University of California, Davis'),
('000000600','University of California, Irvine'),
('000000421','University of California, Santa Barbara'),
('000000268','University of California, Irvine'),
('000000587','University of Southern California'),
('000000184','IQVIA, Inc.'),
('000000228','Calibr'),
('000000055','University of California, San Francisco'),
('000000073','Stanford University'),
('000000359','Children\'s Hospital of Orange County'),
('000000188','Stanford University'),
('000000038','ExCellThera Inc.'),
('000000499','University of Southern California'),
('000000030','University of Southern California'),
('000000550','University of California, Riverside'),
('000000247','University of Southern California'),
('000000234','University of Southern California'),
('000000403','Parkinson\'s Institute'),
('000000352','Capricor, Inc'),
('000000174','San Diego State University Foundation'),
('000000138','BrainStorm Cell Therapeutics'),
('000000561','University of California, San Francisco'),
('000000236','University of California, Davis'),
('000000599','University of California, Berkeley'),
('000000292','University of California, San Francisco'),
('000000518','Stanford University'),
('000000320','University of California, Los Angeles'),
('000000512','San Diego State University Foundation'),
('000000410','University of California, Los Angeles'),
('000000368','City of Hope, Beckman Research Institute'),
('000000459','University of California, Los Angeles'),
('000000230','Caladrius Biosciences'),
('000000525','Gladstone Institutes, J. David'),
('000000319','Cedars-Sinai Medical Center'),
('000000505','University of California, San Francisco'),
('000000013','University of California, Irvine'),
('000000485','Gladstone Institutes, J. David'),
('000000486','University of Southern California'),
('000000432','Stanford University'),
('000000596','Sanford Burnham Prebys Medical Discovery Institute'),
('000000295','University of California, Los Angeles'),
('000000374','Stanford University'),
('000000177','University of California, San Diego'),
('000000344','University of California, Berkeley'),
('000000429','Sanford Burnham Prebys Medical Discovery Institute'),
('000000364','University of Southern California'),
('000000163','Stanford University'),
('000000367','International Symposium on Neural Regeneration, Inc.'),
('000000203','Mosaic Event Management, Inc.'),
('000000081','Salk Institute for Biological Studies'),
('000000383','University of California, Irvine'),
('000000045','Stanford University'),
('000000232','University of California, Davis'),
('000000380','University of California, San Diego'),
('000000281','University of California, Los Angeles'),
('000000517','Salk Institute for Biological Studies'),
('000000563','University of California, San Francisco'),
('000000157','Stanford University'),
('000000242','Stanford University'),
('000000105','City of Hope, Beckman Research Institute'),
('000000051','City of Hope, Beckman Research Institute'),
('000000102','University of California, Los Angeles'),
('000000554','University of California, Los Angeles'),
('000000390','Stanford University'),
('000000120','University of California, San Francisco'),
('000000194','Children\'s Hospital of Los Angeles'),
('000000564','Salk Institute for Biological Studies'),
('000000363','Gladstone Institutes, J. David'),
('000000241','University of California, San Diego'),
('000000229','Cedars-Sinai Medical Center'),
('000000263','Gladstone Institutes, J. David'),
('000000178','Vitalant Research Institute'),
('000000308','University of California, San Diego'),
('000000394','University of California, Los Angeles'),
('000000103','University of California, San Francisco'),
('000000243','University of California, San Diego'),
('000000539','University of California, Los Angeles'),
('000000227','University of California, Irvine'),
('000000031','University of California, Los Angeles'),
('000000158','University of California, Los Angeles'),
('000000544','University of Southern California'),
('000000153','University of California, San Francisco'),
('000000048','University of California, Los Angeles'),
('000000014','University of California, Los Angeles'),
('000000350','University of California, Los Angeles'),
('000000560','Stanford University'),
('000000054','University of California, San Diego'),
('000000354','City of Hope, Beckman Research Institute'),
('000000161','St. Jude Children\'s Research Hospital'),
('000000028','University of California, San Diego'),
('000000441','Stanford University'),
('000000407','University of California, Berkeley'),
('000000018','University of California, San Francisco'),
('000000082','University of California, Los Angeles'),
('000000254','Gladstone Institutes, J. David'),
('000000087','University of California, San Francisco'),
('000000069','University of California, Los Angeles'),
('000000293','Sanford Burnham Prebys Medical Discovery Institute'),
('000000036','Scripps Research Institute'),
('000000576','University of California, San Francisco'),
('000000465','Stanford University'),
('000000255','University of California, San Francisco'),
('000000151','Cellerant Therapeutics, Inc.'),
('000000483','University of California, San Diego'),
('000000101','University of California, San Diego'),
('000000015','University of California, San Diego'),
('000000316','University of California, Los Angeles'),
('000000162','University of California, San Francisco'),
('000000440','Cedars-Sinai Medical Center'),
('000000094','Keystone Symposia on Molecular and Cellular Biology'),
('000000575','University of California, San Francisco'),
('000000409','Stanford University'),
('000000058','University of California, Los Angeles'),
('000000070','Stanford University'),
('000000135','University of California, San Diego'),
('000000590','University of California, Irvine'),
('000000314','Cellular Dynamics International'),
('000000284','Palo Alto Veterans Institute for Research'),
('000000567','Stanford University'),
('000000128','RUNX1 Research Program'),
('000000371','OncoMed Pharmaceuticals, Inc.'),
('000000570','City of Hope, Beckman Research Institute'),
('000000142','University of California, San Francisco'),
('000000543','City of Hope, Beckman Research Institute'),
('000000258','Gladstone Institutes, J. David'),
('000000436','Palo Alto Veterans Institute for Research'),
('000000239','University of Southern California'),
('000000072','Children\'s Hospital of Los Angeles'),
('000000211','Cal Poly Corporation, an Auxiliary of California Polytechnic State University, San Luis Obispo'),
('000000214','San Jose State University'),
('000000489','Scripps Research Institute'),
('000000032','University of California, Los Angeles'),
('000000264','University of California, San Francisco'),
('000000361','Childrens Hospital of Oakland Research Institute'),
('000000115','Zenobia Therapeutics'),
('000000348','University of California, Davis'),
('000000067','Pathways to Stem Cell Science'),
('000000366','Buck Institute for Age Research'),
('000000588','University of California, Irvine'),
('000000552','Stanford University'),
('000000221','Cedars-Sinai Medical Center'),
('000000357','University of California, Davis'),
('000000461','University of Southern California'),
('000000469','Gladstone Institutes, J. David'),
('000000522','Ludwig Institute for Cancer Research'),
('000000274','University of California, San Diego'),
('000000063','Jasper Therapeutics, Inc.'),
('000000392','University of California, Los Angeles'),
('000000430','University of California, Davis'),
('000000160','Caladrius Biosciences'),
('000000257','University of California, Berkeley'),
('000000422','Buck Institute for Age Research'),
('000000029','Celularity Inc'),
('000000099','University of California, Riverside'),
('000000146','X-Therma Inc.'),
('000000276','Stanford University'),
('000000076','City of Hope, Beckman Research Institute'),
('000000170','Gladstone Institutes, J. David'),
('000000106','University of California, San Diego'),
('000000016','City of Hope, Beckman Research Institute'),
('000000393','University of California, Los Angeles'),
('000000493','University of California, San Diego'),
('000000061','Ankasa Regenerative Therapeutics'),
('000000439','University of California, Los Angeles'),
('000000143','City of Hope, Beckman Research Institute'),
('000000044','University of California, Los Angeles'),
('000000296','University of California, Los Angeles'),
('000000520','Sanford Burnham Prebys Medical Discovery Institute'),
('000000577','Sanford Burnham Prebys Medical Discovery Institute'),
('000000569','University of California, Los Angeles');

INSERT t_disease_area VALUES
('000000001','Age-related macular degeneration'),
('000000002','Alpha Thalassemia Major'),
('000000003','Amyotrophic Lateral Sclerosis'),
('000000004','Amyotrophic Lateral Sclerosis'),
('000000005','B cell cancers'),
('000000005','Leukemia'),
('000000006','B cell cancers'),
('000000006','Leukemia'),
('000000007','Beta Thalassemia'),
('000000008','Blood Cancer'),
('000000009','Blood Cancer'),
('000000010','Blood Cancer'),
('000000010','Bone Marrow Transplant'),
('000000010','Viral Infection'),
('000000011','Blood Cancer'),
('000000011','Solid Tumors'),
('000000012','Blood Cancer'),
('000000013','Bone or Cartilage Disease'),
('000000014','Brain Cancer'),
('000000015','Brain Cancer'),
('000000015','Breast Cancer'),
('000000016','Brain Cancer'),
('000000017','Brain Cancer'),
('000000018','Colon Cancer'),
('000000019','Corneal Damage'),
('000000020','COVID-19'),
('000000021','COVID-19'),
('000000022','COVID-19'),
('000000023','Heart disease associated with Duchenne muscular dystrophy'),
('000000024','Heart failure'),
('000000025','HIV-related Lymphoma'),
('000000025','HIV/AIDS'),
('000000026','HIV/AIDS'),
('000000027','HIV/AIDS'),
('000000028','HIV/AIDS'),
('000000029','Huntington\'s Disease'),
('000000030','Kidney Failure'),
('000000031','Kidney Failure'),
('000000032','Kidney Failure'),
('000000033','Kidney Failure'),
('000000034','Kidney Failure'),
('000000035','Kidney Failure'),
('000000036','Leukemia, Acute Myeloid (AML),'),
('000000037','Leukemia, Acute Myeloid (AML),'),
('000000038','Leukemia, Acute Myeloid (AML),'),
('000000039','Leukocyte Adhesion Deficiency'),
('000000040','Lung Cancer'),
('000000041','Melanoma'),
('000000042','Melanoma'),
('000000042','Skin cancer'),
('000000042','Sarcoma'),
('000000043','Multiple Myeloma'),
('000000044','Osteoarthritis'),
('000000045','Osteonecrosis'),
('000000046','Parkinson\'s Disease'),
('000000047','Pulmonary Hypertension'),
('000000048','Retinitis Pigmentosa'),
('000000049','Retinitis Pigmentosa'),
('000000050','Retinitis Pigmentosa'),
('000000051','Retinitis Pigmentosa'),
('000000053','Severe Combined Immunodeficiency'),
('000000053','Adenosine deaminase-deficient (ADA-SCID),'),
('000000054','Severe Combined Immunodeficiency'),
('000000054','Artemis deficient (ART-SCID),'),
('000000055','Severe Combined Immunodeficiency'),
('000000055','X-linked (X-SCID),'),
('000000056','Severe Combined Immunodeficiency'),
('000000056','X-linked (X-SCID),'),
('000000057','Sickle Cell Disease'),
('000000058','Sickle Cell Disease'),
('000000059','Sickle Cell Disease'),
('000000060','Sickle Cell Disease'),
('000000061','Solid Tumors'),
('000000062','Spina Bifida'),
('000000063','Spinal Cord Injury'),
('000000064','Spinal Cord Injury'),
('000000065','Stroke'),
('000000066','Type 1 diabetes'),
('000000067','Type 1 diabetes'),
('000000068','Type 1 diabetes'),
('000000069','Type 1 diabetes'),
('000000070','X-linked Chronic Granulomatous Disease');


Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-12245','Development of novel synNotch CART cell therapy in patients with recurrent EGFRvIII+ glioblastoma',null,'Brain Cancer, Cancer, Solid Tumors',null, null,'Therapeutic Translational Research Projects','Pre-Active','University of California, San Francisco','Somatic Cell',2663144;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-12250','HSC-Engineered Off-The-Shelf CAR-iNKT Cell Therapy for Multiple Myeloma',null,'Blood Cancer, Cancer, Multiple Myeloma',null, null,'Therapeutic Translational Research Projects','Pre-Active','University of California, Los Angeles','Adult Stem Cell',5949651;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-12258','CAR-Tnm cell therapy for melanoma targeting TYRP-1',null,'Cancer, Melanoma, Solid Tumors',null, null,'Therapeutic Translational Research Projects','Pre-Active','University of California, Los Angeles','Adult Stem Cell',5904462;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-12153','Phase I Study of IL13Rα2-Targeting CAR T Cells After Lymphodepletion for Children with Refractory or Recurrent Malignant Brain Tumors', 930279876,'Brain Cancer, Cancer, Solid Tumors','44348', '45291','Clinical Trial Stage Projects','Active','City of Hope, Beckman Research Institute','Adult Stem Cell',8401309;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-12149','Phase 1 Clinical Development of IO-202, A First-in-Class Antibody Targeting LILRB4, for the Treatment of AML with Monocytic Differentiation and CMML', 428643122,'Acute Myeloid Leukemia, Blood Cancer, Cancer','44348', '45138','Clinical Trial Stage Projects','Active','Immune-Onc Therapeutics','Cancer Stem Cell',6000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-12129','The CuRe Trial: Cellular Therapy for In Utero Myelomeningocele Repair', 622076833,'Neurological Disorders, Spina Bifida','44197', '45291','Clinical Trial Stage Projects','Active','University of California, Davis','Adult Stem Cell',8996474;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-12105','Human iPSC-derived chimeric antigen receptor-expressing macrophages for cancer treatment',null,'Cancer, Ovarian Cancer, Solid Tumors','44197', '44561','Quest - Discovery Stage Research Projects','Active','University of California, San Diego','iPS Cell',222200;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-12111','Hematopoietic Stem Cell Gene Therapy for X-linked Agammaglobulinemia',null,'Blood Disorders','44197', '44561','Quest - Discovery Stage Research Projects','Active','University of California, Los Angeles','Adult Stem Cell',219230;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-12124','Dual angiogenic and immunomodulating nanotechnology for subcutaneous stem cell derived islet transplantation for the treatment of diabetes',null,'Diabetes, Metabolic Disorders, Type 1 diabetes','44197', '44561','Quest - Discovery Stage Research Projects','Active','Lundquist Institute for Biomedical Innovation at Harbor - UCLA Medical Center','Embryonic Stem Cell',250000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-12126','The First Orally Delivered Cell Therapy for the Treatment of Inflammatory Bowel Disease',null,'Inflammatory bowel disease, Intestinal Disease, Metabolic Disorders','44197', '44561','Quest - Discovery Stage Research Projects','Active','Vitabolus, Inc.','Adult Stem Cell',249000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-12130','Transplantation of Pluripotent Stem Cell Derived Microglia for the Treatment of Adult-onset Leukoencephalopathy (HDLS/ALSP)',null,'Neurological Disorders','44197', '44561','Quest - Discovery Stage Research Projects','Active','University of California, Irvine','Embryonic Stem Cell',214668;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-12158','Development of a SYF2 antisense oligonucleotide (ASO) treatment for ALS',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','44197', '44561','Quest - Discovery Stage Research Projects','Active','University of Southern California','iPS Cell',222300;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-12164','Optimization of a human interneuron cell therapy for traumatic brain injury',null,'Neurological Disorders, Traumatic Brain Injury','44197', '44561','Quest - Discovery Stage Research Projects','Active','University of California, Irvine','iPS Cell',250000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-12169','Human-induced pluripotent stem cell-derived glial enriched progenitors to treat white matter stroke and vascular dementia.',null,'Neurological Disorders, Stroke','44197', '44561','Quest - Discovery Stage Research Projects','Active','University of California, Los Angeles','iPS Cell',250000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-12170','Development of COVID-19 Antiviral Therapy Using Human iPSC-Derived Lung Organoids',null,'COVID-19, Infectious Disease','44197', '44561','Quest - Discovery Stage Research Projects','Active','University of California, San Diego','iPS Cell',250000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-12172','Combating COVID-19 using human PSC-derived NK cells',null,'COVID-19, Infectious Disease','44197', '44561','Quest - Discovery Stage Research Projects','Active','City of Hope, Beckman Research Institute','Embryonic Stem Cell, iPS Cell',249998;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2SCD-12031','Phase 2 Study of Hematopoietic Stem Cell Gene Transfer Inducing Fetal Hemoglobin in Sickle Cell Disease', 746175381,'Blood Disorders, Sickle Cell Disease','44197', '45657','Cure Sickle Cell Initiative Clinical Trial Stage Projects','Active','Boston Children's Hospital','Adult Stem Cell',8333581;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-12090','Anti-HIV duoCAR-T cell therapy for HIV infection', 658145356,'HIV/AIDS, Immune Disease, Infectious Disease','44197', '45291','Clinical Trial Stage Projects','Active','University of California, San Francisco','Adult Stem Cell',8970732;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-12095','A Phase I Clinical Trial for a Lentiviral Gene Therapy Targeting the TCIRG1 Gene for Infantile Malignant Osteopetrosis (IMO)', 445221155,'Bone or Cartilage Disease','44166', '45322','Clinical Trial Stage Projects','Active','Rocket Pharmaceuticals, Inc.','Adult Stem Cell',3728485;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2P-12212','Simplification of Excipient Solution for Implanting Candidate Human H9-scNSC Cell Line for Spinal Cord Injury',null,'Neurological Disorders, Spinal Cord Injury','44197', '44561','Progression Award - Discovery Stage Research Projects','Active','University of California, San Diego','Embryonic Stem Cell',180000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2P-12191','Stimulating endogenous muscle stem cells to counter muscle wasting',null,'Skeletal/Smooth Muscle disorders','44166', '44530','Progression Award - Discovery Stage Research Projects','Active','Stanford University','Adult Stem Cell',237060;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2P-11946','Safety “Clinical Trial” of the Cardiac Liability of COVID19 Polytherapy',null,'COVID-19, Infectious Disease','44166', '44530','Progression Award - Discovery Stage Research Projects','Active','University of California, Berkeley','iPS Cell',224500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2P-12150','Human neural stem cell (hNSC) derived exosomes vs CSC14 hNSCs for the treatment of traumatic brain injury (TBI)',null,'Neurological Disorders, Traumatic Brain Injury','44348', '44926','Progression Award - Discovery Stage Research Projects','Active','University of California, Irvine','Embryonic Stem Cell',202667;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-12007','Pro-healing biomaterial for treating lung inflammation associated with COVID-19',null,'COVID-19, Infectious Disease, Respiratory Disorders','44075', '44439','Discovery Research Projects','Active','University of California, San Diego','Adult Stem Cell',221758;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-12020','Battling COVID-19 Using Off-The-Shelf HSC-Engineered iNKT Cells',null,'COVID-19, Infectious Disease','44075', '44439','Discovery Research Projects','Active','University of California, Los Angeles','Adult Stem Cell',250000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2P-11700','Global gene expression profiling of single inhibitory neurons derived from human stem cells',null,'Epilepsy, Neurological Disorders','44044', '44408','Progression Award - Discovery Stage Research Projects','Active','Neurona Therapeutics','Embryonic Stem Cell',202500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.11-11718','2020 CIRM Grantee Meeting',null,null,'44044', '44227','Conference – The 2020 Grantee Meeting','Active','University of California, Irvine',null,176762;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-12022','Using hiPSC-derived lung organoids, a clinically-relevant system, to validate & winnow a list of approved drugs that inhibit SARS-CoV-2 cytopathy',null,'COVID-19, Infectious Disease, Respiratory Disorders','44044', '44408','Discovery Research Projects','Active','Sanford Burnham Prebys Medical Discovery Institute','iPS Cell',228229;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1COVID19-12047','Development of Anti-COVID RNAi Therapeutics Using Human iPSC-Derived Alveolar Epithelial Cells',null,'COVID-19, Infectious Disease','44044', '44408','Discovery Research Projects','Active','University of California, San Diego','iPS Cell',150000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2COVID19-11857','A phase I/II study of human placental hematopoietic stem cell derived natural killer cells (CYNK-001) for the treatment of adults with COVID-19', 126859008,'COVID-19, Infectious Disease, Respiratory Disorders','44044', '44773','Clinical Trial Stage Projects','Active','Celularity Inc','Adult Stem Cell',750000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-12016','Chimeric Antigen Receptor Targeting Spike Glycoprotein of SARS-cov2',null,'COVID-19, Infectious Disease, Respiratory Disorders','44044', '44408','Discovery Research Projects','Active','University of Southern California','iPS Cell',249996;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-11838','Biomaterial vaccine to enhance the formation of SARS-CoV-2-specific T memory stem cells',null,'COVID-19, Infectious Disease','44013', '44377','Discovery Research Projects','Active','University of California, Los Angeles','Adult Stem Cell',149916;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1COVID19-11975','COVID-19 Antiviral Therapy to Block Direct Cell Injury and Associated Tissue Damage',null,'COVID-19, Infectious Disease','44013', '44377','Therapeutic Translational Research Projects','Active','University of California, Los Angeles','Adult Stem Cell',349999;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-11947','Persistent Off-the-Shelf meACE2-CAR-IL-15 NK Cells Derived from CD34(+) Cord Blood Stem Cells to Prevent and Treat COVID-19',null,'COVID-19, Infectious Disease','44013', '44377','Discovery Research Projects','Active','City of Hope, Beckman Research Institute','Adult Stem Cell',150000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-11920','Application of PGE2/BPV, a muscle stem cell targeting therapeutic, to the treatment of COVID-19 associated diaphragm atrophy',null,'COVID-19, Infectious Disease','44013', '44377','Discovery Research Projects','Active','Stanford University','Adult Stem Cell',149996;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-11941','Identifying HLA Class I Restricted Peptides That Induce CD8+ T Cells Against SARS-CoV-2',null,'COVID-19, Infectious Disease','44013', '44377','Discovery Research Projects','Active','Stanford University','Adult Stem Cell',249999;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2P-11791','Evaluation of Gene Therapy Approaches for Autosomal Recessive Hyper IgE Syndrome Due to Mutations in DOCK8',null,'Blood Disorders, Immune Disease','44013', '44561','Progression Award - Discovery Stage Research Projects','Active','University of California, Los Angeles','Adult Stem Cell',234000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-11811','Repurposing Aminoadamantane Nitrate Compounds to Inhibit SARS-CoV-2 Viral Activity and to Protect the Brain from Viral-Related Damage',null,'COVID-19, Infectious Disease','43983', '44347','Discovery Research Projects','Active','Scripps Research Institute','iPS Cell',150000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-11901','Development of a novel PIKFYVE kinase inhibitor for the treatment of COVID-19',null,'COVID-19, Infectious Disease','43983', '44347','Discovery Research Projects','Active','University of Southern California','iPS Cell',150000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2COVID19-11823','Mesenchymal Stromal Cells for ARDS (COVID positive and COVID negative)', 405167503,'COVID-19, Infectious Disease','44013', '44742','Clinical Trial Stage Projects','Active','University of California, San Francisco','Adult Stem Cell',701049;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2SCD-11674','A Phase 1 Study of ECT-001 Expanded Cord Blood and Myeloablative Regimen with Reduced Toxicity in Patients with Severe Sickle Cell Disease.', 524014957,'Blood Disorders, Sickle Cell Disease','43983', '45230','Cure Sickle Cell Initiative Clinical Trial Stage Projects','Active','ExCellThera Inc.','Adult Stem Cell',2000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-11764','Identifying a lead compound for COVID19 using high throughput screening with lung stem cell organoids',null,'COVID-19, Infectious Disease, Respiratory Disorders','43983', '44347','Discovery Research Projects','Active','University of California, Los Angeles','iPS Cell',149998;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2COVID19-11817','Stem cell-based rapid identification of SARS-CoV-2 T cell epitopes and T cell receptors for therapeutic use',null,'COVID-19, Infectious Disease, Respiratory Disorders','43983', '44347','Discovery Research Projects','Active','University of California, Los Angeles','Adult Stem Cell',126692;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2COVID19-11775','Evaluation and Characterization of SARS-CoV-2 Antibody in Convalescent Volunteer Plasma Donors for Potential Therapeutic Use', 674664083,'COVID-19, Infectious Disease, Respiratory Disorders','43952', '44500','Clinical Trial Stage Projects','Active','City of Hope, Beckman Research Institute','Other, Vital Research Opportunity',999999;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2P-11662','Using metabolic pausing for maintaining stable and high-quality pluripotent stem cells',null,null,'43983', '44347','Progression Award - Discovery Stage Research Projects','Active','Stanford University','Embryonic Stem Cell',208422;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.5-11705','The 2020 SPARK Annual Meeting',null,null,'43862', '44469','Conference - Manage The SPARK Annual Meeting','Active','University of California, Davis',null,50000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11555','BCMA/CS1 Bispecific CAR-T Cell Therapy to Prevent Antigen Escape in Multiple Myeloma',null,'Blood Cancer, Cancer, Multiple Myeloma','43862', '44592','Therapeutic Translational Research Projects','Active','University of California, Los Angeles','Adult Stem Cell',3176805;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11611','Development of a human stem cell-derived inhibitory neuron therapeutic for the treatment of chronic focal epilepsy',null,'Epilepsy, Neurological Disorders','43862', '44408','Therapeutic Translational Research Projects','Active','Neurona Therapeutics','Embryonic Stem Cell',4848505;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-11591','IND-enabling activities for a Phase 1 Study of Autologous CD4LVFOXP3 T Cells in Subjects with IPEX Syndrome',null,'Blood Disorders, Immune Disease, IPEX Syndrome','43800', '44469','Late Stage Preclinical Projects','Active','Stanford University','Vital Research Opportunity',5002496;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11472','A Phase 2 Study of the Safety of Repeat Intravitreal Injection of Human Retinal Progenitor Cells (jCell) in Adult Subjects with Retinitis Pigmentosa', 348055147,'Retinitis Pigmentosa, Vision Loss','43800', '44530','Clinical Trial Stage Projects','Active','jCyte, Inc',null,6608592;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11620','Clinical Study to Assess Safety and Efficacy of Subretinal Injection of Human Neural Progenitor Cells for Treatment of Retinitis Pigmentosa', 290045516,'Retinitis Pigmentosa, Vision Loss','43800', '45260','Clinical Trial Stage Projects','Active','Cedars-Sinai Medical Center','Adult Stem Cell',10444063;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11650','Safety and Feasibility of Cultivated Autologous Limbal Stem Cells for Limbal Stem Cell Deficiency', 548379726,'Corneal Damage, Vision Loss','43800', '45260','Clinical Trial Stage Projects','Active','University of California, Los Angeles','Adult Stem Cell',10301486;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11661','A Phase 1b Safety Study for MRI guided delivery of AAV2-GDNF for the treatment of Parkinson’s disease', 700280774,'Neurological Disorders, Parkinson's Disease','43800', '45260','Clinical Trial Stage Projects','Active','Brain Neurotherapy Bio','Vital Research Opportunity',5510462;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11536','Ex Vivo Gene Editing of Human Hematopoietic Stem Cells for the Treatment of X-Linked Hyper-IgM Syndrome',null,'Blood Disorders, Hyper IgM Syndrome, Immune Disease','43862', '44773','Therapeutic Translational Research Projects','Active','University of California, Los Angeles','Adult Stem Cell',4896628;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11544','Neural Stem cell-mediated oncolytic immunotherapy for ovarian cancer',null,'Cancer, Ovarian Cancer, Solid Tumors','43862', '44773','Therapeutic Translational Research Projects','Active','City of Hope, Beckman Research Institute','Adult Stem Cell',2873262;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11574','A Phase I Study of Chimeric Antigen Receptor Engineered Stem/Memory T Cells for the Treatment of HER2-Positive Brain Metastases', 724720172,'Brain Cancer, Breast Cancer, Cancer, Solid Tumors','43709', '44804','Clinical Trial Stage Projects','Active','City of Hope, Beckman Research Institute','Adult Stem Cell',9015149;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11532','PRPE-SF,  polarized hESC-derived RPE Soluble Factors,  as a Therapy for Early Stage Dry Age-related Macular Degeneration',null,'Age-related macular degeneration, Vision Loss','43709', '44804','Therapeutic Translational Research Projects','Active','`','Embryonic Stem Cell',3733556;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11548','An optimized human neural stem cell line (hNSC) for the treatment of traumatic brain injury (TBI)',null,'Neurological Disorders, Traumatic Brain Injury','43770', '44681','Therapeutic Translational Research Projects','Active','University of California, Irvine','Embryonic Stem Cell',4804737;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11579','Human Embryonic Stem Cell-Derived Neural Stem Cells for Severe Spinal Cord Injury (SCI)',null,'Neurological Disorders, Spinal Cord Injury','43770', '44681','Therapeutic Translational Research Projects','Active','University of California, San Diego','Embryonic Stem Cell',6235897;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11628','Human Neural Stem Cells (hNSCs) for neuroprotection in perinatal hypoxic-ischemic brain injury (HII)-Pre-IND-enabling Studies',null,'Brain Injury, hypoxic, ischemic, Neurological Disorders, Pediatrics','43770', '44681','Therapeutic Translational Research Projects','Active','Sanford Burnham Prebys Medical Discovery Institute','Adult Stem Cell',4963684;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.10-11681','CIRM - Leading the New Era of Living Medicines',null,null,'43647', '44196','Conference - The 2020 Alpha Stem Cell Clinic Annual Symposium','Active','University of California, Davis',null,60000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11478','Phase 1/2 study for autologous human CD34+ hematopoietic stem cells ex vivo transduced with pCCL-CTNS lentiviral vector for treatment of Cystinosis.', 420180594,'Cystinosis, Kidney Disease, Kidney Failure, Metabolic Disorders','43678', '45138','Clinical Trial Stage Projects','Active','University of California, San Diego','Adult Stem Cell',11999944;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11437','Pancreatic Islets and Parathyroid Gland Co-transplantation for Treatment of Diabetes in the Intra-Muscular Site: PARADIGM', 779998305,'Diabetes, Metabolic Disorders, Type 1 diabetes','43647', '45688','Clinical Trial Stage Projects','Active','University of California, San Francisco','Adult Stem Cell',11083012;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2P-11595','Autologous therapy for Parkinson's disease: single cell RNAseq for in depth characterization of transplanted cells',null,'Neurological Disorders, Parkinson's Disease','43647', '44012','Progression Award - Discovery Stage Research Projects','Closed','Aspen Neuroscience','iPS Cell',177579;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-11497','Curing Sickle cell Disease with CRISPR-Cas9 genome editing',null,'Blood Disorders, Sickle Cell Disease','43617', '44165','Late Stage Preclinical Projects','Active','University of California, San Francisco','Adult Stem Cell',2242805;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11380','Genetic Modification of Stem Cells and T cells to Activate the Immune System to Target Solid Tumors', 393572823,'Cancer, Sarcoma, Solid Tumors','43617', '44561','Clinical Trial Stage Projects','Active','University of California, Los Angeles','Adult Stem Cell',4693839;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11480','LADICell', 141872240,'Blood Disorders, Immune Disease, Leukocyte Adhesion Deficiency','43617', '45138','Clinical Trial Stage Projects','Active','Rocket Pharmaceuticals, Inc.','Adult Stem Cell',6567085;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.4-11552','2020 and 2021 Bridges Annual Meeting',null,null,'43800', '44530','Conference - Manage The Bridges Annual Meeting','Active','Cal State Univ, San Marcos',null,320000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-11256','IND-enabling development of ART352-L, an endogenous stem cell reactivation therapy to enhance bone healing in the elderly',null,'Bone or Cartilage Disease, Intervertebral disc degeneration','43586', '44012','Late Stage Preclinical Projects','Closed','Ankasa Regenerative Therapeutics','Adult Stem Cell',3987693;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11431-A','A monoclonal antibody that depletes blood stem cells and enables chemotherapy free transplants',null,'Blood Disorders, Severe Combined Immunodeficiency, X-linked (X-SCID)','43862', '44074','Clinical Trial Stage Projects','Closed','Stanford University','Adult Stem Cell',1113487;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11431-B','A monoclonal antibody that depletes blood stem cells and enables chemotherapy free transplants',null,'Blood Disorders, Severe Combined Immunodeficiency, X-linked (X-SCID)','44075', '45016','Clinical Trial Stage Projects','Active','Jasper Therapeutics, Inc.','Adult Stem Cell',2313398;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-10953','An hESC-derived hNSC Therapeutic for Huntington’s Disease',null,'Huntington's Disease, Neurological Disorders','43525', '44620','Late Stage Preclinical Projects','Active','University of California, Irvine','Embryonic Stem Cell',5635393;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11400','Induction of Tolerance by Combinatorial Therapy w/ Donor Stem Cells and Expanded Recipient Treg cells in HLA-mismatched Kidney Transplant Recipients', 377241337,'Kidney Disease, Kidney Failure','43525', '45260','Clinical Trial Stage Projects','Active','Stanford University','Adult Stem Cell',11955585;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11371','AB-205-001 Phase 1b Trial and Related Activities to Support Clinical Development of AB-205', 264882075,'Blood Cancer, Cancer','43497', '44957','Clinical Trial Stage Projects','Active','Angiocrine Bioscience, Inc.','Adult Stem Cell',6192579;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-11404','Placental Mesenchymal Stem Cell Augmentation of Fetal Myelomeningocele Repair',null,'Neurological Disorders, Spina Bifida','43466', '44227','Late Stage Preclinical Projects','Closed','University of California, Davis','Adult Stem Cell',5619643;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.5-11452','2019 SPARK Annual Meeting',null,null,'43466', '43738','Conference - Manage The SPARK Annual Meeting','Closed','Pathways to Stem Cell Science',null,49915;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11259','Developing engineered autologous leukemia vaccines to target residual leukemic stem cells',null,'Acute Myeloid Leukemia, Blood Cancer, Cancer','43497', '44439','Therapeutic Translational Research Projects','Active','University of California, San Francisco','Cancer Stem Cell',4171728;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11265','Clinical Translation of Autologous Regenerative Cell Therapy for Blindness',null,'Age-related macular degeneration, Vision Loss','43466', '44346','Therapeutic Translational Research Projects','Active','University of California, Los Angeles','iPS Cell',5068026;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-11300','NeuBright, a purified allogeneic cell therapy product for treatment of Dry Age-related Macular Degeneration',null,'Age-related macular degeneration, Vision Loss','43497', '44408','Therapeutic Translational Research Projects','Active','Stanford University','Adult Stem Cell',4235758;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10973','Small Molecule Proteostasis Regulators to Treat Photoreceptor Diseases',null,'Vision Loss','43497', '44592','Quest - Discovery Stage Research Projects','Active','University of California, San Diego','iPS Cell',1160648;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10979','Universal Pluripotent Liver Failure Therapy (UPLiFT)',null,'Liver Disease, Metabolic Disorders','43525', '44620','Quest - Discovery Stage Research Projects','Active','Children's Hospital of Los Angeles','iPS Cell',1297512;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11070','Drug Development for Autism Spectrum Disorder Using Human Patient iPSCs',null,'Autism, Neurological Disorders','43497', '44408','Quest - Discovery Stage Research Projects','Active','Scripps Research Institute','iPS Cell',1827576;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11105','Pluripotent stem cell-derived bladder epithelial progenitors for definitive cell replacement therapy of bladder cancer',null,'Bladder or Urinary Tract Disorder, Cancer, Skeletal/Smooth Muscle disorders, Solid Tumors','43497', '44227','Quest - Discovery Stage Research Projects','Closed','Stanford University','Embryonic Stem Cell',1265436;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11183','A screen for drugs to protect against chemotherapy-induced hearing loss, using sensory hair cells derived by direct lineage reprogramming from hiPSCs',null,'Hearing Loss','43497', '44227','Quest - Discovery Stage Research Projects','Closed','University of Southern California','iPS Cell',741574;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11199','Modulation of the Wnt pathway to restore inner ear function',null,'Hearing Loss','43497', '44408','Quest - Discovery Stage Research Projects','Active','Stanford University','Adult Stem Cell',1394870;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-11223','CMV-specific T cells expressing anti-HIV CAR and CMV vaccine boost as immunotherapy for HIV/AIDS',null,'HIV/AIDS, Infectious Disease','43435', '44408','Late Stage Preclinical Projects','Active','City of Hope, Beckman Research Institute',null,3812797;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.9-11423','2019 Alpha Stem Cell Clinic Symposium - Mending Stem Cells: The Past, Present & Future Regenerative Medicine',null,null,'43466', '43646','Conference - The 2019 Alpha Stem Cell Clinic Annual Symposium','Closed','University of California, San Francisco',null,60000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-10999','Late-Stage Preclinical Study of CAR-T Memory Stem Cells Targeting PSMA (P-PSMA-101) for the Treatment of Castrate-Resistant Metastatic Prostate Cancer',null,'Cancer, Prostate Cancer, Solid Tumors','43344', '43822','Late Stage Preclinical Projects','Closed','Poseida Therapeutics, Inc.','Adult Stem Cell',3992090;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11036','Non-viral reprogramming of the endogenous TCRα locus to direct stem memory T cells against shared neoantigens in malignant gliomas',null,'Brain Cancer, Cancer, Solid Tumors','43435', '44469','Quest - Discovery Stage Research Projects','Active','University of California, San Francisco','Adult Stem Cell',900000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11107','Chimeric Antigen Receptor-Engineered Stem/Memory T Cells for the Treatment of Recurrent Ovarian Cancer',null,'Cancer, Ovarian Cancer, Solid Tumors','43374', '44286','Quest - Discovery Stage Research Projects','Active','City of Hope, Beckman Research Institute','Adult Stem Cell',1351174;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11109','Regenerative Thymic Tissues as Curative Cell Therapy for Patients with 22q11 Deletion Syndrome',null,'Immune Disease, Thymic Disorder, 22q11 Deletion/DiGeorge','43466', '44408','Quest - Discovery Stage Research Projects','Active','Stanford University','Embryonic Stem Cell, iPS Cell',1251720;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11131','Genetically Modified Hematopoietic Stem Cells for the Treatment of Danon Disease',null,'Danon Disease, Heart Disease, Metabolic Disorders','43405', '44500','Quest - Discovery Stage Research Projects','Active','University of California, San Diego','Adult Stem Cell',1393200;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11157','Preclinical Development of An HSC-Engineered Off-The-Shelf iNKT Cell Therapy for Cancer',null,'Cancer','43435', '44255','Quest - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Adult Stem Cell',1404000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11165','Develop iPSC-derived microglia to treat progranulin-deficient Frontotemporal Dementia',null,'Dementia, Neurological Disorders','43405', '44439','Quest - Discovery Stage Research Projects','Active','Gladstone Institutes, J. David','iPS Cell',1547157;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-11175','Therapeutic immune tolerant human islet-like organoids (HILOs) for Type 1 Diabetes',null,'Diabetes, Metabolic Disorders, Type 1 diabetes','43405', '44135','Quest - Discovery Stage Research Projects','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell',1637209;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-10967','Ex Vivo Gene Engineering of Blood Stem Cells for Enhanced Chemotherapy Efficacy in Glioblastoma Patients',null,'Brain Cancer, Cancer, Solid Tumors','43313', '44439','Late Stage Preclinical Projects','Active','City of Hope, Beckman Research Institute','Adult Stem Cell',3684259;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-11059','MRI Guided Delivery of Neural Progenitor Cells Secreting GDNF for the Treatment of Parkinson's disease',null,'Neurological Disorders, Parkinson's Disease','43313', '44620','Late Stage Preclinical Projects','Active','University of California, San Francisco','Adult Stem Cell',5811340;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10784','A phase I trial of intratumoral administration of CCL21-gene modified dendritic cell (DC) combined with intravenous pembrolizumab for advanced NSCLC', 743173689,'Cancer, Lung Cancer, Solid Tumors','43282', '44742','Clinical Trial Stage Projects','Active','University of California, Los Angeles','Adult Stem Cell',10955315;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-10937','Therapeutic development of Oxy200, an oxysterol with bone anabolic and anti-resorptive properties for intervention in osteoporosis',null,'Bone or Cartilage Disease','43313', '44012','Therapeutic Translational Research Projects','Closed','MAX BioPharma, Inc.','Adult Stem Cell',1400000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-10958','Autologous iPSC-derived smooth muscle cell therapy for treatment of urinary incontinence',null,'Bladder or Urinary Tract Disorder, Incontinence, Skeletal/Smooth Muscle disorders','43344', '44804','Therapeutic Translational Research Projects','Active','Stanford University','iPS Cell',5977155;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-10995','Morphological and functional integration of stem cell derived retina organoid sheets into degenerating retina models',null,'Retinitis Pigmentosa, Vision Loss','43344', '44530','Therapeutic Translational Research Projects','Active','University of California, Irvine','Embryonic Stem Cell',4769039;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN2-10990-A','Development of a Noninvasive Prenatal Test for Beta-Hemoglobinopathies for Earlier Stem Cell Therapeutic Interventions',null,'Beta Thalassemia, Blood Disorders, Sickle Cell Disease','43344', '44196','Diagnostic Translational Research Projects','Closed','Children's Hospital of Oakland Research Institute','Adult Stem Cell',1088592;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN2-10990-B','Development of a Noninvasive Prenatal Test for Beta-Hemoglobinopathies for Earlier Stem Cell Therapeutic Interventions',null,'Beta Thalassemia, Blood Disorders, Sickle Cell Disease','44197', '44651','Diagnostic Translational Research Projects','Active','University of California, San Francisco','Adult Stem Cell',633014;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10830','Gene Transfer for Artemis-Deficient Severe Combined Immunodeficiency Using a Lentiviral Vector to Transduce Autologous CD34 Hematopoietic Stem Cells', 794945806,'Blood Disorders, Severe Combined Immunodeficiency, Artemis deficient (ART-SCID)','43252', '45107','Clinical Trial Stage Projects','Active','University of California, San Francisco','Adult Stem Cell',12000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10846','Phase 1 Study of CD19/CD22 Chimeric Antigen Receptor (CAR) T Cells in Adults with Recurrent or Refractory B Cell Malignancies', 559172804,'B cell cancers, Blood Cancer, Cancer, Leukemia','43252', '44712','Clinical Trial Stage Projects','Active','Stanford University','Adult Stem Cell',11034982;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-11031','A Phase 1/2 Study to Assess the Safety, Tolerability, and Efficacy of ST-400 Autologous HSPC Transplant in Transfusion-dependent β-Thalassemia', 395472507,'Beta Thalassemia, Blood Disorders','43252', '44926','Clinical Trial Stage Projects','Active','Sangamo BioSciences, Inc.','Adult Stem Cell',8000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-10893','IND enabling development of FT516: A Natural Killer Cell Immunotherapy for Cancer Derived from a Human Inducible Pluripotent Stem Cell',null,'Cancer, Solid Tumors','43191', '44067','Late Stage Preclinical Projects','Closed','Fate Therapeutics, Inc.','iPS Cell',4000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10847','Treatment of sickle cell disease by induction of  mixed chimerism and immune tolerance using CD4+ T-depleted haploidentical blood stem cell transplant', 976431381,'Blood Disorders, Sickle Cell Disease','43191', '44681','Clinical Trial Stage Projects','Active','City of Hope, Beckman Research Institute','Adult Stem Cell',5742180;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10411','Cellular Immunotherapy for Induction of Immune Tolerance in HLA Matched Living Donor Kidney Transplant Recipients', 543072310,'Kidney Disease, Kidney Failure','43160', '44926','Clinical Trial Stage Projects','Active','Medeor Therapeutics, Inc.','Adult Stem Cell',11217155;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10779','Stem Cells for Huntington’s Disease (HD) International (SC4HDI) Conference',null,null,'43132', '43465','Conference II','Closed','University of California, Irvine',null,31727;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10842','iPSCs: A Decade of Progress and Beyond',null,null,'43132', '43220','Conference II','Closed','Keystone Symposia on Molecular and Cellular Biology',null,35000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10860','“Myelin Through the Ages: Evolution, Development, Degeneration and Disease” - 2018 Gordon Research Conference (GRC) and Gordon Research Seminar (GRS)',null,'Neurological Disorders','43132', '43220','Conference II','Closed','University of California, San Francisco',null,10000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10873','ISSCR 2019 Nucleus Forum',null,null,'43374', '43555','Conference II','Closed','International Society for Stem Cell Research',null,24000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10883','ISSCR 2019',null,null,'43374', '43708','Conference II','Closed','International Society for Stem Cell Research',null,50000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10884','2018 Stanford Drug Discovery and Stem Cell Technology Conference',null,null,'43132', '43251','Conference II','Closed','Stanford University',null,15000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10903','19th Annual UC System-wide Bioengineering Symposium',null,null,'43252', '43343','Conference II','Closed','University of California, Riverside',null,14536;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.8-10913','Delivery of Stem Cell Therapeutics to Patients',null,null,'43132', '43281','Conference - The 2018 Alpha Stem Cell Clinic Annual Symposium','Closed','University of California, Los Angeles',null,60000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10714','iPS Glial Therapy for White Matter Stroke and Vascular Dementia',null,'Neurological Disorders, Stroke','43191', '43921','Quest - Discovery Stage Research Projects','Closed','University of California, Los Angeles','iPS Cell',2096095;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10747','Targeting Cancer Stem Cells in Hematologic Malignancies',null,'Acute Myeloid Leukemia, Blood Cancer, Cancer','43191', '44104','Quest - Discovery Stage Research Projects','Closed','University of California, San Diego','Cancer Stem Cell',1960560;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10748','Engineering Lifelong Cellular Immunity to HIV',null,'HIV/AIDS, Infectious Disease','43191', '44104','Quest - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Adult Stem Cell',1701178;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10751','Silicon Nanopore Membrane encapsulated enriched-Beta Clusters for Type 1 Diabetes treatment',null,'Diabetes, Metabolic Disorders, Type 1 diabetes','43191', '43921','Quest - Discovery Stage Research Projects','Closed','University of California, San Francisco','Embryonic Stem Cell',1113000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10753','Generation and in vitro profiling of neural stem cell lines to predict in vivo efficacy for chronic cervical spinal cord injury.',null,'Neurological Disorders, Spinal Cord Injury','43191', '44104','Quest - Discovery Stage Research Projects','Closed','University of California, Irvine','Adult Stem Cell',1575613;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10524','Genome Editing of Sinusoidal Endothelial Stem Cells for Permanent Correction of Hemophilia A',null,'Blood Disorders, Hemophilia A','43191', '44469','Quest - Discovery Stage Research Projects','Active','City of Hope, Beckman Research Institute','Adult Stem Cell',2182193;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10525','Development of a Cellular Therapeutic for Treatment of Epilepsy',null,'Epilepsy, Neurological Disorders','43160', '43646','Quest - Discovery Stage Research Projects','Closed','Neurona Therapeutics','Embryonic Stem Cell',1616536;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10559','Development of immune invisible beta cells as a cell therapy for type 1 diabetes through genetic modification of hESCs',null,'Diabetes, Metabolic Disorders, Type 1 diabetes','43191', '44104','Quest - Discovery Stage Research Projects','Closed','University of California, San Diego','Embryonic Stem Cell',1924791;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10591','Preclinical development of an immune evasive islet cell replacement therapy for type 1 diabetes',null,'Diabetes, Metabolic Disorders, Type 1 diabetes','43191', '43921','Quest - Discovery Stage Research Projects','Closed','ViaCyte, Inc.','Embryonic Stem Cell',1470987;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10604','Stimulating endogenous muscle stem cells to counter muscle atrophy',null,'Skeletal/Smooth Muscle disorders','43160', '44074','Quest - Discovery Stage Research Projects','Closed','Stanford University','Adult Stem Cell',2198687;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10665','Neural Stem Cell Relays for Severe Spinal Cord Injury',null,'Neurological Disorders, Spinal Cord Injury','43191', '43769','Quest - Discovery Stage Research Projects','Closed','University of California, San Diego','Embryonic Stem Cell',1638900;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10679','Towards hepatocyte cell replacement therapy: developing a renewable source of human hepatocytes from pluripotent stem cells',null,'Liver Disease, Metabolic Disorders','43191', '44104','Quest - Discovery Stage Research Projects','Closed','Stanford University','Embryonic Stem Cell',1968456;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10695','Identification and Generation of Long Term Repopulating Human Muscle Stem Cells from Human Pluripotent Stem Cells',null,'Muscular Dystrophy, Skeletal/Smooth Muscle disorders','43191', '44104','Quest - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Embryonic Stem Cell, iPS Cell',2148519;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10588','Targeting cancer stem cells with nanoparticle RNAi delivery to prevent recurrence and metastasis of ovarian cancer',null,'Cancer, Ovarian Cancer, Solid Tumors','43160', '43890','Inception - Discovery Stage Research Projects','Closed','Loma Linda University','Cancer Stem Cell',172870;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10598','Enhanced Branching Morphogenesis and Pluripotent Cell Lineage Differentiation for Pediatric Regenerative Therapies',null,'Kidney Disease','43132', '43496','Inception - Discovery Stage Research Projects','Closed','University of California, Davis','iPS Cell',235800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10603','iPSC-Derived Smooth Muscle Progenitors for Treatment of Abdominal Aortic Aneurysm',null,'Vascular Disease','43191', '44196','Inception - Discovery Stage Research Projects','Closed','Palo Alto Veterans Institute for Research','iPS Cell',172621;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10620','Bone Marrow Targeting of Hematopoietic Stem Cells Engineered to Overexpress 25-OH-VD3 1-α-hydroxylase for Acute Myeloid Leukemia Therapy',null,'Acute Myeloid Leukemia, Blood Cancer, Cancer','43191', '43555','Inception - Discovery Stage Research Projects','Closed','Loma Linda University','Adult Stem Cell',178967;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10643','IVD rejuvenation using iPSC-derived notochordal cells',null,'Bone or Cartilage Disease','43132', '43769','Inception - Discovery Stage Research Projects','Closed','Cedars-Sinai Medical Center','iPS Cell',241992;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10674','A new phenotypic screening platform that identifies biologically-relevant targets and lead compounds for the treatment of Parkinson’s disease',null,'Neurological Disorders, Parkinson's Disease','43132', '43496','Inception - Discovery Stage Research Projects','Closed','Zenobia Therapeutics','iPS Cell',112500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10718','Gingival mesenchymal stem cells as a novel treatment modality for periodontal tissue regeneration',null,'Bone or Cartilage Disease','43191', '43921','Inception - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Adult Stem Cell',194483;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-10416','DEBCT: Genetically Corrected, Induced Pluripotent Cell-Derived Epithelial Sheets for Definitive Treatment of Dystrophic Epidermolysis Bullosa',null,'Epidermolysis Bullosa, Skin Disease','43160', '44439','Therapeutic Translational Research Projects','Active','Stanford University','iPS Cell',5107353;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10721','An IPSC cell based model of macular degeneration for drug discovery.',null,'Age-related macular degeneration, Vision Loss','43191', '43921','Inception - Discovery Stage Research Projects','Closed','University of California, San Diego','iPS Cell',232200;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-10540','A Splicing Modulator Targeting Cancer Stem Cells in Acute Myeloid Leukemia',null,'Acute Myeloid Leukemia, Blood Cancer, Cancer','43160', '44165','Therapeutic Translational Research Projects','Active','University of California, San Diego','Cancer Stem Cell',2511767;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-10587','Human Embryonic Stem Cell-Derived Natural Killer Cells for Cancer Treatment',null,'Acute Myeloid Leukemia, Blood Cancer, Cancer','43160', '44439','Therapeutic Translational Research Projects','Active','University of California, San Diego','Embryonic Stem Cell',4698821;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10475','Generation of human airway stem cells by direct transcriptional reprogramming for disease modeling and regeneration',null,'Respiratory Disorders','43191', '43921','Inception - Discovery Stage Research Projects','Closed','University of California, San Francisco','Directly Reprogrammed Cell',238408;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10513','Novel metabolic labeling method for tracking stem cells to irradiated salivary glands using PET',null,'Other','43191', '43555','Inception - Discovery Stage Research Projects','Closed','Stanford University','Adult Stem Cell',229227;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10516','Development of treatments to improve healing of ischemic wounds',null,'Vascular Disease','43191', '43555','Inception - Discovery Stage Research Projects','Closed','University of California, Davis','Adult Stem Cell',235099;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10522','Identification of antigenic neo-epitopes from in vitro reprogrammed human tissue precursors for regenerative therapy',null,'Other','43191', '43555','Inception - Discovery Stage Research Projects','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',193500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10555','Optimizing self-renewal signaling kinetics to stabilize ex vivo hematopoietic stem cell expansion',null,'Blood Disorders','43191', '43646','Inception - Discovery Stage Research Projects','Closed','Stanford University','Adult Stem Cell',210906;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10583','Human Pancreatic Cancer Stem Cells: Developing a Novel Drug for Cancer Eradication',null,'Cancer, Pancreatic Cancer, Solid Tumors','43160', '43524','Inception - Discovery Stage Research Projects','Closed','Human BioMolecular Research Institute','Cancer Stem Cell',303785;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10388','Evaluation of the Safety and Tolerability of KA34 in a Phase 1, Double-Blind, Dose Escalation Trial in Patients with Knee Osteoarthritis', 599402117,'Arthritis, Bone or Cartilage Disease, Osteoarthritis','43070', '44160','Clinical Trial Stage Projects','Closed','Calibr','Adult Stem Cell',8447523;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10392','Antiviral Cellular Therapy for Enhancing T-cell Reconstitution Before or After Hematopoietic Stem Cell Transplantation (ACES)', 112097238,'Blood Cancer, Blood Disorders, Bone Marrow Transplant and Viral Infection, Cancer','43070', '44895','Clinical Trial Stage Projects','Active','Children's Hospital of Los Angeles','Adult Stem Cell',4825587;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10395','Clinical Study of T stem cell memory (Tscm)-based CAR-T cells in Patients with Multiple Myeloma', 386557613,'Blood Cancer, Cancer, Multiple Myeloma','43070', '44561','Clinical Trial Stage Projects','Active','Poseida Therapeutics, Inc.','Adult Stem Cell',19813407;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.5-10834','The 2018 SPARK Annual Meeting',null,null,'43101', '43373','Conference - Manage The SPARK Annual Meeting','Closed','University of California, Davis',null,39559;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.4-10812','2018 and 2019 Bridges Annual Meeting',null,null,'43070', '43799','Conference - Manage The Bridges Annual Meeting','Closed','Cal State Univ, San Marcos',null,291622;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10771','Living with and Curing RUNX1 FPD/AML Forum',null,null,'43344', '43434','Conference II','Closed','RUNX1 Research Program',null,9500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10795','2017 World Alliance Forum in San Francisco (WAFSF) "Healthcare Game Changers"',null,null,'43040', '43131','Conference II','Closed','Alliance Forum Foundation',null,5000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('INFR4-10361-B','University of California, San Francisco (UCSF) CIRM Alpha Stem Cell Clinic',null,'Multiple Indications (Alpha Clinics)','43739', '44530','Alpha Stem Cell Clinics Network Expansion','Active','University of California, San Francisco',null,5707388;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-10084','Genome Editing of Autologous Hematopoietic Stem Cells to Treat Sickle Cell Disease',null,'Blood Disorders, Sickle Cell Disease','43040', '44104','Late Stage Preclinical Projects','Closed','Stanford University','Adult Stem Cell',4849363;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09574','A Phase 2 Open-Label, Multi-Center, Randomized, Controlled, Optimal Dose-Finding Study of DCC-UCB in Adults Receiving High Dose Chemotherapy for AML', 662635471,'Acute Myeloid Leukemia, Blood Cancer, Cancer','43040', '43556','Clinical Trial Stage Projects','Closed','Nohla Therapeutics Inc','Adult Stem Cell',4310000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09672','Clinical trial of directly vascularized islet cell replacement therapy for high-risk type 1 diabetes', 550559457,'Diabetes, Metabolic Disorders, Type 1 diabetes','43070', '45260','Clinical Trial Stage Projects','Active','ViaCyte, Inc.','Embryonic Stem Cell',19752463;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09688','A Phase 3 Study Comparing the Utility of Human Acellular Vessels  to Arteriovenous Fistula in Subjects with End-Stage Renal Disease (California Sites)', 569576576,'Kidney Disease, Kidney Failure','43040', '44025','Clinical Trial Stage Projects','Closed','Humacyte, Inc.','Adult Stem Cell',3525000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10248','Phase I Study of Chimeric Antigen Receptor Engineered Central Memory T cells for the Treatment of Malignant Glioma', 912265363,'Brain Cancer, Cancer, Solid Tumors','43040', '44530','Clinical Trial Stage Projects','Active','City of Hope, Beckman Research Institute','Adult Stem Cell',12753854;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('INFR4-10314','Alpha Stem Cell Clinic for Northern and Central California',null,'Multiple Indications (Alpha Clinics)','43070', '44530','Alpha Stem Cell Clinics Network Expansion','Active','University of California, Davis',null,7905671;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('INFR4-10361-A','University of California, San Francisco (UCSF) CIRM Alpha Stem Cell Clinic',null,'Multiple Indications (Alpha Clinics)','43070', '43738','Alpha Stem Cell Clinics Network Expansion','Closed','Children's Hospital of Oakland Research Institute',null,2292611;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10386','AB-110-001 Phase 1b Trial and Related Activities to Support Clinical Development of AB-110', 488589151,'Blood Cancer, Cancer','43009', '44561','Clinical Trial Stage Projects','Active','Angiocrine Bioscience, Inc.','Adult Stem Cell',5000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10192','A Phase 1b/2a Study of the ROR1-Targeting Monoclonal Antibody, Cirmtuzumab, and the Bruton Tyrosine Kinase Inhibitor, Ibrutinib, in B-Cell Cancers', 215107784,'B cell cancers, Blood Cancer, Cancer, Leukemia','43009', '44651','Clinical Trial Stage Projects','Active','University of California, San Diego','Cancer Stem Cell',18292674;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.7-10742','Basis of Standardization for Cell Therapies',null,null,'43009', '43281','Conference - Manage a Symposium on Pluripotent Stem Cell Manufacturing','Closed','International Alliance for Biological Standardization',null,100000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-10258','Development of ROR1 CAR-T cells to target cancer stem cells in advanced malignancies',null,'Blood Cancer, Cancer, Leukemia','43009', '44229','Therapeutic Translational Research Projects','Active','University of California, San Diego','Cancer Stem Cell',5751079;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09894','A Phase 3, Randomized, Placebo-controlled Multicenter Study to Evaluate Efficacy & Safety of Repeated Administrations of NurOwn® in Patients with ALS', 618295341,'Amyotrophic Lateral Sclerosis, Neurological Disorders','42948', '44408','Clinical Trial Stage Projects','Active','BrainStorm Cell Therapeutics','Adult Stem Cell',15912390;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10227','JDRF Encapsulation Consortium Fall 2017 Meeting',null,'Diabetes, Metabolic Disorders, Type 1 diabetes','42979', '43069','Conference II','Closed','JDRF International',null,42425;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10088','Preclinical development of AAV vector-mediated in vivo hepatic reprogramming of myofibroblasts as a therapy for liver fibrosis',null,'Liver Disease, Metabolic Disorders','43040', '43951','Quest - Discovery Stage Research Projects','Closed','University of California, San Francisco','Directly Reprogrammed Cell',1638389;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-10344','A Double-Blind, Controlled Ph 2b Study of the Safety and Efficacy of Modified Stem Cells in Patients with Chronic Motor Deficit from Ischemic Stroke', 570792450,'Neurological Disorders, Stroke','42948', '44135','Clinical Trial Stage Projects','Closed','SanBio, Inc.','Adult Stem Cell',18970000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10090','Human Cardiac Chip for Assessment of Proarrhythmic Risk',null,'Heart Disease, Toxicity','43040', '43951','Quest - Discovery Stage Research Projects','Closed','University of California, Berkeley','iPS Cell',899581;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09183','In Utero Hematopoietic Stem Cell Transplantation For The Treatment Of Fetuses With Alpha Thalassemia Major', 354923182,'Alpha Thalassemia Major, Blood Disorders','42948', '44773','Clinical Trial Stage Projects','Active','University of California, San Francisco','Adult Stem Cell',10906978;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10107-A','A Novel Approach to Eradicate Cancer Stem Cells',null,'Cancer, Colon Cancer, Solid Tumors','43040', '43830','Quest - Discovery Stage Research Projects','Closed','City of Hope, Beckman Research Institute','Cancer Stem Cell',1539935;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10107-B','A Novel Approach to Eradicate Cancer Stem Cells',null,'Cancer, Colon Cancer, Solid Tumors','43831', '44227','Quest - Discovery Stage Research Projects','Active','University of California, San Diego','Cancer Stem Cell',279977;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10110','Multipotent Cardiovascular Progenitor Regeneration of the Myocardium after MI',null,'Heart Disease','43009', '44012','Quest - Discovery Stage Research Projects','Closed','Stanford University','iPS Cell',1809234;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10120','Microenvironment for hiPSC-derived pacemaking cardiomyocytes',null,'Heart Disease','43040', '44135','Quest - Discovery Stage Research Projects','Closed','University of California, Davis','iPS Cell',2042438;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10124','Targeted Gene Editing in the Treatment of X-Linked Hyper-IgM Syndrome',null,'Blood Disorders, Hyper IgM Syndrome','43009', '43921','Quest - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Adult Stem Cell',1512333;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10129','Non-Toxic, Highly-Effective Bioinspired Cryoprotectants for On-Demand Stem Cell Therapies',null,'Other','43040', '43951','Quest - Discovery Stage Research Projects','Closed','X-Therma Inc.','Embryonic Stem Cell, iPS Cell',887883;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10134','Platform Technology for Pluripotent Stem Cell-Derived T cell Immunotherapy',null,'Cancer','43009', '43738','Quest - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Embryonic Stem Cell',965636;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10182','Discovery of therapeutics for Huntington’s Disease',null,'Huntington's Disease, Neurological Disorders','43040', '43769','Quest - Discovery Stage Research Projects','Closed','Rumi Scientific CA','Embryonic Stem Cell',1399800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10188','Immunization strategies to prevent Zika viral congenital eye and brain disease',null,'Infectious Disease, Neurological Disorders, Zika virus','43040', '44043','Quest - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Adult Stem Cell, iPS Cell',2128867;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10195','Identification and characterization of the optimal human neural stem cell line (hNSC) for the treatment of traumatic brain injury (TBI) 2.0.',null,'Neurological Disorders, Traumatic Brain Injury','43009', '43921','Quest - Discovery Stage Research Projects','Closed','University of California, Irvine','Embryonic Stem Cell',1671213;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10061','Lgr5-mediated self-renewal in B cell selection and leukemia-initiation',null,'B cell cancers, Blood Cancer, Cancer, Leukemia','43040', '43769','Quest - Discovery Stage Research Projects','Closed','City of Hope, Beckman Research Institute','Cancer Stem Cell',2186520;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-09433','Intraparenchymal NR1 Stem Cell Therapy for Chronic Subcortical Ischemic Stroke',null,'Neurological Disorders, Stroke','42948', '44222','Late Stage Preclinical Projects','Closed','Stanford University','Embryonic Stem Cell',5300000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-10067','A tool for rapid development of clinical-grade protocols for dopaminergic neuronal differentiation of Parkinson’s Disease patient-derived iPSCs',null,'Neurological Disorders, Parkinson's Disease','42979', '43616','Quest - Discovery Stage Research Projects','Closed','Scaled Biolabs Inc.','iPS Cell',657528;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-09776','Development of CLT030-ADC, a Leukemic Stem Cell Targeting Antibody-Drug-Conjugate, for Treatment of Acute Myeloid Leukemia',null,'Acute Myeloid Leukemia, Blood Cancer, Cancer','42948', '43830','Late Stage Preclinical Projects','Closed','Cellerant Therapeutics, Inc.','Cancer Stem Cell',6863755;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-09912','A Novel Tissue Engineering Technique to Repair Degenerated Retina',null,'Vision Loss','42979', '43343','Inception - Discovery Stage Research Projects','Closed','University of Southern California','Embryonic Stem Cell',215133;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-09984','Hypo-immunogenic cardiac patches for myocardial regeneration',null,'Heart Disease','43009', '43373','Inception - Discovery Stage Research Projects','Closed','University of California, San Francisco','iPS Cell',235818;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-09999','Generation of expandable, self-renewing muscle stem cells for Duchenne Muscular Dystrophy',null,'Muscular Dystrophy, Skeletal/Smooth Muscle disorders','42917', '43646','Inception - Discovery Stage Research Projects','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell, iPS Cell',252000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10036','Prodrug innovation to target muscle stem cells and enhance muscle regeneration',null,'Skeletal/Smooth Muscle disorders','43009', '43738','Inception - Discovery Stage Research Projects','Closed','Stanford University','Adult Stem Cell',235834;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10074','Reprogramming human stem cells for blood cell generation',null,'Blood Disorders','42917', '43281','Inception - Discovery Stage Research Projects','Closed','University of California, San Diego','Adult Stem Cell',210060;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-10079','An exosome-based translational strategy to mitigate Alzheimer’s disease neuropathology',null,'Alzheimer's Disease, Neurological Disorders','43009', '43373','Inception - Discovery Stage Research Projects','Closed','University of California, Irvine','Embryonic Stem Cell',157650;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10141','15th International Cord Blood Sympsium',null,'Blood Disorders','42856', '42947','Conference II','Closed','American Association of Blood Banks',null,30000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10224','Third International Workshop on Clinical Tolerance',null,null,'42948', '43039','Conference II','Closed','Stanford University',null,29500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-10240','The 18th Annual UC System-Wide Bioengineering Symposium',null,null,'42887', '42978','Conference II','Closed','University of California, Los Angeles',null,25000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-09814','Injectable pro-regenerative scaffold for treating symptomatic peripheral artery disease',null,'Vascular Disease','42917', '44500','Therapeutic Translational Research Projects','Active','University of California, San Diego','Adult Stem Cell',2839317;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN4-09884','A Novel, Robust and Comprehensive Predictive Tool Using Human Disease-Specific Induced Pluripotent Stem Cells for Preclinical Drug Screening',null,'Heart Disease, Toxicity','42917', '43708','Tool Translational Research Projects','Closed','Stanford University','iPS Cell',975000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-09472','Allogenic human adipose-derived mesenchymal stem cells for the treatment of knee osteoarthritis',null,'Bone or Cartilage Disease, Osteoarthritis','42795', '43173','Late Stage Preclinical Projects','Closed','Cellular Biomedicine Group, Inc.','Adult Stem Cell',1200000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09730','Phase 2 Safety and Efficacy Study of CLBS03 Autologous T-Regulatory Cells in Adolescents with Recent Onset Type 1 Diabetes Mellitus', 881604473,'Diabetes, Metabolic Disorders, Type 1 diabetes','42826', '44001','Clinical Trial Stage Projects','Closed','Caladrius Biosciences','Adult Stem Cell',8175946;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09284','Human Neural Progenitors Secreting Glial Cell Line-Derived Neurotrophic Factor (CNS10-NPC-GDNF) for the Treatment of Amyotrophic Lateral Sclerosis', 153036181,'Amyotrophic Lateral Sclerosis, Neurological Disorders','42826', '44408','Clinical Trial Stage Projects','Active','Cedars-Sinai Medical Center','Adult Stem Cell',6154067;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09504','Lentiviral Gene Therapy for Infants with X-linked Severe Combined Immunodeficiency using Autologous Bone Marrow Stem Cells and Busulfan Conditioning', 991056597,'Blood Disorders, Immune Disease, Severe Combined Immunodeficiency, X-linked (X-SCID)','42826', '44651','Clinical Trial Stage Projects','Active','St. Jude Children's Research Hospital','Adult Stem Cell',11924780;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-09947','2017 Stanford Drug Discovery and Stem Cell Technology Conference',null,null,'42826', '42916','Conference II','Closed','Stanford University',null,2359;
"Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.6-09695','2nd Annual Symposium of the CIRM Alpha Stem Cell Clinics Network 
""Alpha Clinics - Making the Future a Reality for Stem Cell-Based Therapies""',null,null,'42767', '42855','Conference - The 2017 Alpha Stem Cell Clinic Annual Symposium','Closed','City of Hope, Beckman Research Institute',null,79287;"
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09526','GENE EDITING FOR FOXP3 IN HUMAN HSC',null,'Blood Disorders, Immune Disease, IPEX Syndrome','42856', '43769','Quest - Discovery Stage Research Projects','Closed','Stanford University','Adult Stem Cell',984228;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09559','Thin Film Encapsulation Devices for Human Stem Cell derived Insulin Producing Cells',null,'Diabetes, Metabolic Disorders, Type 1 diabetes','42887', '43616','Quest - Discovery Stage Research Projects','Closed','University of California, San Francisco','Embryonic Stem Cell',1092063;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09565','Preclinical development of human hepatocyte progenitor cells for cell therapy',null,'Liver Disease, Metabolic Disorders','42887', '43616','Quest - Discovery Stage Research Projects','Closed','Stanford University','Adult Stem Cell',1651211;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09569','hNSC-mediated delivery of ApiCCT1 as a candidate therapeutic for Huntington’s disease',null,'Huntington's Disease, Neurological Disorders','42887', '43799','Quest - Discovery Stage Research Projects','Closed','University of California, Irvine','Embryonic Stem Cell',1650263;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09596','Direct Cardiac Reprogramming for Regenerative Medicine',null,'Heart Disease','42887', '43616','Quest - Discovery Stage Research Projects','Closed','Gladstone Institutes, J. David','Directly Reprogrammed Cell',2392157;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09610','CRISPR/dCas9 mutant targeting SNCA promoter for downregulation of alpha-synuclein expression as a novel therapeutic approach for Parkinson’s disease',null,'Neurological Disorders, Parkinson's Disease','42887', '43446','Quest - Discovery Stage Research Projects','Closed','Parkinson's Institute','iPS Cell',1288415;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09615','Targeted off-the-shelf immunotherapy to treat refractory cancers',null,'Blood Cancer, Cancer, Ovarian Cancer, Solid Tumors','42856', '43769','Quest - Discovery Stage Research Projects','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1936936;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09624','Protein tyrosine phosphatase - sigma inhibitors for hematopoietic regeneration',null,'Blood Cancer, Blood Disorders, Cancer','42887', '43616','Quest - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Adult Stem Cell',2116708;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09635','Designing a cellular niche for transplantation of human embryonic stem cell-derived beta cells',null,'Diabetes, Metabolic Disorders','42856', '43708','Quest - Discovery Stage Research Projects','Closed','University of California, San Francisco','Embryonic Stem Cell',2006076;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09637','Genome Editing to Correct Cystic Fibrosis Mutations in Airway Stem Cells',null,'Cystic Fibrosis, Respiratory Disorders','42856', '43769','Quest - Discovery Stage Research Projects','Closed','Stanford University','Adult Stem Cell',1968456;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09649','A treatment for Zika virus infection and neuroprotection efficacy',null,'Infectious Disease, Neurological Disorders, Zika virus','42826', '43738','Quest - Discovery Stage Research Projects','Closed','University of California, San Diego','iPS Cell',1924524;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09698','Phase 2b Clinical Study of Safety and Efficacy of Intravitreal Injection of Retinal Progenitor Cells (jCell)  for Treatment of Retinitis Pigmentosa', 950189050,'Retinitis Pigmentosa, Vision Loss','42767', '44408','Clinical Trial Stage Projects','Active','jCyte, Inc','Other',8295750;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09439','Induction of Tolerance to Combined Kidney and Hematopoietic Progenitor Cell Transplants from HLA Haplotype Matched Living Donors', 142294510,'Kidney Disease, Kidney Failure','42767', '44561','Clinical Trial Stage Projects','Active','Stanford University','Adult Stem Cell',6653266;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-09292-B','Curing Sickle cell Disease with CRISPR-Cas9 genome editing',null,'Blood Disorders, Sickle Cell Disease','43831', '44196','Therapeutic Translational Research Projects','Closed','University of California, San Francisco','Adult Stem Cell',60635;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-09270','An autologous somatic stem cell therapy for the treatment of osteonecrosis',null,'Bone or Cartilage Disease, Osteonecrosis','42795', '43434','Therapeutic Translational Research Projects','Closed','Ankasa Regenerative Therapeutics','Adult Stem Cell',2088780;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-09288','Pluripotent stem cell-derived chondrocytes for articular cartilage repair',null,'Bone or Cartilage Disease','42795', '43830','Therapeutic Translational Research Projects','Closed','University of Southern California','Embryonic Stem Cell',2503104;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-09292-A','Curing Sickle cell Disease with CRISPR-Cas9 genome editing',null,'Blood Disorders, Sickle Cell Disease','42767', '43723','Therapeutic Translational Research Projects','Closed','Children's Hospital of Oakland Research Institute','Adult Stem Cell',4394276;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-09394','Human iPSC-derived GABAergic Progenitors for Alzheimer’s Disease Treatment',null,'Alzheimer's Disease, Neurological Disorders','42795', '43373','Therapeutic Translational Research Projects','Closed','Gladstone Institutes, J. David','iPS Cell',1900000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.5-09742','Manage the 2017 SPARK Annual Meeting',null,null,'42736', '43039','Conference - Manage The SPARK Annual Meeting','Closed','City of Hope, Beckman Research Institute',null,22555;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-09707','The 7th Annual California ALS research network and PAC10 meeting',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','42705', '42794','Conference II','Closed','University of Southern California',null,10830;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09444','Pulmonary Arterial Hypertension Treated with Cardiosphere-Derived Allogeneic Stem Cells', 989840466,'Heart Disease, Pulmonary Hypertension, Vascular Disease','42736', '44712','Clinical Trial Stage Projects','Active','Cedars-Sinai Medical Center','Adult Stem Cell',7354772;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09339-B','Efficacy and safety of cryopreserved autologous CD34+ HSC transduced with EFS lentiviral vector encoding for human ADA gene in ADA-SCID subjects',null,'Blood Disorders, Genetic Disorder, Immune Disease, Pediatrics, Severe Combined Immunodeficiency, Adenosine deaminase-deficient (ADA-SCID)','43252', '44926','Clinical Trial Stage Projects','Active','Orchard Therapeutics plc','Adult Stem Cell',8465745;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-09339-A','Efficacy and safety of cryopreserved autologous CD34+ HSC transduced with EFS lentiviral vector encoding for human ADA gene in ADA-SCID subjects', 996564243,'Blood Disorders, Genetic Disorder, Immune Disease, Pediatrics, Severe Combined Immunodeficiency, Adenosine deaminase-deficient (ADA-SCID)','42736', '43281','Clinical Trial Stage Projects','Closed','University of California, Los Angeles','Adult Stem Cell',10156925;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.4-09623','2017 Bridges Annual Meeting',null,null,'42705', '43008','Conference - Manage The Bridges Annual Meeting','Closed','San Diego State University Foundation',null,153449;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('INFR2-09298','A Translating Center designed to expedite the development and delivery of high quality stem cell therapies to patients',null,'Multiple Indications (Alpha Clinics)','42705', '44530','Translating Center','Active','IQVIA, Inc.',null,15000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-09230','Ex vivo transduced autologous human CD34+ hematopoietic stem cells for treatment of cystinosis',null,'Cystinosis, Genetic Disorder, Metabolic Disorders, Pediatrics','42675', '43784','Late Stage Preclinical Projects','Closed','University of California, San Diego','Adult Stem Cell',5273189;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-09545','The 2017 Midwinter Conference of Immunologists at Asilomar',null,null,'42644', '42794','Conference II','Closed','Midwinter Conference of Immunologists',null,5000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-09580','2016 Tissue Engineering and Regenerative Medicine International Society - Americas (TERMIS-AM) Conference in San Diego, CA on December 11-14, 2016',null,null,'42705', '42794','Conference II','Closed','University of California, San Diego',null,40000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-09588','Cellular Therapies and Transfusion Medicine in Trauma and Critical Care - Looking Towards the Future',null,null,'42856', '42947','Conference II','Closed','Vitalant Research Institute',null,30000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-09475','2016 World Alliance Forum in San Francisco (WAFSF) “US-Japan Innovative Healthcare Technologies Conference”',null,null,'42675', '42766','Conference II','Closed','Alliance Forum Foundation',null,20000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-08982','Scalable, Defined Production of Oligodendrocyte Precursor Cells to Treat Neural Disease and Injury',null,'Neurological Disorders, Spinal Cord Injury','42675', '43585','Quest - Discovery Stage Research Projects','Closed','University of California, Berkeley','Embryonic Stem Cell, iPS Cell',1627099;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09032','MSC delivery of an artificial transcription factor to the brain as a treatment for Angelman Syndrome',null,'Autism, Neurological Disorders','42705', '43616','Quest - Discovery Stage Research Projects','Closed','University of California, Davis','Adult Stem Cell',1055319;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09073','Autologous cell therapy for Parkinson’s disease using iPSC-derived DA neurons',null,'Neurological Disorders, Parkinson's Disease','42705', '43190','Quest - Discovery Stage Research Projects','Closed','Scripps Research Institute','iPS Cell',2299786;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09098','Use of Human iPSC-derived Endothelial Cells for Calcific Aortic Valve Disease Therapeutics',null,'Heart Disease, Vascular Disease','42705', '43434','Quest - Discovery Stage Research Projects','Closed','Gladstone Institutes, J. David','iPS Cell',2400048;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-09123','Immunotherapy for HIV infection using engineered hematopoietic stem/progenitor cells',null,'HIV/AIDS, Infectious Disease','42644', '43555','Quest - Discovery Stage Research Projects','Closed','California Institute of Technology','Adult Stem Cell',1569193;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-08671','Stem cell-derived islet cell replacement therapy with immunosuppression for high-risk type 1 diabetes',null,'Diabetes, Metabolic Disorders, Type 1 diabetes','42583', '43008','Late Stage Preclinical Projects','Closed','ViaCyte, Inc.','Embryonic Stem Cell',3544721;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-08938','A Human Acellular Vessel in Patients Needing Renal Replacement Therapy: A Comparison with ePTFE Grafts as Conduits for Hemodialysis (HUMANITY)', 265770499,'Kidney Disease, Kidney Failure','42583', '44025','Clinical Trial Stage Projects','Closed','Humacyte, Inc.','Adult Stem Cell',7625000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-08824','CRISPR/Cas9 nanoparticle enabled therapy for Duchenne Muscular Dystrophy in muscle stem cells',null,'Muscular Dystrophy, Skeletal/Smooth Muscle disorders','42675', '43585','Quest - Discovery Stage Research Projects','Closed','University of California, Los Angeles','iPS Cell',2150400;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC2-08874','Novel Rejuvenated T Cell Immunotherapy for Lung Cancer',null,'Cancer, Lung Cancer, Solid Tumors','42675', '43404','Quest - Discovery Stage Research Projects','Closed','Stanford University','iPS Cell',1968456;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('INFR1-09166','An Accelerating Center designed to expedite the development and delivery of high quality stem cell therapies to patients',null,'Multiple Indications (Alpha Clinics)','42583', '43721','Accelerating Center','Closed','IQVIA, Inc.',null,11772453;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-08686','Regeneration of a Normal Corneal Surface by Limbal Stem Cell Therapy',null,'Corneal Damage, Vision Loss','42583', '43830','Late Stage Preclinical Projects','Closed','University of California, Los Angeles','Adult Stem Cell',4244211;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.3-09229','Stem Cells for Lung Diseases - Overcoming Barriers to Find New Therapies',null,'Respiratory Disorders','42522', '42704','Conference - Lung Regenerative Medicine Workshop','Closed','University of California, Los Angeles',null,44548;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08750','Curing bladder cancer by replacing corrupted urothelium with differentiated hES cells',null,'Cancer','42614', '42978','Inception - Discovery Stage Research Projects','Closed','Stanford University','Embryonic Stem Cell',210906;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08776','Genome editing for causation and reversion of MPN-associated mutations in human hematopoietic stem cells',null,'Blood Cancer, Cancer','42614', '43159','Inception - Discovery Stage Research Projects','Closed','University of California, Berkeley','Adult Stem Cell',235800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08790','Targeting progenitors in scar tissue to reduce chronic scar burden',null,'Heart Disease','42614', '43343','Inception - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Adult Stem Cell',230400;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08792','Generation of bile duct-competent transplantable human liver organoids',null,'Liver Disease, Metabolic Disorders','42583', '42947','Inception - Discovery Stage Research Projects','Closed','University of California, San Francisco','iPS Cell',206460;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08643','Exosomal Y-RNAs as mediators of bioactivity of cardiac-derived cell therapy',null,'Heart Disease','42552', '42916','Inception - Discovery Stage Research Projects','Closed','Cedars-Sinai Medical Center','Adult Stem Cell',181063;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08800','Blood Brain Barrier (BBB)-on-Chip: Development and validation of a novel iPS-based microfluidic model of the human BBB',null,'Neurological Disorders','42583', '42947','Inception - Discovery Stage Research Projects','Closed','Cedars-Sinai Medical Center','iPS Cell',241992;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08650','Activation of patient-specific endogenous myocardial repair through the exosomes generated  from the hypoxic iPSC-derived cardiomyocytes (iCMs).',null,'Heart Disease','42583', '42947','Inception - Discovery Stage Research Projects','Closed','Stanford University','iPS Cell',234619;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08819','Organoid Modeling of Human Cortical Microcircuits',null,'Neurological Disorders','42614', '43343','Inception - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Embryonic Stem Cell',208916;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-08522','2nd Generation Vaccine for the Treatment of Glioblastoma',null,'Brain Cancer, Cancer, Solid Tumors','42583', '43706','Therapeutic Translational Research Projects','Closed','Stanford University','Cancer Stem Cell',2929889;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08652','Examining the efficacy of GDF11 antibody as a rejuvenator of aged human muscle stem cell capacity and muscle repair .',null,'Aging, Skeletal/Smooth Muscle disorders','42552', '42916','Inception - Discovery Stage Research Projects','Closed','University of California, San Francisco','Adult Stem Cell',180000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08823','Novel Platforms to Enhance In Vivo Delivery of Skeletal Muscle Progenitor Cells from Human Pluripotent Stem Cells',null,'Muscular Dystrophy, Skeletal/Smooth Muscle disorders','42552', '43100','Inception - Discovery Stage Research Projects','Closed','University of California, Los Angeles','iPS Cell',230400;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08825','Reverse transcriptase inhibitors as a novel therapeutic approach for neurological autoimmune disorders',null,'Neurological Disorders','42552', '42947','Inception - Discovery Stage Research Projects','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',210060;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08842','Identification of stem cell surface markers as potential therapeutic targets for advanced prostate cancer',null,'Cancer, Prostate Cancer, Solid Tumors','42552', '42916','Inception - Discovery Stage Research Projects','Closed','University of California, Los Angeles','Adult Stem Cell',209160;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08848','Embryonic Stem Cells for Corneal Endothelial Degeneration',null,'Vision Loss','42552', '42916','Inception - Discovery Stage Research Projects','Closed','Stanford University','Embryonic Stem Cell, iPS Cell',235836;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08855','Modulating Liver Sinusoidal Endothelial Cell Permeability to Enhance Engraftment of Endothelial Cell Progenitors for the Treatment of Hemophilia A',null,'Blood Disorders, Hemophilia A','42583', '43131','Inception - Discovery Stage Research Projects','Closed','Vitalant Research Institute','Adult Stem Cell, iPS Cell',180000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08868','Developing a personalized approach to beta cell replacement for patients with a genetic form of diabetes',null,'Diabetes, Metabolic Disorders','42614', '43159','Inception - Discovery Stage Research Projects','Closed','Children's Hospital of Los Angeles','iPS Cell',179995;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08683','Microenvironment based optimization of retinal induction using CRISPR-CAS9 reporter pluripotent stem cells as an expandable source of retinal progenitors and photoreceptors.',null,'Vision Loss','42644', '43738','Inception - Discovery Stage Research Projects','Closed','University of California, San Diego','iPS Cell',232200;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08723','iPS-Interneuron Transplantation for Neural Repair after Stroke',null,'Neurological Disorders, Stroke','42614', '42978','Inception - Discovery Stage Research Projects','Closed','University of California, Los Angeles','iPS Cell',229396;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08731','Autologous iPSC-based therapy for radiation induced bladder injury',null,'Bladder or Urinary Tract Disorder, Skeletal/Smooth Muscle disorders','42644', '43190','Inception - Discovery Stage Research Projects','Closed','Stanford University','iPS Cell',235836;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DISC1-08737','New Methods for the Chemical Expansion of Hematopoietic Stem and Progenitor Cells',null,'Blood Disorders','42552', '43281','Inception - Discovery Stage Research Projects','Closed','University of California, San Diego','Adult Stem Cell',232200;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08465','International Society for Experimental Hematology, 45th Annual Scientific Meeting',null,'Blood Disorders','42491', '42643','Conference II','Closed','International Society for Experimental Hematology',null,25000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08866','14th International Cord Blood Symposium: Give Life Twice',null,'Blood Disorders','42491', '42582','Conference II','Closed','American Association of Blood Banks',null,15000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08985','Neurogenesis during Development and in the Adult Brain (joint with Transcriptional and Epigenetic Control in Stem Cells)',null,null,'42736', '42825','Conference II','Closed','Keystone Symposia on Molecular and Cellular Biology',null,35000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-09080','HD-CARE INAUGURAL SYMPOSIUM',null,'Huntington's Disease, Neurological Disorders','42461', '42551','Conference II','Closed','University of California, Irvine',null,1500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-08561-B','Personalized Cell Therapy for Diabetes',null,'Diabetes, Metabolic Disorders','42826', '43465','Therapeutic Translational Research Projects','Closed','University of California, Los Angeles','iPS Cell',1494896;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-08471','ASCENT- Advanced Stem Cell Enteric Neuropathy Therapy',null,'Intestinal Disease, Metabolic Disorders, Neurological Disorders, Pediatrics','42552', '44561','Therapeutic Translational Research Projects','Active','Children's Hospital of Los Angeles','iPS Cell',7077352;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-08519','Overexpression of HexA/HexB by lentivector expression in blood cells to treat Tay-Sachs and Sandhoff disease',null,'Metabolic Disorders, Neurological Disorders','42522', '43738','Therapeutic Translational Research Projects','Closed','University of California, Davis','Adult Stem Cell',883174;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-08525','Process development for establishing an iPSC-based therapeutic candidate for Canavan disease',null,'Canavan Disease, Neurological Disorders','42552', '44561','Therapeutic Translational Research Projects','Active','City of Hope, Beckman Research Institute','iPS Cell',7377384;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-08533','Stem Cell-Based iNKT Cell Therapy for Cancer',null,'Acute Myeloid Leukemia, Blood Cancer, Cancer, Multiple Myeloma','42552', '44196','Therapeutic Translational Research Projects','Closed','University of California, Los Angeles','Adult Stem Cell',6956775;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-08334','Allogeneic Cardiosphere-Derived Cells for Duchenne Muscular Dystrophy Cardiomyopathy', 472613885,'Heart Disease, Heart disease associated with Duchenne muscular dystrophy','42461', '43616','Clinical Trial Stage Projects','Closed','Capricor, Inc','Adult Stem Cell',3376259;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-08552','Human Embryonic Stem Cell-Derived Neural Stem Cell Transplants in Amyotrophic Lateral Sclerosis',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','42522', '43190','Therapeutic Translational Research Projects','Closed','University of California, San Diego','Embryonic Stem Cell',1790000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRAN1-08561-A','Personalized Cell Therapy for Diabetes',null,'Diabetes, Metabolic Disorders','42552', '42825','Therapeutic Translational Research Projects','Closed','Semma Therapeutics','iPS Cell',597333;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-08363','Ex Vivo Transduction of the Human Artemis (DCLRE1C) cDNA by Lentiviral Vector AProArt into CD34+ Hematopoietic Cells for Artemis (ART)-Deficient Severe Combined Immunodeficiency (SCID)',null,'Blood Disorders, Immune Disease, Severe Combined Immunodeficiency, Artemis deficient (ART-SCID)','42491', '43220','Late Stage Preclinical Projects','Closed','University of California, San Francisco','Adult Stem Cell',4268865;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.1-08976','2016 CIRM Bridges & SPARK Meetings',null,null,'42430', '42643','Conference - Manage The 2016 Bridges And SPARK Annual Meetings','Closed','Mosaic Event Management, Inc.',null,205388;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-08342','Development of AB-110: genetically-modified endothelial cells plus expanded cord blood hematopoietic stem cells  as a transplantation therapy',null,'Blood Cancer, Cancer','42461', '42978','Late Stage Preclinical Projects','Closed','Angiocrine Bioscience, Inc.','Adult Stem Cell',3797117;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1.2-08931','UCSD Division of Regenerative Medicine and CIRM Alpha Clinics Network Symposium',null,null,'42430', '42521','Conference - The 2016 Alpha Stem Cell Clinic Annual Symposium','Closed','University of California, San Diego',null,37778;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08376','Bridges to Stem Cell Research Internship Program',null,null,'42583', '44469','Bridges','Active','San Diego State University Foundation',null,3045886;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC3-08407','Internship at a Cutting Edge CIRM-funded Stem Cell Research Facility',null,null,'42522', '44561','SPARK','Active','University of California, Davis',null,373324;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08381','CIRM Graduate Student Training Grant for the Implementation of a Stem Cell Technology and Lab Management Program: Training in Stem Cell Sciences and Regenerative Medicine',null,null,'42522', '44469','Bridges','Active','Cal State Univ, Channel Island',null,2970025;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC3-08422','Developing High School Students' Research Practices and Regenerative Medicine Knowledge through a Summer Intern Program',null,null,'42522', '44561','SPARK','Active','University of California, San Francisco',null,382430;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08382','Bridges to Stem Cell Research, Therapy and Careers: A Talent Development Program for Training Diverse Undergraduates for Careers in Regenerative Medicine',null,null,'42948', '44926','Bridges','Active','Cal State Univ, Fullerton',null,2947898;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC3-08425','Stem Cell and Regenerative Medicine- Summer Research Internship',null,null,'42522', '44561','SPARK','Active','Stanford University',null,380827;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC3-08431','CIRM Early Investigators High School Stem Cell Research Program',null,null,'42522', '44561','SPARK','Active','California Institute of Technology',null,189343;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08383','CIRM Stem Cell Biotechnology Training Program',null,null,'42552', '44469','Bridges','Active','Cal State Univ, Long Beach',null,3055374;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08388','Interdisciplinary Master of Science Program in Regenerative Medicine',null,null,'42552', '44742','Bridges','Active','Cal Poly Corporation, an Auxiliary of California Polytechnic State University, San Luis Obispo',null,2632378;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08390','Strengthening the Pipeline of Master's-level Scientific and Laboratory Personnel in Stem Cell Research',null,null,'42736', '44592','Bridges','Active','Cal State Univ, Sacramento',null,2084054;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08391','CIRM Bridges 2.0: Training the Next Generation of Stem Cell Scientists',null,null,'42522', '44530','Bridges','Active','San Francisco State University',null,3041625;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08394','SCILL- Stem Cell Internships in Laboratory-based Learning',null,null,'42522', '44712','Bridges','Active','San Jose State University',null,3086302;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08397','CIRM 2.0 Bridges Training Program',null,null,'42583', '44469','Bridges','Active','Humboldt State University',null,2702644;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08398','Bridges to Stem Cell Research and Therapy at Pasadena City College',null,null,'42614', '44439','Bridges','Active','Pasadena City College',null,2556959;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08400','Stem Cell Training Enhancement Program with a focus on Translational Research',null,null,'42917', '44742','Bridges','Active','City College Of San Francisco',null,2069835;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08411','Stem Cell Scientist Training Program',null,null,'42917', '44742','Bridges','Active','Cal State Univ, Northridge',null,2760691;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08418','Stem Cell Scholars- from Basic Research to Clinical Translation: training a diverse pool of students in the lab, engaging them in patient and healthcare activities, motivating  them to educate their immediate community and enabling them for careers in ...',null,null,'42979', '44926','Bridges','Active','Cal State Univ, San Bernadino',null,2659136;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC3-08387','SPARK Award Program in Stem Cell Biology for California High School Students',null,null,'42522', '44561','SPARK','Active','City of Hope, Beckman Research Institute',null,276780;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC3-08399','Leveraging Investment in hiGHschool Training:  Summer Program to Accelerate Regenerative medicine Knowledge (LIGHT a SPARK)',null,null,'42522', '44561','SPARK','Active','Children's Hospital of Oakland Research Institute',null,228940;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC2-08375','CIRM Bridges to Stem Cell Research and Therapy Training Grant',null,null,'42552', '44469','Bridges','Active','Cal State Univ, San Marcos',null,3041366;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC3-08404','Mentored High School Summer Research Program',null,null,'42491', '44561','SPARK','Active','Cedars-Sinai Medical Center',null,305281;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08714','California ALS Research Summit 2016',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','42370', '42460','Conference II','Closed','University of California, San Diego',null,11400;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08433','Primary Immune Deficiency Treatment Consortium (PIDTC) Annual Scientific Workshop',null,'Immune Disease','42491', '42582','Conference II','Closed','University of California, Los Angeles',null,29807;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08626','2016 Rachmiel Levine-Arthur Riggs Diabetes Research Symposium',null,null,'42430', '42521','Conference II','Closed','City of Hope, Beckman Research Institute',null,10000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08673','2016 Gordon Research Conference on Craniofacial Morphogenesis and Tissue Regeneration',null,'Developmental Disorders','42430', '42521','Conference II','Closed','Gordon Research Conferences',null,5000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08701','Drug Discovery & Stem Cell Models for Cardiovascular Disease Conference',null,'Blood Disorders, Heart Disease','42430', '42521','Conference II','Closed','Stanford University',null,7500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-08280','A Phase III randomized double-blind, controlled study of ICT 107 with maintenance temozolomide (TMZ) in newly diagnosed glioblastoma following resection and concomitant TMZ chemoradiotherapy', 968023395,'Brain Cancer, Cancer, Solid Tumors','42309', '42907','Clinical Trial Stage Projects','Closed','ImmunoCellular Therapeutics','Cancer Stem Cell',5391016;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08380','Stem Cell Meeting on the Mesa',null,null,'42278', '42369','Conference II','Closed','Sanford Consortium for Regenerative Medicine',null,50000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08410','2015 World Alliance Forum in San Francisco (2015 WAFSF) "Regenerative Medicine: Let's Talk Business!"',null,null,'42278', '42369','Conference II','Closed','Alliance Forum Foundation',null,10000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('EDUC1-08366','Human Research In Times of Controversy: From Stem Cells To Fetal Tissue',null,null,'42278', '42369','Conference II','Closed','University of California, Irvine',null,13562;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-08309','Development of a Chondrogenic Drug Candidate Targeting Resident Mesenchymal Stem Cells for the Treatment of Osteoarthritis',null,'Bone or Cartilage Disease','42248', '42855','Late Stage Preclinical Projects','Closed','Calibr',null,1667832;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-08289','Stem Cell Gene Therapy for HIV Mediated by Lentivector Transduced, Pre-selected CD34+ Cells in AIDS lymphoma patients', 154998134,'Blood Cancer, Cancer, HIV-related Lymphoma, HIV/AIDS, Infectious Disease','42248', '44439','Clinical Trial Stage Projects','Active','University of California, Davis','Adult Stem Cell',8414265;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-08231','A Phase I/II, Non Randomized, Multicenter, Open-Label Study of G1XCGD (Lentiviral Vector Transduced CD34+ Cells) in Patients With X-Linked Chronic Granulomatous Disease', 207121535,'Blood Disorders, Immune Disease, Pediatrics, X-linked Chronic Granulomatous Disease','42248', '44926','Clinical Trial Stage Projects','Active','University of California, Los Angeles','Adult Stem Cell',7083364;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN1-08235','IND-enabling study of subretinal delivery of human neural progenitor cells for the treatment of retinitis pigmentosa',null,'Vision Loss','42217', '43434','Late Stage Preclinical Projects','Closed','Cedars-Sinai Medical Center','Adult Stem Cell',4954514;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CLIN2-08239','Tumor stem cell-targeted immunotherapy for metastatic melanoma –a randomized phase 3 clinical trial.', 543704704,'Cancer, Melanoma, Solid Tumors','42186', '42418','Clinical Trial Stage Projects','Closed','Caladrius Biosciences','Cancer Stem Cell',3000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PC1-08086','Human Stem-Cell Based Development of a Potent Alzheimer’s Drug Candidate',null,'Alzheimer's Disease, Neurological Disorders','42248', '43251','Preclinical Development Awards','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell, iPS Cell',1664885;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PC1-08117','A hNSC Development Candidate for Huntington’s Disease',null,'Huntington's Disease, Neurological Disorders','42186', '43465','Preclinical Development Awards','Closed','University of California, Irvine','Embryonic Stem Cell',4951623;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PC1-08142','Development of a Chondrogenic Drug Candidate Targeting Cartilage-residing Mesenchymal Stem Cells for the Treatment of Osteoarthritis',null,'Bone or Cartilage Disease','42156', '42429','Preclinical Development Awards','Closed','Calibr','Adult Stem Cell',2306703;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PC1-08103','Placental Stem Cells for the In Utero Treatment of Spina Bifida',null,'Neurological Disorders, Pediatrics, Spina Bifida','42248', '43343','Preclinical Development Awards','Closed','University of California, Davis','Adult Stem Cell',2182146;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PC1-08118','Scaffold for dermal regeneration containing pre-conditioned mesenchymal stem cells to heal chronic diabetic wounds',null,'Diabetes, Diabetic Wounds, Metabolic Disorders, Skin Disease','42248', '43524','Preclinical Development Awards','Closed','University of California, Davis','Adult Stem Cell',4620144;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PC1-08128','Embryonic Stem Cell-Derived Chondroprogenitor Cells to Repair Osteochondral Defects',null,'Bone or Cartilage Disease','42217', '43496','Preclinical Development Awards','Closed','Scripps Health','Embryonic Stem Cell',7660211;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PC1-08111','Pre-clinical development of gene correction therapy of hematopoietic stem cells for SCID-X1',null,'Blood Disorders, Genetic Disorder, Immune Disease, Pediatrics, Severe Combined Immunodeficiency, X-linked (X-SCID)','42278', '43190','Preclinical Development Awards','Closed','Stanford University','Adult Stem Cell',874877;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08207','Cellular Therapies in Trauma and Critical Care Medicine: Forging New Frontiers',null,'Trauma','42156', '42277','Conference','Closed','Vitalant Research Institute',null,40000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08209','USC/UCSF/UCLA Tri-Institutional Stem Cell Retreat',null,null,'42125', '42216','Conference','Closed','University of Southern California',null,5000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08216','SIGHT RESTORATION THROUGH STEM CELL THERAPY',null,null,'42156', '42247','Conference','Closed','Ocular Research Symposia Foundation, Inc.',null,20000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08225','Cardiovascular Tissue Engineering Symposium',null,null,'42125', '42216','Conference','Closed','Stanford University',null,25000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08274','Pathways of Neurodevelopmental Disorders (C8)',null,null,'42095', '42185','Conference','Closed','University of California, Davis',null,29939;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07914-B','Skin-derived precursor cells for the treatment of enteric neuromuscular dysfunction',null,'Intestinal Disease, Metabolic Disorders, Neurological Disorders, Pediatrics','42826', '43555','Tools and Technologies III','Closed','Stanford University','Adult Stem Cell',772098;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07838','Development of a scalable, practical, and transferable GMP-compliant suspension culture-based differentiation process for cardiomyocyte production from human embryonic stem cells.',null,'Heart Disease','42095', '42825','Tools and Technologies III','Closed','City of Hope, Beckman Research Institute','Embryonic Stem Cell',891518;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07670','Development of a clinical-grade extracorporeal liver support system using human induced pluripotent stem cell-derived hepatic cells',null,'Liver Disease, Metabolic Disorders','42278', '43677','Tools and Technologies III','Closed','University of Southern California','iPS Cell',1257011;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07763','A suite of engineered human pluripotent stem cell lines to facilitate the generation of hematopoietic stem cells',null,'Blood Disorders','42217', '43585','Tools and Technologies III','Closed','University of California, Los Angeles','Embryonic Stem Cell',1382400;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07796','A Chromatin Context Tool for Predicting iPS Lineage Predisposition and Tissue Graftability',null,'Skin Disease','42095', '43190','Tools and Technologies III','Closed','Stanford University','Embryonic Stem Cell, iPS Cell',1391125;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07899','Development of 3D Bioprinting Techniques using Human Embryonic Stem Cells Derived Cardiomyocytes for Cardiac Tissue Engineering',null,'Heart Disease','42156', '43251','Tools and Technologies III','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1368264;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07800','Engineered Biomaterials for Scalable Manufacturing and High Viability Implantation of hPSC-Derived Cells to Treat Neurodegenerative Disease',null,'Neurological Disorders, Parkinson's Disease, Vision Loss','42125', '43220','Tools and Technologies III','Closed','University of California, Berkeley','Embryonic Stem Cell, iPS Cell',1239276;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07948','Injectable Hydrogels for the Delivery, Maturation, and Engraftment of Clinically Relevant Numbers of Human Induced Pluripotent Stem Cell-Derived Neural Progenitors to the Central Nervous System',null,'Neurological Disorders, Spinal Cord Injury','42156', '43373','Tools and Technologies III','Closed','Stanford University','iPS Cell',1347767;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07907','Technologies to improve in vivo function of transplanted stem cells',null,'Skeletal/Smooth Muscle disorders','42095', '43524','Tools and Technologies III','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1373683;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07893','Optimizing the differentiation and expansion of microglial progenitors from human pluripotent stem cells for the study and treatment of neurological disease.',null,'Alzheimer's Disease, Neurological Disorders','42217', '43312','Tools and Technologies III','Closed','University of California, Irvine','Embryonic Stem Cell',1147596;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07655','User-friendly predictive molecular diagnostic assays for quality control of stem cell derivatives for transplantation and drug discovery',null,'Neurological Disorders','42278', '43555','Tools and Technologies III','Closed','Scripps Research Institute','Embryonic Stem Cell, iPS Cell',1728390;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07683','Identification and isolation of transplantable human hematopoietic stem cells from pluripotent cell lines; two steps from primitive hematopoiesis to transplantable definitive cells, and non-toxic conditioning of hosts for hematopoeitic stem cell transp...',null,'Blood Disorders','42217', '43312','Tools and Technologies III','Closed','Stanford University','Embryonic Stem Cell',1271952;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07914-A','Skin-derived precursor cells for the treatment of enteric neuromuscular dysfunction',null,'Intestinal Disease, Metabolic Disorders, Neurological Disorders, Pediatrics','42095', '42825','Tools and Technologies III','Closed','University of California, Los Angeles','Adult Stem Cell',1044423;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07848','Site-specific gene editing in hematopoietic stem cells as an anti-HIV therapy',null,'HIV/AIDS, Infectious Disease','42217', '43312','Tools and Technologies III','Closed','University of Southern California','Adult Stem Cell',1495665;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07981','Multi-modal technology for non-destructive characterization of bioengineered tissues',null,'Bone or Cartilage Disease','42156', '43434','Tools and Technologies III','Closed','University of California, Davis','Adult Stem Cell',1574151;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07949','Embryonic stem cell-based generation of rat models for assessing human cellular therapies',null,'Other','42125', '43220','Tools and Technologies III','Closed','University of Southern California','Embryonic Stem Cell',1326979;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07879','Multimodal platform combining optical and ultrasonic technologies for in vivo nondestructive evaluation of engineered vascular tissue constructs',null,'Vascular Disease','42156', '43496','Tools and Technologies III','Closed','University of California, Davis','Adult Stem Cell',1834350;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07692','Small molecule tools and scale-up technologies to expand human umbilical cord blood stem and progenitor cells for clinical and research use',null,'Blood Disorders','42186', '43646','Tools and Technologies III','Closed','University of California, San Francisco','Adult Stem Cell',1416600;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07804','Injectable Macroporous Matrices to Enhance Stem Cell Engraftment and Survival',null,'Bone or Cartilage Disease','42186', '43646','Tools and Technologies III','Closed','Stanford University','Adult Stem Cell',1434235;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07798','Macaca mulatta as advanced model for predictive preclinical testing of engineered cardiac autografts and allografts',null,'Heart Disease','42186', '43281','Tools and Technologies III','Closed','Stanford University','iPS Cell',1689744;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07678','A small molecule tool for reducing the malignant potential in reprogramming human iPSCs and ESCs',null,'Other','42156', '43434','Tools and Technologies III','Closed','University of California, Los Angeles','Embryonic Stem Cell, iPS Cell',1283900;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT3-07616','Development of a Relevant Pre-Clinical Animal Model as a Tool to Evaluate Human Stem Cell-Derived Replacement Therapies for Motor Neuron Injuries and Degenerative Diseases',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders, Spinal Cord Injury, Spinal Muscular Atrophy','42217', '43585','Tools and Technologies III','Closed','University of California, Los Angeles','Embryonic Stem Cell',1308711;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08071','2015 Gordon Research Conference: Stem Cells & Cancer',null,null,'42037', '42124','Conference','Closed','Gordon Research Conferences',null,20000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08177','15th Annual Rachmiel Levine Diabetes and Obesity Symposium',null,null,'42064', '42155','Conference','Closed','City of Hope, Beckman Research Institute',null,20000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08023','THE 5TH ANNUAL CALIFORNIA ALS PAC10 AND RESEARCH NETWORK MEETING',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','41974', '42063','Conference','Closed','Gladstone Institutes, J. David',null,9529;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('AC1-07659','The Innovation-Alpha Clinic for Cellular Therapies (I-ACT) – A Program for the Development and Delivery of Innovative Cell-based Treatments and Cures for Life-threatening Diseases.',null,'Multiple Indications (Alpha Clinics)','42036', '44043','Alpha Stem Cell Clinics','Closed','City of Hope, Beckman Research Institute','Adult Stem Cell',8000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('AC1-07764','Alpha Stem Cell Clinic for the Development of Regenerative Therapies',null,'Multiple Indications (Alpha Clinics)','42036', '44408','Alpha Stem Cell Clinics','Active','University of California, San Diego','Adult Stem Cell, Embryonic Stem Cell',7999137;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('AC1-07675','UCLA-UCI Alpha Stem Cell Clinic (ASCC) Consortium',null,'Multiple Indications (Alpha Clinics)','42095', '44286','Alpha Stem Cell Clinics','Active','University of California, Los Angeles','Adult Stem Cell',8000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08171','13th Annual Gene Therapy Symposium for Heart, Lung, and Blood Diseases',null,null,'41944', '42035','Conference','Closed','University of California, Davis',null,10000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('AP1-08039','Clinical Development of a Cell Therapy for Diabetes',null,'Diabetes, Metabolic Disorders, Type 1 diabetes','42005', '43220','Accelerated Development Pathway I','Closed','ViaCyte, Inc.','Embryonic Stem Cell',8783852;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07588','The Stem Cell Niche in Development and Disease',null,null,'41913', '42004','Conference','Closed','University of California, San Francisco',null,5000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08160','Stem Cell Meeting on the Mesa',null,null,'41913', '42004','Conference','Closed','Sanford Consortium for Regenerative Medicine',null,40000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-08046','The 2014 Santa Cruz Developmental Biology Meeting',null,null,'41852', '41943','Conference','Closed','University of California, San Francisco',null,3000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('LA1-08013','Single Molecule Biophysics and Biology of Cellular Identity',null,'Other','42156', '43830','Research Leadership','Closed','University of California, Berkeley','Embryonic Stem Cell',4175924;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('LA1-08015','Engineering microscale tissue constructs from human pluripotent stem cells',null,'Heart Disease, Neurological Disorders','41974', '43799','Research Leadership','Closed','Gladstone Institutes, J. David','Embryonic Stem Cell, iPS Cell',5849100;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('LA1-08014','Niche-Focused Research: Discovery & Development of Hematopoietic Regenerative Factors',null,'Blood Cancer, Blood Disorders, Cancer, Leukemia','41883', '43708','Research Leadership','Closed','University of California, Los Angeles','Adult Stem Cell',4645297;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('SP3A-07552','A Phase I/IIa Dose Escalation Safety Study of AST-OPC1 in Patients with Cervical Sensorimotor Complete Spinal Cord Injury', 368817374,'Neurological Disorders, Spinal Cord Injury','41913', '44146','Strategic Partnership III Track A','Closed','Lineage Cell Therapeutics Inc.','Embryonic Stem Cell',14323318;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('SP3A-07536','A Phase I, Open-Label Study To Assess The Safety, Feasibility and Engraftment of Zinc Finger Nucleases (ZFN) CCR5 Modified Autologous CD34+ Hematopoietic Stem/Progenitor Cells (SB-728MR-HSPC) with Escalating Doses of Busulfan In HIV-1 (R5) Infected Sub...', 337115119,'HIV/AIDS, Infectious Disease','42095', '44561','Strategic Partnership III Track A','Active','City of Hope, Beckman Research Institute','Adult Stem Cell',5583438;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07874','UC Systemwide Bioengineering Symposium',null,null,'41760', '41851','Conference','Closed','University of California, Irvine',null,7525;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07825','The 2014 BIO International Convention',null,null,'41760', '41851','Conference','Closed','Biocom Institute',null,50000;
"Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07623','2014 Materials Research Society (MRS) Spring Meeting: 
Symposium Y: Biomaterials for Biomolecule Delivery and Understanding Cell-Niche Interactions',null,null,'41699', '41882','Conference','Closed','Stanford University',null,10000;"
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07636','In Utero Hematopoietic Stem Cell Transplantation and Maternal-Fetal Tolerance',null,null,'41699', '41973','Conference','Closed','University of California, San Francisco',null,17526;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07414','Directed Differentiation of Specialized Endothelial Cells',null,'Vascular Disease','41791', '42521','Basic Biology V','Closed','University of California, Merced','Embryonic Stem Cell, iPS Cell',475686;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07384','Metabolically-driven epigenetic changes in iPSC reprogramming',null,null,'41760', '42855','Basic Biology V','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell, iPS Cell',1491900;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07285','A novel druggable mechanism to safeguard stem cell genome',null,null,'41699', '42794','Basic Biology V','Closed','Gladstone Institutes, J. David','Adult Stem Cell, Embryonic Stem Cell',1294495;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07480','In vitro modeling of human motor neuron disease',null,'Neurological Disorders, Spinal Muscular Atrophy','41730', '43190','Basic Biology V','Closed','University of California, Los Angeles','iPS Cell',1148758;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07409','Biophysical Determinants of Early Embryonic Stem Cell Fate Specification',null,'Other','41821', '43281','Basic Biology V','Closed','University of California, San Francisco','Embryonic Stem Cell',1186500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07379','Role of intracytoplasmic pattern recognition receptors in HSC engraftment',null,'Blood Disorders','41760', '42490','Basic Biology V','Closed','University of California, San Diego',null,615639;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('GC1R-06673-A','Center of Excellence for Stem Cell Genomics - Stanford',null,'Multiple Indications (Alpha Clinics)','41791', '43799','Genomics Centers of Excellence Awards (R)','Closed','Stanford University','Adult Stem Cell, Cancer Stem Cell, iPS Cell',22787914;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-06978','CD61-driven stemness program in epithelial cancer',null,'Cancer, Solid Tumors','41821', '42916','Basic Biology V','Closed','University of California, San Diego','Cancer Stem Cell',1161000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07458','Non-invasive live imaging of stem cell signature metabolic states',null,null,'41791', '42521','Basic Biology V','Closed','University of California, Irvine','Adult Stem Cell, Embryonic Stem Cell',516366;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('GC1R-06673-B','Center of Excellence for Stem Cell Genomics - Salk',null,'Multiple Indications (Alpha Clinics)','41791', '43982','Genomics Centers of Excellence Awards (R)','Closed','Salk Institute for Biological Studies',null,13201635;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-06974','A Requirement for Protein Homeostasis in the Mediation of Stem Cell Health',null,null,'41699', '42794','Basic Biology V','Closed','University of California, Berkeley','Embryonic Stem Cell, iPS Cell',1034100;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('GC1R-06673-C','Center of Excellence for Stem Cell Genomics - UCSC',null,'Multiple Indications (Alpha Clinics)','41791', '43982','Genomics Centers of Excellence Awards (R)','Closed','University of California, Santa Cruz',null,3999083;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07210','New Regulators of Spermatogonial Stem Cells: RHOX Homeobox Transcription Factors',null,null,'41760', '42490','Basic Biology V','Closed','University of California, San Diego','Adult Stem Cell',552811;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07236','Defining links between chromatin state and developmental competence',null,null,'41730', '42825','Basic Biology V','Closed','University of California, San Diego','Embryonic Stem Cell',1050300;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07012','Systems-level discovery of the regulatory mechanisms directing differentiation of hESC',null,null,'41699', '42825','Basic Biology V','Closed','University of California, San Diego','Embryonic Stem Cell',1161000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07466','Mechanisms of human induced neuronal cell reprogramming',null,null,'41821', '42916','Basic Biology V','Closed','Stanford University','Directly Reprogrammed Cell',1178370;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07363','Paracrine and synaptic mechanisms underlying neural stem cell-mediated stroke recovery',null,'Neurological Disorders, Stroke','41852', '42947','Basic Biology V','Closed','Stanford University','Embryonic Stem Cell',1178370;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-06935','Misregulated Mitophagy in Parkinsonian Neurodegeneration',null,'Neurological Disorders, Parkinson's Disease','41852', '43312','Basic Biology V','Closed','Stanford University','iPS Cell',1174943;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07398','Engineered matrices for control of lineage commitment in human pancreatic stem cells',null,'Diabetes, Metabolic Disorders','41699', '42428','Basic Biology V','Closed','California Institute of Technology',null,526896;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07089','Differentiation of Human Hematopoietic Stem Cells into iNKT Cells',null,'Blood Disorders','41699', '42428','Basic Biology V','Closed','University of California, Los Angeles',null,614400;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07254','Molecular basis of plasma membrane characteristics reflecting stem cell fate potential',null,'Neurological Disorders','41730', '43190','Basic Biology V','Closed','University of California, Irvine','Adult Stem Cell',994108;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07230-A','Promoting survival and countering hypertrophy of pluripotent stem cell (PSC)-derived chondrocytes',null,'Arthritis','41821', '42247','Basic Biology V','Closed','University of California, Los Angeles','Embryonic Stem Cell',411330;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07356','Metabolic regulation of cardiac differentiation and maturation',null,'Heart Disease','41760', '43039','Basic Biology V','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1124834;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07302','Innate Immune Regulation of Lung Alveolar Stem Cell Renewal in Mouse and Man',null,null,'41791', '42521','Basic Biology V','Closed','Cedars-Sinai Medical Center',null,617662;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07320','Assessing the mechanism by which the Bone Morphogenetic Proteins direct stem cell fate',null,'Neurological Disorders, Spinal Cord Injury','41699', '42428','Basic Biology V','Closed','University of California, Los Angeles','Embryonic Stem Cell',515730;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07025','Epigenetic mechanisms that enforce pluripotency in embryonic stem cells',null,null,'41760', '42978','Basic Biology V','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1160997;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07011','Elucidating pathways from hereditary Alzheimer mutations to pathological tau phenotypes',null,'Alzheimer's Disease, Neurological Disorders','41730', '42825','Basic Biology V','Closed','University of California, San Diego','iPS Cell',1050300;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07262','Generation of a functional thymus to induce immune tolerance to stem cell derivatives',null,'Diabetes, HIV/AIDS, Immune Disease, Infectious Disease, Metabolic Disorders','41821', '43100','Basic Biology V','Closed','University of California, San Francisco','Embryonic Stem Cell',1191000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07422','Molecular regulation of stem cell potency',null,'Aging, Skeletal/Smooth Muscle disorders, Trauma','41821', '42978','Basic Biology V','Closed','Palo Alto Veterans Institute for Research','Adult Stem Cell',966510;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07230-B','Promoting survival and countering hypertrophy of pluripotent stem cell (PSC)-derived chondrocytes',null,'Arthritis','42248', '43100','Basic Biology V','Closed','University of Southern California','Embryonic Stem Cell',735138;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB5-07469','Mass Cytometry to Delineate the Human Muscle Stem Cell Hierarchy and Dysfunction in Aging',null,null,'41791', '42886','Basic Biology V','Closed','Stanford University','Adult Stem Cell',1175357;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07647','Tri-Institutional Stem Cell Retreat',null,null,'41699', '41790','Conference','Closed','University of California, San Francisco',null,3500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07688','Cardiovascular Regenerative Medicine Symposium',null,null,'41671', '41759','Conference','Closed','Stanford University',null,9000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07550','Third Annual Symposium on Regenerative Rehabilitation',null,null,'41699', '41790','Conference','Closed','Stanford University',null,20000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07618','Regenerative Medicine Foundation 2014 Conference',null,null,'41730', '41820','Conference','Closed','Human Organ Project',null,50000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR3-06924','Therapeutic Eradication of Cancer Stem Cells with UC-961 (Cirmtuzumab)', 699291832,'Blood Cancer, Cancer','41791', '43069','Disease Team Therapy Development III','Closed','University of California, San Diego','Cancer Stem Cell',4179598;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR3-06965','Clinical Investigation of a Humanized Anti-CD47 Antibody in Targeting Cancer Stem Cells in Hematologic Malignancies and Solid Tumors', 144571942,'Blood Cancer, Cancer, Solid Tumors','41791', '42521','Disease Team Therapy Development III','Closed','Stanford University','Cancer Stem Cell',6505568;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR3-06945','Clinical Trial of Stem Cell Gene Therapy for Sickle Cell Disease', 775336843,'Blood Disorders, Pediatrics, Sickle Cell Disease','41821', '44561','Disease Team Therapy Development III','Active','University of California, Los Angeles','Adult Stem Cell',13145465;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR3-07281','Tissue Engineered Recellularized Laryngotracheal Implants',null,'Respiratory Disorders','41730', '42735','Disease Team Therapy Development III','Closed','University of California, Davis','Adult Stem Cell',3181162;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR3-07438','Phase 1 Safety Assessment of CPCB-RPE1, hESC-derived RPE Cell Coated Parylene Membrane Implants, in Patients with Advanced Dry Age Related Macular Degeneration', 179431196,'Age-related macular degeneration, Vision Loss','41852', '43677','Disease Team Therapy Development III','Closed','University of Southern California','Embryonic Stem Cell',16339827;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR3-07067','A Phase I dose escalation and expansion clinical trial of the novel first-in-class Polo-like Kinase 4 (PLK4) inhibitor, CFI-400945 in patients with advanced solid tumors', 299238214,'Cancer, Solid Tumors','41760', '43585','Disease Team Therapy Development III','Closed','University of California, Los Angeles','Cancer Stem Cell',5683693;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07597','Keystone Symposia, "Stem Cells and Reprogramming"',null,null,'41699', '41790','Conference','Closed','Gladstone Institutes, J. David',null,50000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07599','Stem Cell Research for Neurological Disorders: A Case Study in Ethical and Policy Issues in ALS Research',null,null,'41609', '42004','Conference','Closed','University of California, Davis',null,1020;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07614','California ALS Research Summit 2014',null,null,'41609', '41698','Conference','Closed','University of California, San Francisco',null,8563;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07544','2013 World Alliance Forum in San Francisco',null,null,'41579', '41670','Conference','Closed','Alliance Forum Foundation',null,3500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07572','7th CA/HSCI Junior PI Conference:  Stem Cells 2.0',null,null,'41579', '41670','Conference','Closed','University of California, Los Angeles',null,2500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07590','The Sanford Consortium for Regenerative Medicine's Scientific Symposium and the Regen Med Partnering Forum at Stem Cell Meeting on the Mesa VIII',null,null,'41548', '41639','Conference','Closed','Sanford Consortium for Regenerative Medicine',null,35000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07598','The Science of Staying Younger Longer',null,null,'41548', '41639','Conference','Closed','University of California, San Francisco',null,6500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07538','12th Annual Gene Therapy Symposium for Heart, Lung, and Blood Diseases',null,null,'41579', '41670','Conference','Closed','University of California, Davis',null,8000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07539','World Stem Cell Summit',null,null,'41579', '41670','Conference','Closed','Scripps Research Institute',null,30000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06788-A','Programming Human ESC-derived Neural Stem Cells with MEF2C for Transplantation in Stroke',null,'Neurological Disorders, Stroke','41699', '42185','Early Translational IV','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell',1020815;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06711','Engineered iPSC for therapy of limb girdle muscular dystrophy type 2B',null,'Muscular Dystrophy, Pediatrics, Skeletal/Smooth Muscle disorders','41640', '42735','Early Translational IV','Closed','Stanford University','iPS Cell',1876253;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06867','Clinical Development of an N-cadherin Antibody to Target Cancer Stem Cells',null,'Cancer, Prostate Cancer, Solid Tumors','41699', '43466','Early Translational IV','Closed','University of California, Los Angeles','Cancer Stem Cell',4075668;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06845','Stem Cell Programming With Chimeric Antigen Receptors to Eradicate HIV Infection',null,'HIV/AIDS, Infectious Disease','41640', '43100','Early Translational IV','Closed','University of California, Los Angeles','Adult Stem Cell',4925166;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06648','Restoring vision by sheet transplants of retinal progenitors and retinal pigment epithelium (RPE) derived from human embryonic stem cells (hESCs)',null,'Vision Loss','41699', '43100','Early Translational IV','Closed','University of California, Irvine','Embryonic Stem Cell',3998948;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06823','Beta-Globin Gene Correction of Sickle Cell Disease in Hematopoietic Stem Cells',null,'Blood Disorders, Pediatrics','41671', '43008','Early Translational IV','Closed','University of California, Los Angeles','Adult Stem Cell',1651884;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06809','Development of a cell and gene based therapy for hemophilia',null,'Blood Disorders, Liver Disease, Metabolic Disorders, Pediatrics','41671', '42766','Early Translational IV','Closed','Salk Institute for Biological Studies','iPS Cell',2298634;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06857','Improving Existing Drugs for Long QT Syndrome type 3 (LQT3) by hiPSC Disease-in-Dish Model',null,'Heart Disease','41609', '43159','Early Translational IV','Closed','Human BioMolecular Research Institute','iPS Cell',6361369;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06831','Gene therapy-corrected autologous hepatocyte-like cells from induced pluripotent stem cells for the treatment of pediatric single enzyme disorders',null,'Genetic Disorder, Liver Disease, Metabolic Disorders, Pediatrics','41671', '43131','Early Translational IV','Closed','University of California, Los Angeles','iPS Cell',1801629;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06788-B','Programming Human ESC-derived Neural Stem Cells with MEF2C for Transplantation in Stroke',null,'Neurological Disorders, Stroke','42186', '42794','Early Translational IV','Closed','The Scintillon Institute','Embryonic Stem Cell',1103185;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06713','Gene Targeting to Endogenous Stem Cells for Segmental Bone Fracture Healing',null,'Arthritis, Bone or Cartilage Disease','41609', '43069','Early Translational IV','Closed','Cedars-Sinai Medical Center','Adult Stem Cell',5121514;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06747','A drug-screening platform for autism spectrum disorders using human astrocytes',null,'Autism, Neurological Disorders, Pediatrics, Rett's Syndrome','41671', '42766','Early Translational IV','Closed','University of California, San Diego','iPS Cell',1656456;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06693','Development of Novel Autophagy Inducers to Block the Progression of and Treat Amyotrophic Lateral Sclerosis (ALS) and Other Neurodegenerative Diseases',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','41699', '42886','Early Translational IV','Closed','Gladstone Institutes, J. David','iPS Cell',2049053;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR4-06847','Use of human iPSC-derived neurons from Huntington’s Disease patients to develop novel, disease-modifying small molecule structural corrector drug candidates targeting the unique, neurotoxic conformation of mutant huntingtin',null,'Huntington's Disease, Neurological Disorders','41609', '41973','Early Translational IV','Closed','Numerate, Inc.','iPS Cell',520015;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07537','3rd International RB conference',null,null,'41518', '41608','Conference','Closed','Stanford University',null,10000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07547','Orange County Summit on Regenerative Medicine (OCSRM)',null,null,'41518', '41608','Conference','Closed','OCTANe Foundation for Innovation',null,2500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07581','IPITA 2013 - 14th World Congress of the International Pancreas and Islet transplant Association',null,null,'41518', '41608','Conference','Closed','University of California, San Francisco',null,10000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-07541','International Society for Heart Research (ISHR) XX1 World Congress',null,null,'41426', '41517','Conference','Closed','University of California, San Diego',null,10000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('LA1-06915','Epithelial progenitors and the stromal niche as therapeutic targets in lung disease',null,'Respiratory Disorders','41456', '43646','Research Leadership','Closed','Cedars-Sinai Medical Center','iPS Cell',4841830;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('LA1-06917','Generation of functional cells and organs from iPSCs',null,'Blood Disorders','41791', '43982','Research Leadership','Closed','Stanford University','iPS Cell',5426810;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('LA1-06919','Molecular Imaging for Stem Cell Science and Clinical Application',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders, Spinal Cord Injury','41518', '44439','Research Leadership','Active','University of California, San Diego','Embryonic Stem Cell, iPS Cell',5920899;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('SP2-06902','A Treatment For Beta-thalassemia via High-Efficiency Targeted Genome Editing of Hematopoietic Stem Cells',null,'Blood Disorders, Pediatrics','41579', '42185','Strategic Partnership II','Closed','Sangamo BioSciences, Inc.','Adult Stem Cell',2760540;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99052','Cell Therapy for amyotrophic Lateral Sclerosis (ALS) -Testing the Limits: What should we use as preclinical standards of clinical trials?',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','41395', '41486','Conference','Closed','University of California, San Diego',null,7193;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99048','UCSC Frontiers of Stem Cells and Aging Symposium',null,'Aging','41395', '41486','Conference','Closed','University of California, Santa Cruz',null,24405;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99051','The 14th UC Systemwide Bioengineering Symposium',null,null,'41395', '41486','Conference','Closed','University of California, San Diego',null,5000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('IT1-06571','Induced pluripotent stem cells from children with autism spectrum disorders',null,'Autism, Neurological Disorders, Pediatrics','41548', '42643','Tissue Collection for Disease Modeling','Closed','Stanford University',null,530265;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('IT1-06570','Using human induced pluripotent stem cells to improve our understanding of Idiopathic Pulmonary Fibrosis',null,'Respiratory Disorders','41548', '42643','Tissue Collection for Disease Modeling','Closed','University of California, Los Angeles',null,811231;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('IT1-06596','Tissue Collection for Accelerating iPSC Research in Cardiovascular Diseases',null,'Heart Disease','41548', '42643','Tissue Collection for Disease Modeling','Closed','Stanford University',null,1291832;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('IT1-06601','Generation of fibroblast cell lines in patients with common blinding eye diseases',null,'Vision Loss','41548', '42643','Tissue Collection for Disease Modeling','Closed','University of California, San Diego',null,1034425;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('IT1-06611','CIRM Tissue Collection for Neurodevelopmental Disabilities',null,'Neurological Disorders, Pediatrics','41548', '42643','Tissue Collection for Disease Modeling','Closed','University of California, San Diego',null,830426;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('IT1-06563','iPSC-derived Hepatocytes as Platforms for Research in Viral Hepatitis and Non-alcoholic Steatohepatitis',null,'Infectious Disease, Liver Disease, Metabolic Disorders','41548', '42460','Tissue Collection for Disease Modeling','Closed','University of California, San Francisco','iPS Cell',791680;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('IT1-06589','Collection of skin biopsies to prepare fibroblasts from patients with Alzheimer's disease and cognitively healthy elderly controls',null,'Alzheimer's Disease, Neurological Disorders','41548', '42643','Tissue Collection for Disease Modeling','Closed','University of California, San Diego',null,643693;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('ID1-06557','Generation and characterization of  high-quality, footprint-free human induced pluripotent stem cell lines from 3,000 donors to investigate multigenic diseases',null,'Multiple Indications (Alpha Clinics)','41579', '43069','hiPSC Derivation','Closed','Cellular Dynamics International',null,16000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('IR1-06600','The CIRM Human Pluripotent Stem Cell Biorepository – A Resource for Safe Storage and Distribution of High Quality iPSCs',null,'Multiple Indications (Alpha Clinics)','41609', '43434','hPSC Repository','Closed','FUJIFILM Cellular Dynamics','iPS Cell',9942175;
"Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99049','2013 Materials Research Society (MRS) Spring Meeting Symposium
""Design of Cell Instructive Materials""',null,null,'41334', '41425','Conference','Closed','University of California, Los Angeles',null,4000;"
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99046','2013 Rachmiel Diabetes and Obesity Levine Symposium - Advances in Diabetes Research',null,'Diabetes, Metabolic Disorders','41306', '41394','Conference','Closed','City of Hope, Beckman Research Institute',null,27750;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06510','White matter neuroregeneration after chemotherapy: stem cell therapy for “chemobrain”',null,'Brain Cancer, Cancer, Neurological Disorders, Solid Tumors','41456', '43281','New Faculty Physician Scientist','Closed','Stanford University','Adult Stem Cell, iPS Cell',2800526;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06532','In Utero Embryonic Stem Cell Transplantation to Treat Congenital Anomalies',null,'Blood Disorders, Pediatrics','41426', '43616','New Faculty Physician Scientist','Closed','University of California, San Francisco','Embryonic Stem Cell',2661742;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06530','Human iPSC modeling and therapeutics for degenerative peripheral nerve disease',null,'Neurological Disorders, Neuropathy','41365', '43190','New Faculty Physician Scientist','Closed','Cedars-Sinai Medical Center','iPS Cell',3031737;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06378','Preclinical evaluation of human embryonic stem cell-derived cardiovascular progenitors in a large animal model',null,'Heart Disease','41426', '43616','New Faculty Physician Scientist','Closed','University of California, Los Angeles','Embryonic Stem Cell',2930388;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06460','Tunable hydrogels for therapeutic delivery of multipotent stem cells.',null,'Skin Disease','41365', '43373','New Faculty Physician Scientist','Closed','University of California, Davis','Adult Stem Cell',2771903;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06455','Human Induced Pluripotent Stem Cell-Derived Cardiovascular Progenitor Cells for Cardiac Cell Therapy.',null,'Heart Disease','41334', '42886','New Faculty Physician Scientist','Closed','University of California, Los Angeles','iPS Cell',2316894;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06425','The generation and expansion of tissue-engineered small intestine from human stem/ progenitor cells: a preclinical study of functional translation',null,'Intestinal Disease, Metabolic Disorders','41640', '43830','New Faculty Physician Scientist','Closed','Children's Hospital of Los Angeles','Adult Stem Cell',3146160;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06529','Enhancing hair cell regeneration in mouse and human inner ear',null,'Hearing Loss','41426', '43251','New Faculty Physician Scientist','Closed','Stanford University','Adult Stem Cell',3088525;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06396','Human pluripotent stem cell-based therapeutics for preeclampsia',null,'Fertility','41426', '43434','New Faculty Physician Scientist','Closed','University of California, San Diego','iPS Cell',2974750;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06525','Stem cell therapy for inflammatory bowel disease',null,'Intestinal Disease, Metabolic Disorders','41365', '43190','New Faculty Physician Scientist','Closed','University of California, San Francisco','Adult Stem Cell, Embryonic Stem Cell',3019013;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06504','Characterization of Human Skeletal Muscle Stem Cells for Clinical Application',null,'Skeletal/Smooth Muscle disorders','41334', '43343','New Faculty Physician Scientist','Closed','University of California, San Francisco','Adult Stem Cell',2959014;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06479','Human endothelial reprogramming for hematopoietic stem cell therapy.',null,'Blood Cancer, Blood Disorders, Cancer','41395', '43220','New Faculty Physician Scientist','Closed','University of California, San Francisco','Directly Reprogrammed Cell, iPS Cell',2197683;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99047','The Best Next Steps: Setting a Path for Advancing Pediatric Neurology',null,'Neurological Disorders, Pediatrics','41244', '41333','Conference','Closed','Children's Neurobiological Solutions (CNS) Foundation',null,10000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('SP1-06513','Preclinical and clinical testing of a stem cell-based combination product for insulin-dependent diabetes',null,'Diabetes, Metabolic Disorders','41518', '42978','Strategic Partnership I','Closed','ViaCyte, Inc.','Embryonic Stem Cell',9475070;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99043','California ALS Summit 2012',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','41214', '41305','Conference','Closed','Cedars-Sinai Medical Center',null,6825;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99041','Cell Therapies in Trauma and Critical Care: Barriers in Translation from Pre-clinical to Clinical Development',null,'Trauma','41214', '41305','Conference','Closed','Vitalant Research Institute',null,18440;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99040','Stem Cells Craniofacial Development and Disease',null,'Developmental Disorders','41183', '41274','Conference','Closed','University of California, San Francisco',null,4500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99045','The Sanford Consortium for Regenerative Medicine Symposium and the investor and Partnering Forum at Stem Cells on the Mesa',null,null,'41183', '41274','Conference','Closed','Sanford Consortium for Regenerative Medicine',null,44000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99039','11th Annual Gene Therapy Symposium for Heart, Lung, and Blood Diseases',null,'Blood Disorders, Heart Disease','41183', '41305','Conference','Closed','University of California, Davis',null,16850;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99042','ISSCR - Roddenberry International Symposium on Cellular reprogramming',null,null,'41183', '41274','Conference','Closed','Gladstone Institutes, J. David',null,43000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99038','Working 2 Walk Science & Advocacy Symposium',null,null,'41183', '41274','Conference','Closed','Research for Cure',null,22113;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06087','Energy metabolism and aging pathways in human stem cell reprogramming and differentiation',null,null,'41395', '42490','Basic Biology IV','Closed','Stanford University','iPS Cell',1414044;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06036','Prostaglandin pathway regulation of self-renwal in hematopoietic and leukemia stem cells',null,'Blood Cancer, Cancer','41214', '42400','Basic Biology IV','Closed','Stanford University','Adult Stem Cell, Cancer Stem Cell',1244455;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-05764','Induction of Pluripotent Stem Cell-Derived Pacemaking Cells',null,'Heart Disease','41306', '42766','Basic Biology IV','Closed','University of California, Davis','iPS Cell',1333689;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06028','Genetic dissection of human cellular reprogramming to pluripotency',null,null,'41214', '42308','Basic Biology IV','Closed','University of California, San Francisco',null,1184883;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06277','Modeling Alexander disease using patient-specific induced pluripotent stem cells',null,'Neurological Disorders, Pediatrics','41275', '42735','Basic Biology IV','Closed','City of Hope, Beckman Research Institute',null,1366656;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-05785','3D Modeling of Retina using Polymer Scaffolds for Understanding Disease Pathogenesis',null,'Vision Loss','41214', '42400','Basic Biology IV','Closed','Buck Institute for Age Research','Embryonic Stem Cell, iPS Cell',1212553;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06144','Deciphering transcriptional control of pancreatic beta-cell maturation in vitro',null,'Diabetes, Metabolic Disorders','41214', '42308','Basic Biology IV','Closed','University of California, San Diego','Embryonic Stem Cell',1258560;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-05855','Modeling disease in human embryonic stem cells using new genetic tools',null,'Neurological Disorders, Neuropathy','41275', '42369','Basic Biology IV','Closed','University of California, San Francisco','Embryonic Stem Cell',1387800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06276','Studying Arrhythmogenic Right Ventricular Dysplasia with patient-specific iPS cells',null,'Heart Disease, Pediatrics','41275', '42582','Basic Biology IV','Closed','Sanford Burnham Prebys Medical Discovery Institute','iPS Cell',1579250;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06102','Role of mechanical signaling in stem cell self-renewal and differentiation',null,null,'41306', '42766','Basic Biology IV','Closed','Stanford University','Embryonic Stem Cell',1062998;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-05763','Long noncoding RNAs for pluripotency and cell fate commitment',null,null,'41334', '42428','Basic Biology IV','Closed','Stanford University','Embryonic Stem Cell',1386627;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-05779','Regulation of Epidermal Self-Renewal and Differentiation by Histone and DNA Demethylases.',null,'Skin Disease','41306', '42400','Basic Biology IV','Closed','University of California, San Diego','Adult Stem Cell',1080000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06079','Common molecular mechanisms in neurodegenerative diseases using patient based iPSC neurons',null,'Huntington's Disease, Neurological Disorders, Parkinson's Disease','41214', '42308','Basic Biology IV','Closed','Gladstone Institutes, J. David','iPS Cell',1395184;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06133','Understanding the status of the X chromosomes in human ESCs and preimplantation embryos',null,null,'41334', '42429','Basic Biology IV','Closed','University of California, Los Angeles','Embryonic Stem Cell',1382400;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-05901','Epigenetic regulation of human cardiac differentiation',null,'Heart Disease','41334', '42429','Basic Biology IV','Closed','Gladstone Institutes, J. David','Embryonic Stem Cell, iPS Cell',1568148;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06035','A new paradigm of lineage-specific reprogramming',null,'Heart Disease','41334', '42429','Basic Biology IV','Closed','Gladstone Institutes, J. David','Directly Reprogrammed Cell',1568395;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06345','Role of the NMD RNA Decay Pathway in Maintaining the Stem-Like State',null,'Neurological Disorders','41214', '42674','Basic Biology IV','Closed','University of California, San Diego','Embryonic Stem Cell',1360450;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06209','Trop2 dependent and independent mechanisms of self-renewal in human cancer stem cells',null,'Cancer, Prostate Cancer, Solid Tumors','41244', '42338','Basic Biology IV','Closed','University of California, Los Angeles','Cancer Stem Cell',1254960;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-05886','Mechanism and Utility of Direct Neuronal Conversion with a MicroRNA-Chromatin Switch',null,'Neurological Disorders','41214', '42308','Basic Biology IV','Closed','Stanford University','Directly Reprogrammed Cell',1392150;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06158','DECIPHERING THE INSTRUCTIONS FOR VERTEBRATE HSC SPECIFICATION AND AMPLIFICATION.',null,null,'41518', '42613','Basic Biology IV','Closed','University of California, San Diego','Adult Stem Cell, Embryonic Stem Cell',1363698;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06244','Mechanisms to protect hESC-derived cells from allogenic immune rejection',null,null,'41244', '42429','Basic Biology IV','Closed','University of California, San Diego','Embryonic Stem Cell',1160997;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06093','Stem Cell Mechanisms Governing Discrete Waves of Gliogenesis in the Childhood Brain',null,'Neurological Disorders, Pediatrics','41306', '42400','Basic Biology IV','Closed','Stanford University','Adult Stem Cell, Embryonic Stem Cell',1264248;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-05825','Asymmetric stem cell division oriented by a local self-renewing signal',null,null,'41365', '42825','Basic Biology IV','Closed','Stanford University','Adult Stem Cell, Embryonic Stem Cell',1038600;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06045','Stem cell models to analyze the role of mutated C9ORF72 in neurodegeneration',null,'Amyotrophic Lateral Sclerosis, Dementia, Neurological Disorders','41334', '42429','Basic Biology IV','Closed','University of California, San Diego','iPS Cell',1260360;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06215','Mechanism of heart regeneration by cardiosphere-derived cells',null,'Heart Disease','41244', '42338','Basic Biology IV','Closed','Cedars-Sinai Medical Center','Adult Stem Cell',1367604;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-05990','Investigation of the role of O-GlcNAcylation in SOX2 function during reprogramming',null,null,'41214', '42308','Basic Biology IV','Closed','University of California, San Francisco','iPS Cell',1260037;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB4-06016','Transcriptional regulation of pluripotency in human embryonic stem cells',null,null,'41244', '42338','Basic Biology IV','Closed','University of California, Berkeley','Embryonic Stem Cell, iPS Cell',1220968;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2A-05394','Human Embryonic Stem Cell-Derived Cardiomyocytes for Patients with End Stage Heart Failure',null,'Heart Disease','41365', '43768','Disease Team Therapy Development - Research','Closed','Stanford University','Embryonic Stem Cell',19060330;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2A-05365','A monoclonal antibody that depletes blood stem cells and enables chemotherapy free transplants',null,'Blood Disorders, Immune Disease, Pediatrics, Severe Combined Immunodeficiency, X-linked (X-SCID)','41487', '43951','Disease Team Therapy Development - Research','Closed','Stanford University','Adult Stem Cell',18990683;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2A-05309','Genetic Re-programming of Stem Cells to Fight Cancer', 189549202,'Cancer, Melanoma, Skin cancer, Solid Tumors','41730', '44165','Disease Team Therapy Development - Research','Closed','University of California, Los Angeles','Adult Stem Cell',14144221;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2A-05423','Phase I study of IM Injection of VEGF-Producing MSC for the Treatment of Critical Limb Ischemia',null,'Vascular Disease','41306', '42277','Disease Team Therapy Development - Research','Closed','University of California, Davis','Adult Stem Cell',3728384;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2A-05302','Treatment of non-traumatic osteonecrosis with endogenous Mesenchymal stem cells', 640955231,'Bone or Cartilage Disease, Osteonecrosis','41275', '44469','Disease Team Therapy Development - Research','Active','University of California, Davis','Adult Stem Cell',19606481;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2A-05415','MSC engineered to produce BDNF for the treatment of Huntington's disease', 835742418,'Huntington's Disease, Neurological Disorders','41306', '42643','Disease Team Therapy Development - Research','Closed','University of California, Davis','Adult Stem Cell',8924235;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2A-05320','Progenitor Cells Secreting GDNF for the Treatment of ALS',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','41306', '42855','Disease Team Therapy Development - Research','Closed','Cedars-Sinai Medical Center','Adult Stem Cell',16168464;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('LA1-06536','Repair and regeneration of the nephron',null,'Kidney Disease','41122', '43312','Research Leadership','Closed','University of Southern California','Embryonic Stem Cell',5672206;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2A-05739','Retinal progenitor cells for treatment of retinitis pigmentosa', 554921585,'Retinitis Pigmentosa, Vision Loss','41275', '43100','Disease Team Therapy Development - Research','Closed','University of California, Irvine','Adult Stem Cell',17144825;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRX-05426','Combination therapy to Enhance Antisense Mediated Exon Skipping for Duchenne Muscular Dystrophy',null,'Muscular Dystrophy, Pediatrics, Skeletal/Smooth Muscle disorders','41334', '42429','Early Translational from Disease Team Conversion','Closed','University of California, Los Angeles','Adult Stem Cell',1823545;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2A-05416','Restoration of memory in Alzheimer’s disease: a new paradigm using neural stem cell therapy',null,'Alzheimer's Disease, Neurological Disorders','41456', '41984','Disease Team Therapy Development - Research','Closed','StemCells, Inc.','Adult Stem Cell',8901641;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2A-05735','Allogeneic Cardiac-Derived Stem Cells for Patients Following a Myocardial Infarction', 456061992,'Heart Disease, Heart failure','41275', '43100','Disease Team Therapy Development - Research','Closed','Capricor, Inc','Adult Stem Cell',14405857;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05559','Human ES cell based therapy of heart failure without allogenic immune rejection',null,'Heart Disease','41183', '42460','Early Translational III','Closed','University of California, San Diego','Embryonic Stem Cell',1857600;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05542','Generation of safe and therapeutically effective human induced hepatocyte-like cells',null,'Liver Disease, Metabolic Disorders','41395', '42855','Early Translational III','Closed','University of California, San Francisco','Directly Reprogrammed Cell',1544170;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05535','Gene Correction of Autologous Hematopoietic Stem Cells in Artemis Deficient SCID',null,'Immune Disease, Pediatrics','41214', '42674','Early Translational III','Closed','University of California, San Francisco','Adult Stem Cell',3862367;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05593','Direct Cardiac Reprogramming for Heart Regeneration',null,'Heart Disease','41214', '42674','Early Translational III','Closed','Gladstone Institutes, J. David','Directly Reprogrammed Cell',5795871;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05709','Tissue engineered cartilage from autologous, dermis-isolated, adult, stem (DIAS) cells',null,'Bone or Cartilage Disease','41334', '42704','Early Translational III','Closed','University of California, Davis','Adult Stem Cell',1735703;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05641','Targeting glioma cancer stem cells with receptor-engineered self-renewing memory T cells',null,'Brain Cancer, Cancer, Solid Tumors','41334', '42613','Early Translational III','Closed','City of Hope, Beckman Research Institute','Adult Stem Cell',5215447;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05617','Targeting Stem Cells to Enhance Remyelination in the Treatment of Multiple Sclerosis',null,'Multiple Sclerosis, Neurological Disorders','41244', '42521','Early Translational III','Closed','Scripps Research Institute','Adult Stem Cell',2559333;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05556','Heart Repair with Human Tissue Engineered Myocardium',null,'Heart Disease','41334', '42429','Early Translational III','Closed','Stanford University','Embryonic Stem Cell',4396738;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05568','Direct reprogramming towards vascular progenitors for the treatment of ischemia',null,'Vascular Disease','41214', '42308','Early Translational III','Closed','Salk Institute for Biological Studies','Directly Reprogrammed Cell',2340000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05603','Multiple Sclerosis therapy: Human Pluripotent Stem Cell-Derived Neural Progenitor Cells',null,'Multiple Sclerosis, Neurological Disorders','41334', '42521','Early Translational III','Closed','University of California, Irvine','Embryonic Stem Cell, iPS Cell',4535005;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05628','Functional Neural Relay Formation by Human Neural Stem Cell Grafting in Spinal Cord Injury',null,'Neurological Disorders, Spinal Cord Injury','41214', '42308','Early Translational III','Closed','University of California, San Diego','Embryonic Stem Cell',4600447;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05676','Molecules to Correct Aberrant RNA Signature in Human Diseased Neurons',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','41244', '42338','Early Translational III','Closed','University of California, San Diego','iPS Cell',1532323;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05669','Stem cell based small molecule therapy for Alzheimer's disease',null,'Alzheimer's Disease, Neurological Disorders','41153', '42247','Early Translational III','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell',1673757;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05501','Local Delivery of Rejuvenated Old Muscle Stem Cells to Increase Strength in Aged Patients',null,'Aging, Skeletal/Smooth Muscle disorders','41183', '42369','Early Translational III','Closed','Stanford University','Adult Stem Cell',1825666;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05626','Extracellular Matrix Bioscaffold Augmented with Human Stem Cells for Cardiovascular Repair',null,'Heart Disease','41214', '42308','Early Translational III','Closed','University of California, Davis','Adult Stem Cell',4631754;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05687','Identification of Novel Therapeutics for Danon Disease Using an iPS Model of the Disease',null,'Heart Disease, Pediatrics','41183', '42643','Early Translational III','Closed','University of California, San Diego','iPS Cell',1701575;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05488','Generation of hepatic cell from placental stem cell for congenital metabolic disorders',null,'Liver Disease, Metabolic Disorders, Pediatrics','41183', '42643','Early Translational III','Closed','University of Southern California','Adult Stem Cell',1750375;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05606','Human ES cell-derived MGE inhibitory interneuron transplantation for spinal cord injury',null,'Neurological Disorders, Spinal Cord Injury','41183', '42277','Early Translational III','Closed','University of California, San Francisco','Embryonic Stem Cell',1623251;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05569','Autologous iPSC Therapy for Urinary Incontinence',null,'Incontinence','41244', '42704','Early Translational III','Closed','Stanford University','iPS Cell',4715738;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05577','Identifying Drugs for Alzheimer's Disease with Human Neurons Made From Human IPS cells',null,'Alzheimer's Disease, Neurological Disorders','41183', '42277','Early Translational III','Closed','University of California, San Diego','iPS Cell',1774420;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR3-05476','Immune-Matched Neural Stem Cell Transplantation for Pediatric Neurodegenerative Disease',null,'Neurological Disorders, Pediatrics','41214', '42674','Early Translational III','Closed','Children's Hospital of Orange County','Adult Stem Cell',4266015;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99037','University of California Systemwide Bioengineering Symposium 2012',null,null,'41030', '41121','Conference','Closed','University of California, Berkeley',null,25200;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99035','The Stem Cell Niche in Development and Regeneration',null,null,'41030', '41121','Conference','Closed','University of Southern California',null,7476;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RP1-05741','The HD iPSC Consortium: Repeat Length Dependent Phenotypes for Assay Development',null,'Huntington's Disease, Neurological Disorders','41091', '41820','iPSC Consortia Award','Closed','Cedars-Sinai Medical Center','iPS Cell',300000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TC1-05946','CHORI/UC Berkeley Summer Stem Cell Research Internship Program for High School Students',null,null,'41061', '42339','Creativity Awards','Closed','Children's Hospital of Oakland Research Institute',null,151046;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TC1-05956','Stem Cell Summer Academy: Creating the Next Generation of Scientists',null,null,'41061', '42338','Creativity Awards','Closed','Scripps Research Institute',null,205122;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TC1-05961','UCSF SEP High School Intern Program',null,null,'41061', '42339','Creativity Awards','Closed','University of California, San Francisco',null,168947;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TC1-06070','Internship at a Cutting Edge CIRM-funded Stem Cell Research Facility',null,null,'41061', '42339','Creativity Awards','Closed','University of California, Davis',null,250064;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TC1-06227','Creativity Award Program in Stem Cell Biology for California High School Students',null,null,'41061', '42339','Creativity Awards','Closed','City of Hope, Beckman Research Institute',null,260825;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TC1-06252','Gladstone Summer Scholars (GSS) internship program',null,null,'41061', '42339','Creativity Awards','Closed','Gladstone Institutes, J. David',null,35044;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TC1-06302','CIRM STAR High School Summer Research and Creativity Program',null,null,'41061', '42339','Creativity Awards','Closed','University of Southern California',null,271160;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TC1-05787','Research Mentorship Program-Immersing High School Students in College Research',null,null,'41061', '42339','Creativity Awards','Closed','University of California, Santa Barbara',null,280726;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TC1-05868','SIMR Program: Stem Cell & Developmental Biology Research Internships',null,null,'41061', '42339','Creativity Awards','Closed','Stanford University',null,340611;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99036','Keystone Symposia, 'The Life of a Stem Cell: From Birth to Deathnull,null,null,'40969', '40999','Conference','Closed','Stanford University',null,50000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99034','Stem Cell Research and Aging',null,'Aging','40940', '41029','Conference','Closed','Buck Institute for Age Research',null,30000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99032','2012 Rachmiel Levine Diabetes and Obesity Symposium: Advances in Diabetes Research',null,'Diabetes, Metabolic Disorders','40909', '40999','Conference','Closed','City of Hope, Beckman Research Institute',null,15000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99027','14th International Symposium on Neural Regeneration',null,'Neurological Disorders','40878', '40908','Conference','Closed','International Symposium on Neural Regeneration, Inc.',null,20000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99031','Innovative Partnerships: Bringing Stem Cell Discoveries to the Clinic',null,null,'40848', '40939','Conference','Closed','City of Hope, Beckman Research Institute',null,14994;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99030','Stem Cell Meeting on the Mesa: 6th Annual Scientific Symposium & 1st Annual Investor and Partnering Forum',null,null,'40817', '40908','Conference','Closed','Sanford Consortium for Regenerative Medicine',null,40000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99025','World Stem Cell Summit',null,null,'40817', '41213','Conference','Closed','California Institute of Technology',null,50000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99029-1','10th Annual Gene Therapy Symposium for Heart, Lung, and Blood Diseases',null,'Blood Disorders, Heart Disease','40848', '40939','Conference','Closed','University of California, Davis',null,18300;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05298','Airways for Children',null,'Respiratory Disorders','40787', '40968','Disease Team Therapy Planning I','Closed','University of California, Davis',null,19800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05352','Anti-Notch1, OMP-52M51: A New Cancer Therapeutic to Reduce CSC Frequency',null,'Cancer','40787', '40968','Disease Team Therapy Planning I','Closed','OncoMed Pharmaceuticals, Inc.',null,65120;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05431','Neural Stem Cell-Based Therapy For Parkinson’s Disease',null,'Neurological Disorders, Parkinson's Disease','40787', '40968','Disease Team Therapy Planning I','Closed','Sanford Burnham Prebys Medical Discovery Institute',null,63952;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05288','Genetically Engineered Mesenchymal Stem Cells for the Treatment of Vertebral Compression Fractures.',null,'Bone or Cartilage Disease','40787', '40968','Disease Team Therapy Planning I','Closed','Cedars-Sinai Medical Center',null,107622;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05426','Combination therapy to Enhance Antisense Mediated Exon Skipping for Duchenne Muscular Dystrophy',null,'Muscular Dystrophy, Skeletal/Smooth Muscle disorders','40787', '40968','Disease Team Therapy Planning I','Closed','University of California, Los Angeles',null,68947;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05423','Phase I study of IM Injection of VEGF Producing MSC for the Treatment of Critical Limb Ischemia',null,'Heart Disease','40787', '41152','Disease Team Therapy Planning I','Closed','University of California, Davis',null,76066;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05415','MSC engineered to produce BDNF for the treatment of Huntington's disease',null,'Huntington's Disease, Neurological Disorders','40787', '41090','Disease Team Therapy Planning I','Closed','University of California, Davis',null,97564;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05365','A monoclonal antibody that depletes blood stem cells and enables chemotherapy free transplants',null,'Immune Disease','40787', '40968','Disease Team Therapy Planning I','Closed','Stanford University',null,90147;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05327','Stem Cell Gene Therapy for HIV in AIDS Lymphoma Patients',null,'Blood Cancer, Cancer, HIV/AIDS, Infectious Disease','40787', '41152','Disease Team Therapy Planning I','Closed','University of California, Davis',null,66880;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05416','Neuroprotection to treat Alzheimer's: a new paradigm using human central nervous system cells',null,'Alzheimer's Disease, Neurological Disorders','40787', '40968','Disease Team Therapy Planning I','Closed','StemCells, Inc.',null,90101;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05309','Genetic Re-programming of Stem Cells to Fight Cancer',null,'Cancer, Melanoma, Solid Tumors','40787', '40968','Disease Team Therapy Planning I','Closed','University of California, Los Angeles',null,97785;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05373','Recombinant Bispecific Antibody Targeting Cancer Stem Cells for the Therapy of Glioblastoma',null,'Brain Cancer, Cancer, Solid Tumors','40787', '40968','Disease Team Therapy Planning I','Closed','Stanford University',null,109750;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05368','Clinical Development of an osteoinductive therapy to prevent osteoporosis-related fractures',null,'Bone or Cartilage Disease','40787', '40968','Disease Team Therapy Planning I','Closed','Samumed, LLC',null,99110;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05272','hESC-derived NPCs Programmed with MEF2C for Cell Transplantation in Parkinson’s Disease',null,'Neurological Disorders, Parkinson's Disease','40787', '40968','Disease Team Therapy Planning I','Closed','Sanford Burnham Prebys Medical Discovery Institute',null,96448;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05320','Stem Cells Secreting GDNF for the Treatment of ALS',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','40787', '40968','Disease Team Therapy Planning I','Closed','Cedars-Sinai Medical Center',null,63487;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05410','A CIRM Disease Team to Develop Allopregnanolone for Prevention and Treatment of Alzheimer's Disease',null,'Alzheimer's Disease, Neurological Disorders','40787', '40968','Disease Team Therapy Planning I','Closed','University of Southern California',null,107961;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05394','Human Embryonic Stem Cell-Derived Cardiomyocytes for Patients with End Stage Heart Failure',null,'Heart Disease','40787', '41152','Disease Team Therapy Planning I','Closed','Stanford University',null,73030;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR2-05302','Increasing the endogenous mesenchymal stem cells to the bone surface to treat osteoporosis',null,'Bone or Cartilage Disease','40787', '40968','Disease Team Therapy Planning I','Closed','University of California, Davis',null,107750;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99028','California ALS Summit 2011',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','40787', '40877','Conference','Closed','University of California, Los Angeles',null,13300;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99022','International RUNX Workshop',null,null,'40756', '40786','Conference','Closed','University of California, San Diego',null,24000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PA1-07523','CIRM Patent Prosecution Assistance Fund for Stem Cell Technologies - UCD',null,null,'41426', '42886','Patent Assistance Fund Awards','Closed','University of California, Davis',null,48595;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PA1-07525','Patent Assistance Fund Proposal - UCSF',null,null,'41518', '43343','Patent Assistance Fund Awards','Closed','University of California, San Francisco',null,87257;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PA1-07216','Intellectual Property in Regenerative Bioengineering from CIRM funded research in regenerative medicine at the University of California, Santa Barbara.',null,null,'41365', '43190','Patent Assistance Fund Awards','Closed','University of California, Santa Barbara',null,23564;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PA1-08156','Intellectual Property for Stem Cell-Related Inventions - HBRI',null,null,'41821', '43646','Patent Assistance Fund Awards','Closed','Human BioMolecular Research Institute',null,50000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PA1-06899','Patent Assistance Fund Application - UCSD',null,null,'41306', '43131','Patent Assistance Fund Awards','Closed','University of California, San Diego',null,38162;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PA1-06901','Funding for Patent Applications for CIRM-funded Inventions out of Stanford University',null,null,'41395', '42855','Patent Assistance Fund Awards','Closed','Stanford University',null,3525;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PA1-06921','Patent Assistance Fund - UCLA',null,null,'41334', '42794','Patent Assistance Fund Awards','Closed','University of California, Los Angeles',null,84973;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('PA1-06938','CIRM Patent Assistance Fund Application - UCI',null,null,'41334', '43159','Patent Assistance Fund Awards','Closed','University of California, Irvine',null,46155;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99026','8th Annual World Congress for Brain, Spinal Cord Mapping and Image Guided Therapy at Mission Bay Conference Center of UCSF School of Medicine',null,'Neurological Disorders','40695', '40724','Conference','Closed','Brain Mapping Foundation',null,17200;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05232','Induced Pluripotent Stem Cells for Tissue Regeneration',null,'Neurological Disorders, Neuropathy','40756', '41851','Basic Biology III','Closed','University of California, Berkeley','iPS Cell',1209148;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05086','Characterization and Engineering of the Cardiac Stem Cell Niche',null,'Heart Disease','41061', '42155','Basic Biology III','Closed','University of California, Los Angeles','iPS Cell',1127741;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05229','Investigation of synaptic defects in autism using patient-derived induced pluripotent stem cells',null,'Autism, Neurological Disorders, Pediatrics','40725', '41455','Basic Biology III','Closed','University of California, San Diego','iPS Cell',843597;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-02209','Correlated time-lapse imaging and single cell molecular analysis of human embryo development',null,'Fertility','40787', '41882','Basic Biology III','Closed','Stanford University','Embryonic Stem Cell, iPS Cell',1259733;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05080','Discovery of mechanisms that control epigenetic states in human reprogramming and pluripotent cells',null,null,'40878', '41973','Basic Biology III','Closed','University of California, Los Angeles','iPS Cell',1364598;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05009','Neural and general splicing factors control self-renewal, neural survival and differentiation',null,'Amyotrophic Lateral Sclerosis, Dementia, Neurological Disorders','40725', '41820','Basic Biology III','Closed','University of California, San Diego','Embryonic Stem Cell',1287619;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05100','Enhancer-mediated gene regulation during early human embryonic development',null,null,'40756', '41851','Basic Biology III','Closed','Stanford University','Embryonic Stem Cell',1420618;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-02098','Molecular basis of human ES cell neurovascular differentiation and co-patterning',null,null,'40725', '41820','Basic Biology III','Closed','University of California, San Diego','Embryonic Stem Cell',1359996;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05103','Molecular Mechanisms Underlying Human Cardiac Cell Junction Maturation and Disease Using Human iPSC',null,'Heart Disease, Pediatrics','40725', '41820','Basic Biology III','Closed','University of California, San Diego','iPS Cell',1341955;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-02266','Biological relevance of microRNAs in hESC differentiation to endocrine pancreas',null,'Diabetes, Metabolic Disorders','40817', '42004','Basic Biology III','Closed','University of California, San Diego','Embryonic Stem Cell',1313649;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05217','Forming the Hematopoietic Niche from Human Pluripotent Stem Cells',null,'Blood Disorders','40878', '42338','Basic Biology III','Closed','University of California, Los Angeles','Embryonic Stem Cell',1252857;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05129','Elucidating Molecular Basis of Hypertrophic Cardiomyopathy with Human Induced Pluripotent Stem Cells',null,'Heart Disease','40787', '41882','Basic Biology III','Closed','Stanford University','iPS Cell',1260537;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05174','Mechanisms of Direct Cardiac Reprogramming',null,'Heart Disease','40787', '41882','Basic Biology III','Closed','Gladstone Institutes, J. David',null,1572380;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05022','Triplet Repeat Instability in Human iPSCs',null,'Huntington's Disease, Neurological Disorders','40756', '41851','Basic Biology III','Closed','Scripps Research Institute','iPS Cell',1705494;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05041','Phenotypic Analysis of Human ES Cell-Derived Muscle Stem Cells',null,'Muscular Dystrophy, Skeletal/Smooth Muscle disorders','40725', '42185','Basic Biology III','Closed','University of California, San Francisco','Embryonic Stem Cell',1381296;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05207','Molecular determinants of accurate differentiation from human pluripotent stem cells',null,null,'40756', '42063','Basic Biology III','Closed','University of California, Los Angeles','Embryonic Stem Cell, iPS Cell',677115;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-02129','Studying neurotransmission of normal and diseased human ES cell-derived neurons in vivo',null,'Autism, Neurological Disorders, Pediatrics, Rett's Syndrome','40756', '42036','Basic Biology III','Closed','University of California, Los Angeles','Embryonic Stem Cell',1382400;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-02165','Etsrp/ER71 mediated stem cell differentiation into vascular lineage',null,null,'40787', '42247','Basic Biology III','Closed','University of California, Los Angeles','Embryonic Stem Cell',1378781;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-02143','Generation and characterization of corticospinal neurons from human embryonic stem cells',null,'Neurological Disorders','40725', '41912','Basic Biology III','Closed','University of California, San Diego','Embryonic Stem Cell',1355063;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05066','USP16 controls stem cell number: implications for Down Syndrome',null,'Genetic Disorder','40756', '41851','Basic Biology III','Closed','Stanford University','Adult Stem Cell',1263826;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-02186','Identifying sources of mutation in human induced pluripotent stem cells by whole genome sequencing',null,null,'40817', '41912','Basic Biology III','Closed','Scripps Research Institute','iPS Cell',1705500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05219','Viral-host interactions affecting neural differentiation of human progenitors',null,'Infectious Disease, Neurological Disorders, Pediatrics','40725', '41820','Basic Biology III','Closed','University of California, San Diego','Embryonic Stem Cell',1372660;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05020','Genomic instability during culturing of human embryonic stem cells',null,null,'40756', '41851','Basic Biology III','Closed','University of California, San Francisco','Embryonic Stem Cell',1070919;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-05083','Functional characterization of mutational load in nuclear reprogramming and differentiation',null,null,'40725', '41820','Basic Biology III','Closed','University of California, San Diego','iPS Cell',1295318;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-02222','Ubiquitin-dependent control of hESC self-renewal and expansion',null,null,'40817', '41912','Basic Biology III','Closed','University of California, Berkeley','Embryonic Stem Cell',1224805;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-02161','Use of human iPS cells to study spinal muscular atrophy',null,'Neurological Disorders, Pediatrics, Spinal Muscular Atrophy','40787', '41912','Basic Biology III','Closed','City of Hope, Beckman Research Institute','iPS Cell',1268868;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB3-02221','Understanding the role of LRRK2 in iPSC cell models of Parkinson's Disease',null,'Neurological Disorders, Parkinson's Disease','40756', '42035','Basic Biology III','Closed','Parkinson's Institute','iPS Cell',1482822;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99023','12th Annual Systemwide Bioengineering Symposium',null,null,'40664', '40755','Conference','Closed','University of California, Santa Barbara',null,15000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99024','First Annual Stem Cell Therapies for Neurological Disorders: Overcoming the Current Barriers to Clinical Translation, April 30 (special stem cell program for high school students on April 28)',null,'Neurological Disorders','40634', '40694','Conference','Closed','Cedars-Sinai Medical Center',null,18500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99021','2011 Rachmiel Levine Diabetes and Obesity Symposium: Advances in Diabetes Research',null,'Diabetes, Metabolic Disorders','40603', '40633','Conference','Closed','City of Hope, Beckman Research Institute',null,15000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01880','Site-specific integration of Lmx1a, FoxA2, & Otx2 to optimize dopaminergic differentiation',null,'Neurological Disorders, Parkinson's Disease','40664', '42063','Tools and Technologies II','Closed','Stanford University','iPS Cell',1592897;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-02057','Tri-resolution Visualization System for Stem Cells and Tissue Regeneration Monitoring',null,null,'40817', '42094','Tools and Technologies II','Closed','TriFoil Imaging, Inc.','Adult Stem Cell',1456989;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01881','Development of a Hydrogel Matrix for Stem Cell Growth and Neural Repair after Stroke',null,'Neurological Disorders, Stroke','40725', '41943','Tools and Technologies II','Closed','University of California, Los Angeles','iPS Cell',1825613;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-02060','Antibody tools to deplete or isolate teratogenic, cardiac, and blood stem cells from hESCs',null,'Blood Disorders, Heart Disease, Liver Disease, Metabolic Disorders','40756', '41851','Tools and Technologies II','Closed','Stanford University','Embryonic Stem Cell, iPS Cell',1463814;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01889','Development of Synthetic Microenvironments for Stem Cell Growth and Differentiation',null,null,'40695', '41974','Tools and Technologies II','Closed','University of California, San Diego','Embryonic Stem Cell',1706628;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-02061','Cellular tools to study brain diseases affecting synaptic transmission',null,'Autism, Neurological Disorders, Pediatrics, Rett's Syndrome','40756', '41851','Tools and Technologies II','Closed','Stanford University','Embryonic Stem Cell, iPS Cell',1664382;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01893','Magnetic Particle Imaging: A Novel Ultra-sensitive Imaging Scanner for Tracking Stem Cells In Vivo',null,null,'40664', '41943','Tools and Technologies II','Closed','University of California, Berkeley','Embryonic Stem Cell',1311596;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-02064','Homologous recombination in human pluripotent stem cells using adeno-associated virus.',null,null,'40634', '41912','Tools and Technologies II','Closed','University of California, San Diego','Embryonic Stem Cell',1659043;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01906','Development of small molecule screens for autism using patient-derived iPS cells',null,'Autism, Neurological Disorders, Pediatrics','40634', '41729','Tools and Technologies II','Closed','Stanford University','iPS Cell',1797606;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01920','Use of hiPSCs to develop lead compounds for the treatment of genetic diseases',null,'Neurological Disorders, Pediatrics','40634', '41729','Tools and Technologies II','Closed','University of California, Los Angeles','iPS Cell',1833054;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01927','Developing a method for rapid identification of high-quality disease specific hIPSC lines',null,'Alzheimer's Disease, Neurological Disorders','40634', '41729','Tools and Technologies II','Closed','University of California, San Diego','iPS Cell',1692334;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01938','Preparation and Delivery of Clinically Relevant Numbers of Stem Cells Using 3D Hydrogels',null,null,'40664', '41759','Tools and Technologies II','Closed','Stanford University','Adult Stem Cell',600695;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01942','Robust generation of induced pluripotent stem cells by a potent set of engineered factors',null,null,'40756', '41851','Tools and Technologies II','Closed','GMR Epigenetics','iPS Cell',1356052;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01965','Editing of Parkinson’s disease mutation in patient-derived iPSCs by zinc-finger nucleases',null,'Neurological Disorders, Parkinson's Disease','40664', '42124','Tools and Technologies II','Closed','Parkinson's Institute','iPS Cell',1327983;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01975','Development and preclinical testing of new devices for cell transplantation to the brain.',null,'Neurological Disorders, Parkinson's Disease','40664', '42124','Tools and Technologies II','Closed','University of California, San Francisco',null,1795891;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-01985','Pluripotent and Somatic Stem Cell Models to Study Inherited Diarrheal Disorders',null,'Genetic Disorder, Intestinal Disease, Metabolic Disorders, Pediatrics','40664', '42124','Tools and Technologies II','Closed','University of California, Los Angeles','iPS Cell',1783250;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-02018','Development of Single Cell MRI Technology using Genetically-Encoded Iron-Based Reporters',null,'Neurological Disorders, Stroke','40634', '41912','Tools and Technologies II','Closed','Stanford University','Adult Stem Cell',1833348;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-02022','Engineering Defined and Scaleable Systems for Dopaminergic Neuron Differentiation of hPSCs',null,'Neurological Disorders, Parkinson's Disease','40695', '41790','Tools and Technologies II','Closed','University of California, Berkeley','Embryonic Stem Cell, iPS Cell',1340816;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-02040','Use of iPS cells (iPSCs) to develop novels tools for the treatment of spinal muscular atrophy.',null,'Neurological Disorders, Pediatrics, Spinal Muscular Atrophy','40664', '41943','Tools and Technologies II','Closed','Cedars-Sinai Medical Center','iPS Cell',1933022;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT2-02052','Development and Application of Versatile, Automated, Microfluidic Cell Culture System',null,null,'40664', '41759','Tools and Technologies II','Closed','Fluidigm Corporation','iPS Cell',1939236;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99020','2011 Gordon Conference on Stem Cells and Cancer',null,'Cancer','40575', '40602','Conference','Closed','Gordon Research Conferences',null,40000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99018','Stem Cell Meeting on Mesa',null,null,'40513', '40543','Conference','Closed','Sanford Consortium for Regenerative Medicine',null,40000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99016','Stem Cells: A New Avenue of HIV Research and New Approaches to HIV Treatment',null,'HIV/AIDS, Infectious Disease','40483', '40602','Conference','Closed','University of California, Los Angeles',null,24456;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99019','9th Annual Gene Therapy Symposium for Heart, Lung and Blood Diseases',null,'Blood Disorders, Heart Disease','40483', '40512','Conference','Closed','University of California, Davis',null,12000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99017','New Approaches in Cell Based Therapies',null,null,'40483', '40512','Conference','Closed','City of Hope, Beckman Research Institute',null,20000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01844','New Drug Discovery for SMA using Patient-derived Induced Pluripotent Stem Cells',null,'Neurological Disorders, Pediatrics, Spinal Muscular Atrophy','40634', '41171','Early Translational II','Closed','iPierian, Inc.','iPS Cell',2410000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01787','Bone Marrow Mesenchymal Stem Cells to Heal Chronic Diabetic Wounds',null,'Skin Disease','40787', '42247','Early Translational II','Closed','University of California, Davis','Adult Stem Cell',4629747;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01816-B','Dual targeting of tyrosine kinase and BCL6 signaling for leukemia stem cell eradication',null,'Blood Cancer, Cancer','41365', '42277','Early Translational II','Closed','University of California, San Francisco','Cancer Stem Cell',2756536;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01749','Inhibitory Nerve Cell Precursors: Dosing, Safety and Efficacy',null,'Epilepsy, Neurological Disorders, Pediatrics','40664', '41759','Early Translational II','Closed','University of California, San Francisco','Embryonic Stem Cell',1564016;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01821','Harnessing native fat-residing stem cells for bone regeneration',null,'Bone or Cartilage Disease','40575', '41882','Early Translational II','Closed','University of California, Los Angeles','Adult Stem Cell',5359076;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01767','Neural restricted, FAC-sorted, human neural stem cells to treat traumatic brain injury',null,'Neurological Disorders, Trauma','40664', '41942','Early Translational II','Closed','University of California, Irvine','Embryonic Stem Cell',1517767;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01780','Systemic Adult Stem Cell Therapy for Osteoporosis-Related Vertebral Compression Fractures',null,'Bone or Cartilage Disease','40603', '41698','Early Translational II','Closed','Cedars-Sinai Medical Center','Adult Stem Cell',1927698;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('LA1-02086','Development of Cellular Therapies for Retinal Disease',null,'Vision Loss','40848', '43039','Research Leadership','Closed','University of California, Santa Barbara','Embryonic Stem Cell, iPS Cell',4690963;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01832','Developing a therapeutic candidate for Canavan disease using induced pluripotent stem cell',null,'Genetic Disorder, Neurological Disorders, Pediatrics','40695', '42155','Early Translational II','Closed','City of Hope, Beckman Research Institute','iPS Cell',1835983;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01756','Stem Cell Therapy for Duchenne Muscular Dystrophy',null,'Muscular Dystrophy, Pediatrics, Skeletal/Smooth Muscle disorders','40575', '41759','Early Translational II','Closed','Stanford University','iPS Cell',2267261;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01856','Banking transplant ready dopaminergic neurons using a scalable process',null,'Neurological Disorders, Parkinson's Disease','40695', '41882','Early Translational II','Closed','Buck Institute for Age Research','Embryonic Stem Cell',4983013;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01785-A','Repair of Conus Medullaris/Cauda Equina Injury using Human ES Cell-Derived Motor Neurons',null,'Neurological Disorders, Spinal Cord Injury','40695', '42035','Early Translational II','Closed','University of California, Irvine','Embryonic Stem Cell',1527011;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01857','Liver Cell Transplantation',null,'Liver Disease, Metabolic Disorders','40634', '41729','Early Translational II','Closed','University of California, Davis','Embryonic Stem Cell',4212621;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01778','Crosstalk: Inflammation in Parkinson’s disease (PD) in a humanized in vitro model',null,'Neurological Disorders, Parkinson's Disease','40664', '41759','Early Translational II','Closed','Salk Institute for Biological Studies','iPS Cell',2472839;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01791','Stem cell-based carriers for RCR vector delivery to glioblastoma',null,'Brain Cancer, Cancer, Solid Tumors','40725', '42004','Early Translational II','Closed','University of California, Los Angeles','Adult Stem Cell',3340625;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01768-B','Regeneration of Functional Human Corneal Epithelial Progenitor Cells',null,'Vision Loss','41852', '42124','Early Translational II','Closed','University of California, Los Angeles','Adult Stem Cell',697507;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01789','Preclinical development of a pan Bcl2 inhibitor for cancer stem cell directed therapy',null,'Blood Cancer, Cancer','40664', '41759','Early Translational II','Closed','University of California, San Diego','Cancer Stem Cell',3103041;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01841','A hESc-based Development Candidate for Huntington's Disease',null,'Huntington's Disease, Neurological Disorders','40695', '42247','Early Translational II','Closed','University of California, Irvine','Embryonic Stem Cell',3955038;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01814','Developing a drug-screening system for Autism Spectrum Disorders using human neurons',null,'Autism, Neurological Disorders, Pediatrics','40634', '41943','Early Translational II','Closed','University of California, San Diego','iPS Cell',1376198;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01771','Development of RNA-based approaches to stem cell gene therapy for HIV',null,'HIV/AIDS, Immune Disease, Infectious Disease','40634', '41851','Early Translational II','Closed','City of Hope, Beckman Research Institute','Adult Stem Cell',3097160;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01768','Regeneration of Functional Human Corneal Epithelial Progenitor Cells',null,'Vision Loss','40603', '41698','Early Translational II','Closed','University of California, Los Angeles','Adult Stem Cell',1524947;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01816-A','Dual targeting of tyrosine kinase and BCL6 signaling for leukemia stem cell eradication',null,'Blood Cancer, Cancer','40817', '41364','Early Translational II','Closed','Children's Hospital of Los Angeles','Cancer Stem Cell',850769;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01794','Human retinal progenitor cells as candidate therapy for retinitis pigmentosa',null,'Vision Loss','40725', '41182','Early Translational II','Closed','University of California, Irvine','Adult Stem Cell',1803768;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01785-B','Repair of Conus Medullaris/Cauda Equina Injury using Human ES Cell-Derived Motor Neurons',null,'Neurological Disorders, Spinal Cord Injury','42064', '42155','Early Translational II','Closed','University of California, Los Angeles','Embryonic Stem Cell',75628;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR2-01829','Cartilage Regeneration by the Chondrogenic Small Molecule PRO1 during Osteoarthritis',null,'Arthritis, Bone or Cartilage Disease','40575', '42004','Early Translational II','Closed','Scripps Research Institute','Adult Stem Cell',6047249;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99013','Translation of Stem Cell Therapies: Strategies and Best Practices for PreClinical Developments',null,null,'40448', '40510','Conference','Closed','Vitalant Research Institute',null,25000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99015','CA-HSCI 1st Generation Stem Cell PI Meeting',null,null,'40422', '40451','Conference','Closed','University of California, San Francisco',null,20000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99014','ISSCR 8th Annual Meeting - San Francisco',null,null,'40330', '40359','Conference','Closed','International Society for Stem Cell Research',null,62475;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('LA1-01747','The role of neural stem cells in cerebellar development, regeneration and tumorigenesis',null,'Brain Cancer, Cancer, Solid Tumors','40483', '43039','Research Leadership','Closed','Sanford Burnham Prebys Medical Discovery Institute',null,5226049;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01530','Molecular Characterization and Functional Exploration of Nuclear Receptors in hiPSCs',null,null,'40391', '41486','Basic Biology II','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell, iPS Cell',1712880;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01724','Donor natural killer (NK) cells as “veto” cells to promote donor-specific tolerance',null,null,'40452', '41547','Transplantation Immunology','Closed','University of California, Davis','Embryonic Stem Cell, iPS Cell',1257601;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01628','Cellular Reprogramming: Dissecting the Molecular Mechanism and Enhancing Efficiency',null,'Neurological Disorders','40422', '41517','Basic Biology II','Closed','iPierian, Inc.','iPS Cell',1458000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01725','Regulatory T cell induced tolerance to ESC transplantation',null,null,'40422', '41608','Transplantation Immunology','Closed','Stanford University',null,1382658;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01567','Differentiation of Human Embryonic Stem Cells into Urothelium',null,'Pediatrics','40452', '41274','Basic Biology II','Closed','University of California, Davis','Embryonic Stem Cell',849037;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01729','Generation of regulatory T cells by reprogramming',null,'Immune Disease','40483', '41578','Transplantation Immunology','Closed','La Jolla Institute for Allergy and Immunology','Adult Stem Cell',1464446;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01730','Inactivating  NK cell reactivity to facilitate transplantation of stem cell derived tissue',null,'Blood Disorders','40513', '41608','Transplantation Immunology','Closed','University of California, Berkeley','Adult Stem Cell',952896;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01637','Systemic Protein Factors as Modulators of the Aging Neurogenic Niche',null,'Alzheimer's Disease, Neurological Disorders','40422', '41698','Basic Biology II','Closed','Palo Alto Veterans Institute for Research','Embryonic Stem Cell, iPS Cell',1159806;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01732','Human Immune System Mouse models as preclinical platforms for stem cell derived grafts',null,'Immune Disease','40422', '41517','Transplantation Immunology','Closed','University of California, Berkeley','Embryonic Stem Cell',1005605;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01502','Programs of alternative splicing regulation by polypyrimidine tract binding protein',null,null,'40391', '41851','Basic Biology II','Closed','University of California, Los Angeles','Embryonic Stem Cell',1344562;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01733','Purified allogeneic hematopoietic stem cells as a platform for tolerance induction',null,'Blood Disorders, Immune Disease, Muscular Dystrophy, Skeletal/Smooth Muscle disorders','40452', '41547','Transplantation Immunology','Closed','Stanford University','Adult Stem Cell',1233275;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01562','Novel Mechanism in Self-Renewal/Differentiation of Human Embryonic Stem Cells',null,null,'40391', '41608','Basic Biology II','Closed','University of California, Los Angeles','Embryonic Stem Cell',1259371;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01702','Stem cell differentiation to thymic epithelium for inducing tolerance to stem cells',null,'HIV/AIDS, Immune Disease, Infectious Disease, Pediatrics','40452', '41912','Transplantation Immunology','Closed','University of California, San Francisco','Embryonic Stem Cell, iPS Cell',1314089;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01735-B','Role of HLA in neural stem cell rejection using humanized mice',null,'Neurological Disorders','41395', '41912','Transplantation Immunology','Closed','University of Southern California','Embryonic Stem Cell',353249;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01497','Self-renewal and senescence in iPS cells derived from patients with a stem cell disease',null,'Blood Disorders, Pediatrics','40634', '42094','Basic Biology II','Closed','Stanford University','Embryonic Stem Cell, iPS Cell',931285;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01703','Stem cell tolerance through the use of engineered antigen-specific regulatory T cells',null,'Diabetes, Immune Disease, Metabolic Disorders','40543', '41638','Transplantation Immunology','Closed','University of California, San Francisco','Embryonic Stem Cell',1152768;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01739','Engineered immune tolerance by Stem Cell-derived thymic regeneration',null,'Immune Disease, Pediatrics','40513', '41789','Transplantation Immunology','Closed','Stanford University','Adult Stem Cell',1271729;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01512','Endothelial cells and ion channel maturation of human stem cell-derived cardiomyocytes',null,null,'40452', '41729','Basic Biology II','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell',1587610;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01706','Engineering Embryonic Stem Cell Allografts for Operational Tolerance',null,null,'40452', '41639','Transplantation Immunology','Closed','Stanford University','Adult Stem Cell, iPS Cell',1411338;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01743','Induction of immune tolerance to human embryonic stem cell-derived allografts',null,'Immune Disease','40422', '41517','Transplantation Immunology','Closed','University of California, San Diego','Embryonic Stem Cell',1192680;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01602','MGE Enhancers to Select for Interneuron Precursors Produced from Human ES Cells',null,'Epilepsy, Neurological Disorders','40391', '41486','Basic Biology II','Closed','University of California, San Francisco','Embryonic Stem Cell',1387800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01707','Engineering Thymic Regeneration to Induce Tolerance',null,'Immune Disease','40513', '41790','Transplantation Immunology','Closed','University of California, Los Angeles',null,1235445;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01735-A','Role of HLA in neural stem cell rejection using humanized mice',null,'Neurological Disorders','40452', '41425','Transplantation Immunology','Closed','Cedars-Sinai Medical Center','Embryonic Stem Cell',1119385;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01592','Kinase signaling analysis of iPS cell reprogramming and differentiation',null,null,'40391', '41394','Basic Biology II','Closed','Stanford University','iPS Cell',1343100;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01709','Role of Innate Immunity in hematopoeitic stem cell-mediated allograft tolerance',null,'Blood Disorders, Immune Disease','40422', '41517','Transplantation Immunology','Closed','Scripps Research Institute','Adult Stem Cell',1705554;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01496','Role of the microenvironment in human iPS and NSC fate and tumorigenesis',null,'Neurological Disorders, Spinal Cord Injury','40452', '41547','Basic Biology II','Closed','University of California, Irvine','Adult Stem Cell, Embryonic Stem Cell',1256194;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01710','Application of Tolerogenic Dendritic Cells for Hematopoietic Stem Cell Transplantation',null,'Immune Disease','40452', '41274','Transplantation Immunology','Closed','Palo Alto Veterans Institute for Research','Adult Stem Cell',733061;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01629','TCF-3:  A Wnt Pathway Effector and Nanog Regulator in Pluripotent Stem Cell Self-Renewal',null,null,'40391', '41759','Basic Biology II','Closed','University of California, Irvine','Embryonic Stem Cell, iPS Cell',1259879;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01645','RUNX1 in maintenance, expansion, and differentiation of therapeutic pluripotent stem cells',null,null,'40391', '41578','Basic Biology II','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1371540;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01711','Development of an immune tolerant hESC source for allogeneic cell therapy applications',null,null,'40422', '41517','Transplantation Immunology','Closed','Escape Therapeutics, Inc','Embryonic Stem Cell',1453040;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01547','The function of YAP in human embryonic stem cells',null,null,'40360', '41455','Basic Biology II','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1245693;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01717','Thymus based tolerance to stem cell therapies',null,'Immune Disease','40575', '41670','Transplantation Immunology','Closed','Scripps Research Institute','Embryonic Stem Cell, iPS Cell',1108921;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01571','The EphrinB2/EphB4 axis in regulating hESC pluripotency and differentiation',null,null,'40391', '41486','Basic Biology II','Closed','University of California, Los Angeles','Embryonic Stem Cell',1371936;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01718','Maternal and Fetal Immune Responses to In Utero Hematopoietic Stem Cell Transplantation',null,'Blood Disorders, Immune Disease, Pediatrics','40513', '41943','Transplantation Immunology','Closed','University of California, San Francisco','Other',1230869;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB2-01553','Maturation of Human Oocytes for SCNT and Embryonic Stem Cell Derivation',null,'Fertility','40391', '41486','Basic Biology II','Closed','Stanford University','SCNT',1309018;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RM1-01720','Induction of immune tolerance after spinal grafting of human ES-derived neural precursors',null,'Neurological Disorders, Spinal Cord Injury','40422', '41517','Transplantation Immunology','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1387800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99011','Systems Biology of Stem Cells',null,null,'40299', '40329','Conference','Closed','University of California, Irvine',null,25000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01461','Autologous cardiac-derived cells for advanced ischemic cardiomyopathy',null,'Heart Disease','40238', '41182','Disease Team Research I','Closed','Cedars-Sinai Medical Center','Adult Stem Cell',5560232;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01490','ZINC FINGER NUCLEASE-BASED STEM CELL THERAPY FOR AIDS',null,'HIV/AIDS, Immune Disease, Infectious Disease','40299', '41912','Disease Team Research I','Closed','City of Hope, Beckman Research Institute','Adult Stem Cell',14536969;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01431','HPSC based therapy for HIV disease using RNAi to CCR5.',null,'HIV/AIDS, Immune Disease, Infectious Disease','40330', '41152','Disease Team Research I','Closed','University of California, Los Angeles','Adult Stem Cell',9905604;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01426','Stem Cell-Mediated Oncocidal Gene Therapy of Glioblastoma (GBM)',null,'Brain Cancer, Cancer, Solid Tumors','40269', '40999','Disease Team Research I','Closed','University of California, San Francisco','Adult Stem Cell',6214914;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01444','Stem cell based treatment strategy for Age-related Macular Degeneration (AMD)',null,'Vision Loss','40269', '42004','Disease Team Research I','Closed','University of Southern California','Embryonic Stem Cell',18904916;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01471','Stem Cell-Derived Astrocyte Precursor Transplants in Amyotrophic Lateral Sclerosis',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','40330', '41182','Disease Team Research I','Closed','University of California, San Diego','Embryonic Stem Cell',5694308;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01430','Development of Highly Active Anti-Leukemia Stem Cell Therapy (HALT)',null,'Blood Cancer, Cancer','40238', '41698','Disease Team Research I','Closed','University of California, San Diego','Cancer Stem Cell',19999826;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01454','iPS Cell-Based Treatment of Dominant Dystrophic Epidermolysis Bullosa',null,'Epidermolysis Bullosa, Pediatrics, Skin Disease','40299', '42035','Disease Team Research I','Closed','Stanford University','iPS Cell',11039208;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01421','Stem Cell-mediated Therapy for High-grade Glioma:  Toward Phase I-II Clinical Trials',null,'Brain Cancer, Cancer, Solid Tumors','40238', '42063','Disease Team Research I','Closed','City of Hope, Beckman Research Institute','Adult Stem Cell',17890623;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01480','Embryonic-Derived Neural Stem Cells for Treatment of Motor Sequelae following Sub-cortical Stroke',null,'Neurological Disorders, Stroke','40210', '42094','Disease Team Research I','Closed','Stanford University','Embryonic Stem Cell',17244851;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01477','Therapeutic Opportunities To Target Tumor Initiating Cells in Solid Tumors',null,'Cancer, Solid Tumors','40299', '42124','Disease Team Research I','Closed','University of California, Los Angeles','Cancer Stem Cell',19979660;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-06893','GENE-MODIFIED HEMATOPOIETIC STEM/PROGENITOR CELL BASED THERAPY FOR HIV DISEASE', 847776695,'HIV/AIDS, Infectious Disease','41306', '42400','Disease Team Research I','Closed','Calimmune, Inc.','Adult Stem Cell',8278722;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01452','Stem Cell Gene Therapy for Sickle Cell Disease',null,'Blood Disorders, Pediatrics, Sickle Cell Disease','40238', '41820','Disease Team Research I','Closed','University of California, Los Angeles','Adult Stem Cell',8833695;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRX-01431','Development of a humanized mouse model for testing anti-HIV HSPC gene therapy strategies in HIV-1 infected mice.',null,'HIV/AIDS, Infectious Disease','41153', '41973','Early Translational from Disease Team Conversion','Closed','University of California, Los Angeles','Adult Stem Cell',1505000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01485','Development of Therapeutic Antibodies Targeting Human Acute Myeloid Leukemia Stem Cells',null,'Blood Cancer, Cancer','40238', '42063','Disease Team Research I','Closed','Stanford University','Cancer Stem Cell',18759276;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TRX-01471','Stem Cell-Derived Astrocyte Precursor Transplants in Amyotrophic Lateral Sclerosis',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','41183', '42094','Early Translational from Disease Team Conversion','Closed','University of California, San Diego','Embryonic Stem Cell',4139754;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DR1-01423','Cell Therapy for Diabetes',null,'Diabetes, Metabolic Disorders','40210', '41851','Disease Team Research I','Closed','ViaCyte, Inc.','Embryonic Stem Cell',22999933;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99010','Stem Cell Meeting on the Mesa',null,null,'40118', '40147','Conference','Closed','Sanford Consortium for Regenerative Medicine',null,40000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01413','RNA Binding Protein-mediated Post-transcriptional Networks Regulating HPSC Pluripotency',null,null,'40087', '41182','Basic Biology I','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1308901;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01385','The retinoblastoma (RB) gene family in cellular reprogramming',null,null,'40118', '41455','Basic Biology I','Closed','Stanford University','iPS Cell',1357085;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01292','Molecular Mechanisms of Reprogramming towards Pluripotency',null,null,'40118', '41274','Basic Biology I','Closed','Stanford University','iPS Cell',1408332;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01406','WNT signaling and the control of cell fate decisions in human pluripotent stem cells.',null,null,'40087', '41364','Basic Biology I','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1329298;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01354','Human Cardiovascular Progenitors, their Niches and Control of Self-renewal and Cell Fate',null,'Heart Disease','40118', '40847','Basic Biology I','Closed','University of California, Los Angeles','Adult Stem Cell',917667;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01417','Directing migration of human stem cells with electric fields',null,null,'40118', '41394','Basic Biology I','Closed','University of California, Davis','Embryonic Stem Cell',816228;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01353','Defining the molecular mechanisms of somatic cell reprogramming',null,null,'40179', '41364','Basic Biology I','Closed','University of Southern California','iPS Cell',1365580;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01328','Molecular Characterization and Functional Exploration of Hemogenic Endothelium',null,'Blood Disorders','40118', '41213','Basic Biology I','Closed','University of California, Los Angeles','Directly Reprogrammed Cell, Embryonic Stem Cell',1371477;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01367','Molecular Characterization of hESC and hIPSC-Derived Spinal Motor Neurons',null,'Amyotrophic Lateral Sclerosis, Genetic Disorder, Neurological Disorders, Pediatrics, Spinal Cord Injury, Spinal Muscular Atrophy','40118', '41425','Basic Biology I','Closed','University of California, Los Angeles','Embryonic Stem Cell, iPS Cell',1229922;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01372','The stem cell microenvironment in the maintenance of pluripotency and reprogramming',null,null,'40087', '41182','Basic Biology I','Closed','University of Southern California','Embryonic Stem Cell, iPS Cell',1325723;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01397','Mitochondrial Metabolism in hESC and hiPSC Differentiation, Reprogramming, and Cancer',null,null,'40118', '41578','Basic Biology I','Closed','University of California, Los Angeles','Embryonic Stem Cell, iPS Cell',1323029;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RB1-01358','Identification and characterization of human ES-derived DA neuronal subtypes',null,'Neurological Disorders, Parkinson's Disease','40118', '41274','Basic Biology I','Closed','Stanford University','Embryonic Stem Cell',1404853;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99008','Innovation and Translational Stem Cell Therapy for Diabetes and Neurological Diseases: Paving the way for real life solutions',null,'Diabetes, Metabolic Disorders, Neurological Disorders','40026', '40086','Conference','Closed','City of Hope, Beckman Research Institute',null,14878;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99004','UCSF Frontiers of Neural Stem Cells Symposium',null,null,'40026', '40117','Conference','Closed','University of California, San Francisco',null,35000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99009','Stem Cell Policy: Understanding the Scientific and Legal Challenges Ahead',null,null,'39995', '40117','Conference','Closed','Stanford University',null,5838;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01215','Methods for detection and elimination of residual human embryonic stem cells in a differentiated cell product',null,'Diabetes, Metabolic Disorders','40057', '41333','Early Translational I','Closed','ViaCyte, Inc.','Embryonic Stem Cell',5405397;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01216','Stem Cell-Based Therapy for Cartilage Regeneration and Osteoarthritis',null,'Arthritis, Bone or Cartilage Disease','40057', '41333','Early Translational I','Closed','Scripps Health','Embryonic Stem Cell, iPS Cell',3118431;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01219','Autologous Retinal Pigmented Epithelial Cells Derived from Induced Pluripotent Stem Cells for the Treatment of Atrophic Age Related Macular Degeneration',null,'Aging, Vision Loss','40087', '41486','Early Translational I','Closed','Scripps Research Institute','iPS Cell',5806321;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01227','Maximizing the Safety of Induced Pluripotent Stem Cells as an Infusion Therapy: Limiting the Mutagenic Threat of Retroelement Retrotransposition during iPSC Generation, Expansion and Differentiation',null,null,'40026', '41182','Early Translational I','Closed','Gladstone Institutes, J. David','Embryonic Stem Cell, iPS Cell',1280001;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01232','Mouse Models for Stem Cell Therapeutic Development',null,null,'40118', '41578','Early Translational I','Closed','Jackson Labs',null,3759134;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01246','Using patient-specific iPSC derived dopaminergic neurons to overcome a major bottleneck in Parkinson's disease research and drug discovery',null,'Neurological Disorders, Parkinson's Disease','40026', '41121','Early Translational I','Closed','Parkinson's Institute','iPS Cell',3698646;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01249','Enhancing healing via Wnt-protein mediated activation of endogenous stem cells',null,'Bone or Cartilage Disease','40057', '41943','Early Translational I','Closed','Stanford University','Adult Stem Cell',6464126;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01272','Development of a Stem Cell-based Transplantation Strategy for Treating Age-related Macular Degeneration',null,'Vision Loss','40118', '41213','Early Translational I','Closed','University of California, Los Angeles','Adult Stem Cell, iPS Cell',5487136;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01273','Curing Hematological Diseases',null,'Blood Disorders, Immune Disease','40057', '41333','Early Translational I','Closed','Salk Institute for Biological Studies','iPS Cell',5979252;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01267','Developmental Candidates for Cell-Based Therapies for Parkinson's Disease (PD)',null,'Neurological Disorders, Parkinson's Disease','40330', '41698','Early Translational I','Closed','Sanford Burnham Prebys Medical Discovery Institute','Adult Stem Cell, Embryonic Stem Cell, iPS Cell',5190752;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01269','In Utero Model to Assess the Fate of Transplanted Human Cells for Translational Research and Pediatric Therapies',null,null,'40057', '41517','Early Translational I','Closed','University of California, Davis','Embryonic Stem Cell',3143392;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01276','Addressing the Cell Purity and Identity Bottleneck Through Generation and Expansion of Clonal Human Embryonic Progenitor Cell Lines',null,null,'40057', '41152','Early Translational I','Closed','BioTime, Inc.','Embryonic Stem Cell',4721706;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01257','Sustained siRNA production from human MSC to treat Huntingtons Disease and other neurodegenerative disorders',null,'Huntington's Disease, Neurological Disorders','40026', '41213','Early Translational I','Closed','University of California, Davis','Adult Stem Cell, Embryonic Stem Cell',2615674;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01245','Neural Stem Cells as a Developmental Candidate to Treat Alzheimer Disease',null,'Aging, Alzheimer's Disease, Neurological Disorders','40148', '41243','Early Translational I','Closed','University of California, Irvine','Adult Stem Cell, Embryonic Stem Cell',3599997;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01277','Developing induced pluripotent stem cells into human therapeutics and disease models',null,'Diabetes, Metabolic Disorders','40026', '41305','Early Translational I','Closed','University of California, San Diego','iPS Cell',5165028;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TR1-01250','Ensuring the safety of cell therapy: a quality control pipeline for cell purification and validation',null,null,'40057', '41333','Early Translational I','Closed','Scripps Research Institute','Embryonic Stem Cell, iPS Cell',5830771;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99003','Weinstein Cardiovascular Development Conference',null,'Blood Disorders, Heart Disease','39934', '39994','Conference','Closed','University of California, San Francisco',null,35000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99006','10th Annual UC Systemwide Bioengineering Symposium',null,null,'39937', '40089','Conference','Closed','University of California, San Diego',null,8000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99005','San Diego Stem Cell Science Education Symposium at UCSD',null,null,'39920', '40026','Conference','Closed','University of California, San Diego',null,6237;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99001','2009 Rachmiel Levine Diabetes and Obesity Symposium:  Advances in Diabetes Biology, Immunology and Cell Therapy',null,'Diabetes, Metabolic Disorders','39822', '39994','Conference','Closed','City of Hope, Beckman Research Institute',null,15000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01197','Specialty in Stem Cell Biology',null,null,'40391', '42947','Bridges','Closed','Berkeley City College',null,2227230;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01150','City of Hope Research Training Program in Stem Cell Biology',null,null,'39995', '42277','Research Training II','Closed','City of Hope, Beckman Research Institute',null,2197782;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01169','UCLA CIRM Research Training Program II',null,null,'39995', '42185','Research Training II','Closed','University of California, Los Angeles',null,7790488;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01151','Training Program in Stem Cell Biology and Engineering',null,null,'40057', '42460','Research Training II','Closed','University of California, Santa Barbara',null,2448823;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01175','Masters of Science Specialization in Stem Cell Technology',null,null,'39995', '42916','Bridges','Closed','Cal Poly Corporation, an Auxiliary of California Polytechnic State University, San Luis Obispo',null,3480357;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01152','UCI-CIRM Research Training Program II',null,null,'40057', '42490','Research Training II','Closed','University of California, Irvine',null,6067550;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01176','Cal Poly Pomona and Cal State LA Collaborative CIRM Bridges Program to Enhance Stem Cell Research Training and Education',null,null,'39965', '42886','Bridges','Closed','Cal Poly Pomona',null,3056191;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01153','Training Program in Stem Cell Research at UCSF',null,null,'40057', '42429','Research Training II','Closed','University of California, San Francisco',null,7814027;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01177','Curriculum Development and Implementation of Stem Cell Technology and Laboratory Management Emphasis in an Established MS Biotechnology and Bioinformatics Program at California State University Channel Islands and Co-development of a GE Course on Stem Cel',null,null,'39965', '42674','Bridges','Closed','Cal State Univ, Channel Island',null,4165092;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01154','Interdisciplinary Stem Cell Training Program at UCSD II',null,null,'40087', '42429','Research Training II','Closed','University of California, San Diego',null,7432600;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01181','Stem Cell Training Program at CSU Fullerton - A Bridge to Stem Cell Research',null,null,'40391', '42947','Bridges','Closed','Cal State Univ, Fullerton',null,2764079;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01155','CIRM Research Training Program in Stem Cells and Aging',null,null,'40360', '41698','Research Training II','Closed','Buck Institute for Age Research',null,1472416;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01182','CIRM Stem Cell Research Biotechnology Training Program at CSULB',null,null,'39995', '42551','Bridges','Closed','Cal State Univ, Long Beach',null,3487091;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01157','UCSC CIRM Training Program in Systems Biology of Stem cells',null,null,'40087', '42369','Research Training II','Closed','University of California, Santa Cruz',null,4397002;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01183','CSUN-UCLA Bridges to Stem Cell Research',null,null,'40391', '42947','Bridges','Closed','Cal State Univ, Northridge',null,3814078;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06455-1.2','Medical School Loan Repayment Program',null,null,'41334', '43159','New Faculty Physician Scientist','Closed','Ali Nsair',null,120312;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01158','Training in the Biology of Human Embryonic Stem Cells and Emerging Technologies II',null,null,'39995', '42400','Research Training II','Closed','Salk Institute for Biological Studies',null,2886221;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01184','Strengthening the Pipeline of Masters-level Scientific and Laboratory Personnel in Stem Cell Research',null,null,'40087', '42735','Bridges','Closed','Cal State Univ, Sacramento',null,3057754;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06532-1.2','Medical School Loan Repayment Program',null,null,'41426', '43251','New Faculty Physician Scientist','Closed','Tippi C. Mackenzie',null,36436;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01159','Stanford CIRM Training Program',null,null,'40087', '42429','Research Training II','Closed','Stanford University',null,7017629;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01185','CSUSB Bridges to Stem Cell Research',null,null,'40422', '43190','Bridges','Closed','Cal State Univ, San Bernadino',null,2762085;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01160','Gladstone CIRM Scholars Program',null,null,'39934', '42247','Research Training II','Closed','Gladstone Institutes, J. David',null,4869300;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01186','California State University-San Marcos CIRM Bridges to the Stem Cell Research Training Grant',null,null,'39965', '42735','Bridges','Closed','Cal State Univ, San Marcos',null,4114712;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01188','City College of San Francisco Stem Cell Training Enhancement Program',null,null,'40391', '42947','Bridges','Closed','City College Of San Francisco',null,2649780;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01161','CIRM Stem Cell Biology Training Program',null,null,'40269', '42613','Research Training II','Closed','University of Southern California',null,5827817;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01190','The HSU CIRM Bridges  to Stem Cell Research Certificate Program',null,null,'39995', '42551','Bridges','Closed','Humboldt State University',null,3195858;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01162','Type III CIRM Stem Cell Research Training Program',null,null,'40422', '42916','Research Training II','Closed','Sanford Burnham Prebys Medical Discovery Institute',null,2781376;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01192','Bridges to Stem Cell Research at Pasadena City College',null,null,'40057', '42613','Bridges','Closed','Pasadena City College',null,3596922;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01163','UC Davis Stem Cell Training Program',null,null,'40026', '42582','Research Training II','Closed','University of California, Davis',null,4838291;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01193','SDSU/CIRM Stem Cell Internship Program',null,null,'40026', '42582','Bridges','Closed','San Diego State University Foundation',null,4156315;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01164','Interdisciplinary Training in Stem Cell Biology, Engineering and Medicine',null,null,'40179', '42551','Research Training II','Closed','University of California, Berkeley',null,6888557;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01194','SFSU Bridges to Stem Cell Research',null,null,'39965', '42582','Bridges','Closed','San Francisco State University',null,4168243;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN3-06378-1.2','Medical School Loan Repayment Program',null,null,'41426', '43251','New Faculty Physician Scientist','Closed','Reza Ardehali',null,35511;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01165','Training Stem Cell Researchers at the Chemistry-Biology Interface',null,null,'39995', '42551','Research Training II','Closed','Scripps Research Institute',null,3697326;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TB1-01195','San Jose State University Stem Cell Internships for Laboratory-based Learning (SJSU SCILL)',null,null,'39965', '42886','Bridges','Closed','San Jose State University',null,4154051;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('TG2-01168','CHLA Stem Cell Training Grant',null,null,'39995', '42551','Research Training II','Closed','Children's Hospital of Los Angeles',null,5020920;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01012','Development of an hES Cell-Based Assay System for Hepatocyte Differentiation Studies and Predictive Toxicology Drug Screening',null,'Liver Disease, Metabolic Disorders, Toxicity','39904', '40816','Tools and Technologies I','Closed','VistaGen Therapeutics, Inc.','Embryonic Stem Cell',971558;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01103','Development of a novel technology for precise, efficient, and safe genetic modification of stem cells',null,null,'39904', '40633','Tools and Technologies I','Closed','Scripps Research Institute','Embryonic Stem Cell',1138548;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01019','In Vivo Imaging for the Detection and Quantitation of Transplanted Stem/Progenitor Cells in Nonhuman Primates',null,null,'39904', '40999','Tools and Technologies I','Closed','University of California, Davis','Adult Stem Cell',799350;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01107','Generation of disease models for neurodegenerative disorders in hESCs by gene targeting',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','40148', '40877','Tools and Technologies I','Closed','University of California, San Diego','Embryonic Stem Cell',709829;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01021','Directed Evolution of Novel AAV Variants for Enhanced Gene Targeting in Pluripotent Human Stem Cells and Investigation of Dopaminergic Neuron Differentiation',null,'Neurological Disorders, Parkinson's Disease','39904', '40999','Tools and Technologies I','Closed','University of California, Berkeley','Embryonic Stem Cell',918000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01108','The Stem Cell Matrix: a map of the molecular pathways that define pluripotent cells',null,null,'39904', '40694','Tools and Technologies I','Closed','Scripps Research Institute','Embryonic Stem Cell, iPS Cell',1133552;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01022','Microfluidic Platform for Screening Chemically Defined Conditions that Facilitate Clonal Expansion of Human Pluripotent Stem Cells',null,null,'39904', '40633','Tools and Technologies I','Closed','University of California, Los Angeles','Embryonic Stem Cell',914096;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01120','A MULTI-MODALITY  MOLECULAR IMAGING SYSTEM (MRSPECT) FOR IN VIVO STEM CELL TRACKING',null,null,'39873', '40602','Tools and Technologies I','Closed','University of California, Irvine',null,719798;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01024','Scaleup of Versatile, Fully Automated, Microfluidic Cell Culture System',null,null,'39904', '40633','Tools and Technologies I','Closed','Fluidigm Corporation','Embryonic Stem Cell',749518;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01126','Novel Tools and Technologies for Translational PET Imaging of Cell-based Therapies',null,null,'39934', '40663','Tools and Technologies I','Closed','University of California, Los Angeles',null,914039;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01027','A Novel SPECT Microscopy System for 3D Imaging of Single Stem Cells In Vivo',null,null,'39904', '40633','Tools and Technologies I','Closed','Gamma Medica-Ideas, Inc.',null,800065;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01143','Optimization in the Identification, Selection and Induction of Maturation of Subtypes of Cardiomyocytes derived from Human Embryonic Stem Cells',null,'Heart Disease','39904', '40633','Tools and Technologies I','Closed','Vala Sciences, Inc.','Embryonic Stem Cell',870717;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01028','Development of Baculoviral Vectors for Gene Editing of Human Stem Cells',null,null,'39904', '40908','Tools and Technologies I','Closed','University of Southern California','Embryonic Stem Cell',945604;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01052','RNA Analysis by Biosynthetic Tagging (RABT): a tool for the identification of cell type-specific RNAs',null,null,'39904', '40816','Tools and Technologies I','Closed','University of California, Merced','Cancer Stem Cell',481096;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01053','Synthetic Matrices for Stem Cell Growth and Differentiation',null,null,'39904', '40999','Tools and Technologies I','Closed','University of California, Santa Barbara','Embryonic Stem Cell',599404;
"Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01055','Magnetic Particle Imaging: A Novel Ultra-sensitive Imaging Scanner
for Tracking Stem Cells In Vivo',null,null,'39904', '40999','Tools and Technologies I','Closed','University of California, Berkeley','Embryonic Stem Cell',858345;"
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01057','Development of Suspension Adaptation, Scale-up cGMP Banking and Cell Characterization Technologies for hESC Lines',null,null,'39904', '40633','Tools and Technologies I','Closed','City of Hope, Beckman Research Institute','Embryonic Stem Cell',882929;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01063','TAT Cell-Permeable Protein Delivery of siRNAs for Epigenetic Programming of Human Pluripotent and Adult Stem Cells',null,null,'39904', '40633','Tools and Technologies I','Closed','University of California, San Diego','Embryonic Stem Cell',720000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01074','Novel Separation of Stem Cell Subpopulations',null,null,'39873', '40967','Tools and Technologies I','Closed','University of California, Irvine','Adult Stem Cell, Embryonic Stem Cell',861122;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01093','Development of the Theracyte Cellular Encapsulation System for Delivery of human ES Cell-derived Pancreatic Islets and Progenitors.',null,'Diabetes, Metabolic Disorders','39904', '40633','Tools and Technologies I','Closed','ViaCyte, Inc.','Adult Stem Cell, Embryonic Stem Cell',827072;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01095','AO Wide-Field Microscope',null,null,'39965', '40816','Tools and Technologies I','Closed','University of California, Santa Cruz',null,549551;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01001','Regulation of Stem Cell Fate in Bioengineered Arrays of Hydrogel Microwells',null,'Aging, Skeletal/Smooth Muscle disorders, Trauma','39904', '40633','Tools and Technologies I','Closed','Stanford University','Adult Stem Cell',949608;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RT1-01097','Discovery of adhesion ligands for pluripotent human stem cells',null,null,'39873', '40602','Tools and Technologies I','Closed','University of California, Davis','Embryonic Stem Cell, iPS Cell',834003;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99000','Stem Cell Therapies for Pediatric Diseases and Injuries:  A Critial Evaluation',null,'Pediatrics','39797', '39978','Conference','Closed','Children's Hospital of Orange County',null,786;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CG1-99002','Translation of Stem Cell Therapies: Best Practices and Regulatory Considerations',null,null,'39845', '40025','Conference','Closed','Vitalant Research Institute',null,30000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00905','Mechanisms of chromatin dynamics at enhancers during ES cell differentiation',null,null,'39814', '41639','New Faculty II','Closed','Ludwig Institute for Cancer Research','Embryonic Stem Cell',1726564;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00945','A Novel Microenvironment-Mediated Functional Skeletal Muscle from Human Embryonic Stem Cells and their In Vivo Engraftment',null,'Muscular Dystrophy, Skeletal/Smooth Muscle disorders','39814', '42004','New Faculty II','Closed','University of California, San Diego','Embryonic Stem Cell',2300569;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00906','Mechanisms of small RNA regulation in early embryonic development',null,null,'39814', '42004','New Faculty II','Closed','University of California, San Francisco','Embryonic Stem Cell',2790695;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00946','Mechanism of Tissue Engineered Small Intestine Formation',null,'Intestinal Disease, Metabolic Disorders, Pediatrics','39814', '41639','New Faculty II','Closed','Children's Hospital of Los Angeles','Adult Stem Cell',3211122;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00950','Molecular dissection of adult liver regeneration to guide the generation of hepatocytes from pluripotent stem cells',null,'Liver Disease, Metabolic Disorders','39814', '42004','New Faculty II','Closed','University of California, San Francisco','Adult Stem Cell, Embryonic Stem Cell',2832008;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00915','Mechanisms in Choroid Plexus Epithelial Development',null,'Neurological Disorders','39814', '41639','New Faculty II','Closed','University of California, Irvine','Embryonic Stem Cell',2793395;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00952','Defining the Isoform-Specific Effects of Apolipoprotein E on the Development of iPS Cells into Functional Neurons in Vitro and in Vivo',null,'Alzheimer's Disease, Neurological Disorders, Stroke','39845', '41670','New Faculty II','Closed','Gladstone Institutes, J. David','iPS Cell',2757303;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00916','Skeletogenic Neural Crest Cells in Embryonic Development and Adult Regeneration of the Jaw',null,'Bone or Cartilage Disease, Trauma','39845', '41820','New Faculty II','Closed','University of Southern California','Embryonic Stem Cell',2247403;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00908','Regulation of Adult Stem Cell Proliferation by RAS and Cell-Permeable Proteins',null,null,'39814', '41820','New Faculty II','Closed','University of California, San Diego','Embryonic Stem Cell',3017978;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00919','High throughput modeling of human neurodegenerative diseases in embryonic stem cells',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders, Neuropathy','39814', '41639','New Faculty II','Closed','University of California, San Francisco','Embryonic Stem Cell',2259092;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00909','VEGF signaling in adventitial stem cells in vascular physiology and disease',null,'Heart Disease','39814', '41440','New Faculty II','Closed','Stanford University','Adult Stem Cell',3005695;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00921','Building Cardiac Tissue from Stem Cells and Natural Matrices',null,'Heart Disease','39814', '41639','New Faculty II','Closed','University of California, Merced','Embryonic Stem Cell',1656083;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00910','Derivation and Characterization of Myeloproliferative Disorder Stem Cells from Human ES Cells',null,'Blood Cancer, Cancer','39814', '41639','New Faculty II','Closed','University of California, San Diego','Cancer Stem Cell, Embryonic Stem Cell',3065572;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00922','Molecular mechanisms governing hESC and iPS cell self-renewal and pluripotency',null,null,'39814', '42004','New Faculty II','Closed','University of California, Davis','Embryonic Stem Cell, iPS Cell',2157255;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00923','The roles of non-coding RNAs in the self-renewal and differentiation of pluripotent stem cells',null,null,'39814', '42004','New Faculty II','Closed','University of California, Berkeley','Embryonic Stem Cell',1406823;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00931','Molecular Mechanisms of Trophoblast Stem Cell Specification and Self-Renewal',null,'Fertility','39814', '41790','New Faculty II','Closed','University of California, San Diego','Adult Stem Cell, Embryonic Stem Cell',3077918;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00933','Laying the groundwork for building a tooth: analysis of dental epithelial stem cells',null,null,'39814', '41639','New Faculty II','Closed','University of California, San Francisco','Adult Stem Cell, Embryonic Stem Cell',3075251;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00902','Stem Cells for Immune System Regeneration to Fight Cancer',null,'Cancer, Melanoma, Solid Tumors','39814', '41639','New Faculty II','Closed','University of California, Los Angeles','Adult Stem Cell',3072000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00934','Mechanisms Underlying the Responses of Normal and Cancer Stem Cells to Environmental and Therapeutic Insults',null,'Blood Cancer, Cancer, Trauma','39814', '41639','New Faculty II','Closed','University of California, San Francisco',null,2124488;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00903','Induction of cardiogenesis in pluripotent cells via chromatin remodeling factors',null,'Heart Disease','39783', '41501','New Faculty II','Closed','Gladstone Institutes, J. David','Embryonic Stem Cell, iPS Cell',2723653;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00938','Mechanisms Underlying the Diverse Functions of STAT3 in Embryonic Stem Cell Fate Regulation',null,null,'39814', '42004','New Faculty II','Closed','University of Southern California','Embryonic Stem Cell',2261174;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00904','Stem Cells in Lung Cancer',null,'Cancer, Lung Cancer, Respiratory Disorders, Solid Tumors','39814', '42004','New Faculty II','Closed','University of California, Los Angeles','Adult Stem Cell, Cancer Stem Cell',2381572;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00940','The molecular basis underlying adult neurogenesis during regeneration and tissue renewal',null,null,'39814', '42004','New Faculty II','Closed','San Diego State University Foundation',null,1712225;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00652','A CIRM Disease Team for the Treatment and Cure of Diabetes',null,'Diabetes, Metabolic Disorders','39661', '39844','Disease Team Planning','Closed','University of California, San Francisco',null,55000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00704','"Stem Cell Therapies for Heart Failure"',null,'Heart Disease, Heart failure','39661', '39844','Disease Team Planning','Closed','Sanford Burnham Prebys Medical Discovery Institute',null,44450;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00649','Development of Induced Pluripotent Stem Cells for Modeling Human Disease',null,'Amyotrophic Lateral Sclerosis, Autism, Blood Disorders, Neurological Disorders, Pediatrics, Rett's Syndrome','39783', '40877','New Cell Lines','Closed','Salk Institute for Biological Studies','iPS Cell',1737720;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00653','Clinical Regenerative Wound Healing With Stem Cells',null,null,'39661', '39844','Disease Team Planning','Closed','University of Southern California',null,33626;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00708','Genetically-modified neural stem cells for treatment of high-grade glioma',null,'Brain Cancer, Cancer, Solid Tumors','39661', '39844','Disease Team Planning','Closed','City of Hope, Beckman Research Institute',null,55000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00660','Induction of pluripotent stem cells by small RNA-guided transcriptional activation',null,null,'39783', '41243','New Cell Lines','Closed','University of California, San Francisco','iPS Cell',1368461;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00656','A CIRM Disease Team for the Repair of Traumatically Injured and Arthritic Cartilage',null,null,'39661', '39844','Disease Team Planning','Closed','University of California, San Francisco',null,33172;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00709','CIRM Planning Grant in Leukemia',null,null,'39661', '39844','Disease Team Planning','Closed','University of California, San Diego',null,52174;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00662','Derivation and analysis of pluripotent stem cell lines with inherited TGF-b mediated disorders from donated IVF embryos and reprogrammed adult skin fibroblasts',null,'Heart Disease','39753', '40847','New Cell Lines','Closed','Stanford University','Embryonic Stem Cell, iPS Cell',1406636;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00657','Stem cell based treatment strategy for Age-related Macular Degeneration (AMD)',null,'Age-related macular degeneration, Vision Loss','39661', '39844','Disease Team Planning','Closed','University of Southern California',null,3088;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00710','{REDACTED} Cardiovascular Regenerative Team',null,null,'39661', '39903','Disease Team Planning','Closed','Stanford University',null,25119;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00669','Somatic cell age and memory in the generation of iPS cells',null,null,'39753', '41213','New Cell Lines','Closed','University of California, San Francisco','iPS Cell',1307201;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00659','Motor neuron diseases: Finding cures through basic, translational, and clinical collaboration',null,null,'39661', '39903','Disease Team Planning','Closed','Salk Institute for Biological Studies',null,51266;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00669','Development of a Stem Cell Therapy to Promote Functional Recovery in Stroke',null,null,'39661', '39844','Disease Team Planning','Closed','University of California, Los Angeles',null,42748;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00670','Derivation and comparative analysis of human pluripotent ESCs, iPSCs and SSCs: Convergence to an embryonic phenotype',null,'Fertility','39753', '41213','New Cell Lines','Closed','Stanford University','Adult Stem Cell, Embryonic Stem Cell, iPS Cell',1409243;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00671','Pluripotent Stem Cell–Based Therapy for Heart Disease',null,null,'39661', '39844','Disease Team Planning','Closed','Gladstone Institutes, J. David',null,13505;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00642-B','Derivation of New ICM-stage hESCs',null,null,'40634', '41029','New Cell Lines','Closed','Gladstone Institutes, J. David','Embryonic Stem Cell, iPS Cell, Other',778859;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00672','Development of a Cell Replacement Therapy Product for Insulin Dependent Diabetes',null,null,'39661', '39844','Disease Team Planning','Closed','ViaCyte, Inc.',null,48950;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00678','New Cell Lines for Huntington's Disease',null,'Huntington's Disease, Neurological Disorders','39814', '40908','New Cell Lines','Closed','University of California, Irvine','Embryonic Stem Cell, iPS Cell',1302526;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00675','Human Stem Cell Approaches to Alzheimers Disease Therapies',null,null,'39661', '39844','Disease Team Planning','Closed','University of California, San Diego',null,55000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00681','Generation of clinical grade human iPS cells',null,'Amyotrophic Lateral Sclerosis, Cancer, Melanoma, Muscular Dystrophy, Neurological Disorders, Skeletal/Smooth Muscle disorders, Solid Tumors','39753', '40847','New Cell Lines','Closed','University of California, Los Angeles','iPS Cell',1341000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00642-A','Derivation of New ICM-stage hESCs',null,null,'39934', '40633','New Cell Lines','Closed','Scripps Research Institute','Embryonic Stem Cell, iPS Cell, Other',936973;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00683','Stem Cell Therapy for AIDS- Disease Team Planning',null,null,'39661', '39844','Disease Team Planning','Closed','University of California, Los Angeles',null,51490;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00682','Derivation of Parkinson's Disease Coded-Stem Cells (PD-SCs)',null,'Neurological Disorders, Parkinson's Disease','39873', '41333','New Cell Lines','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell, iPS Cell',1556448;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00688','Develop a cell replacement therapy for Parkinson's disease using human embryonic stem cells',null,null,'39661', '39844','Disease Team Planning','Closed','Buck Institute for Age Research',null,37161;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00630','Derivation of hESC Lines with Disease Lesions',null,'Genetic Disorder','39753', '41090','New Cell Lines','Closed','Stanford University','Embryonic Stem Cell',1404725;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00690','Stem cells for neuroprotection of photoreceptors in retinitis pigmentosa',null,null,'39661', '39844','Disease Team Planning','Closed','University of California, Irvine',null,23537;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00634','Safe, efficient creation of human induced pluripotent stem cells without the use of retroviruses',null,'Immune Disease','39753', '40847','New Cell Lines','Closed','Stanford University','iPS Cell',1406875;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00696','Stem Cell-Mediated Oncocidal Therapy of Primary & Metastatic Brain Tumors',null,null,'39661', '39844','Disease Team Planning','Closed','Ludwig Institute for Cancer Research',null,3867;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00636','Generation of Pluripotent Cell Lines from Human Embryos',null,'Genetic Disorder, Pediatrics','39753', '41213','New Cell Lines','Closed','University of California, Los Angeles','Embryonic Stem Cell',1168501;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00667','New Technology for the Derivation of Human Pluripotent Stem Cell Lines for Clinical Use',null,null,'39873', '40968','New Cell Lines','Closed','University of Southern California','Embryonic Stem Cell, iPS Cell, Other',1266134;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00697','CIRM Disease Team Planning Award',null,null,'39661', '39844','Disease Team Planning','Closed','Children's Hospital of Oakland Research Institute',null,16939;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00639','Induced Pluripotent Stem Cells for Cardiovascular Diagnostics',null,'Heart Disease, Toxicity','39845', '41029','New Cell Lines','Closed','Gladstone Institutes, J. David','iPS Cell',1708560;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00698','{REDACTED} Heart Disease Regenerative Medicine Team Planning Award',null,'Heart Disease','39661', '39844','Disease Team Planning','Closed','Cedars-Sinai Medical Center',null,38980;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00644','Protein transduction of transcription factors: a non-genetic approach to generate new pluripotent cell lines from human skin.',null,null,'39753', '40847','New Cell Lines','Closed','University of California, San Diego','iPS Cell',1073585;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00700','Huntington's Disease Team',null,'Huntington's Disease, Neurological Disorders','39661', '39844','Disease Team Planning','Closed','University of California, Irvine',null,41953;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00648','Optimization of Human Embryonic Stem Cell Derivation Techniques and Production/Distribution of GMP-Grade Lines',null,null,'39753', '41213','New Cell Lines','Closed','University of California, San Francisco','Embryonic Stem Cell',1383419;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('DT1-00701','STEM CELL GENE THERAPY FOR SICKLE CELL DISEASE',null,'Blood Disorders, Sickle Cell Disease','39661', '39844','Disease Team Planning','Closed','Children's Hospital of Los Angeles',null,12131;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RL1-00650','Establishment of Frontotemporal Dementia Patient-Specific Induced Pluripotent Stem (iPS) Cell Lines with Defined Genetic Mutations',null,'Dementia, Neurological Disorders','39845', '40939','New Cell Lines','Closed','Gladstone Institutes, J. David','iPS Cell',1696424;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00600','CIRM Center of Excellence at Buck Institute for Age Research',null,null,'40269', '40999','Major Facilities','Closed','Buck Institute for Age Research',null,20500000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00607','Sanford Consortium for Regenerative Medicine',null,null,'39703', '40705','Major Facilities','Closed','Sanford Consortium for Regenerative Medicine',null,42827439;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00609','Stanford SIM1 Building',null,null,'39619', '40543','Major Facilities','Closed','Stanford University',null,43578000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00610','UC Berkeley CIRM Center of Excellence',null,null,'39619', '40968','Major Facilities','Closed','University of California, Berkeley',null,20183500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00611','UC Davis CIRM Institute',null,null,'39619', '40543','Major Facilities','Closed','University of California, Davis',null,20082400;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00612','UC Irvine CIRM Institute',null,null,'39619', '40359','Major Facilities','Closed','University of California, Irvine',null,27156000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00613','UCLA CIRM Institute',null,null,'39619', '40543','Major Facilities','Closed','University of California, Los Angeles',null,19854900;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00614','Stem Cell Instrumentation Foundry',null,null,'39995', '40543','Major Facilities','Closed','University of California, Merced',null,4341321;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00616','UC Santa Barbara Bio Sciences II',null,null,'39619', '41090','Major Facilities','Closed','University of California, Santa Barbara',null,3205800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00617','UC Santa Cruz IBSC Facility',null,null,'39703', '41274','Major Facilities','Closed','University of California, Santa Cruz',null,7191950;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00618','UCSF CIRM Building',null,null,'39619', '40359','Major Facilities','Closed','University of California, San Francisco',null,34862400;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('FA1-00619','Broad CIRM Facility at USC',null,null,'39619', '40724','Major Facilities','Closed','University of Southern California',null,26972500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN2-00908-1.2','Medical School Loan Repayment Program',null,null,'39814', '41820','New Faculty II','Closed','Benjamin D. Yu',null,28388;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00562-1.2','Medical School Loan Repayment Program',null,null,'39630', '41820','New Faculty I','Closed','Mohammad Pashmforoush',null,27949;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00538-B','ES-Derived Cells for the Treatment of Alzheimer's Disease',null,'Aging, Alzheimer's Disease, Neurological Disorders','40238', '41517','New Faculty I','Closed','Western University of Health Sciences','Embryonic Stem Cell',1401642;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00540','Mechanisms of Stem Cell Fate Decisions',null,null,'39508', '41517','New Faculty I','Closed','University of California, Santa Cruz',null,2201759;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00544-B','Characterization of mechanisms regulating de-differentiation and the re-acquisition of stem cell identity',null,null,'41275', '41729','New Faculty I','Closed','University of California, Los Angeles','Embryonic Stem Cell',382773;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00550','Epigenetics in cancer stem cell initiation and clinical outcome prediction',null,'Cancer, Solid Tumors','39630', '41455','New Faculty I','Closed','University of California, Los Angeles','Embryonic Stem Cell',3063450;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00554','Enhancing Survival of Embryonic Stem Cell-Derived Grafts by Induction of Immunological Tolerance',null,null,'39600', '41425','New Faculty I','Closed','University of California, Merced','Embryonic Stem Cell',1576389;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00557','Mechanisms of Hematopoietic stem cell Specification and Self-Renewal',null,'Anemia, Blood Cancer, Blood Disorders, Cancer','39539', '41364','New Faculty I','Closed','University of California, Los Angeles','Adult Stem Cell, Embryonic Stem Cell',2286900;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00561','Combinatorial Chemistry Approaches to Develop LIgands against Leukemia Stem Cells',null,'Blood Cancer, Cancer','39508', '41517','New Faculty I','Closed','University of California, Davis','Adult Stem Cell, Cancer Stem Cell',2386409;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00562','Transcriptional Regulation of Cardiac Pacemaker Cell Progenitors',null,'Heart Disease','39630', '41820','New Faculty I','Closed','University of Southern California','Embryonic Stem Cell',2816578;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00564','In vitro reprogramming of mouse and human somatic cells to an embryonic state',null,'Neurological Disorders, Rett's Syndrome','39600', '41425','New Faculty I','Closed','University of California, Los Angeles','iPS Cell',2229427;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00566','A Novel Engineered Niche to Explore the Vasculogenic Potential of Embryonic Stem Cells',null,'Heart Disease','39600', '39994','New Faculty I','Closed','University of California, Irvine','Adult Stem Cell, Embryonic Stem Cell',395764;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00525','Skeletal muscle development from hESC and its in vivo applications in animal models of muscular dystrophy',null,'Muscular Dystrophy, Skeletal/Smooth Muscle disorders','39569', '40025','New Faculty I','Closed','City of Hope, Beckman Research Institute','Embryonic Stem Cell',131840;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00572','Oral and Craniofacial Reconstruction Using Mesenchymal Stem Cells',null,'Bone or Cartilage Disease','39508', '41517','New Faculty I','Closed','University of Southern California','Adult Stem Cell',3242651;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00536-A','Reprogramming of human somatic cells back to pluripotent embryonic stem cells',null,null,'39569', '40633','New Faculty I','Closed','Scripps Research Institute','Embryonic Stem Cell, iPS Cell',1393876;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00527','Molecular mechanisms involved in adult neural stem cell maintenance',null,'Aging, Neurological Disorders','39508', '41333','New Faculty I','Closed','Stanford University','Adult Stem Cell, Embryonic Stem Cell',2348435;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00575','Genetic dissection of mesodermal commitment to the hematopoietic fates.',null,null,'39539', '41364','New Faculty I','Closed','University of California, San Diego',null,2150620;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00538-A','ES-Derived Cells for the Treatment of Alzheimer's Disease',null,'Aging, Alzheimer's Disease, Neurological Disorders','39508', '41333','New Faculty I','Closed','University of California, Riverside','Embryonic Stem Cell',621639;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00529','Noncoding RNAs in Cell Fate Determination',null,null,'39600', '41425','New Faculty I','Closed','Stanford University','Embryonic Stem Cell',2985894;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00577','Genetic Encoding Novel Amino Acids in Embryonic Stem Cells for Molecular Understanding of Differentiation to Dopamine Neurons',null,'Neurological Disorders, Parkinson's Disease','39539', '41517','New Faculty I','Closed','Salk Institute for Biological Studies',null,2587742;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00544-A','Characterization of mechanisms regulating de-differentiation and the re-acquisition of stem cell identity',null,null,'39539', '41274','New Faculty I','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell',2134100;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00530','Molecular mechanisms of neural stem cell differentiation in the developing brain',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','39508', '41698','New Faculty I','Closed','University of California, Santa Cruz','Adult Stem Cell',2147592;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00579','Trithorax and Polycomb methyltransferase complexes in cell fate determination.',null,null,'39539', '41364','New Faculty I','Closed','Stanford University','Embryonic Stem Cell',2373903;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00584','Generating pluripotent cell lines from neurons.',null,null,'39569', '41394','New Faculty I','Closed','Scripps Research Institute',null,2786560;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00532','Identification of hESC-mediated molecular mechanism that positively regulates the regenerative capacity of post-natal tissues',null,'Aging, Muscular Dystrophy, Pediatrics, Skeletal/Smooth Muscle disorders, Trauma','39508', '41486','New Faculty I','Closed','University of California, Berkeley','Embryonic Stem Cell',2246020;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00535','Bioengineering technology for fast optical control of differentiation and function in stem cells and stem cell progeny',null,null,'39661', '41152','New Faculty I','Closed','Stanford University','Embryonic Stem Cell',2424209;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00536-B','Reprogramming of human somatic cells back to pluripotent embryonic stem cells',null,null,'40634', '41364','New Faculty I','Closed','Gladstone Institutes, J. David','Embryonic Stem Cell, iPS Cell',1320101;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00502-1.2','TSRI Center for hESC Research',null,null,'39814', '42004','Shared Labs','Closed','Scripps Research Institute','Embryonic Stem Cell, iPS Cell',3725070;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00511-1.1','Collaborative Laboratory for Human Embryonic Stem Cell Research at Sanford-Burnham Medical Research Institute',null,null,'39329', '40059','Shared Labs','Closed','Sanford Burnham Prebys Medical Discovery Institute',null,1361825;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00504-1.2','UC Davis Translational Human Embryonic Stem Cell Shared Research Facility',null,null,'40118', '42674','Shared Labs','Closed','University of California, Davis','Embryonic Stem Cell, iPS Cell',1728111;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00514-1.1','The Gladstone CIRM Shared Human Embryonic Stem Cell Core Laboratory',null,null,'39297', '40027','Shared Labs','Closed','Gladstone Institutes, J. David',null,842672;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00505-1.2','CIRM Shared Research Laboratories',null,null,'40210', '42400','Shared Labs','Closed','University of California, Los Angeles','Embryonic Stem Cell, iPS Cell',1751297;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00518-1.1','The Stanford University Center for Human Embryonic Stem Cell Research and Education',null,null,'39326', '40056','Shared Labs','Closed','Stanford University',null,2439590;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00506-1.2','UCSC Shared Stem Cell Facility',null,null,'39873', '42429','Shared Labs','Closed','University of California, Santa Cruz','Embryonic Stem Cell, iPS Cell',1719722;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00519-1.1','The Berkeley Human Embryonic Stem Cell Shared Research Laboratory',null,null,'39315', '40045','Shared Labs','Closed','University of California, Berkeley',null,1227659;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00507-1.2','The Childrens Hospital of Los Angeles hESC Facility',null,null,'40057', '42613','Shared Labs','Closed','Children's Hospital of Los Angeles','Embryonic Stem Cell, iPS Cell',1750259;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00520-1.1','The University of California: Irvine Regional Human Embryonic Stem Cell Shared Research Laboratory and Stem Cell Techniques Course',null,null,'39315', '40044','Shared Labs','Closed','University of California, Irvine',null,2107376;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00508-1.2','A Stem Cell Core Facility for Studying Human Embryonic Stem Cell Differentiation',null,null,'40026', '42582','Shared Labs','Closed','University of California, Riverside','Embryonic Stem Cell, iPS Cell',1663284;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00521-1.1','The UCSB Laboratory for Stem Cell Biology and Engineering',null,null,'39339', '40434','Shared Labs','Closed','University of California, Santa Barbara',null,1407192;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00511-1.2','Collaborative Laboratory for Human Embryonic Stem Cell Research at Sanford-Burnham Medical Research Institute',null,null,'39845', '42035','Shared Labs','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell, iPS Cell',1805884;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00522-1.1','Enhancing Facilities for Genetic Manipulation and Engineering of Human Embryonic Stem Cells at UCSD',null,null,'39339', '40069','Shared Labs','Closed','University of California, San Diego',null,1728080;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00514-1.2','The Gladstone CIRM Shared Human Embryonic Stem Cell Core Laboratory',null,null,'39448', '42004','Shared Labs','Closed','Gladstone Institutes, J. David',null,1698515;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00523-1.1','The University of California San Francisco Shared Research and Teaching Laboratory: a Non-Federal Human Embryonic Stem Cell Resource for the Bay Area Community',null,null,'39380', '40475','Shared Labs','Closed','University of California, San Francisco',null,2144758;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00518-1.2','The Stanford University Center for Human Embryonic Stem Cell Research and Education',null,null,'39326', '42063','Shared Labs','Closed','Stanford University','Adult Stem Cell, Embryonic Stem Cell, iPS Cell',3434600;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00500-1.1','Shared viral vector facility for genetic manipulation of huamn ES cell',null,null,'39297', '40027','Shared Labs','Closed','Salk Institute for Biological Studies',null,1478923;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00524-1.1','USC Center for Stem Cell and Regenerative Medicine: Shared Research Laboratory and Course in Current Protocols in Human Embryonic Stem Cell Research',null,null,'39315', '40045','Shared Labs','Closed','University of Southern California',null,1724015;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00519-1.2','The Berkeley Human Embryonic Stem Cell Shared Research Laboratory',null,null,'40179', '42551','Shared Labs','Closed','University of California, Berkeley',null,1673221;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00501-1.1','North Bay CIRM Shared Research Laboratory for Stem Cells and Aging',null,null,'39385', '40115','Shared Labs','Closed','Buck Institute for Age Research',null,2414749;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00520-1.2','The University of California: Irvine Regional Human Embryonic Stem Cell Shared Research Laboratory and Stem Cell Techniques Course',null,null,'39934', '42308','Shared Labs','Closed','University of California, Irvine','Embryonic Stem Cell, iPS Cell',3072500;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00502-1.1','TSRI Center for hESC Research',null,null,'39297', '40027','Shared Labs','Closed','Scripps Research Institute',null,1440164;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00521-1.2','The UCSB Laboratory for Stem Cell Biology and Engineering',null,null,'40087', '42643','Shared Labs','Closed','University of California, Santa Barbara','Adult Stem Cell, Embryonic Stem Cell, iPS Cell',1638357;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00504-1.1','UC Davis Translational Human Embryonic Stem Cell Shared Research Facility',null,null,'39339', '40069','Shared Labs','Closed','University of California, Davis',null,2000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00522-1.2','Enhancing Facilities for Genetic Manipulation and Engineering of Human Embryonic Stem Cells at UCSD',null,null,'39753', '41943','Shared Labs','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1737133;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00505-1.1','CIRM Shared Research Laboratories',null,null,'39329', '40421','Shared Labs','Closed','University of California, Los Angeles',null,2000000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00523-1.2','The University of California San Francisco Shared Research and Teaching Laboratory: a Non-Federal Human Embryonic Stem Cell Resource for the Bay Area Community',null,null,'39965', '42155','Shared Labs','Closed','University of California, San Francisco','Embryonic Stem Cell, iPS Cell',3289649;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00506-1.1','UCSC Shared Stem Cell Facility',null,null,'39310', '40405','Shared Labs','Closed','University of California, Santa Cruz',null,1849452;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00500-1.2','Shared viral vector facility for genetic manipulation of huamn ES cell',null,null,'39401', '42094','Shared Labs','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell, iPS Cell',1844315;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00524-1.2','USC Center for Stem Cell and Regenerative Medicine: Shared Research Laboratory and Course in Current Protocols in Human Embryonic Stem Cell Research',null,null,'39995', '42551','Shared Labs','Closed','University of Southern California','Embryonic Stem Cell, iPS Cell',3411861;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00507-1.1','The Childrens Hospital of Los Angeles hESC Facility',null,null,'39329', '40424','Shared Labs','Closed','Children's Hospital of Los Angeles',null,1684648;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00501-1.2','North Bay CIRM Shared Research Laboratory for Stem Cells and Aging',null,'Neurological Disorders','39630', '41973','Shared Labs','Closed','Buck Institute for Age Research','Embryonic Stem Cell, iPS Cell',3478933;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('CL1-00508-1.1','A Stem Cell Core Facility for Studying Human Embryonic Stem Cell Differentiation',null,null,'39339', '40069','Shared Labs','Closed','University of California, Riverside',null,1976931;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00125','MEF2C-Directed Neurogenesis From Human Embryonic Stem Cells',null,'Neurological Disorders, Parkinson's Disease, Stroke','39356', '41029','Comprehensive Grant','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell',2832000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00149','Human Embryonic Stem Cell Therapeutic Strategies to Target HIV Disease',null,'HIV/AIDS, Immune Disease, Infectious Disease','39295', '40939','Comprehensive Grant','Closed','University of California, Los Angeles','Embryonic Stem Cell',2401903;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00354','Prospective isolation of hESC-derived hematopoietic and cardiomyocyte stem cells',null,'Blood Disorders, Heart Disease, Immune Disease','39264', '40724','Comprehensive Grant','Closed','Stanford University','Embryonic Stem Cell',2471386;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00151','Engineering a Cardiovascular Tissue Graft from Human Embryonic Stem Cells',null,'Heart Disease','39264', '40724','Comprehensive Grant','Closed','Stanford University','Embryonic Stem Cell',2454490;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00110','Improved hES Cell Growth and Differentiation',null,null,'39295', '40939','Comprehensive Grant','Closed','University of California, Irvine','Embryonic Stem Cell',2381713;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00345','hESC-Derived Motor Neurons For the Treatment of Cervical Spinal Cord Injury',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders, Spinal Cord Injury, Spinal Muscular Atrophy','39295', '40755','Comprehensive Grant','Closed','University of California, Irvine','Embryonic Stem Cell',2158445;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00347','Understanding hESC-based Hematopoiesis for Therapeutic Benefit',null,null,'39295', '40755','Comprehensive Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',2460822;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00346','Derivation of Inhibitory Nerve Cells from Human Embryonic Stem Cells',null,'Epilepsy, Neurological Disorders','39295', '40755','Comprehensive Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',2410874;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00353','The Dangers of Mitochondrial DNA Heteroplasmy in Stem Cells Created by Therapeutic Cloning',null,null,'39295', '40359','Comprehensive Grant','Closed','University of California, Irvine','Embryonic Stem Cell, Other',1790133;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00137','Human oocyte development for genetic, pharmacological and reprogramming applications',null,'Fertility','39295', '41121','Comprehensive Grant','Closed','Stanford University','Embryonic Stem Cell',2298411;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00108-B','Regulated Expansion of Lympho-hematopoietic Stem and Progenitor Cells from Human Embryonic Stem Cells (hESC)',null,null,'39845', '40877','Comprehensive Grant','Closed','University of California, Los Angeles','Embryonic Stem Cell',1653416;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00142','microRNA Regulation of Cardiomyocyte Differentiation from Human Embryonic Stem Cells',null,'Heart Disease','39295', '40755','Comprehensive Grant','Closed','Gladstone Institutes, J. David','Embryonic Stem Cell',2994719;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00108-A','Regulated Expansion of Lympho-hematopoietic Stem and Progenitor Cells from Human Embryonic Stem Cells (hESC)',null,null,'39295', '39844','Comprehensive Grant','Closed','Children's Hospital of Los Angeles','Embryonic Stem Cell',575994;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00359','An in vitro and in vivo comparison among three different human hepatic stem cell populations.',null,'Liver Disease, Metabolic Disorders','39356', '40816','Comprehensive Grant','Closed','University of California, Davis','Adult Stem Cell, Embryonic Stem Cell',2251223;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00111','Epigenetic gene regulation during the differentiation of human embryonic stem cells: Impact on neural repair',null,'Neurological Disorders, Stroke','39295', '40755','Comprehensive Grant','Closed','University of California, Los Angeles','Embryonic Stem Cell, iPS Cell',2412995;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00119','Generation of inner ear sensory cells from human ES cells toward a cure for deafness',null,'Hearing Loss','39264', '40724','Comprehensive Grant','Closed','Stanford University','Embryonic Stem Cell',2330371;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00113','Constructing a fate map of the human embryo',null,null,'39295', '41121','Comprehensive Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',2430487;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00124','Embryonic Stem Cell-Derived Therapies Targeting Cardiac Ischemic Disease',null,'Heart Disease','39295', '40877','Comprehensive Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',2424353;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00115','Molecular and Cellular Transitions from ES Cells to Mature Functioning Human Neurons',null,'Amyotrophic Lateral Sclerosis, Genetic Disorder, Neurological Disorders, Parkinson's Disease','39356', '40816','Comprehensive Grant','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell',2749293;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00133','Guiding the developmental program of human embryonic stem cells by isolated Wnt factors',null,null,'39264', '40724','Comprehensive Grant','Closed','Stanford University','Embryonic Stem Cell',1710462;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00116','Using Human Embryonic Stem Cells  to Understand and to Develop New Therapies for Alzheimer's Disease',null,'Aging, Alzheimer's Disease, Genetic Disorder, Neurological Disorders','39295', '40755','Comprehensive Grant','Closed','University of California, San Diego','Embryonic Stem Cell, iPS Cell',1859414;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00144','Preclinical Model for Labeling, Transplant, and In Vivo Imaging of Differentiated Human Embryonic Stem Cells',null,'Kidney Disease','39295', '41121','Comprehensive Grant','Closed','University of California, Davis','Embryonic Stem Cell',2166757;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00131','Spinal ischemic paraplegia: modulation by human embryonic stem cell implant.',null,'Neurological Disorders, Spinal Cord Injury','39295', '40755','Comprehensive Grant','Closed','University of California, San Diego','Embryonic Stem Cell',2356090;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00148','Mechanisms to maintain the self-renewal and genetic stability of human embryonic stem cells',null,'Cancer, Genetic Disorder','39295', '40755','Comprehensive Grant','Closed','University of California, San Diego','Embryonic Stem Cell',2467200;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00132','Chemical Genetic Approach to Production of hESC-derived Cardiomyocytes',null,'Heart Disease','39356', '40816','Comprehensive Grant','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell',2832000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00100','Functional Genomic Analysis of Chemically Defined Human Embryonic Stem Cells',null,'Genetic Disorder, Muscular Dystrophy, Pediatrics, Skeletal/Smooth Muscle disorders','39264', '40724','Comprehensive Grant','Closed','Stanford University','Embryonic Stem Cell',2518303;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00104','Modeling Myocardial Therapy with Human Embryonic Stem Cells',null,'Heart Disease','39295', '40755','Comprehensive Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',2134694;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00134','Immunology of neural stem cell fate and function',null,'Trauma','39264', '40908','Comprehensive Grant','Closed','Stanford University','Adult Stem Cell, Embryonic Stem Cell',2396000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RC1-00135','Human stem cell derived oligodendrocytes for treatment of stroke and MS',null,'Immune Disease, Multiple Sclerosis, Neurological Disorders, Stroke','39295', '40939','Comprehensive Grant','Closed','University of California, San Francisco','Adult Stem Cell, Embryonic Stem Cell',2459235;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00402','Down-Regulation of Alloreactive Immune Responses to hES Cell-Derived Graft Tissues',null,null,'39356', '40086','SEED Grant','Closed','University of California, Los Angeles','Embryonic Stem Cell',399239;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00313','Role of Mitochondria in Self-Renewal Versus Differentiation of Human Embryonic Stem Cells',null,null,'39295', '40025','SEED Grant','Closed','University of California, Los Angeles','Embryonic Stem Cell',543274;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00174','A method to maintain and propagate pluripotent human ES cells',null,null,'39356', '40086','SEED Grant','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell',760042;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00289','Stem Cell Survival and Differentiation Through Chemical Genetics',null,null,'39295', '40390','SEED Grant','Closed','University of California, Riverside','Embryonic Stem Cell',522933;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00381','Labeling of human embryonic stem cells with iron oxide nanoparticles and fluorescent dyes for a non-invasive cell depiction with MR imaging and optical imaging',null,null,'39295', '40025','SEED Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',240214;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00319','Reprogramming Differentiated Human Cells to a Pluripotent State',null,null,'39295', '40025','SEED Grant','Closed','Stanford University','Embryonic Stem Cell, iPS Cell',380005;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00193','Retinoic Acid-FGF Antagonism during Motor Neuron Differentiation of Human ES Cells',null,null,'39356', '40086','SEED Grant','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell',695229;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00171','Development of Neuro-Coupled  Human Embryonic Stem Cell-Derived Cardiac Pacemaker Cells.',null,'Heart Disease','39356', '40451','SEED Grant','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell',695680;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00203','Genetic Enhancement of the Immune Response to Melanoma via hESC-derived T cells',null,'Cancer, Melanoma, Solid Tumors','39295', '40147','SEED Grant','Closed','University of California, Los Angeles','Embryonic Stem Cell',616800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00321','Embryonic stem cell-derived thymic epithelial cells',null,'Immune Disease','39264', '39994','SEED Grant','Closed','Stanford University','Embryonic Stem Cell',628793;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00331','Modeling Parkinson's Disease Using Human Embryonic Stem Cells',null,'Neurological Disorders, Parkinson's Disease','39356', '40086','SEED Grant','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell',701060;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00292','Mapping the transcriptional regulatory elements in the genome of hESC',null,null,'39479', '40390','SEED Grant','Closed','Ludwig Institute for Cancer Research','Embryonic Stem Cell',653823;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00428','Sources of Genetic Instability in Human Embryonic Stem Cells.',null,'Cancer','39448', '40178','SEED Grant','Closed','City of Hope, Beckman Research Institute','Embryonic Stem Cell',327311;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00322','In Vivo Imaging of Human Embryonic Stem Cell Derivatives and Tumorigenicity',null,null,'39448', '40178','SEED Grant','Closed','Stanford University','Embryonic Stem Cell',623634;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00262','Regulation of human neural progenitor cell proliferation by Ryk-mediated Wnt signaling',null,null,'39448', '40359','SEED Grant','Closed','University of Southern California','Embryonic Stem Cell',624000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00295','In Vitro Differentiation of T cells from Human Embryonic Stem Cells.',null,null,'39264', '40359','SEED Grant','Closed','University of California, Berkeley','Embryonic Stem Cell',477894;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00434','Transcriptional Regulation of Human Embryonic Stem Cells',null,null,'39356', '40451','SEED Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',595755;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00323','Role of Chromatin Modifiers in Regulating Human Embryonic Stem Cell Pluripotency',null,null,'39264', '39994','SEED Grant','Closed','Stanford University','Embryonic Stem Cell',629952;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00249','hESC as tools to investigate the neural crest origin of Ewing's sarcoma',null,'Cancer, Pediatrics, Solid Tumors','39295', '40025','SEED Grant','Closed','Children's Hospital of Los Angeles','Embryonic Stem Cell',595576;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00183','EC regeneration in cerebrovascular ischemia: role of NO',null,'Vascular Disease','39264', '39629','SEED Grant','Closed','Stanford University','Embryonic Stem Cell',476995;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00170','In vitro differentiation of hESCs into corticospinal motor neurons',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders','39295', '40390','SEED Grant','Closed','University of California, Santa Cruz','Embryonic Stem Cell',465624;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00210','The APOBEC3 Gene Family as Guardians of Genome Stability in Human Embryonic Stem Cells',null,'Cancer','39295', '40025','SEED Grant','Closed','Gladstone Institutes, J. David','Embryonic Stem Cell',717363;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00199','Assessing the role of Eph/ephrin signaling in hESC growth and differentiation',null,null,'39295', '40390','SEED Grant','Closed','University of California, Santa Cruz','Embryonic Stem Cell',474161;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00239-A','Micro Platform for Controlled Cardiac Myocyte Differentiation',null,'Heart Disease','39295', '39994','SEED Grant','Closed','University of California, Merced','Embryonic Stem Cell',193700;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00317','Role of HDAC in human stem cells pluripotentiality and differentiation',null,null,'39295', '39933','SEED Grant','Closed','Gladstone Institutes, J. David','Embryonic Stem Cell',590997;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00444','Role of the tumor suppressor gene, p16INK4a, in regulating stem cell phenotypes in embryonic stem cells and human epithelial cells.',null,'Cancer','39295', '40390','SEED Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',614784;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00326','In Vivo Molecular Magnetic Resonance Imaging of Human Embryonic Stem Cells in Murine Model of Myocardial Infarction',null,'Heart Disease','39264', '40359','SEED Grant','Closed','Stanford University','Embryonic Stem Cell',629952;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00259','Modeling Human Embryonic Development with Human Embryonic Stem Cells',null,null,'39295', '40025','SEED Grant','Closed','University of California, Los Angeles','Embryonic Stem Cell, iPS Cell',528096;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00198','Specification of Ventricular Myocyte and Pacemaker Lineages Utilizing Human Embryonic Stem Cells',null,'Heart Disease','39264', '39994','SEED Grant','Closed','University of California, San Diego','Embryonic Stem Cell',585600;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00215','Identifying small molecules that stimulate the differentiation of hESCs into dopamine-producing neurons',null,'Neurological Disorders, Parkinson's Disease','39264', '39994','SEED Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',542619;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00449','Force, Dimensionality and Stem Cell Fate',null,null,'39295', '40025','SEED Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',529762;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00205','Generation of forebrain neurons from human embryonic stem cells',null,'Aging, Alzheimer's Disease, Neurological Disorders','39264', '39994','SEED Grant','Closed','University of California, San Diego','Embryonic Stem Cell',587591;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00225','New Chemokine-Derived Therapeutics Targeting Stem Cell Migration',null,'Neurological Disorders, Spinal Cord Injury, Stroke, Trauma','39356', '40086','SEED Grant','Closed','Sanford Burnham Prebys Medical Discovery Institute','Adult Stem Cell, Embryonic Stem Cell',708000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00333','Genetic manipulation of human embryonic stem cells and its application in studying CNS development and repair',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders, Spinal Cord Injury','39264', '40359','SEED Grant','Closed','University of California, San Diego','Embryonic Stem Cell',600441;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00222','Therapeutic potential of Retinal Pigment Epithelial cell lines derived from hES cells for retinal degeneration.',null,'Aging, Vision Loss','39264', '39994','SEED Grant','Closed','University of Southern California','Embryonic Stem Cell',651607;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00466','Analysis of Candidate Neural Crest Cells Derived from Human ES Cells',null,null,'39356', '40086','SEED Grant','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell',703684;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00377','The Immunological Niche: Effect of immunosuppressant drugs on stem cell proliferation, gene expression, and differentiation in a model of spinal cord injury.',null,'Neurological Disorders, Spinal Cord Injury','39417', '40147','SEED Grant','Closed','University of California, Irvine','Adult Stem Cell, Embryonic Stem Cell',595345;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00236','Novel vectors for gene transfer into human ES cells',null,null,'39264', '39994','SEED Grant','Closed','Stanford University','Embryonic Stem Cell',574737;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00365','Profiling surface glycans and glycoprotein expression of human embryonic stem cells',null,null,'39295', '40390','SEED Grant','Closed','University of California, Berkeley','Embryonic Stem Cell',444847;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00239-B','Micro Platform for Controlled Cardiac Myocyte Differentiation',null,'Heart Disease','39995', '40359','SEED Grant','Closed','University of California, Irvine','Embryonic Stem Cell',156426;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00195','Regulation of Specific Chromosomal Boundary Elements by CTCF Protein Complexes in Human Embryonic Stem Cells',null,null,'39417', '40147','SEED Grant','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell',647343;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00200','Role of Glycans in Human Embryonic Stem Cell Conversion to Neural Precursor Cells',null,null,'39356', '40451','SEED Grant','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell',708000;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00298','Functions of RB family proteins in human embryonic stem cells',null,'Cancer','39264', '40086','SEED Grant','Closed','Stanford University','Embryonic Stem Cell',498609;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00242','Technology for hESC-Derived Cardiomyocyte Differentiation and Optimization of Graft-Host Integration in Adult Myocardium',null,'Heart Disease','39264', '40209','SEED Grant','Closed','Stanford University','Embryonic Stem Cell',572891;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00477','Non-coding RNA as tool for the active control of stem cell differentiation',null,null,'39295', '40390','SEED Grant','Closed','University of California, Riverside','Embryonic Stem Cell',571650;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00228','Derivation and Characterization of Cancer Stem Cells from Human ES Cells',null,'Blood Cancer, Cancer','39295', '40025','SEED Grant','Closed','University of California, San Diego','Cancer Stem Cell, Embryonic Stem Cell',616305;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00404','Patient-specific cells with nuclear transfer',null,null,'39479', '40329','SEED Grant','Closed','Stanford University','Embryonic Stem Cell, SCNT',629653;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00327','Self-renewal of human embryonic stem cells',null,null,'39264', '39994','SEED Grant','Closed','University of Southern California','Embryonic Stem Cell',621421;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00302','A Chemical Approach to Stem Cell Biology',null,null,'39448', '40178','SEED Grant','Closed','Scripps Research Institute','Embryonic Stem Cell',748944;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00243','Differentiation of Human Embryonic Stem Cells to Intestinal Fates',null,'Intestinal Disease, Metabolic Disorders, Pediatrics, Trauma','39264', '39994','SEED Grant','Closed','Stanford University','Embryonic Stem Cell',554176;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00452','Induction of pluripotency in fibroblasts by fusion with enucleated human embryonic stem cell syncytia',null,null,'39264', '39994','SEED Grant','Closed','University of California, San Francisco','Other',329245;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00420','Improving microenvironments to promote hematopoietic stem cell development from human embryonic stem cells',null,'Blood Disorders','39356', '40268','SEED Grant','Closed','University of California, Los Angeles','Embryonic Stem Cell',550241;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00408','Screening for Oncogenic Epigenetic Alterations in Human ES Cells',null,'Cancer','39264', '40359','SEED Grant','Closed','University of Southern California','Embryonic Stem Cell',647431;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00271','Optimization of guidance response in human embryonic stem cell derived midbrain dopaminergic neurons in development and disease',null,'Neurological Disorders, Parkinson's Disease','39264', '40178','SEED Grant','Closed','Stanford University','Embryonic Stem Cell',607363;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00432','Mitochondrial Dysfunction in Embryonic Stem Cells',null,null,'39264', '39629','SEED Grant','Closed','University of California, Irvine','Embryonic Stem Cell',245582;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00172','Genetic modification of the human genome to resist HIV-1 infection and/or disease progression',null,'HIV/AIDS, Immune Disease, Infectious Disease','39295', '40025','SEED Grant','Closed','University of California, Los Angeles','Embryonic Stem Cell',616800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00308','Endodermal differentiation of human ES cells',null,'Diabetes, Metabolic Disorders','39295', '40390','SEED Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',611027;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00409','Human Embryonic Stem Cells and Remyelination in a Viral Model of Demyelination',null,'Immune Disease, Multiple Sclerosis, Neurological Disorders','39295', '40390','SEED Grant','Closed','University of California, Irvine','Embryonic Stem Cell',368081;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00413','Using human embryonic stem cells to treat radiation-induced stem cell loss: Benefits vs cancer risk',null,'Cancer, Neurological Disorders, Skeletal/Smooth Muscle disorders','39417', '40329','SEED Grant','Closed','University of California, Irvine','Embryonic Stem Cell',593242;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00464','hESCs for Articular Cartilage Regeneration',null,'Bone or Cartilage Disease','39264', '39909','SEED Grant','Closed','University of California, Davis','Embryonic Stem Cell',301703;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00161','MicroRNA Regulation of Human Embryonic Stem Cell Self-Renewal and Differentiation',null,null,'39508', '40421','SEED Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',605886;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00453','Hair Cells and Spiral Ganglion Neuron Differentiation from Human Embryonic Stem Cells',null,'Hearing Loss','39295', '40025','SEED Grant','Closed','University of California, Davis','Embryonic Stem Cell',458071;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00280','Generation of long-term cultures of human hematopoietic multipotent progenitors from embryonic stem cells',null,'Blood Disorders','39264', '39994','SEED Grant','Closed','University of California, San Diego','Embryonic Stem Cell',473952;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00247','Development of human ES cell lines as a model system for Alzheimer disease drug discovery',null,'Alzheimer's Disease, Neurological Disorders','39264', '40178','SEED Grant','Closed','University of California, Irvine','Embryonic Stem Cell',473963;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00163','Programmed Cell Death Pathways Activated in Embryonic Stem Cells',null,null,'39295', '40117','SEED Grant','Closed','Buck Institute for Age Research','Embryonic Stem Cell',728950;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00455','Derivation and characterization of human ES cells from FSHD embryos',null,'Genetic Disorder, Muscular Dystrophy, Skeletal/Smooth Muscle disorders','39356', '40086','SEED Grant','Closed','University of California, Irvine','Embryonic Stem Cell',607200;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00283','Trophoblast differentiation of human ES cells.',null,'Fertility','39356', '40086','SEED Grant','Closed','Sanford Burnham Prebys Medical Discovery Institute','Embryonic Stem Cell',696354;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00207','Human Embryonic Stem Cell Differentiation to Trophoblast: Basic Biology and Clinical Translation to Improve Human Fertility',null,'Fertility','39264', '40178','SEED Grant','Closed','University of California, San Francisco','Embryonic Stem Cell',614784;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00169','Discovering Potent Molecules with Human ESCs to Treat Heart Disease',null,'Heart Disease','39448', '40359','SEED Grant','Closed','Human BioMolecular Research Institute','Embryonic Stem Cell',688274;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00245','Cellular epigenetic diversity as a blueprint for defining the identity and functional potential of human embryonic stem cells',null,null,'39295', '40025','SEED Grant','Closed','University of California, Los Angeles','Embryonic Stem Cell',549698;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00288','Gene regulatory mechanisms that control spinal neuron differentiation from hES cells.',null,'Amyotrophic Lateral Sclerosis, Neurological Disorders, Spinal Muscular Atrophy','39356', '40086','SEED Grant','Closed','Salk Institute for Biological Studies','Embryonic Stem Cell',704543;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00173','Combinatorial Platform for Optimizing Microenvironments to Control hESC Fate',null,null,'39264', '40178','SEED Grant','Closed','University of California, San Diego','Embryonic Stem Cell',577148;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00416','Production of Oocytes from Human ES Cells',null,null,'39264', '40359','SEED Grant','Closed','University of California, Irvine','Embryonic Stem Cell',385466;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RS1-00462','MicroRNAs in Human Stem Cell Differentiation and Mental Disorders',null,'Autism, Developmental Disorders, Neurological Disorders','39295', '40209','SEED Grant','Closed','Gladstone Institutes, J. David','Embryonic Stem Cell',748800;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T3-00006','Training Program in Systems Biology of Stem Cells',null,null,'38808', '40177','Training Grant I-3','Closed','University of California, Santa Cruz',null,1133701;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T3-00007','Training in the Biology of Human Enbryonic Stem Cells and Emerging Technologies',null,null,'38808', '39964','Training Grant I-3','Closed','Salk Institute for Biological Studies',null,1261333;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T3-00009','UCSB Stem Cell Biology Training Program',null,null,'38808', '40268','Training Grant I-3','Closed','University of California, Santa Barbara',null,975334;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T1-00001','Stanford CIRM Training Program',null,null,'38808', '40268','Training Grant I-1','Closed','Stanford University',null,3035282;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T1-00002','Training Grant I',null,null,'38808', '40268','Training Grant I-1','Closed','University of California, San Francisco',null,2868145;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T1-00003','Interdisciplinary Stem Cell Training Program at UCSD',null,null,'38808', '40268','Training Grant I-1','Closed','University of California, San Diego',null,3459396;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T1-00004','CIRM Stem Cell Biology Training Grant',null,null,'38808', '40268','Training Grant I-1','Closed','University of Southern California',null,2332431;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T1-00005','CIRM Type I Comprehensive Training Program',null,null,'38808', '40147','Training Grant I-1','Closed','University of California, Los Angeles',null,3660398;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T1-00006','Stem Cell Research Training Grant',null,null,'38808', '40268','Training Grant I-1','Closed','University of California, Davis',null,1780859;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T1-00007','Human Stem Cell Training at UC Berkeley and Childrens Hospital of Oakland',null,null,'38808', '39964','Training Grant I-1','Closed','University of California, Berkeley',null,2360457;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T1-00008','Stem Cell Research Training Grant',null,null,'38808', '40147','Training Grant I-1','Closed','University of California, Irvine',null,1935487;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T2-00001','Training Grant I',null,null,'38808', '40268','Training Grant I-2','Closed','Scripps Research Institute',null,1021395;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T2-00003','Gladstone CIRM Scholar Program',null,null,'38808', '40268','Training Grant I-2','Closed','Gladstone Institutes, J. David',null,2192073;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T2-00004','Burnham Institute CIRM Stem Cell Training Grant (Type II)',null,null,'38808', '40056','Training Grant I-2','Closed','Sanford Burnham Prebys Medical Discovery Institute',null,1061865;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T2-00005','Training Grant 1',null,null,'38808', '40268','Training Grant I-2','Closed','Children's Hospital of Los Angeles',null,2173872;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('T2-00006','Training in Stem Cell Biology at CIT',null,null,'38808', '40268','Training Grant I-2','Closed','California Institute of Technology',null,1817214;
Insert into ct_grant(grant_number,grant_title,trial_id,disease_focus,start_date,end_date,type,award_status,institution,stem_cell_use,amount) VALUES ('RN1-00584','Generating pluripotent cell lines from neurons.',null,null,null, null,'New Faculty I','Closed','Scripps Research Institute',null,2786560;
