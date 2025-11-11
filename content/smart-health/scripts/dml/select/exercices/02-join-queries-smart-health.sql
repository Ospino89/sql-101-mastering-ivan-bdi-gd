-- ##################################################
-- #   CONSULTAS CON JOINS - SMART HEALTH          #
-- ##################################################

-- 1. Listar todos los pacientes con su tipo de documento correspondiente,
-- mostrando el nombre completo del paciente, número de documento y nombre del tipo de documento,
-- ordenados por apellido del paciente.
SELECT
    T1.first_name||' '||COALESCE(T1.middle_name, '')||' '||T1.first_surname||' '||COALESCE(T1.second_surname, '') AS paciente,
    T1.document_number AS numero_documento,
    T2.type_name AS tipo_documento

FROM smart_health.patients T1
INNER JOIN smart_health.document_types T2
    ON T1.document_type_id = T2.document_type_id
ORDER BY T1.first_surname
LIMIT 10; 


-- 2. Consultar todas las citas médicas con la información del paciente y del doctor asignado,
-- mostrando nombres completos, fecha y hora de la cita,
-- ordenadas por fecha de cita de forma descendente.

--INNER JOIN 

--smart_health.appointments: patient_id(FK)
--smart_health.appointments: doctor_id(FK)
--smart_health.patients: patient_id(PK)
--smart_health.patients: doctor_id(PK)

SELECT
    T2.first_name||' '||COALESCE(T2.middle_name, '')||' '||T2.first_surname||' '||COALESCE(T2.second_surname, '') AS paciente,
    T1.appointment_date AS fecha_cita,
    T1.start_time AS hora_inicio_cita,
    T1.end_time AS hora_fin_cita,
    'Dr. '||' '||T3.first_name||' '||COALESCE(T3.last_name, '') AS doctor_asignado,
    T3.internal_code AS codigo_medico

FROM smart_health.appointments T1
INNER JOIN smart_health.patients T2
    ON T1.patient_id = T2.patient_id
INNER JOIN smart_health.doctors T3
    ON T1.doctor_id = T3.doctor_id
ORDER BY T1.appointment_date DESC
LIMIT 10;


-- 3. Obtener todas las direcciones de pacientes con información completa del municipio y departamento,
-- mostrando el nombre del paciente, dirección completa y ubicación geográfica,
-- ordenadas por departamento y municipio.


--INNER JOIN

--smart_health.patient_addresses: patient_id(FK)
--smar_health.patient_addresses: address_id(FK)
--smarth_health.patients: patient_id(PK)
--smarth_health.addresses: address_id(PK)


--smart_health.addresses: municipality_code(FK)
--smart_health.municipalities: departament_code(FK)
--smart_health.municipalities: municipality_code(PK)
--smart_health.departaments: departament_code(PK)


SELECT
    P.first_name||''||P.first_surname AS NOMBRE ,
    A.* ,
    M.* , 
    D.* 
FROM smart_health.patients P
INNER JOIN smart_health.patient_addresses PA
ON P.patient_id = PA.patient_id
INNER JOIN smart_health.addresses A 
ON A.address_id = PA.address_id 
INNER JOIN smart_health.municipalities M
ON A.municipality_code = M.municipality_code 
INNER JOIN smart_health.departments D 
ON M.department_code = D.department_code
ORDER BY M.municipality_name , D.department_name;




-- 4. Listar todos los médicos con sus especialidades asignadas,
-- mostrando el nombre del doctor, especialidad y fecha de certificación,
-- filtrando solo especialidades activas y ordenadas por apellido del médico.


--smart_health.doctor_specialties : doctor_id(FK)
--smart_health.doctor_specialties : specialty_id(FK)
--smart_health.doctorS : doctor_id(PK)
--smart_health.specialties : specialty_id(PK)

SELECT 
    D.first_name||' '||D.last_name AS NOMBRE,
    S.specialty_name AS ESPECIALIDAD,
    DE.certification_date AS FECHA_CERTIFICACION
FROM smart_health.doctor_specialties DE
INNER JOIN smart_health.doctors D 
ON DE.doctor_id = D.doctor_id
INNER JOIN smart_health.specialties S 
ON DE.specialty_id = S.specialty_id
WHERE DE.is_active = TRUE 
ORDER BY D.last_name;



-- [NO REALIZAR]
-- 5. Consultar todas las alergias de pacientes con información del medicamento asociado,
-- mostrando el nombre del paciente, medicamento, severidad y descripción de la reacción,
-- filtrando solo alergias graves o críticas, ordenadas por severidad.

-- [NO REALIZAR]
-- 6. Obtener todos los registros médicos con el diagnóstico principal asociado,
-- mostrando el paciente, doctor que registró, diagnóstico y fecha del registro,
-- filtrando registros del último año, ordenados por fecha de registro descendente.

-- 7. Listar todas las prescripciones médicas con información del medicamento y registro médico asociado,
-- mostrando el paciente, medicamento prescrito, dosis y si se generó alguna alerta,
-- filtrando prescripciones con alertas generadas, ordenadas por fecha de prescripción.

    --INNER JOIN 

--smart_health.prescriptions: medication_id(FK)
--smart_health.prescriptions: medical_record_id(FK)
--smart_health.medications: medication_id(PK)
--smart_health.medical_records: medical_record_id(PK)

--smart_health.medical_records: patient_id(FK)
--smart_health.patients: patient_id(PK)

SELECT
    P.first_name||' '||COALESCE(P.middle_name, '')||' '||P.first_surname||' '||COALESCE(P.second_surname, '') AS paciente,
    M.presentation, MEDICAMENTO
    PR.dosage AS DOSIS,
    PR.alert_generated
FROM smart_health.prescriptions PR
INNER JOIN smart_health.medications M 
ON PR.medication_id = M.medication_id 
INNER JOIN smart_health.medical_records MR 
ON PR.medical_record_id = MR.medical_record_id 
INNER JOIN smart_health.patients P 
ON P.patient_id = MR.patient_id
WHERE PR.alert_generated = TRUE
ORDER BY PR.prescription_date;




-- 8. Consultar todas las citas con información de la sala asignada (si tiene),
-- mostrando paciente, doctor, sala y horario,
-- usando LEFT JOIN para incluir citas sin sala asignada, ordenadas por fecha y hora.

--LEFT JOIN

--smart_health.appointments: room_id(FK)
--smart_health.appointments: patient_id_id(FK)
--smart_health.appointments: doctor_id(FK)
--smart_health.rooms: room_id(PK)
--smart_health.parients: patient_id(PK)
--smart_health.doctors: doctor_id(PK)


SELECT 
    P.first_name||' '||COALESCE(P.middle_name, '')||' '||P.first_surname||' '||COALESCE(P.second_surname, '') AS paciente,
    D.first_name||' '||D.last_name AS DOCTOR ,
    R.room_name,
    A.start_time , A.end_time
FROM smart_health.appointments A
LEFT JOIN smart_health.rooms R
ON R.room_id = A.room_id
INNER JOIN smart_health.patients P 
ON A.patient_id = P.patient_id
INNER JOIN smart_health.doctors D 
ON A.doctor_id = D.doctor_id
ORDER BY creation_date; 




-- 9. Listar todos los teléfonos de pacientes con información completa del paciente,
-- mostrando nombre, tipo de teléfono, número y si es el teléfono principal,
-- filtrando solo teléfonos móviles, ordenados por nombre del paciente.
SELECT
    p.first_name || ' ' || COALESCE(p.middle_name, '') || ' ' || p.first_surname || ' ' || COALESCE(p.second_surname, '') AS nombre_completo,
    ph.phone_type,
    ph.phone_number,
    ph.is_primary
FROM smart_health.patients AS p
INNER JOIN smart_health.patient_phones AS ph
    ON p.patient_id = ph.patient_id
--WHERE ph.phone_type = 'Móvil'
ORDER BY p.first_name, p.first_surname;


-- 10. Obtener todos los doctores que NO tienen especialidades asignadas (ANTI JOIN),
-- mostrando su información básica y fecha de ingreso,
-- útil para identificar médicos que requieren actualización de información,
-- ordenados por fecha de ingreso al hospital.

SELECT
    d.doctor_id,
    d.internal_code,
    d.first_name,
    d.last_name,
    d.medical_license_number,
    d.professional_email,
    d.phone_number,
    d.hospital_admission_date AS fecha_ingreso,
    d.active
FROM smart_health.doctors AS d
LEFT JOIN smart_health.doctor_specialties AS ds
    ON d.doctor_id = ds.doctor_id
WHERE ds.doctor_id IS NULL
ORDER BY d.hospital_admission_date;


-- ##################################################
-- #              FIN DE CONSULTAS                  #
-- ##################################################