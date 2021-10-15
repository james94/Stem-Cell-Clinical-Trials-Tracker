drop database if exists mytrial;
create database mytrial;
-- use mytrial;

CREATE TABLE trial (
	trial_id varchar(9) not null,
    trial_status varchar(25) not null,
    target_enrollment integer,
    NCT_no char(11),
    phase varchar(5) not null,
    title varchar(300) not null,
    primary key (trial_id)
);

CREATE TABLE p_watchlist (
	patient_id varchar(9) not null,
    name varchar(50) not null,
    primary key (patient_id, name),
    foreign key (patient_id) references patient (patient_id)
);

CREATE TABLE investigates (
	researcher_id varchar(9) not null,
    trial_id varchar(9) not null,
    primary key (researcher_id, trial_id),
    foreign key (researcher_id) references researcher (researcher_id),
    foreign key (trial_id) references trial (trial_id)
);
