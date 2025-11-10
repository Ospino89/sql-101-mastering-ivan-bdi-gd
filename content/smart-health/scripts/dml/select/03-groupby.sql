--1 contar cuantos pacientes estan registrados por cada tipo de documento, 
--mostrando el nombre del tipo de documento y la cantidad total de pacientes,
--ordenados por cantidad de mayor a menor 

--INNER JOIN 
--smart_health.patients: document_tipe_id(FK)
--smart_health.document_tyes:document_tipe_id(PK)
--AGREGATION FUNCION: COUNT


SELECT 
    T2.type_name AS tipo_documento,
    COUNT(*) AS total_documentos



FROM smart_health.patients T1 
INNER JOIN smart_health.document_tyes T2
    ON T1.document_tipe_id = T2.document_tipe_id
GROUP BY T2.type_name
ORDER BY total_documentos DESC;






SELECT AVG(EXTRACT(YEAR FROM AGE (birth_date))) AS PROMEDIO 
FROM smart_health.patients;



SELECT
 P.first_name ||''|| COALESCE(P.middle_name,'')||''||P.first_surname||''|| COALESCE(P.second_surname,'') AS nombre_cpmpleto
 
FROM smart_health.appointments A 
INNER JOIN smart_health.patients P 
ON A.patient_id = P.patient_id;




SELECT first_name , 
SELECT AGE(EXTRACT(YEAR FROM birth_date)) edad
FROM smart_health.patients P 
GROUP 






