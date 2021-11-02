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
       ('Geron Corporation'); 
       
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
('000000001',' Cancer'),
('000000001',' Solid Tumors'),
('000000001','Brain Cancer'),
('000000002',' Blood Cancer'),
('000000002',' Cancer'),
('000000002',' Infectious Disease'),
('000000002',' Multiple Myeloma'),
('000000002','Acute Myeloid Leukemia'),
('000000002','Blood Cancer'),
('000000002','Blood Disorders'),
('000000002','Cancer'),
('000000002','COVID-19'),
('000000002','Multiple Myeloma'),
('000000003',' Melanoma'),
('000000003',' Solid Tumors'),
('000000003','Cancer'),
('000000004',' Cancer'),
('000000004',' Solid Tumors'),
('000000004','Brain Cancer'),
('000000005',' Blood Cancer'),
('000000005',' Cancer'),
('000000005','Acute Myeloid Leukemia'),
('000000006',' Pediatrics'),
('000000006',' Spina Bifida'),
('000000006','Neurological Disorders'),
('000000007',' Blood Cancer'),
('000000007',' Cancer'),
('000000007',' Ovarian Cancer'),
('000000007',' Solid Tumors'),
('000000007','Acute Myeloid Leukemia'),
('000000007','Blood Cancer'),
('000000007','Cancer'),
('000000008',' Adenosine deaminase-deficient (ADA-SCID)'),
('000000008',' Genetic Disorder'),
('000000008',' Immune Disease'),
('000000008',' Pediatrics'),
('000000008',' Severe Combined Immunodeficiency'),
('000000008',' Sickle Cell Disease'),
('000000008',' X-linked Chronic Granulomatous Disease'),
('000000008','Blood Disorders'),
('000000008','Immune Disease'),
('000000009',' Metabolic Disorders'),
('000000009',' Type 1 diabetes'),
('000000009','Diabetes'),
('000000010',' Intestinal Disease'),
('000000010',' Metabolic Disorders'),
('000000010','Inflammatory bowel disease'),
('000000011',' Neurological Disorders'),
('000000011','Alzheimer\'s Disease'),
('000000011','Neurological Disorders'),
('000000012',' Infectious Disease'),
('000000012',' Neurological Disorders'),
('000000012','Amyotrophic Lateral Sclerosis'),
('000000012','COVID-19'),
('000000013',' Traumatic Brain Injury'),
('000000013','Neurological Disorders'),
('000000014',' Stroke'),
('000000014','Neurological Disorders'),
('000000015',' Infectious Disease'),
('000000015','COVID-19'),
('000000016',' Infectious Disease'),
('000000016',' Neurological Disorders'),
('000000016',' Pediatrics'),
('000000016','Canavan Disease'),
('000000016','COVID-19'),
('000000016','Genetic Disorder'),
('000000016','Neurological Disorders'),
('000000017',' Sickle Cell Disease'),
('000000017','Blood Disorders'),
('000000018',' Immune Disease'),
('000000018',' Infectious Disease'),
('000000018','HIV/AIDS'),
('000000019','Bone or Cartilage Disease'),
('000000020',' Spinal Cord Injury'),
('000000020','Neurological Disorders'),
('000000021',' Infectious Disease'),
('000000021',' Skeletal/Smooth Muscle disorders'),
('000000021','Aging'),
('000000021','COVID-19'),
('000000021','Skeletal/Smooth Muscle disorders'),
('000000022',' Infectious Disease'),
('000000022',' Toxicity'),
('000000022','COVID-19'),
('000000022','Heart Disease'),
('000000023',' Spinal Cord Injury'),
('000000023',' Trauma'),
('000000023',' Traumatic Brain Injury'),
('000000023','Neurological Disorders'),
('000000024',' Infectious Disease'),
('000000024',' Respiratory Disorders'),
('000000024','COVID-19'),
('000000024','Vascular Disease'),
('000000025',' Neurological Disorders'),
('000000025','Epilepsy'),
('000000027',' hypoxic'),
('000000027',' Infectious Disease'),
('000000027',' ischemic'),
('000000027',' Neurological Disorders'),
('000000027',' Parkinson\'s Disease'),
('000000027',' Pediatrics'),
('000000027',' Respiratory Disorders'),
('000000027','Brain Injury'),
('000000027','COVID-19'),
('000000027','Neurological Disorders'),
('000000028',' Infectious Disease'),
('000000028','COVID-19'),
('000000029',' Infectious Disease'),
('000000029',' Respiratory Disorders'),
('000000029','COVID-19'),
('000000030',' Infectious Disease'),
('000000030',' Respiratory Disorders'),
('000000030','COVID-19'),
('000000031',' Infectious Disease'),
('000000031','COVID-19'),
('000000032',' Infectious Disease'),
('000000032',' Neurological Disorders'),
('000000032','COVID-19'),
('000000032','Infectious Disease'),
('000000033',' Infectious Disease'),
('000000033','COVID-19'),
('000000034',' Cancer'),
('000000034',' Infectious Disease'),
('000000034','Brain Cancer'),
('000000034','COVID-19'),
('000000035',' Hyper IgM Syndrome'),
('000000035',' Immune Disease'),
('000000035','Blood Disorders'),
('000000036',' Infectious Disease'),
('000000036',' Neurological Disorders'),
('000000036',' Stroke'),
('000000036','Autism'),
('000000036','COVID-19'),
('000000036','Neurological Disorders'),
('000000037',' Infectious Disease'),
('000000037','COVID-19'),
('000000038',' Sickle Cell Disease'),
('000000038','Blood Disorders'),
('000000039',' Infectious Disease'),
('000000039',' Lung Cancer'),
('000000039',' Respiratory Disorders'),
('000000039',' Solid Tumors'),
('000000039','Cancer'),
('000000039','COVID-19'),
('000000039','Respiratory Disorders'),
('000000040',' Infectious Disease'),
('000000040',' Respiratory Disorders'),
('000000040','Blood Disorders'),
('000000040','Cancer'),
('000000040','COVID-19'),
('000000040','Immune Disease'),
('000000041',' Cancer'),
('000000041',' Immune Disease'),
('000000041',' Infectious Disease'),
('000000041',' Respiratory Disorders'),
('000000041','Brain Cancer'),
('000000041','COVID-19'),
('000000041','HIV/AIDS'),
('000000041','Multiple Indications (Alpha Clinics)'),
('000000042',' Lung Cancer'),
('000000042','Blood Disorders'),
('000000042','Cancer'),
('000000044',' Cancer'),
('000000044',' Multiple Myeloma'),
('000000044','Blood Cancer'),
('000000045',' Immune Disease'),
('000000045',' IPEX Syndrome'),
('000000045','Blood Disorders'),
('000000046',' Vision Loss'),
('000000046','Retinitis Pigmentosa'),
('000000046','Vision Loss'),
('000000047',' Neurological Disorders'),
('000000047',' Pediatrics'),
('000000047',' Vision Loss'),
('000000047','Amyotrophic Lateral Sclerosis'),
('000000047','Huntington\'s Disease'),
('000000047','Neurological Disorders'),
('000000047','Retinitis Pigmentosa'),
('000000048',' Vision Loss'),
('000000048','Corneal Damage'),
('000000048','Vision Loss'),
('000000049',' Parkinson\'s Disease'),
('000000049','Neurological Disorders'),
('000000050',' Cancer'),
('000000050',' Ovarian Cancer'),
('000000050',' Solid Tumors'),
('000000050','Brain Cancer'),
('000000050','Cancer'),
('000000051',' Breast Cancer'),
('000000051',' Cancer'),
('000000051',' Ovarian Cancer'),
('000000051','Brain Cancer'),
('000000051','Cancer'),
('000000052',' Vision Loss'),
('000000052','Age-related macular degeneration'),
('000000052','Vision Loss'),
('000000053',' Cancer'),
('000000053',' HIV-related Lymphoma'),
('000000053',' HIV/AIDS'),
('000000053',' Infectious Disease'),
('000000053','Blood Cancer'),
('000000053','Multiple Indications (Alpha Clinics)'),
('000000054',' Genetic Disorder'),
('000000054',' Kidney Disease'),
('000000054',' Kidney Failure'),
('000000054',' Metabolic Disorders'),
('000000054',' Pediatrics'),
('000000054','Cystinosis'),
('000000055',' Metabolic Disorders'),
('000000055','Diabetes'),
('000000056',' Parkinson\'s Disease'),
('000000056','Neurological Disorders'),
('000000057',' Sickle Cell Disease'),
('000000057','Blood Disorders'),
('000000057','Multiple Indications (Alpha Clinics)'),
('000000058',' Sarcoma'),
('000000058','Cancer'),
('000000059',' Immune Disease'),
('000000059','Blood Disorders'),
('000000061',' Intervertebral disc degeneration'),
('000000061',' Osteonecrosis'),
('000000061','Bone or Cartilage Disease'),
('000000062',' Immune Disease'),
('000000062',' Muscular Dystrophy'),
('000000062',' Pediatrics'),
('000000062',' Severe Combined Immunodeficiency'),
('000000062',' Skeletal/Smooth Muscle disorders'),
('000000062',' X-linked (X-SCID)'),
('000000062','Blood Disorders'),
('000000062','Immune Disease'),
('000000063',' Severe Combined Immunodeficiency'),
('000000063','Blood Disorders'),
('000000064',' Neurological Disorders'),
('000000064','Huntington\'s Disease'),
('000000065',' Kidney Failure'),
('000000065','Kidney Disease'),
('000000066',' Cancer'),
('000000066','Blood Cancer'),
('000000068',' Blood Cancer'),
('000000068','Acute Myeloid Leukemia'),
('000000069',' Vision Loss'),
('000000069','Age-related macular degeneration'),
('000000070',' Vision Loss'),
('000000070','Age-related macular degeneration'),
('000000071','Vision Loss'),
('000000072',' Metabolic Disorders'),
('000000072',' Neurological Disorders'),
('000000072',' Pediatrics'),
('000000072','Intestinal Disease'),
('000000072','Liver Disease'),
('000000073',' Cancer'),
('000000073',' Skeletal/Smooth Muscle disorders'),
('000000073',' Solid Tumors'),
('000000073','Bladder or Urinary Tract Disorder'),
('000000073','Cancer'),
('000000074','Hearing Loss'),
('000000075','Hearing Loss'),
('000000076',' Infectious Disease'),
('000000076','HIV/AIDS'),
('000000077',' Prostate Cancer'),
('000000077','Cancer'),
('000000078',' Thymic Disorder'),
('000000078','Immune Disease'),
('000000079',' Heart Disease'),
('000000079',' Pediatrics'),
('000000079','Danon Disease'),
('000000079','Heart Disease'),
('000000080',' Neurological Disorders'),
('000000080','Dementia'),
('000000081',' Metabolic Disorders'),
('000000081','Diabetes'),
('000000082',' Lung Cancer'),
('000000082','Cancer'),
('000000083','Bone or Cartilage Disease'),
('000000084',' Incontinence'),
('000000084',' Skeletal/Smooth Muscle disorders'),
('000000084','Bladder or Urinary Tract Disorder'),
('000000084','Incontinence'),
('000000085',' Vision Loss'),
('000000085','Retinitis Pigmentosa'),
('000000085','Vision Loss'),
('000000086',' Blood Disorders'),
('000000086','Beta Thalassemia'),
('000000087',' Blood Disorders'),
('000000087','Beta Thalassemia'),
('000000088',' Pediatrics'),
('000000088',' Severe Combined Immunodeficiency'),
('000000088','Blood Disorders'),
('000000088','Immune Disease'),
('000000089',' Blood Cancer'),
('000000089',' Cancer'),
('000000089',' Leukemia'),
('000000089','B cell cancers'),
('000000090',' Blood Disorders'),
('000000090','Beta Thalassemia'),
('000000091',' Solid Tumors'),
('000000091','Cancer'),
('000000092',' Sickle Cell Disease'),
('000000092','Blood Disorders'),
('000000093',' Kidney Failure'),
('000000093','Kidney Disease'),
('000000095','Neurological Disorders'),
('000000098',' Heart Disease'),
('000000098',' Toxicity'),
('000000098','Blood Disorders'),
('000000098','Heart Disease'),
('000000100','Multiple Indications (Alpha Clinics)'),
('000000101',' Blood Cancer'),
('000000101','Acute Myeloid Leukemia'),
('000000101','Blood Disorders'),
('000000102',' Infectious Disease'),
('000000102','HIV/AIDS'),
('000000103',' Metabolic Disorders'),
('000000103','Diabetes'),
('000000104',' Spinal Cord Injury'),
('000000104','Neurological Disorders'),
('000000105',' Hemophilia A'),
('000000105','Blood Disorders'),
('000000106',' Genetic Disorder'),
('000000106',' Metabolic Disorders'),
('000000106','Cancer'),
('000000106','Diabetes'),
('000000106','Heart Disease'),
('000000106','Immune Disease'),
('000000107',' Metabolic Disorders'),
('000000107','Diabetes'),
('000000108',' Metabolic Disorders'),
('000000108','Liver Disease'),
('000000109',' Skeletal/Smooth Muscle disorders'),
('000000109','Muscular Dystrophy'),
('000000110',' Ovarian Cancer'),
('000000110','Cancer'),
('000000111',' Heart Disease'),
('000000111','Blood Disorders'),
('000000111','Kidney Disease'),
('000000112','Vascular Disease'),
('000000113',' Blood Cancer'),
('000000113','Acute Myeloid Leukemia'),
('000000114','Bone or Cartilage Disease'),
('000000115',' Parkinson\'s Disease'),
('000000115','Neurological Disorders'),
('000000116','Bone or Cartilage Disease'),
('000000117',' Skin Disease'),
('000000117','Epidermolysis Bullosa'),
('000000117','Skin Disease'),
('000000118',' Vision Loss'),
('000000118','Age-related macular degeneration'),
('000000118','Vision Loss'),
('000000119',' Blood Cancer'),
('000000119',' Cancer'),
('000000119','Acute Myeloid Leukemia'),
('000000119','Blood Cancer'),
('000000119','Cancer'),
('000000119','Multiple Indications (Alpha Clinics)'),
('000000120','Respiratory Disorders'),
('000000121','Other'),
('000000122','Vascular Disease'),
('000000123','Other'),
('000000124',' Pancreatic Cancer'),
('000000124','Cancer'),
('000000124','Heart Disease'),
('000000125',' Bone or Cartilage Disease'),
('000000125','Arthritis'),
('000000126',' Blood Disorders'),
('000000126',' Bone Marrow Transplant and Viral Infection'),
('000000126',' Cancer'),
('000000126','Blood Cancer'),
('000000127',' Cancer'),
('000000127','Blood Cancer'),
('000000130',' Genetic Disorder'),
('000000130',' Immune Disease'),
('000000130',' Pediatrics'),
('000000130',' Respiratory Disorders'),
('000000130',' Severe Combined Immunodeficiency'),
('000000130',' Sickle Cell Disease'),
('000000130',' X-linked (X-SCID)'),
('000000130','Blood Disorders'),
('000000130','Cystic Fibrosis'),
('000000131',' Blood Cancer'),
('000000131','Acute Myeloid Leukemia'),
('000000132',' Metabolic Disorders'),
('000000132','Diabetes'),
('000000133',' Kidney Failure'),
('000000133','Kidney Disease'),
('000000134',' Cancer'),
('000000134','Brain Cancer'),
('000000135',' Blood Cancer'),
('000000135',' Cancer'),
('000000135',' Leukemia'),
('000000135','B cell cancers'),
('000000135','Blood Cancer'),
('000000137',' Cancer'),
('000000137','Blood Cancer'),
('000000138',' Neurological Disorders'),
('000000138','Amyotrophic Lateral Sclerosis'),
('000000139',' Metabolic Disorders'),
('000000139','Diabetes'),
('000000140',' Metabolic Disorders'),
('000000140','Liver Disease'),
('000000141',' Stroke'),
('000000141','Neurological Disorders'),
('000000142',' Blood Disorders'),
('000000142',' Immune Disease'),
('000000142',' Pediatrics'),
('000000142','Alpha Thalassemia Major'),
('000000142','Blood Disorders'),
('000000143',' Colon Cancer'),
('000000143','Cancer'),
('000000144',' Heart failure'),
('000000144','Heart Disease'),
('000000145','Heart Disease'),
('000000146','Other'),
('000000147',' Neurological Disorders'),
('000000147','Huntington\'s Disease'),
('000000148',' Blood Cancer'),
('000000148',' Cancer'),
('000000148',' Leukemia'),
('000000148','B cell cancers'),
('000000149',' Stroke'),
('000000149','Neurological Disorders'),
('000000150',' Parkinson\'s Disease'),
('000000150','Neurological Disorders'),
('000000151',' Blood Cancer'),
('000000151','Acute Myeloid Leukemia'),
('000000152','Vision Loss'),
('000000153','Heart Disease'),
('000000154',' Skeletal/Smooth Muscle disorders'),
('000000154','Muscular Dystrophy'),
('000000155',' Neurological Disorders'),
('000000155','Alzheimer\'s Disease'),
('000000156','Blood Disorders'),
('000000157',' Kidney Failure'),
('000000157','Kidney Disease'),
('000000158',' Neuropathy'),
('000000158','Neurological Disorders'),
('000000159',' Osteoarthritis'),
('000000159','Bone or Cartilage Disease'),
('000000160',' Metabolic Disorders'),
('000000160','Diabetes'),
('000000161',' Immune Disease'),
('000000161',' Severe Combined Immunodeficiency'),
('000000161',' X-linked (X-SCID)'),
('000000161','Blood Disorders'),
('000000162',' Metabolic Disorders'),
('000000162','Diabetes'),
('000000163',' Metabolic Disorders'),
('000000163','Liver Disease'),
('000000164',' Vascular Disease'),
('000000164','Heart Disease'),
('000000165',' Parkinson\'s Disease'),
('000000165','Neurological Disorders'),
('000000166',' Blood Disorders'),
('000000166',' Cancer'),
('000000166',' Leukemia'),
('000000166','Blood Cancer'),
('000000167',' Metabolic Disorders'),
('000000167','Diabetes'),
('000000168',' Neurological Disorders'),
('000000168',' Pediatrics'),
('000000168',' Rett\'s Syndrome'),
('000000168','Autism'),
('000000168','Infectious Disease'),
('000000168','Neurological Disorders'),
('000000169','Arthritis'),
('000000169','Bone or Cartilage Disease'),
('000000170',' Neurological Disorders'),
('000000170','Alzheimer\'s Disease'),
('000000172',' Pulmonary Hypertension'),
('000000172','Heart Disease'),
('000000173',' Adenosine deaminase-deficient (ADA-SCID)'),
('000000173',' Genetic Disorder'),
('000000173',' Immune Disease'),
('000000173',' Pediatrics'),
('000000173',' Severe Combined Immunodeficiency'),
('000000173','Blood Disorders'),
('000000175','Multiple Indications (Alpha Clinics)'),
('000000178','Trauma'),
('000000179',' Parkinson\'s Disease'),
('000000179',' Spinal Cord Injury'),
('000000179','Neurological Disorders'),
('000000180',' Neurological Disorders'),
('000000180','Autism'),
('000000181',' Parkinson\'s Disease'),
('000000181','Immune Disease'),
('000000181','Neurological Disorders'),
('000000182',' Infectious Disease'),
('000000182','HIV/AIDS'),
('000000183',' Metabolic Disorders'),
('000000183','Diabetes'),
('000000184','Multiple Indications (Alpha Clinics)'),
('000000185',' Cancer'),
('000000185','Blood Cancer'),
('000000186','Heart Disease'),
('000000187','Heart Disease'),
('000000188','Heart Disease'),
('000000189',' Genetic Disorder'),
('000000189',' Neurological Disorders'),
('000000189',' Pediatrics'),
('000000189',' Spinal Cord Injury'),
('000000189',' Spinal Muscular Atrophy'),
('000000189','Amyotrophic Lateral Sclerosis'),
('000000189','Neurological Disorders'),
('000000190',' Skeletal/Smooth Muscle disorders'),
('000000190','Aging'),
('000000191',' Prostate Cancer'),
('000000191','Cancer'),
('000000192','Vision Loss'),
('000000193',' Hemophilia A'),
('000000193','Blood Disorders'),
('000000194',' Metabolic Disorders'),
('000000194','Diabetes'),
('000000195','Blood Disorders'),
('000000196','Blood Disorders'),
('000000197',' Metabolic Disorders'),
('000000197','Diabetes'),
('000000198',' Neurological Disorders'),
('000000198','Metabolic Disorders'),
('000000199',' Heart disease associated with Duchenne muscular dystrophy'),
('000000199','Heart Disease'),
('000000200',' Alzheimer\'s Disease'),
('000000200',' Genetic Disorder'),
('000000200',' Neurological Disorders'),
('000000200','Aging'),
('000000200','Alzheimer\'s Disease'),
('000000200','Amyotrophic Lateral Sclerosis'),
('000000201',' Metabolic Disorders'),
('000000201','Diabetes'),
('000000202',' Artemis deficient (ART-SCID)'),
('000000202',' Immune Disease'),
('000000202',' Severe Combined Immunodeficiency'),
('000000202','Blood Disorders'),
('000000204',' Cancer'),
('000000204','Blood Cancer'),
('000000222',' Neurological Disorders'),
('000000222','Amyotrophic Lateral Sclerosis'),
('000000224',' Metabolic Disorders'),
('000000224','Developmental Disorders'),
('000000224','Intestinal Disease'),
('000000225',' Cancer'),
('000000225','Brain Cancer'),
('000000228',' Bone or Cartilage Disease'),
('000000228',' Neurological Disorders'),
('000000228','Arthritis'),
('000000228','Bone or Cartilage Disease'),
('000000228','Multiple Sclerosis'),
('000000229','Vision Loss'),
('000000230',' Melanoma'),
('000000230','Cancer'),
('000000231',' Neurological Disorders'),
('000000231','Alzheimer\'s Disease'),
('000000232',' Diabetic Wounds'),
('000000232',' Metabolic Disorders'),
('000000232',' Skin Disease'),
('000000232','Diabetes'),
('000000232','Skin Disease'),
('000000233',' Bone or Cartilage Disease'),
('000000233','Arthritis'),
('000000233','Bone or Cartilage Disease'),
('000000237',' Metabolic Disorders'),
('000000237',' Neurological Disorders'),
('000000237',' Pediatrics'),
('000000237','Intestinal Disease'),
('000000238','Heart Disease'),
('000000239',' Metabolic Disorders'),
('000000239','Liver Disease'),
('000000240',' Blood Cancer'),
('000000240',' Blood Disorders'),
('000000240',' Cancer'),
('000000240','Anemia'),
('000000240','Blood Disorders'),
('000000241','Heart Disease'),
('000000242',' Spinal Cord Injury'),
('000000242','Neurological Disorders'),
('000000243',' Skeletal/Smooth Muscle disorders'),
('000000243','Muscular Dystrophy'),
('000000243','Skeletal/Smooth Muscle disorders'),
('000000244',' Cancer'),
('000000244',' Heart Disease'),
('000000244',' Liver Disease'),
('000000244',' Metabolic Disorders'),
('000000244','Blood Cancer'),
('000000244','Blood Disorders'),
('000000245',' Infectious Disease'),
('000000245','HIV/AIDS'),
('000000246','Bone or Cartilage Disease'),
('000000247','Other'),
('000000248','Vascular Disease'),
('000000249','Blood Disorders'),
('000000250','Bone or Cartilage Disease'),
('000000251','Other'),
('000000252',' Neurological Disorders'),
('000000252',' Spinal Cord Injury'),
('000000252',' Spinal Muscular Atrophy'),
('000000252','Amyotrophic Lateral Sclerosis'),
('000000252','Neurological Disorders'),
('000000254',' Neurological Disorders'),
('000000254','Amyotrophic Lateral Sclerosis'),
('000000254','Huntington\'s Disease'),
('000000257','Other'),
('000000258',' Neurological Disorders'),
('000000258','Heart Disease'),
('000000259',' Spinal Cord Injury'),
('000000259','Neurological Disorders'),
('000000260','Heart Disease'),
('000000262','Heart Disease'),
('000000262','Vascular Disease'),
('000000263','Heart Disease'),
('000000264','Other'),
('000000265','Blood Disorders'),
('000000266','Multiple Indications (Alpha Clinics)'),
('000000267',' Solid Tumors'),
('000000267','Cancer'),
('000000269','Multiple Indications (Alpha Clinics)'),
('000000271','Multiple Indications (Alpha Clinics)'),
('000000272','Neurological Disorders'),
('000000273',' Metabolic Disorders'),
('000000273','Diabetes'),
('000000275',' Neurological Disorders'),
('000000275',' Pediatrics'),
('000000275',' Rett\'s Syndrome'),
('000000275','Autism'),
('000000276',' Parkinson\'s Disease'),
('000000276','Neurological Disorders'),
('000000277',' Metabolic Disorders'),
('000000277','Diabetes'),
('000000278','Neurological Disorders'),
('000000279','Heart Disease'),
('000000281',' Spinal Cord Injury'),
('000000281','Neurological Disorders'),
('000000282','Blood Disorders'),
('000000283',' HIV/AIDS'),
('000000283',' Immune Disease'),
('000000283',' Infectious Disease'),
('000000283',' Metabolic Disorders'),
('000000283',' Pediatrics'),
('000000283','Diabetes'),
('000000283','HIV/AIDS'),
('000000284',' Skeletal/Smooth Muscle disorders'),
('000000284','Aging'),
('000000287','Respiratory Disorders'),
('000000288',' Solid Tumors'),
('000000288','Cancer'),
('000000293',' Parkinson\'s Disease'),
('000000293',' Stroke'),
('000000293','Neurological Disorders'),
('000000294',' Parkinson\'s Disease'),
('000000294',' Pediatrics'),
('000000294','Immune Disease'),
('000000294','Muscular Dystrophy'),
('000000294','Neurological Disorders'),
('000000295',' Prostate Cancer'),
('000000295','Cancer'),
('000000296',' Cancer'),
('000000296',' Immune Disease'),
('000000296',' Infectious Disease'),
('000000296',' Melanoma'),
('000000296',' Muscular Dystrophy'),
('000000296',' Neurological Disorders'),
('000000296',' Skeletal/Smooth Muscle disorders'),
('000000296','Amyotrophic Lateral Sclerosis'),
('000000296','HIV/AIDS'),
('000000297',' Immune Disease'),
('000000297',' Liver Disease'),
('000000297',' Metabolic Disorders'),
('000000297',' Pediatrics'),
('000000297','Blood Disorders'),
('000000298',' Liver Disease'),
('000000298',' Metabolic Disorders'),
('000000298',' Pediatrics'),
('000000298','Genetic Disorder'),
('000000299',' Bone or Cartilage Disease'),
('000000299','Arthritis'),
('000000299','Bone or Cartilage Disease'),
('000000300',' Neurological Disorders'),
('000000300','Huntington\'s Disease'),
('000000301','Cancer'),
('000000304','Respiratory Disorders'),
('000000305',' Neurological Disorders'),
('000000305','Amyotrophic Lateral Sclerosis'),
('000000306',' Pediatrics'),
('000000306','Blood Disorders'),
('000000307','Aging'),
('000000309',' Neurological Disorders'),
('000000309','Autism'),
('000000310','Vision Loss'),
('000000311',' Pediatrics'),
('000000311','Neurological Disorders'),
('000000312',' Liver Disease'),
('000000312','Infectious Disease'),
('000000313',' Neurological Disorders'),
('000000313','Alzheimer\'s Disease'),
('000000314','Multiple Indications (Alpha Clinics)'),
('000000315','Multiple Indications (Alpha Clinics)'),
('000000317',' Metabolic Disorders'),
('000000317','Diabetes'),
('000000318',' Cancer'),
('000000318',' Neurological Disorders'),
('000000318',' Pediatrics'),
('000000318',' Solid Tumors'),
('000000318','Brain Cancer'),
('000000318','Neurological Disorders'),
('000000319',' Neuropathy'),
('000000319','Neurological Disorders'),
('000000320','Heart Disease'),
('000000321','Skin Disease'),
('000000322','Heart Disease'),
('000000323','Fertility'),
('000000324',' Skeletal/Smooth Muscle disorders'),
('000000324','Muscular Dystrophy'),
('000000324','Skeletal/Smooth Muscle disorders'),
('000000325',' Blood Disorders'),
('000000325','Blood Cancer'),
('000000326',' Pediatrics'),
('000000326','Neurological Disorders'),
('000000328',' Neurological Disorders'),
('000000328','Aging'),
('000000329',' Cancer'),
('000000329','Blood Cancer'),
('000000331','Vision Loss'),
('000000332',' Neurological Disorders'),
('000000332',' Neuropathy'),
('000000332','Amyotrophic Lateral Sclerosis'),
('000000332','Neurological Disorders'),
('000000333',' Pediatrics'),
('000000333','Heart Disease'),
('000000336','Skin Disease'),
('000000337',' Rett\'s Syndrome'),
('000000337','Neurological Disorders'),
('000000338','Heart Disease'),
('000000339','Neurological Disorders'),
('000000341',' Dementia'),
('000000341',' Neurological Disorders'),
('000000341','Amyotrophic Lateral Sclerosis'),
('000000342','Heart Disease'),
('000000345',' Melanoma'),
('000000345',' Skin cancer'),
('000000345',' Solid Tumors'),
('000000345','Cancer'),
('000000346','Heart Disease'),
('000000346','Vascular Disease'),
('000000347',' Osteonecrosis'),
('000000347','Bone or Cartilage Disease'),
('000000348',' Neurological Disorders'),
('000000348','Huntington\'s Disease'),
('000000349','Kidney Disease'),
('000000350',' Pediatrics'),
('000000350',' Skeletal/Smooth Muscle disorders'),
('000000350','Muscular Dystrophy'),
('000000351',' Neurological Disorders'),
('000000351','Alzheimer\'s Disease'),
('000000352',' Heart failure'),
('000000352','Heart Disease'),
('000000353','Bone or Cartilage Disease'),
('000000354',' Cancer'),
('000000354','Brain Cancer'),
('000000355','Vascular Disease'),
('000000356',' Neurological Disorders'),
('000000356','Multiple Sclerosis'),
('000000357','Heart Disease'),
('000000358',' Neurological Disorders'),
('000000358',' Spinal Cord Injury'),
('000000358','Epilepsy'),
('000000358','Neurological Disorders'),
('000000359',' Pediatrics'),
('000000359','Neurological Disorders'),
('000000359','Pediatrics'),
('000000364',' Neurological Disorders'),
('000000364','Alzheimer\'s Disease'),
('000000366','Aging'),
('000000367','Neurological Disorders'),
('000000368',' Metabolic Disorders'),
('000000368','Diabetes'),
('000000370','Respiratory Disorders'),
('000000371','Cancer'),
('000000372',' Parkinson\'s Disease'),
('000000372','Neurological Disorders'),
('000000373','Bone or Cartilage Disease'),
('000000374','Heart Disease'),
('000000375',' Neurological Disorders'),
('000000375','Amyotrophic Lateral Sclerosis'),
('000000384','Neurological Disorders'),
('000000385',' Alzheimer\'s Disease'),
('000000385',' Neurological Disorders'),
('000000385','Aging'),
('000000385','Autism'),
('000000386','Fertility'),
('000000388',' Pediatrics'),
('000000388','Heart Disease'),
('000000389',' Metabolic Disorders'),
('000000389','Diabetes'),
('000000390','Heart Disease'),
('000000391',' Neurological Disorders'),
('000000391','Huntington\'s Disease'),
('000000393',' Neurological Disorders'),
('000000393',' Pediatrics'),
('000000393',' Rett\'s Syndrome'),
('000000393','Autism'),
('000000395',' Neurological Disorders'),
('000000395','Amyotrophic Lateral Sclerosis'),
('000000395','Neurological Disorders'),
('000000396','Genetic Disorder'),
('000000398',' Neurological Disorders'),
('000000398','Infectious Disease'),
('000000402',' Pediatrics'),
('000000402','Neurological Disorders'),
('000000403',' Parkinson\'s Disease'),
('000000403','Neurological Disorders'),
('000000405','Neurological Disorders'),
('000000409',' Neurological Disorders'),
('000000409','Autism'),
('000000409','Trauma'),
('000000410',' Pediatrics'),
('000000410','Neurological Disorders'),
('000000412',' Parkinson\'s Disease'),
('000000412','Neurological Disorders'),
('000000413',' Intestinal Disease'),
('000000413',' Metabolic Disorders'),
('000000413',' Pediatrics'),
('000000413','Genetic Disorder'),
('000000414',' Stroke'),
('000000414','Neurological Disorders'),
('000000416',' Immune Disease'),
('000000416',' Infectious Disease'),
('000000416','HIV/AIDS'),
('000000417',' Pediatrics'),
('000000417','Neurological Disorders'),
('000000418',' Cancer'),
('000000418','Blood Cancer'),
('000000419',' Neurological Disorders'),
('000000419','Epilepsy'),
('000000420','Bone or Cartilage Disease'),
('000000421','Vision Loss'),
('000000422',' Parkinson\'s Disease'),
('000000422','Neurological Disorders'),
('000000423',' Metabolic Disorders'),
('000000423','Liver Disease'),
('000000424',' Autism'),
('000000424',' Blood Disorders'),
('000000424',' Genetic Disorder'),
('000000424',' Neurological Disorders'),
('000000424',' Parkinson\'s Disease'),
('000000424',' Pediatrics'),
('000000424',' Rett\'s Syndrome'),
('000000424','Amyotrophic Lateral Sclerosis'),
('000000424','Neurological Disorders'),
('000000425',' Cancer'),
('000000425','Brain Cancer'),
('000000426',' Immune Disease'),
('000000426','HIV/AIDS'),
('000000428',' Cancer'),
('000000428','Blood Cancer'),
('000000429',' Cancer'),
('000000429','Brain Cancer'),
('000000431','Neurological Disorders'),
('000000433','Pediatrics'),
('000000434','Immune Disease'),
('000000435','Blood Disorders'),
('000000436',' Neurological Disorders'),
('000000436','Alzheimer\'s Disease'),
('000000437','Immune Disease'),
('000000440','Neurological Disorders'),
('000000441',' Pediatrics'),
('000000441','Blood Disorders'),
('000000442',' Immune Disease'),
('000000442',' Metabolic Disorders'),
('000000442','Diabetes'),
('000000443',' Pediatrics'),
('000000443','Immune Disease'),
('000000445',' Neurological Disorders'),
('000000445','Epilepsy'),
('000000447',' Immune Disease'),
('000000447','Blood Disorders'),
('000000448','Immune Disease'),
('000000453',' Spinal Cord Injury'),
('000000453','Neurological Disorders'),
('000000454',' Cancer'),
('000000454','Brain Cancer'),
('000000455',' Cancer'),
('000000455','Blood Cancer'),
('000000456',' Pediatrics'),
('000000456','Epidermolysis Bullosa'),
('000000457',' Infectious Disease'),
('000000457','HIV/AIDS'),
('000000458',' Metabolic Disorders'),
('000000458','Diabetes'),
('000000459','Heart Disease'),
('000000462','Blood Disorders'),
('000000465',' Parkinson\'s Disease'),
('000000465','Neurological Disorders'),
('000000467',' Metabolic Disorders'),
('000000467','Diabetes'),
('000000468',' Vision Loss'),
('000000468','Aging'),
('000000469','Cancer'),
('000000471',' Parkinson\'s Disease'),
('000000471','Neurological Disorders'),
('000000472','Bone or Cartilage Disease'),
('000000473','Vision Loss'),
('000000475',' Neurological Disorders'),
('000000475','Huntington\'s Disease'),
('000000476',' Alzheimer\'s Disease'),
('000000476',' Neurological Disorders'),
('000000476','Aging'),
('000000476','Alzheimer\'s Disease'),
('000000477',' Heart Disease'),
('000000477','Blood Disorders'),
('000000479',' Cancer'),
('000000479','Brain Cancer'),
('000000483','Heart Disease'),
('000000491',' Metabolic Disorders'),
('000000491','Liver Disease'),
('000000493',' Neurological Disorders'),
('000000493','Amyotrophic Lateral Sclerosis'),
('000000498','Heart Disease'),
('000000501',' Metabolic Disorders'),
('000000501','Diabetes'),
('000000506','Neurological Disorders'),
('000000507',' Trauma'),
('000000507','Bone or Cartilage Disease'),
('000000509','Heart Disease'),
('000000516','Heart Disease'),
('000000517',' Neurological Disorders'),
('000000517','Amyotrophic Lateral Sclerosis'),
('000000518','Fertility'),
('000000520',' Parkinson\'s Disease'),
('000000520','Neurological Disorders'),
('000000521',' Muscular Dystrophy'),
('000000521',' Pediatrics'),
('000000521',' Skeletal/Smooth Muscle disorders'),
('000000521','Genetic Disorder'),
('000000523',' Pediatrics'),
('000000523','Genetic Disorder'),
('000000524',' Toxicity'),
('000000524','Heart Disease'),
('000000525',' Neurological Disorders'),
('000000525','Dementia'),
('000000537','Heart Disease'),
('000000538',' Alzheimer\'s Disease'),
('000000538','Aging'),
('000000539',' Solid Tumors'),
('000000539','Cancer'),
('000000541',' Cancer'),
('000000541','Blood Cancer'),
('000000542','Heart Disease'),
('000000543',' Skeletal/Smooth Muscle disorders'),
('000000543','Muscular Dystrophy'),
('000000544','Bone or Cartilage Disease'),
('000000545',' Parkinson\'s Disease'),
('000000545','Neurological Disorders'),
('000000546',' Neurological Disorders'),
('000000546','Amyotrophic Lateral Sclerosis'),
('000000547',' Muscular Dystrophy'),
('000000547',' Pediatrics'),
('000000547',' Skeletal/Smooth Muscle disorders'),
('000000547',' Trauma'),
('000000547','Aging'),
('000000551','Fertility'),
('000000556','Heart Disease'),
('000000557',' Neurological Disorders'),
('000000557',' Spinal Cord Injury'),
('000000557',' Spinal Muscular Atrophy'),
('000000557','Amyotrophic Lateral Sclerosis'),
('000000559',' Stroke'),
('000000559','Neurological Disorders'),
('000000560','Hearing Loss'),
('000000561','Heart Disease'),
('000000562','Heart Disease'),
('000000563',' Multiple Sclerosis'),
('000000563',' Neurological Disorders'),
('000000563',' Stroke'),
('000000563','Immune Disease'),
('000000569',' Melanoma'),
('000000569','Cancer'),
('000000570','Cancer'),
('000000571',' Pediatrics'),
('000000571','Cancer'),
('000000572','Vascular Disease'),
('000000575','Cancer'),
('000000576',' Parkinson\'s Disease'),
('000000576','Neurological Disorders'),
('000000577',' Spinal Cord Injury'),
('000000577',' Stroke'),
('000000577',' Trauma'),
('000000577','Neurological Disorders'),
('000000578',' Vision Loss'),
('000000578','Aging'),
('000000584','Heart Disease'),
('000000586',' Metabolic Disorders'),
('000000586',' Pediatrics'),
('000000586',' Trauma'),
('000000586','Intestinal Disease'),
('000000587','Cancer'),
('000000589',' Metabolic Disorders'),
('000000589','Diabetes'),
('000000590',' Multiple Sclerosis'),
('000000590','Immune Disease'),
('000000591',' Neurological Disorders'),
('000000591','Cancer'),
('000000592','Bone or Cartilage Disease'),
('000000593','Hearing Loss'),
('000000595',' Muscular Dystrophy'),
('000000595','Genetic Disorder'),
('000000596','Fertility'),
('000000598',' Developmental Disorders'),
('000000598','Autism');

INSERT works_for VALUES('000000592','University of California, Davis');
INSERT works_for VALUES('000000535','University of California, San Francisco');
INSERT works_for VALUES('000000386','Stanford University');
INSERT works_for VALUES('000000382','University of California, Los Angeles');
INSERT works_for VALUES('000000104','University of California, Irvine');
INSERT works_for VALUES('000000107','ViaCyte, Inc.');
INSERT works_for VALUES('000000075','Stanford University');
INSERT works_for VALUES('000000034','Stanford University');
INSERT works_for VALUES('000000154','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000326','Children\'s Neurobiological Solutions (CNS) Foundation');
INSERT works_for VALUES('000000334','Stanford University');
INSERT works_for VALUES('000000351','StemCells, Inc.');
INSERT works_for VALUES('000000579','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000456','Stanford University');
INSERT works_for VALUES('000000147','Rumi Scientific CA');
INSERT works_for VALUES('000000322','University of California, Los Angeles');
INSERT works_for VALUES('000000111','University of California, Davis');
INSERT works_for VALUES('000000010','Vitabolus, Inc.');
INSERT works_for VALUES('000000116','University of California, Los Angeles');
INSERT works_for VALUES('000000458','ViaCyte, Inc.');
INSERT works_for VALUES('000000122','University of California, Davis');
INSERT works_for VALUES('000000168','University of California, San Diego');
INSERT works_for VALUES('000000523','University of California, Los Angeles');
INSERT works_for VALUES('000000340','University of California, San Diego');
INSERT works_for VALUES('000000056','Aspen Neuroscience');
INSERT works_for VALUES('000000190','University of California, San Francisco');
INSERT works_for VALUES('000000270','University of California, Berkeley');
INSERT works_for VALUES('000000249','University of California, San Francisco');
INSERT works_for VALUES('000000349','University of Southern California');
INSERT works_for VALUES('000000542','University of California, Irvine');
INSERT works_for VALUES('000000385','University of California, San Diego');
INSERT works_for VALUES('000000286','Human Organ Project');
INSERT works_for VALUES('000000434','La Jolla Institute for Allergy and Immunology');
INSERT works_for VALUES('000000325','University of California, San Francisco');
INSERT works_for VALUES('000000328','Stanford University');
INSERT works_for VALUES('000000225','ImmunoCellular Therapeutics');
INSERT works_for VALUES('000000136','International Alliance for Biological Standardization');
INSERT works_for VALUES('000000117','Stanford University');
INSERT works_for VALUES('000000345','University of California, Los Angeles');
INSERT works_for VALUES('000000109','University of California, Los Angeles');
INSERT works_for VALUES('000000186','University of California, Los Angeles');
INSERT works_for VALUES('000000358','University of California, San Francisco');
INSERT works_for VALUES('000000419','University of California, San Francisco');
INSERT works_for VALUES('000000384','Brain Mapping Foundation');
INSERT works_for VALUES('000000478','Berkeley City College');
INSERT works_for VALUES('000000343','University of California, San Francisco');
INSERT works_for VALUES('000000304','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000450','Escape Therapeutics, Inc');
INSERT works_for VALUES('000000452','University of California, Los Angeles');
INSERT works_for VALUES('000000508','University of California, San Diego');
INSERT works_for VALUES('000000189','University of California, Los Angeles');
INSERT works_for VALUES('000000338','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000379','University of California, Santa Barbara');
INSERT works_for VALUES('000000084','Stanford University');
INSERT works_for VALUES('000000090','Sangamo BioSciences, Inc.');
INSERT works_for VALUES('000000582','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000060','Cal State Univ, San Marcos');
INSERT works_for VALUES('000000141','SanBio, Inc.');
INSERT works_for VALUES('000000152','University of Southern California');
INSERT works_for VALUES('000000546','University of California, Santa Cruz');
INSERT works_for VALUES('000000504','Ludwig Institute for Cancer Research');
INSERT works_for VALUES('000000395','University of California, San Diego');
INSERT works_for VALUES('000000165','Parkinson\'s Institute');
INSERT works_for VALUES('000000091','Fate Therapeutics, Inc.');
INSERT works_for VALUES('000000477','University of California, San Francisco');
INSERT works_for VALUES('000000023','University of California, Irvine');
INSERT works_for VALUES('000000414','Stanford University');
INSERT works_for VALUES('000000039','University of California, Los Angeles');
INSERT works_for VALUES('000000524','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000420','University of California, Los Angeles');
INSERT works_for VALUES('000000586','Stanford University');
INSERT works_for VALUES('000000307','University of California, Santa Cruz');
INSERT works_for VALUES('000000217','City College Of San Francisco');
INSERT works_for VALUES('000000251','University of California, Los Angeles');
INSERT works_for VALUES('000000492','Scripps Research Institute');
INSERT works_for VALUES('000000488','San Francisco State University');
INSERT works_for VALUES('000000035','University of California, Los Angeles');
INSERT works_for VALUES('000000581','University of California, Berkeley');
INSERT works_for VALUES('000000555','Children\'s Hospital of Los Angeles');
INSERT works_for VALUES('000000097','International Society for Stem Cell Research');
INSERT works_for VALUES('000000119','University of California, San Diego');
INSERT works_for VALUES('000000389','University of California, San Diego');
INSERT works_for VALUES('000000591','University of California, Irvine');
INSERT works_for VALUES('000000509','Stanford University');
INSERT works_for VALUES('000000541','University of California, Davis');
INSERT works_for VALUES('000000176','Midwinter Conference of Immunologists');
INSERT works_for VALUES('000000279','University of California, San Diego');
INSERT works_for VALUES('000000134','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000444','Stanford University');
INSERT works_for VALUES('000000556','Stanford University');
INSERT works_for VALUES('000000536','University of Southern California');
INSERT works_for VALUES('000000218','Cal State Univ, Northridge');
INSERT works_for VALUES('000000047','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000131','Nohla Therapeutics Inc');
INSERT works_for VALUES('000000282','University of California, San Diego');
INSERT works_for VALUES('000000025','Neurona Therapeutics');
INSERT works_for VALUES('000000356','University of California, Irvine');
INSERT works_for VALUES('000000003','University of California, Los Angeles');
INSERT works_for VALUES('000000089','Stanford University');
INSERT works_for VALUES('000000594','Buck Institute for Age Research');
INSERT works_for VALUES('000000299','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000007','University of California, San Diego');
INSERT works_for VALUES('000000291','University of California, Los Angeles');
INSERT works_for VALUES('000000093','Medeor Therapeutics, Inc.');
INSERT works_for VALUES('000000412','University of California, San Francisco');
INSERT works_for VALUES('000000026','University of California, Irvine');
INSERT works_for VALUES('000000233','Scripps Health');
INSERT works_for VALUES('000000490','Children\'s Hospital of Los Angeles');
INSERT works_for VALUES('000000017','Boston Children\'s Hospital');
INSERT works_for VALUES('000000182','California Institute of Technology');
INSERT works_for VALUES('000000113','Loma Linda University');
INSERT works_for VALUES('000000267','University of California, San Diego');
INSERT works_for VALUES('000000426','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000573','University of California, Santa Cruz');
INSERT works_for VALUES('000000484','University of California, Santa Cruz');
INSERT works_for VALUES('000000578','University of Southern California');
INSERT works_for VALUES('000000377','University of California, Davis');
INSERT works_for VALUES('000000435','University of California, Berkeley');
INSERT works_for VALUES('000000095','University of California, San Francisco');
INSERT works_for VALUES('000000179','University of California, Berkeley');
INSERT works_for VALUES('000000231','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000180','University of California, Davis');
INSERT works_for VALUES('000000277','California Institute of Technology');
INSERT works_for VALUES('000000196','International Society for Experimental Hematology');
INSERT works_for VALUES('000000513','University of Southern California');
INSERT works_for VALUES('000000145','University of California, Davis');
INSERT works_for VALUES('000000315','FUJIFILM Cellular Dynamics');
INSERT works_for VALUES('000000398','University of California, San Diego');
INSERT works_for VALUES('000000331','Buck Institute for Age Research');
INSERT works_for VALUES('000000164','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000169','University of Southern California');
INSERT works_for VALUES('000000455','University of California, San Diego');
INSERT works_for VALUES('000000481','University of California, Santa Barbara');
INSERT works_for VALUES('000000288','University of California, Los Angeles');
INSERT works_for VALUES('000000077','Poseida Therapeutics, Inc.');
INSERT works_for VALUES('000000006','University of California, Davis');
INSERT works_for VALUES('000000256','University of California, San Francisco');
INSERT works_for VALUES('000000265','University of California, San Diego');
INSERT works_for VALUES('000000589','University of California, San Francisco');
INSERT works_for VALUES('000000195','University of California, San Diego');
INSERT works_for VALUES('000000114','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000008','University of California, Los Angeles');
INSERT works_for VALUES('000000376','University of California, San Diego');
INSERT works_for VALUES('000000438','University of California, Los Angeles');
INSERT works_for VALUES('000000538','Western University of Health Sciences');
INSERT works_for VALUES('000000497','Gamma Medica-Ideas, Inc.');
INSERT works_for VALUES('000000558','University of California, Irvine');
INSERT works_for VALUES('000000593','University of California, Davis');
INSERT works_for VALUES('000000342','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000226','Sanford Consortium for Regenerative Medicine');
INSERT works_for VALUES('000000066','Angiocrine Bioscience, Inc.');
INSERT works_for VALUES('000000506','University of California, Irvine');
INSERT works_for VALUES('000000009','Lundquist Institute for Biomedical Innovation at Harbor - UCLA Medical Center');
INSERT works_for VALUES('000000571','Children\'s Hospital of Los Angeles');
INSERT works_for VALUES('000000427','Vitalant Research Institute');
INSERT works_for VALUES('000000220','Childrens Hospital of Oakland Research Institute');
INSERT works_for VALUES('000000437','University of California, Berkeley');
INSERT works_for VALUES('000000321','University of California, Davis');
INSERT works_for VALUES('000000519','ViaCyte, Inc.');
INSERT works_for VALUES('000000428','University of California, San Francisco');
INSERT works_for VALUES('000000079','University of California, San Diego');
INSERT works_for VALUES('000000305','University of California, San Diego');
INSERT works_for VALUES('000000433','University of California, Davis');
INSERT works_for VALUES('000000574','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000139','JDRF International');
INSERT works_for VALUES('000000175','IQVIA, Inc.');
INSERT works_for VALUES('000000341','University of California, San Diego');
INSERT works_for VALUES('000000027','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000065','Stanford University');
INSERT works_for VALUES('000000501','ViaCyte, Inc.');
INSERT works_for VALUES('000000137','University of California, San Diego');
INSERT works_for VALUES('000000250','Stanford University');
INSERT works_for VALUES('000000388','University of California, San Diego');
INSERT works_for VALUES('000000083','MAX BioPharma, Inc.');
INSERT works_for VALUES('000000201','Semma Therapeutics');
INSERT works_for VALUES('000000598','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000223','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000317','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000404','University of California, Santa Barbara');
INSERT works_for VALUES('000000259','Lineage Cell Therapeutics Inc.');
INSERT works_for VALUES('000000476','University of California, Irvine');
INSERT works_for VALUES('000000585','University of California, Riverside');
INSERT works_for VALUES('000000424','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000487','University of California, Davis');
INSERT works_for VALUES('000000306','Sangamo BioSciences, Inc.');
INSERT works_for VALUES('000000473','University of California, Los Angeles');
INSERT works_for VALUES('000000507','University of Southern California');
INSERT works_for VALUES('000000446','Stanford University');
INSERT works_for VALUES('000000553','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000149','Stanford University');
INSERT works_for VALUES('000000040','University of California, Los Angeles');
INSERT works_for VALUES('000000019','Rocket Pharmaceuticals, Inc.');
INSERT works_for VALUES('000000531','University of California, Los Angeles');
INSERT works_for VALUES('000000457','Calimmune, Inc.');
INSERT works_for VALUES('000000528','University of California, Berkeley');
INSERT works_for VALUES('000000129','Alliance Forum Foundation');
INSERT works_for VALUES('000000336','University of California, San Diego');
INSERT works_for VALUES('000000235','Ocular Research Symposia Foundation, Inc.');
INSERT works_for VALUES('000000339','Stanford University');
INSERT works_for VALUES('000000298','University of California, Los Angeles');
INSERT works_for VALUES('000000123','University of California, San Diego');
INSERT works_for VALUES('000000043','University of California, Davis');
INSERT works_for VALUES('000000533','University of California, Santa Barbara');
INSERT works_for VALUES('000000096','International Society for Stem Cell Research');
INSERT works_for VALUES('000000597','University of California, Irvine');
INSERT works_for VALUES('000000568','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000121','Stanford University');
INSERT works_for VALUES('000000559','University of California, Los Angeles');
INSERT works_for VALUES('000000466','Stanford University');
INSERT works_for VALUES('000000240','University of California, Los Angeles');
INSERT works_for VALUES('000000557','University of California, Irvine');
INSERT works_for VALUES('000000562','University of California, San Francisco');
INSERT works_for VALUES('000000566','University of California, San Francisco');
INSERT works_for VALUES('000000021','Stanford University');
INSERT works_for VALUES('000000086','Childrens Hospital of Oakland Research Institute');
INSERT works_for VALUES('000000046','jCyte, Inc');
INSERT works_for VALUES('000000209','California Institute of Technology');
INSERT works_for VALUES('000000001','University of California, San Francisco');
INSERT works_for VALUES('000000042','Stanford University');
INSERT works_for VALUES('000000140','University of California, San Francisco');
INSERT works_for VALUES('000000335','Stanford University');
INSERT works_for VALUES('000000132','ViaCyte, Inc.');
INSERT works_for VALUES('000000494','University of California, Los Angeles');
INSERT works_for VALUES('000000583','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000333','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000448','Palo Alto Veterans Institute for Research');
INSERT works_for VALUES('000000297','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000431','iPierian, Inc.');
INSERT works_for VALUES('000000547','University of California, Berkeley');
INSERT works_for VALUES('000000416','University of California, Los Angeles');
INSERT works_for VALUES('000000244','Stanford University');
INSERT works_for VALUES('000000246','University of California, Davis');
INSERT works_for VALUES('000000471','Parkinson\'s Institute');
INSERT works_for VALUES('000000159','Cellular Biomedicine Group, Inc.');
INSERT works_for VALUES('000000185','University of California, Berkeley');
INSERT works_for VALUES('000000215','Humboldt State University');
INSERT works_for VALUES('000000312','University of California, San Francisco');
INSERT works_for VALUES('000000313','University of California, San Diego');
INSERT works_for VALUES('000000237','Stanford University');
INSERT works_for VALUES('000000362','Scripps Research Institute');
INSERT works_for VALUES('000000475','University of California, Davis');
INSERT works_for VALUES('000000602','Geron Corporation');
INSERT works_for VALUES('000000155','University of California, Irvine');
INSERT works_for VALUES('000000324','University of California, San Francisco');
INSERT works_for VALUES('000000285','University of California, San Francisco');
INSERT works_for VALUES('000000181','Scripps Research Institute');
INSERT works_for VALUES('000000442','University of California, San Francisco');
INSERT works_for VALUES('000000192','Stanford University');
INSERT works_for VALUES('000000133','Humacyte, Inc.');
INSERT works_for VALUES('000000515','University of California, San Francisco');
INSERT works_for VALUES('000000290','University of California, San Francisco');
INSERT works_for VALUES('000000261','Biocom Institute');
INSERT works_for VALUES('000000540','University of California, Merced');
INSERT works_for VALUES('000000202','University of California, San Francisco');
INSERT works_for VALUES('000000332','University of California, San Francisco');
INSERT works_for VALUES('000000033','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000411','GMR Epigenetics');
INSERT works_for VALUES('000000402','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000482','Cal Poly Pomona');
INSERT works_for VALUES('000000472','Stanford University');
INSERT works_for VALUES('000000309','Stanford University');
INSERT works_for VALUES('000000303','University of California, San Diego');
INSERT works_for VALUES('000000406','TriFoil Imaging, Inc.');
INSERT works_for VALUES('000000387','Stanford University');
INSERT works_for VALUES('000000391','Scripps Research Institute');
INSERT works_for VALUES('000000502','University of California, Santa Cruz');
INSERT works_for VALUES('000000100','University of California, Los Angeles');
INSERT works_for VALUES('000000124','Human BioMolecular Research Institute');
INSERT works_for VALUES('000000166','University of California, Los Angeles');
INSERT works_for VALUES('000000572','Stanford University');
INSERT works_for VALUES('000000417','iPierian, Inc.');
INSERT works_for VALUES('000000300','Numerate, Inc.');
INSERT works_for VALUES('000000527','Stanford University');
INSERT works_for VALUES('000000373','Samumed, LLC');
INSERT works_for VALUES('000000346','University of California, Davis');
INSERT works_for VALUES('000000399','University of California, San Francisco');
INSERT works_for VALUES('000000222','University of California, San Diego');
INSERT works_for VALUES('000000445','University of California, San Francisco');
INSERT works_for VALUES('000000532','University of California, Merced');
INSERT works_for VALUES('000000405','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000041','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000071','University of California, San Diego');
INSERT works_for VALUES('000000198','University of California, Davis');
INSERT works_for VALUES('000000269','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000311','University of California, San Diego');
INSERT works_for VALUES('000000238','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000092','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000005','Immune-Onc Therapeutics');
INSERT works_for VALUES('000000098','Stanford University');
INSERT works_for VALUES('000000271','University of California, Santa Cruz');
INSERT works_for VALUES('000000355','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000062','Stanford University');
INSERT works_for VALUES('000000110','Loma Linda University');
INSERT works_for VALUES('000000521','Stanford University');
INSERT works_for VALUES('000000167','University of California, San Francisco');
INSERT works_for VALUES('000000301','Stanford University');
INSERT works_for VALUES('000000150','Scaled Biolabs Inc.');
INSERT works_for VALUES('000000012','University of Southern California');
INSERT works_for VALUES('000000310','University of California, San Diego');
INSERT works_for VALUES('000000262','University of California, Merced');
INSERT works_for VALUES('000000050','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000024','University of California, San Diego');
INSERT works_for VALUES('000000068','University of California, San Francisco');
INSERT works_for VALUES('000000378','University of California, San Francisco');
INSERT works_for VALUES('000000548','Stanford University');
INSERT works_for VALUES('000000118','University of California, San Diego');
INSERT works_for VALUES('000000408','University of California, San Diego');
INSERT works_for VALUES('000000381','Stanford University');
INSERT works_for VALUES('000000206','University of California, San Francisco');
INSERT works_for VALUES('000000337','University of California, Los Angeles');
INSERT works_for VALUES('000000360','University of Southern California');
INSERT works_for VALUES('000000078','Stanford University');
INSERT works_for VALUES('000000480','University of California, Los Angeles');
INSERT works_for VALUES('000000443','Stanford University');
INSERT works_for VALUES('000000183','ViaCyte, Inc.');
INSERT works_for VALUES('000000022','University of California, Berkeley');
INSERT works_for VALUES('000000059','Rocket Pharmaceuticals, Inc.');
INSERT works_for VALUES('000000503','University of California, Davis');
INSERT works_for VALUES('000000584','Stanford University');
INSERT works_for VALUES('000000125','Calibr');
INSERT works_for VALUES('000000397','Scripps Research Institute');
INSERT works_for VALUES('000000491','VistaGen Therapeutics, Inc.');
INSERT works_for VALUES('000000049','Brain Neurotherapy Bio');
INSERT works_for VALUES('000000400','University of California, San Diego');
INSERT works_for VALUES('000000451','University of California, San Diego');
INSERT works_for VALUES('000000108','Stanford University');
INSERT works_for VALUES('000000595','University of California, Irvine');
INSERT works_for VALUES('000000353','University of California, Davis');
INSERT works_for VALUES('000000500','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000529','University of California, Davis');
INSERT works_for VALUES('000000248','University of California, Davis');
INSERT works_for VALUES('000000200','University of California, San Diego');
INSERT works_for VALUES('000000545','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000252','University of California, Los Angeles');
INSERT works_for VALUES('000000004','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000253','Gordon Research Conferences');
INSERT works_for VALUES('000000173','Orchard Therapeutics plc');
INSERT works_for VALUES('000000064','University of California, Irvine');
INSERT works_for VALUES('000000080','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000002','University of California, Los Angeles');
INSERT works_for VALUES('000000213','San Francisco State University');
INSERT works_for VALUES('000000511','University of California, Berkeley');
INSERT works_for VALUES('000000365','University of California, Santa Barbara');
INSERT works_for VALUES('000000187','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000551','University of California, San Francisco');
INSERT works_for VALUES('000000199','Capricor, Inc');
INSERT works_for VALUES('000000549','University of California, Santa Cruz');
INSERT works_for VALUES('000000278','University of California, Irvine');
INSERT works_for VALUES('000000212','Cal State Univ, Sacramento');
INSERT works_for VALUES('000000210','Cal State Univ, Long Beach');
INSERT works_for VALUES('000000514','University of California, San Francisco');
INSERT works_for VALUES('000000462','University of California, Los Angeles');
INSERT works_for VALUES('000000085','University of California, Irvine');
INSERT works_for VALUES('000000273','University of California, San Diego');
INSERT works_for VALUES('000000323','University of California, San Diego');
INSERT works_for VALUES('000000415','Fluidigm Corporation');
INSERT works_for VALUES('000000372','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000193','Vitalant Research Institute');
INSERT works_for VALUES('000000534','University of California, Santa Cruz');
INSERT works_for VALUES('000000449','University of California, Irvine');
INSERT works_for VALUES('000000327','Research for Cure');
INSERT works_for VALUES('000000275','Stanford University');
INSERT works_for VALUES('000000020','University of California, San Diego');
INSERT works_for VALUES('000000283','University of California, San Francisco');
INSERT works_for VALUES('000000601','Forty Seven Inc.');
INSERT works_for VALUES('000000052','University of Southern California');
INSERT works_for VALUES('000000580','Stanford University');
INSERT works_for VALUES('000000144','Stanford University');
INSERT works_for VALUES('000000057','University of California, San Francisco');
INSERT works_for VALUES('000000289','University of California, Davis');
INSERT works_for VALUES('000000423','University of California, Davis');
INSERT works_for VALUES('000000148','Children\'s Hospital of Los Angeles');
INSERT works_for VALUES('000000418','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000463','University of Southern California');
INSERT works_for VALUES('000000370','University of California, Davis');
INSERT works_for VALUES('000000468','Scripps Research Institute');
INSERT works_for VALUES('000000453','University of California, San Diego');
INSERT works_for VALUES('000000413','University of California, Los Angeles');
INSERT works_for VALUES('000000375','University of California, Los Angeles');
INSERT works_for VALUES('000000526','Buck Institute for Age Research');
INSERT works_for VALUES('000000011','University of California, Irvine');
INSERT works_for VALUES('000000302','OCTANe Foundation for Innovation');
INSERT works_for VALUES('000000130','Stanford University');
INSERT works_for VALUES('000000127','Poseida Therapeutics, Inc.');
INSERT works_for VALUES('000000053','University of California, Davis');
INSERT works_for VALUES('000000479','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000396','Stanford University');
INSERT works_for VALUES('000000329','Stanford University');
INSERT works_for VALUES('000000530','University of California, Irvine');
INSERT works_for VALUES('000000172','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000516','Stanford University');
INSERT works_for VALUES('000000037','University of California, San Francisco');
INSERT works_for VALUES('000000496','University of California, Los Angeles');
INSERT works_for VALUES('000000565','University of California, Riverside');
INSERT works_for VALUES('000000126','Children\'s Hospital of Los Angeles');
INSERT works_for VALUES('000000401','University of California, Berkeley');
INSERT works_for VALUES('000000266','Stanford University');
INSERT works_for VALUES('000000464','University of California, Los Angeles');
INSERT works_for VALUES('000000474','BioTime, Inc.');
INSERT works_for VALUES('000000294','Stanford University');
INSERT works_for VALUES('000000260','University of California, Irvine');
INSERT works_for VALUES('000000318','Stanford University');
INSERT works_for VALUES('000000330','University of California, San Francisco');
INSERT works_for VALUES('000000272','University of California, San Diego');
INSERT works_for VALUES('000000460','University of California, Davis');
INSERT works_for VALUES('000000454','University of California, San Francisco');
INSERT works_for VALUES('000000537','Mohammad Pashmforoush');
INSERT works_for VALUES('000000088','University of California, San Francisco');
INSERT works_for VALUES('000000347','University of California, Davis');
INSERT works_for VALUES('000000156','American Association of Blood Banks');
INSERT works_for VALUES('000000074','University of Southern California');
INSERT works_for VALUES('000000112','Palo Alto Veterans Institute for Research');
INSERT works_for VALUES('000000447','Scripps Research Institute');
INSERT works_for VALUES('000000219','Cal State Univ, San Bernadino');
INSERT works_for VALUES('000000207','Cal State Univ, Fullerton');
INSERT works_for VALUES('000000205','Cal State Univ, Channel Island');
INSERT works_for VALUES('000000425','University of California, Los Angeles');
INSERT works_for VALUES('000000467','ViaCyte, Inc.');
INSERT works_for VALUES('000000224','Gordon Research Conferences');
INSERT works_for VALUES('000000495','University of California, Irvine');
INSERT works_for VALUES('000000191','University of California, Los Angeles');
INSERT works_for VALUES('000000470','Jackson Labs');
INSERT works_for VALUES('000000216','Pasadena City College');
INSERT works_for VALUES('000000498','Vala Sciences, Inc.');
INSERT works_for VALUES('000000204','Angiocrine Bioscience, Inc.');
INSERT works_for VALUES('000000510','University of California, Davis');
INSERT works_for VALUES('000000280','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000369','California Institute of Technology');
INSERT works_for VALUES('000000171','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000208','Stanford University');
INSERT works_for VALUES('000000245','University of Southern California');
INSERT works_for VALUES('000000197','University of California, Los Angeles');
INSERT works_for VALUES('000000287','University of California, Davis');
INSERT works_for VALUES('000000600','University of California, Irvine');
INSERT works_for VALUES('000000421','University of California, Santa Barbara');
INSERT works_for VALUES('000000268','University of California, Irvine');
INSERT works_for VALUES('000000587','University of Southern California');
INSERT works_for VALUES('000000184','IQVIA, Inc.');
INSERT works_for VALUES('000000228','Calibr');
INSERT works_for VALUES('000000055','University of California, San Francisco');
INSERT works_for VALUES('000000073','Stanford University');
INSERT works_for VALUES('000000359','Children\'s Hospital of Orange County');
INSERT works_for VALUES('000000188','Stanford University');
INSERT works_for VALUES('000000038','ExCellThera Inc.');
INSERT works_for VALUES('000000499','University of Southern California');
INSERT works_for VALUES('000000030','University of Southern California');
INSERT works_for VALUES('000000550','University of California, Riverside');
INSERT works_for VALUES('000000247','University of Southern California');
INSERT works_for VALUES('000000234','University of Southern California');
INSERT works_for VALUES('000000403','Parkinson\'s Institute');
INSERT works_for VALUES('000000352','Capricor, Inc');
INSERT works_for VALUES('000000174','San Diego State University Foundation');
INSERT works_for VALUES('000000138','BrainStorm Cell Therapeutics');
INSERT works_for VALUES('000000561','University of California, San Francisco');
INSERT works_for VALUES('000000236','University of California, Davis');
INSERT works_for VALUES('000000599','University of California, Berkeley');
INSERT works_for VALUES('000000292','University of California, San Francisco');
INSERT works_for VALUES('000000518','Stanford University');
INSERT works_for VALUES('000000320','University of California, Los Angeles');
INSERT works_for VALUES('000000512','San Diego State University Foundation');
INSERT works_for VALUES('000000410','University of California, Los Angeles');
INSERT works_for VALUES('000000368','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000459','University of California, Los Angeles');
INSERT works_for VALUES('000000230','Caladrius Biosciences');
INSERT works_for VALUES('000000525','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000319','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000505','University of California, San Francisco');
INSERT works_for VALUES('000000013','University of California, Irvine');
INSERT works_for VALUES('000000485','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000486','University of Southern California');
INSERT works_for VALUES('000000432','Stanford University');
INSERT works_for VALUES('000000596','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000295','University of California, Los Angeles');
INSERT works_for VALUES('000000374','Stanford University');
INSERT works_for VALUES('000000177','University of California, San Diego');
INSERT works_for VALUES('000000344','University of California, Berkeley');
INSERT works_for VALUES('000000429','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000364','University of Southern California');
INSERT works_for VALUES('000000163','Stanford University');
INSERT works_for VALUES('000000367','International Symposium on Neural Regeneration, Inc.');
INSERT works_for VALUES('000000203','Mosaic Event Management, Inc.');
INSERT works_for VALUES('000000081','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000383','University of California, Irvine');
INSERT works_for VALUES('000000045','Stanford University');
INSERT works_for VALUES('000000232','University of California, Davis');
INSERT works_for VALUES('000000380','University of California, San Diego');
INSERT works_for VALUES('000000281','University of California, Los Angeles');
INSERT works_for VALUES('000000517','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000563','University of California, San Francisco');
INSERT works_for VALUES('000000157','Stanford University');
INSERT works_for VALUES('000000242','Stanford University');
INSERT works_for VALUES('000000105','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000051','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000102','University of California, Los Angeles');
INSERT works_for VALUES('000000554','University of California, Los Angeles');
INSERT works_for VALUES('000000390','Stanford University');
INSERT works_for VALUES('000000120','University of California, San Francisco');
INSERT works_for VALUES('000000194','Children\'s Hospital of Los Angeles');
INSERT works_for VALUES('000000564','Salk Institute for Biological Studies');
INSERT works_for VALUES('000000363','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000241','University of California, San Diego');
INSERT works_for VALUES('000000229','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000263','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000178','Vitalant Research Institute');
INSERT works_for VALUES('000000308','University of California, San Diego');
INSERT works_for VALUES('000000394','University of California, Los Angeles');
INSERT works_for VALUES('000000103','University of California, San Francisco');
INSERT works_for VALUES('000000243','University of California, San Diego');
INSERT works_for VALUES('000000539','University of California, Los Angeles');
INSERT works_for VALUES('000000227','University of California, Irvine');
INSERT works_for VALUES('000000031','University of California, Los Angeles');
INSERT works_for VALUES('000000158','University of California, Los Angeles');
INSERT works_for VALUES('000000544','University of Southern California');
INSERT works_for VALUES('000000153','University of California, San Francisco');
INSERT works_for VALUES('000000048','University of California, Los Angeles');
INSERT works_for VALUES('000000014','University of California, Los Angeles');
INSERT works_for VALUES('000000350','University of California, Los Angeles');
INSERT works_for VALUES('000000560','Stanford University');
INSERT works_for VALUES('000000054','University of California, San Diego');
INSERT works_for VALUES('000000354','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000161','St. Jude Children\'s Research Hospital');
INSERT works_for VALUES('000000028','University of California, San Diego');
INSERT works_for VALUES('000000441','Stanford University');
INSERT works_for VALUES('000000407','University of California, Berkeley');
INSERT works_for VALUES('000000018','University of California, San Francisco');
INSERT works_for VALUES('000000082','University of California, Los Angeles');
INSERT works_for VALUES('000000254','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000087','University of California, San Francisco');
INSERT works_for VALUES('000000069','University of California, Los Angeles');
INSERT works_for VALUES('000000293','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000036','Scripps Research Institute');
INSERT works_for VALUES('000000576','University of California, San Francisco');
INSERT works_for VALUES('000000465','Stanford University');
INSERT works_for VALUES('000000255','University of California, San Francisco');
INSERT works_for VALUES('000000151','Cellerant Therapeutics, Inc.');
INSERT works_for VALUES('000000483','University of California, San Diego');
INSERT works_for VALUES('000000101','University of California, San Diego');
INSERT works_for VALUES('000000015','University of California, San Diego');
INSERT works_for VALUES('000000316','University of California, Los Angeles');
INSERT works_for VALUES('000000162','University of California, San Francisco');
INSERT works_for VALUES('000000440','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000094','Keystone Symposia on Molecular and Cellular Biology');
INSERT works_for VALUES('000000575','University of California, San Francisco');
INSERT works_for VALUES('000000409','Stanford University');
INSERT works_for VALUES('000000058','University of California, Los Angeles');
INSERT works_for VALUES('000000070','Stanford University');
INSERT works_for VALUES('000000135','University of California, San Diego');
INSERT works_for VALUES('000000590','University of California, Irvine');
INSERT works_for VALUES('000000314','Cellular Dynamics International');
INSERT works_for VALUES('000000284','Palo Alto Veterans Institute for Research');
INSERT works_for VALUES('000000567','Stanford University');
INSERT works_for VALUES('000000128','RUNX1 Research Program');
INSERT works_for VALUES('000000371','OncoMed Pharmaceuticals, Inc.');
INSERT works_for VALUES('000000570','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000142','University of California, San Francisco');
INSERT works_for VALUES('000000543','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000258','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000436','Palo Alto Veterans Institute for Research');
INSERT works_for VALUES('000000239','University of Southern California');
INSERT works_for VALUES('000000072','Children\'s Hospital of Los Angeles');
INSERT works_for VALUES('000000211','Cal Poly Corporation, an Auxiliary of California Polytechnic State University, San Luis Obispo');
INSERT works_for VALUES('000000214','San Jose State University');
INSERT works_for VALUES('000000489','Scripps Research Institute');
INSERT works_for VALUES('000000032','University of California, Los Angeles');
INSERT works_for VALUES('000000264','University of California, San Francisco');
INSERT works_for VALUES('000000361','Childrens Hospital of Oakland Research Institute');
INSERT works_for VALUES('000000115','Zenobia Therapeutics');
INSERT works_for VALUES('000000348','University of California, Davis');
INSERT works_for VALUES('000000067','Pathways to Stem Cell Science');
INSERT works_for VALUES('000000366','Buck Institute for Age Research');
INSERT works_for VALUES('000000588','University of California, Irvine');
INSERT works_for VALUES('000000552','Stanford University');
INSERT works_for VALUES('000000221','Cedars-Sinai Medical Center');
INSERT works_for VALUES('000000357','University of California, Davis');
INSERT works_for VALUES('000000461','University of Southern California');
INSERT works_for VALUES('000000469','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000522','Ludwig Institute for Cancer Research');
INSERT works_for VALUES('000000274','University of California, San Diego');
INSERT works_for VALUES('000000063','Jasper Therapeutics, Inc.');
INSERT works_for VALUES('000000392','University of California, Los Angeles');
INSERT works_for VALUES('000000430','University of California, Davis');
INSERT works_for VALUES('000000160','Caladrius Biosciences');
INSERT works_for VALUES('000000257','University of California, Berkeley');
INSERT works_for VALUES('000000422','Buck Institute for Age Research');
INSERT works_for VALUES('000000029','Celularity Inc');
INSERT works_for VALUES('000000099','University of California, Riverside');
INSERT works_for VALUES('000000146','X-Therma Inc.');
INSERT works_for VALUES('000000276','Stanford University');
INSERT works_for VALUES('000000076','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000170','Gladstone Institutes, J. David');
INSERT works_for VALUES('000000106','University of California, San Diego');
INSERT works_for VALUES('000000016','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000393','University of California, Los Angeles');
INSERT works_for VALUES('000000493','University of California, San Diego');
INSERT works_for VALUES('000000061','Ankasa Regenerative Therapeutics');
INSERT works_for VALUES('000000439','University of California, Los Angeles');
INSERT works_for VALUES('000000143','City of Hope, Beckman Research Institute');
INSERT works_for VALUES('000000044','University of California, Los Angeles');
INSERT works_for VALUES('000000296','University of California, Los Angeles');
INSERT works_for VALUES('000000520','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000577','Sanford Burnham Prebys Medical Discovery Institute');
INSERT works_for VALUES('000000569','University of California, Los Angeles');

