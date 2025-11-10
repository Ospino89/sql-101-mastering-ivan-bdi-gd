-- ##################################################
-- # CONSULTAS CON JOINS Y AGREGACIÓN - SMART HEALTH #
-- ##################################################

-- 1. Contar cuántos pacientes están registrados por cada tipo de documento,
-- mostrando el nombre del tipo de documento y la cantidad total de pacientes,
-- ordenados por cantidad de mayor a menor.

-- INNER JOIN
-- smart_health.patients: FK (document_type_id)
-- smart_health.document_types: PK(document_type_id)
-- AGGREGATION FUNCTION: COUNT
SELECT
    T2.type_name AS tipo_documento,
    COUNT(*) AS total_documentos

FROM smart_health.patients T1
INNER JOIN smart_health.document_types T2
    ON T1.document_type_id = T2.document_type_id
GROUP BY T2.type_name
ORDER BY total_documentos DESC;




-- 2. Obtener la cantidad de citas programadas por cada médico,
-- mostrando el nombre completo del doctor y el total de citas,
-- filtrando solo médicos con más de 5 citas, ordenados por cantidad descendente.


--INNER JOIN
--smart_health.appointments: doctor_id(FK)
--smart_health.doctors: doctor_id(PK)

-- AGGREGATION FUNCTION: COUNT

SELECT 
    D.first_name||' '||D.last_name AS DOCTOR ,
    COUNT(A.*) AS TOTAL_CITAS
FROM smart_health.appointments A 
INNER JOIN smart_health.doctors D 
    ON A.doctor_id = D.doctor_id
GROUP BY DOCTOR
HAVING COUNT(A.*) > 5
ORDER BY TOTAL_CITAS DESC;



-- 3. Contar cuántas especialidades tiene cada médico activo,
-- mostrando el nombre del doctor y el número total de especialidades,
-- ordenados por cantidad de especialidades de mayor a menor.

--INNER JOIN
--smart_health.doctor_specialties: doctor_id(FK) 
--smart_health.doctor_specialties: speciality_id(FK)
--smart_health.doctors: doctor_id(PK)
--smart_health.specialties: speciality_id(PK)

-- AGGREGATION FUNCTION: COUNT

SELECT
    D.first_name||' '||D.last_name AS DOCTOR,
    COUNT(S.*) AS ESPECIALIDADES 
FROM smart_health.doctors D 
INNER JOIN smart_health.doctor_specialties DS 
    ON D.doctor_id = DS.doctor_id
INNER JOIN smart_health.specialties S 
    ON S.specialty_id = DS.specialty_id
WHERE D.active = TRUE  
GROUP BY DOCTOR 
ORDER BY ESPECIALIDADES DESC;


-- 4. Calcular cuántos pacientes residen en cada departamento,
-- mostrando el nombre del departamento y la cantidad total de pacientes,
-- filtrando solo departamentos con al menos 3 pacientes, ordenados alfabéticamente.


--INNER JOIN 
--smart_health.patient_addresses: patient_id(FK)
--smart_health.patient_addresses: address_id(FK)
--smart_health.patients: patient_id(PK)
--smart_health.addresses: address_id(PK)


--smart_health.addresses: municipality_code(FK)
--smart_health.municipalities: department_code(FK)
--smart_health.municipalities: municipality_code(PK)
--smart_health.departments: department_code(PK)

-- AGGREGATION FUNCTION: COUNT


SELECT
    P.first_name||' '||COALESCE(P.middle_name, '')||' '||P.first_surname||' '||COALESCE(P.second_surname, '') AS paciente,
    D.department_name,
    COUNT(p.*) AS CANTIDAS_PACIENTES
FROM smart_health.patients P 
INNER JOIN smart_health.patient_addresses PA 
    ON P.patient_id = PA.patient_id
INNER JOIN smart_health.addresses A 
    ON A.address_id = PA.address_id
INNER JOIN smart_health.municipalities M 
    ON A.municipality_code = M.municipality_code
INNER JOIN smart_health.departments D 
    ON M.department_code = D.department_code 
GROUP BY department_name
HAVING COUNT(p.*) > 3
ORDER BY department_name; 




-- 5. Contar cuántas citas ha tenido cada paciente por estado de cita,
-- mostrando el nombre del paciente, estado de la cita y cantidad,
-- ordenados por nombre de paciente y estado.


--INNER JOIN 
--smart_health.appointments:patient_id(FK)
--smart_health.patients:patient_id(PK)

-- AGGREGATION FUNCTION: COUNT

SELECT 
    P.first_name||' '||COALESCE(P.middle_name, '')||' '||P.first_surname||' '||COALESCE(P.second_surname, '') AS PACIENTE,
    A.status,
    COUNT(A.*) AS CANTIDAD_CITAS 
FROM smart_health.appointments A 
INNER JOIN smart_health.patients P 
    ON A.patient_id = P.patient_id 
GROUP BY PACIENTE , A.status 
ORDER BY PACIENTE , A.status;



-- 6. Calcular cuántos registros médicos ha realizado cada doctor,
-- mostrando el nombre del doctor y el total de registros,
-- filtrando solo doctores con más de 10 registros, ordenados por cantidad descendente.

--INNER JOIN 
--smart_health.medical_records: doctor_id(FK)
--smart_health.doctors: doctor_id(PK)

-- AGGREGATION FUNCTION: COUNT


SELECT
    D.first_name||' '||D.last_name AS DOCTOR,
    COUNT(MR.*) AS CANTIDAD_REGISTROS
FROM smart_health.medical_records MR 
INNER JOIN smart_health.doctors D 
    ON MR.doctor_id = D.doctor_id
GROUP BY DOCTOR
HAVING COUNT(MR.*) > 10 
ORDER BY CANTIDAD_REGISTROS DESC;



-- 7. Contar cuántas prescripciones se han emitido para cada medicamento,
-- mostrando el nombre comercial del medicamento y el total de prescripciones,
-- filtrando medicamentos con al menos 2 prescripciones, ordenados por cantidad descendente.

-- 8. Calcular cuántos pacientes tienen alergias por cada medicamento,
-- mostrando el nombre del medicamento y la cantidad de pacientes alérgicos,
-- ordenados por cantidad de mayor a menor.

-- 9. Contar cuántas direcciones tiene registrado cada paciente,
-- mostrando el nombre del paciente y el total de direcciones,
-- filtrando solo pacientes con más de 1 dirección, ordenados por cantidad descendente.

-- 10. Calcular cuántas salas de cada tipo están activas en el hospital,
-- mostrando el tipo de sala y la cantidad total,
-- filtrando solo tipos con al menos 2 salas, ordenados por cantidad descendente.

-- ##################################################
-- #              FIN DE CONSULTAS                  #
-- ##################################################   