// Smart Health Database - DBML (refs declared separately to avoid duplicate endpoints)

Table patients {
  patient_id int [pk]
  first_name varchar
  middle_name varchar
  last_name varchar
  maternal_surname varchar
  birth_date date
  sex char
  email varchar
  registration_date date
  active boolean
}

Table patient_documents {
  patient_document_id int [pk]
  document_type_id int
  document_number varchar
  issuing_country varchar
  issue_date date
  patient_id int
}

Table patient_addresses {
  patient_address_id int [pk]
  address_type varchar
  street_address varchar
  municipality varchar
  department varchar
  country_code varchar
  latitude varchar
  longitude varchar
  postal_code varchar
  patient_id int
}

Table patient_phones {
  patient_phone_id int [pk]
  phone_type varchar
  phone_number varchar
  primary boolean
  patient_id int
}

Table emergency_contacts {
  emergency_contact_id int [pk]
  name varchar
  relationship varchar
  phone varchar
  email varchar
  instructions varchar
  patient_id int
}

Table doctors {
  doctor_id int [pk]
  internal_code varchar
  license_number varchar
  first_name varchar
  last_name varchar
  professional_email varchar
  hospital_entry_date date
  active boolean
}

Table doctor_specialties {
  specialty_id int [pk]
  doctor_id int
}

Table doctor_phones {
  doctor_phone_id int [pk]
  phone_type varchar
  phone_number varchar
  doctor_id int
}

Table doctor_addresses {
  doctor_address_id int [pk]
  address_type varchar
  department varchar
  municipality varchar
  address_text varchar
  service_hours varchar
  doctor_id int
}

Table doctor_schedules {
  doctor_schedule_id int [pk]
  weekday varchar
  start_time timestamp
  end_time timestamp
  modality varchar
  doctor_id int
}

Table appointments {
  appointment_id int [pk]
  date date
  start_time time
  end_time time
  care_type varchar
  status varchar
  room_id varchar
  reason varchar
  created_by varchar
  creation_date date
  patient_id int
  doctor_id int
}

Table medical_records {
  record_id int [pk]
  record_datetime datetime
  record_type varchar
  summary_text varchar
  structured_summary json
  doctor_id int
  patient_id int
}

Table prescriptions {
  prescription_id int [pk]
  dosage varchar
  frequency varchar
  duration varchar
  notes varchar
  record_id int
}

Table vital_signs {
  vital_sign_id int [pk]
  vital_type varchar
  value varchar
  unit varchar
  record_datetime datetime
  record_id int
}

Table diagnoses {
  diagnosis_id int [pk]
  icd_code varchar
  description varchar
  record_id int
}

Table medications {
  medication_id int [pk]
  atc_code varchar
  trade_name varchar
  active_principle varchar
  presentation varchar
  prescription_id int
}

Table insurers {
  insurer_id int [pk]
  name varchar
  contact varchar
}

Table insurance_policies {
  policy_id int [pk]
  policy_number varchar
  coverage_summary varchar
  start_date date
  end_date date
  status varchar
  patient_id int
  insurer_id int
}

// Relationships (single declaration per endpoint)
Ref: patients.patient_id < patient_documents.patient_id
Ref: patients.patient_id < patient_addresses.patient_id
Ref: patients.patient_id < patient_phones.patient_id
Ref: patients.patient_id < emergency_contacts.patient_id
Ref: patients.patient_id < medical_records.patient_id
Ref: patients.patient_id < insurance_policies.patient_id

Ref: doctors.doctor_id < appointments.doctor_id
Ref: patients.patient_id < appointments.patient_id

Ref: doctors.doctor_id < medical_records.doctor_id
Ref: doctors.doctor_id < doctor_specialties.doctor_id
Ref: doctors.doctor_id < doctor_phones.doctor_id
Ref: doctors.doctor_id < doctor_addresses.doctor_id
Ref: doctors.doctor_id < doctor_schedules.doctor_id

Ref: insurers.insurer_id < insurance_policies.insurer_id

Ref: medical_records.record_id < prescriptions.record_id
Ref: medical_records.record_id < vital_signs.record_id
Ref: medical_records.record_id < diagnoses.record_id

Ref: prescriptions.prescription_id < medications.prescription_id


Ref: "insurers"."insurer_id" < "insurers"."name"