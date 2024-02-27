use hospital_portal;
create table patient(
      patient_id          integer            not null,
      ssn                 integer            not null,
      first_name          varchar(50)        not null,
      last_name           varchar(50)        not null,
      middle_name         text,
      address             text               not null,
      email               text               not null,
      dob                 date               not null,
      gender              text               not null,
      primary key(patient_id),
      unique(ssn)
);
create table medical_worker(
      worker_id           integer            not null,
      ssn                 integer            not null,
      first_name          varchar(50)        not null,
      last_name           varchar(50)        not null,
      dob                 date               not null,
      gender              text               not null,
      email               text               not null,
      role                varchar(50)        not null         check(role in('doctor', 'nurse')),
      primary key(worker_id),
      unique(ssn)
);
create table treats(
      worker_id           integer            not null,
      patient_id          integer            not null,
      foreign key(worker_id) references medical_worker(worker_id),
      foreign key(patient_id) references patient(patient_id)
);
create table vital_signs(
      patient_id          integer            not null,
      date_retrieved      datetime           not null,
      temperature         float              not null,
      bp_numerator        int                not null,
      bp_denominator      int                not null,
      height              float              not null,
      weight              float              not null,
      bmi                 float              not null,
      worker_id           integer            not null,
      foreign key(patient_id) references patient(patient_id),
      foreign key(worker_id) references medical_worker(worker_id),
      primary key(patient_id, date_retrieved)
);
create table diagnosis(
      diagnosis_code      integer             not null,
      patient_id          integer             not null,
      diagnosis_date      date                not null,
      name                text                not null,
      worker_id           integer             not null,
      foreign key(patient_id) references patient(patient_id),
      foreign key(worker_id) references medical_worker(worker_id),
      primary key(patient_id, diagnosis_code)
);
create table medication(
      ndc                 integer                not null,
      name                varchar(150)           not null,
      description         text                   not null,
      company             text                   not null,
      route               varchar(50)            check(route in('rectal', 'vaginal', 'oral', 'respiratory', 'transdermal')),
      primary key(ndc)
);
create table prescription(
      patient_id          integer            not null,
      worker_id           integer            not null,
      ndc                 integer            not null,
      strength            integer            not null,
      measurement         varchar(10)        not null           check(measurement in('mg', 'mcg')), -- just working with 2 measurements for now
      instructions        text               not null,
      prescription_date   date               not null,
      foreign key(patient_id) references patient(patient_id),
      foreign key(worker_id) references medical_worker(worker_id),
      foreign key(ndc) references medication(ndc),
      primary key(patient_id, ndc)
);
create table immunization(
      vaccine_code        integer            not null,
      name                varchar(200)       not null,
      patient_id          integer            not null,
      worker_id           integer            not null,
      date_administered   date               not null,
      foreign key(patient_id) references patient(patient_id),
      foreign key(worker_id) references medical_worker(worker_id),
      primary key(patient_id, vaccine_code, date_administered)
);

