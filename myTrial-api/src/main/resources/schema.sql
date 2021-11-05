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
    phase varchar(10) not null,
    title varchar(300) not null,
    org_name varchar(300),
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
    disease varchar(300) not null,
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
    trial_id varchar(9),
    primary key (org_name),
    foreign key (trial_id) references trial (trial_id)
);

CREATE TABLE r_disease_area (
    researcher_id varchar(9) not null,
    disease varchar(300) not null,
    primary key (researcher_id, disease),
    foreign key (researcher_id) references researcher (researcher_id)
);

CREATE TABLE ct_grant
	(grant_number		varchar(8), 
	 grant_title		varchar(20), 
         trial_id		varchar(9) DEFAULT -1, 
	 disease_focus		varchar(20),
     start_date			date,
     end_date			date,
     type			varchar(20), 
     award_status		varchar(20),
     institution		varchar(20),
     stem_cell_use		varchar(30),
     amount			decimal(10,2) check (amount > 0),		
	 primary key (grant_number),
		foreign key (trial_id) references trial(trial_id)
		on delete set default
	);
    
    
CREATE TABLE r_watchlist
	( name			    varchar(20), 
	 researcher_id		    varchar(9) DEFAULT -1, 
	 disease_area		    varchar(20),
	 primary key (name, researcher_id),
	 foreign key (researcher_id) references researcher(researcher_id)
		on delete set default
	);

-- INSERT into Database TABLES
INSERT trial VALUES
("179431196","Active, not recruiting",16,"NCT02590692","Phase 1","Phase 1 Safety Assessment of CPCB-RPE1, hESC-derived RPE Cell Coated Parylene Membrane Implants, in Patients with Advanced Dry Age Related Macular Degeneration","University of Southern California"),
("354923182","Recruiting",10,"NCT02986698","Phase 1","In Utero Hematopoietic Stem Cell Transplantation For The Treatment Of Fetuses With Alpha Thalassemia Major","University of California, San Francisco"),
("618295341","Completed",261,"NCT03280056","Phase 3","A Phase 3, Randomized, Placebo-controlled Multicenter Study to Evaluate Efficacy & Safety of Repeated Administrations of NurOwn® in Patients with ALS","BrainStorm Cell Therapeutics"),
("153036181","Completed",18,"NCT02943850","Phase 1/2","Progenitor Cells Secreting GDNF for the Treatment of ALS","Cedars-Sinai Medical Center"),
("559172804","Recruiting",57,"NCT03233854","Phase 1","Phase 1 Study of CD19/CD22 Chimeric Antigen Receptor (CAR) T Cells in Adults with Recurrent or Refractory B Cell Malignancies","Stanford University"),
("215107784","Recruiting",156,"NCT03088878","Phase 1/2","A Phase 1b/2a Study of the ROR1-Targeting Monoclonal Antibody, Cirmtuzumab, and the Bruton Tyrosine Kinase Inhibitor, Ibrutinib, in B-Cell Cancers","University of California, San Diego"),
("395472507","Active, not recruiting",6,"NCT03432364","Phase 1/2","A Phase 1/2 Study to Assess the Safety, Tolerability, and Efficacy of ST-400 Autologous HSPC Transplant in Transfusion-dependent β-Thalassemia","Sangamo BioSciences, Inc."),
("488589151","Active, not recruiting",10,"NCT03483324","Phase 1","AB-110-001 Phase 1b Trial and Related Activities to Support Clinical Development of AB-110","Angiocrine Bioscience, Inc."),
("264882075","Active, not recruiting",42,"NCT03925935","Phase 1","Trial of AB-205 in Adults With Lymphoma Undergoing High-Dose Therapy and Autologous Stem Cell Transplantation","Angiocrine Bioscience, Inc."),
("112097238","Active, not recruiting",60,"NCT03475212","Phase 1/2","Antiviral Cellular Therapy for Enhancing T-cell Reconstitution Before or After Hematopoietic Stem Cell Transplantation (ACES)","Children's Hospital of Los Angeles"),
("144571942","Completed",88,"NCT02216409","Phase 1","Clinical Investigation of a Humanized Anti-CD47 Antibody in Targeting Cancer Stem Cells in Hematologic Malignancies and Solid Tumors","Stanford University"),
("699291832","Completed",26,"NCT02222688","Phase 1","Therapeutic Eradication of Cancer Stem Cells with UC-961 (Cirmtuzumab)","University of California, San Diego"),
("445221155","Recruiting",2,"NCT04525352","Phase 1","A Phase I Clinical Trial for a Lentiviral Gene Therapy Targeting the TCIRG1 Gene for Infantile Malignant Osteopetrosis (IMO)","Rocket Pharmaceuticals, Inc."),
("912265363","Recruiting",92,"NCT02208362","Phase 1","Phase I Study of Chimeric Antigen Receptor Engineered Central Memory T cells for the Treatment of Malignant Glioma","City of Hope, Beckman Research Institute"),
("724720172","Recruiting",39,"NCT03696030","Phase 1","A Phase I Study of Chimeric Antigen Receptor Engineered Stem/Memory T Cells for the Treatment of HER2-Positive Brain Metastases","City of Hope, Beckman Research Institute"),
("930279876","Recruiting",18,"NCT04510051","Phase 1","Phase I Study of IL13Rα2-Targeting CAR T Cells After Lymphodepletion for Children with Refractory or Recurrent Malignant Brain Tumors","City of Hope, Beckman Research Institute"),
("968023395","Suspended",414,"NCT02546102","Phase 3","A Phase III randomized double-blind, controlled study of ICT 107 with maintenance temozolomide (TMZ) in newly diagnosed glioblastoma following resection and concomitant TMZ chemoradiotherapy","ImmunoCellular Therapeutics"),
("211312774","Completed",78,"NCT02953782","Phase 1/2","A Phase 1b/2 Trial of the Anti-CD47 Antibody Hu5F9-G4 in Combination with Cetuximab in Patients with Solid Tumors and Advanced Colorectal Cancer","Forty Seven Inc."),
("548379726","Recruiting",20,"NCT03957954","Phase 1","Safety and Feasibility of Cultivated Autologous Limbal Stem Cells for Limbal Stem Cell Deficiency","University of California, Los Angeles"),
("126859008","Active, not recruiting",86,"NCT04365101","Phase 1/2","A phase I/II study of human placental hematopoietic stem cell derived natural killer cells (CYNK-001) for the treatment of adults with COVID-19","Celularity Inc"),
("674664083","Launching",null,"","Phase 1","Evaluation and Characterization of SARS-CoV-2 Antibody in Convalescent Volunteer Plasma Donors for Potential Therapeutic Use","City of Hope, Beckman Research Institute"),
("405167503","Recruiting",120,"NCT03818854","Phase 2","Mesenchymal Stromal Cells for ARDS (COVID positive and COVID negative)","University of California, San Francisco"),
("472613885","Completed",25,"NCT02485938","Phase 2","Allogeneic Cardiosphere-Derived Cells for Duchenne Muscular Dystrophy Cardiomyopathy","Capricor, Inc"),
("456061992","Closed",156,"NCT01458405","Phase 2","Allogeneic Cardiac-Derived Stem Cells for Patients Following a Myocardial Infarction","Capricor, Inc"),
("154998134","Recruiting",18,"NCT02797470","Phase 1/2","Stem Cell Gene Therapy for HIV Mediated by Lentivector Transduced, Pre-selected CD34+ Cells in AIDS lymphoma patients","University of California, Davis"),
("847776695","Completed",13,"NCT01734850","Phase 1/2","GENE-MODIFIED HEMATOPOIETIC STEM/PROGENITOR CELL BASED THERAPY FOR HIV DISEASE","Calimmune, Inc."),
("337115119","Active, not recruiting",12,"NCT02500849","Phase 1","A Phase I, Open-Label Study To Assess The Safety, Feasibility and Engraftment of Zinc Finger Nucleases (ZFN) CCR5 Modified Autologous CD34+ Hematopoietic Stem/Progenitor Cells (SB-728MR-HSPC) with Escalating Doses of Busulfan In HIV-1 (R5) Infected Subjec","City of Hope, Beckman Research Institute"),
("658145356","Launching",null,"NCT04648046","Phase 1/2","Anti-HIV duoCAR-T cell therapy for HIV infection","University of California, San Francisco"),
("835742418","Completed",29,"NCT01937923","Phase 1/2","MSC engineered to produce BDNF for the treatment of Huntington's disease","University of California, Davis"),
("265770499","Active, not recruiting",355,"NCT02644941","Phase 3","A Human Acellular Vessel in Patients Needing Renal Replacement Therapy: A Comparison with ePTFE Grafts as Conduits for Hemodialysis (HUMANITY)","Humacyte, Inc."),
("569576576","Recruiting",240,"NCT03183245","Phase 3","A Phase 3 Study Comparing the Utility of Human Acellular Vessels  to Arteriovenous Fistula in Subjects with End-Stage Renal Disease (California Sites)","Humacyte, Inc."),
("543072310","Active, not recruiting",30,"NCT03363945","Phase 3","Cellular Immunotherapy for Induction of Immune Tolerance in HLA Matched Living Donor Kidney Transplant Recipients","Medeor Therapeutics, Inc."),
("377241337","Recruiting",22,"NCT03943238","Phase 1","Induction of Tolerance by Combinatorial Therapy w/ Donor Stem Cells and Expanded Recipient Treg cells in HLA-mismatched Kidney Transplant Recipients","Stanford University"),
("142294510","Active, not recruiting",15,"NCT00319657","Phase 1","Induction of Tolerance to Combined Kidney and Hematopoietic Progenitor Cell Transplants from HLA Haplotype Matched Living Donors","Stanford University"),
("420180594","Recruiting",6,"NCT03897361","Phase 1/2","Phase 1/2 study for autologous human CD34+ hematopoietic stem cells ex vivo transduced with pCCL-CTNS lentiviral vector for treatment of Cystinosis.","University of California, San Diego"),
("900330719","Recruiting",287,"NCT03248479","Phase 1","A Phase 1b Trial of Hu5F9-G4 Monotherapy or Hu5F9-G4 in Combination with Azacitidine in Patients with Acute Myeloid Leukemia","Forty Seven Inc."),
("428643122","Recruiting",44,"NCT04372433","Phase 1","Phase 1 Clinical Development of IO-202, A First-in-Class Antibody Targeting LILRB4, for the Treatment of AML with Monocytic Differentiation and CMML","Immune-Onc Therapeutics"),
("662635471","Closed",146,"NCT03301597","Phase 2","A Phase 2 Open-Label, Multi-Center, Randomized, Controlled, Optimal Dose-Finding Study of DCC-UCB in Adults Receiving High Dose Chemotherapy for AML","Nohla Therapeutics Inc"),
("141872240","Recruiting",9,"NCT03812263","Phase 1/2","A Clinical Trial to Evaluate the Safety and Efficacy of RP-L201 in Subjects With Leukocyte Adhesion Deficiency-I","Rocket Pharmaceuticals, Inc."),
("743173689","Recruiting",24,"NCT03546361","Phase 1","A phase I trial of intratumoral administration of CCL21-gene modified dendritic cell (DC) combined with intravenous pembrolizumab for advanced NSCLC","University of California, Los Angeles"),
("543704704","Closed",4,"NCT01875653","Phase 3","Tumor stem cell-targeted immunotherapy for metastatic melanoma –a randomized phase 3 clinical trial.","Caladrius Biosciences"),
("189549202","Recruiting",12,"NCT03240861","Phase 1","Genetic Re-programming of Stem Cells to Fight Cancer","University of California, Los Angeles"),
("386557613","Recruiting",220,"NCT03288493","Phase 1","Clinical Study of T stem cell memory (Tscm)-based CAR-T cells in Patients with Multiple Myeloma","Poseida Therapeutics, Inc."),
("599402117","Completed",60,"NCT03133676","Phase 1","Evaluation of the Safety and Tolerability of KA34 in a Phase 1, Double-Blind, Dose Escalation Trial in Patients with Knee Osteoarthritis","Calibr"),
("640955231","Active, not recruiting",59,"NCT03197623","Phase 1/2","Treatment of non-traumatic osteonecrosis with endogenous Mesenchymal stem cells","University of California, Davis"),
("700280774","Recruiting",12,"NCT04167540","Phase 1","A Phase 1b Safety Study for MRI guided delivery of AAV2-GDNF for the treatment of Parkinson’s disease","Brain Neurotherapy Bio"),
("989840466","Recruiting",26,"NCT03145298","Phase 1/2","Pulmonary Arterial Hypertension Treated with Cardiosphere-Derived Allogeneic Stem Cells","Cedars-Sinai Medical Center"),
("290045516","Recruiting",16,"NCT04284293","Phase 1","Clinical Study to Assess Safety and Efficacy of Subretinal Injection of Human Neural Progenitor Cells for Treatment of Retinitis Pigmentosa","Cedars-Sinai Medical Center"),
("348055147","Completed",84,"NCT03073733","Phase 2","A Phase 2 Study of the Safety of Repeat Intravitreal Injection of Human Retinal Progenitor Cells (jCell) in Adult Subjects with Retinitis Pigmentosa","jCyte, Inc"),
("950189050","Completed",84,"NCT03073733","Phase 2","Phase 2b Clinical Study of Safety and Efficacy of Intravitreal Injection of Retinal Progenitor Cells (jCell)  for Treatment of Retinitis Pigmentosa","jCyte, Inc"),
("554921585","Completed",28,"NCT02320812","Phase 1/2","Retinal progenitor cells for treatment of retinitis pigmentosa","University of California, Irvine"),
("393572823","Recruiting",12,"NCT03240861","Phase 1","Genetically Engineered PBMC and PBSC Expressing NY-ESO-1 TCR After a Myeloablative Conditioning Regimen to Treat Patients With Advanced Cancer (NYESO SCT)","University of California, Los Angeles"),
("996564243","Completed",10,"NCT02999984","Phase 2","Efficacy and safety of cryopreserved autologous CD34+ HSC transduced with EFS lentiviral vector encoding for human ADA gene in ADA-SCID subjects","University of California, Los Angeles"),
("794945806","Recruiting",15,"NCT03538899","Phase 1","Gene Transfer for Artemis-Deficient Severe Combined Immunodeficiency Using a Lentiviral Vector to Transduce Autologous CD34 Hematopoietic Stem Cells","University of California, San Francisco"),
("991056597","Recruiting",28,"NCT01512888","Phase 1/2","Lentiviral Gene Therapy for Infants with X-linked Severe Combined Immunodeficiency using Autologous Bone Marrow Stem Cells and Busulfan Conditioning","St. Jude Children's Research Hospital"),
("579693919","Recruiting",40,"NCT02963064","Phase 1/2","A monoclonal antibody that depletes blood stem cells and enables chemotherapy free transplants","Stanford University"),
("746175381","Suspended",15,"NCT03282656","Phase 2","Phase 2 Study of Hematopoietic Stem Cell Gene Transfer Inducing Fetal Hemoglobin in Sickle Cell Disease","Boston Children's Hospital"),
("976431381","Recruiting",6,"NCT03249831","Phase 1","Treatment of sickle cell disease by induction of  mixed chimerism and immune tolerance using CD4+ T-depleted haploidentical blood stem cell transplant","City of Hope, Beckman Research Institute"),
("524014957","Not yet recruiting",12,"NCT04594031","Phase 1","A Phase 1 Study of ECT-001 Expanded Cord Blood and Myeloablative Regimen with Reduced Toxicity in Patients with Severe Sickle Cell Disease","ExCellThera Inc."),
("775336843","Active, not recruiting",6,"NCT02247843","Phase 1","Clinical Trial of Stem Cell Gene Therapy for Sickle Cell Disease","University of California, Los Angeles"),
("299238214","Active, not recruiting",48,"NCT01954316","Phase 1","A Phase I dose escalation and expansion clinical trial of the novel first-in-class Polo-like Kinase 4 (PLK4) inhibitor, CFI-400945 in patients with advanced solid tumors","University of California, Los Angeles"),
("622076833","Recruiting",35,"NCT04652908","Phase 1","The CuRe Trial: Cellular Therapy for In Utero Myelomeningocele Repair","University of California, Davis"),
("346428118","Completed",5,"NCT01217008","Phase 1","Evaluation of Safety and Preliminary Efficacy of Escalating Doses of GRNOPC1 in Subacute Spinal Cord Injury","Geron Corporation"),
("368817374","Completed",25,"NCT02302157","Phase 1/2","A Phase I/IIa Dose Escalation Safety Study of AST-OPC1 in Patients with Cervical Sensorimotor Complete Spinal Cord Injury","Lineage Cell Therapeutics Inc."),
("570792450","Completed",163,"NCT02448641","Phase 2","A Double-Blind, Controlled Ph 2b Study of the Safety and Efficacy of Modified Stem Cells in Patients with Chronic Motor Deficit from Ischemic Stroke","SanBio, Inc."),
("881604473","Completed",113,"NCT02691247","Phase 2","Phase 2 Safety and Efficacy Study of CLBS03 Autologous T-Regulatory Cells in Adolescents with Recent Onset Type 1 Diabetes Mellitus","Caladrius Biosciences"),
("779998305","Recruiting",8,"NCT03977662","Phase 1/2","Pancreatic Islet and PARAthyroid Co-Transplantation for Treatment of Diabetes in IntraMuscular Site: PARADIGM","University of California, San Francisco"),
("849307871","Active, not recruiting",69,"NCT02239354","Phase 1/2","Preclinical and clinical testing of a stem cell-based combination product for insulin-dependent diabetes","ViaCyte, Inc."),
("550559457","Recruiting",75,"NCT03163511","Phase 1/2","Clinical trial of directly vascularized islet cell replacement therapy for high-risk type 1 diabetes","ViaCyte, Inc."),
("207121535","Active, not recruiting",10,"NCT02234934","Phase 1/2","A Phase I/II, Non Randomized, Multicenter, Open-Label Study of G1XCGD (Lentiviral Vector Transduced CD34+ Cells) in Patients With X-Linked Chronic Granulomatous Disease","University of California, Los Angeles");

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

INSERT investigates VALUES
("000000052","179431196"),														
("000000142","354923182"),														
("000000138","618295341"),														
("000000047","153036181"),														
("000000089","559172804"),														
("000000135","215107784"),														
("000000090","395472507"),														
("000000066","488589151"),														
("000000066","264882075"),														
("000000126","112097238"),														
("000000244","144571942"),														
("000000135","699291832"),														
("000000019","445221155"),														
("000000134","912265363"),														
("000000051","724720172"),														
("000000004","930279876"),														
("000000225","968023395"),														
("000000601","211312774"),														
("000000048","548379726"),														
("000000029","126859008"),														
("000000041","674664083"),														
("000000037","405167503"),														
("000000199","472613885"),														
("000000352","456061992"),														
("000000053","154998134"),														
("000000457","847776695"),														
("000000041","337115119"),														
("000000018","658145356"),														
("000000348","835742418"),														
("000000133","265770499"),														
("000000133","569576576"),														
("000000093","543072310"),														
("000000065","377241337"),														
("000000157","142294510"),														
("000000054","420180594"),														
("000000601","900330719"),														
("000000005","428643122"),														
("000000131","662635471"),														
("000000059","141872240"),														
("000000082","743173689"),														
("000000230","543704704"),														
("000000345","189549202"),														
("000000127","386557613"),														
("000000125","599402117"),														
("000000347","640955231"),														
("000000049","700280774"),														
("000000172","989840466"),														
("000000047","290045516"),														
("000000046","348055147"),														
("000000046","950189050"),														
("000000046","554921585"),														
("000000058","393572823"),														
("000000008","996564243"),														
("000000088","794945806"),														
("000000161","991056597"),														
("000000062","579693919"),														
("000000017","746175381"),														
("000000092","976431381"),														
("000000038","524014957"),														
("000000008","775336843"),														
("000000288","299238214"),														
("000000006","622076833"),														
("000000602","346428118"),														
("000000259","368817374"),														
("000000141","570792450"),														
("000000160","881604473"),														
("000000055","779998305"),														
("000000132","849307871"),														
("000000132","550559457"),														
("000000008","207121535");													

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


INSERT org
VALUES ('Aspen Neuroscience'),
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
       ('Ludwig Institute for Cancer Research'); 
