psql -U sm_admin -d smarthdb
 
--mostrar el nombre completo, correo y genero de los pacientes nacidas entre 
--1990 y 1993. listar las 5 primeras personas ordenadas alfabeticamente por su primer nombre


--FROM : pacientes --> smart_health.patients;


SELECT 
    first_name ||' '||first_surname AS fullname, 
    gender,
    email,
    birth_date
    

FROM smart_health.patients
WHERE birth_date BETWEEN '1990-01-01' and '1993-12-31'
ORDER BY first_name 
LIMIT 5;





--modificar consulta anterior 
--pérsonas nacidas entre el 2005 y 2008 y que el genero sea masculino o femenino 
--ordenar descendentemente po primer apellido , mostrar los primeros 8 resultados


SELECT 
    first_name ||' '||first_surname AS fullname, 
    gender,
    email,
    birth_date
    

FROM smart_health.patients
WHERE birth_date BETWEEN '2005-01-01' and '2008-12-31' and  gender IN ('M','F') 

ORDER BY first_surname DESC 
LIMIT 8;



--1. Mostrar los medicamentos, que tienen un ingrediente activo como 
--PARACETAMOL o IBUPROFENO.


SELECT *
FROM smart_health.medications
WHERE active_ingredient IN('PARACETAMOL','IBUPROFENO');




--2. Mostrar los primeros 5 medicos, que tienen dominio institucional @hospitalcentral.com
SELECT *
FROM smart_health.doctors
WHERE professional_email like '%@hospitalcentral.com'
LIMIT 5;



--3. Mostrar nombre completo, genero, tipo identificacion, numero de documento
-- y la fecha de registro, de los 5 pacientes mas jovenes, que tengan estado activo.

SELECT first_name ||''||first_surname AS nombre_completo,
gender,
document_type_id,
document_number,
registration_date,
FROM smart_health.patients
WHERE active = TRUE
ORDER BY birth_date DESC
LIMIT 5; 


--4. Mostrar las 10 primeras citas, que se hicieron
-- entre el 25 de Febrero del 2025 y el 28 de Octubre del 2025.

SELECT *
FROM smart_health.appointments
WHERE appointment_date BETWEEN '2025-02-25' AND '2025-10-28'
ORDER BY appointment_date 
limit 10;



-- 5. Mostrar los datos del numero de telefono, 
-- para los siguientes pacientes.
-- Filtrar por el campo numero_documento.
-- JSON
SELECT
    patient_id,
    phone_type,
    phone_number
FROM smart_health.patient_phones
WHERE patient_id IN 
(
    SELECT patient_id FROM smart_health.patients
    WHERE document_number IN ('30451580',
'1006631391',
'1009149871',
'1298083',
'1004928596',
'1008188849',
'1607132',
'30470003')
);

--  patient_id | phone_type | phone_number
-- ----------+------------+--------------
--       11118 | Móvil      | 3117935551
--         855 | Móvil      | 3014649922
--       15919 | Móvil      | 3201212554
--       11188 | Móvil      | 3149662006
--        7453 | Fijo       | 6043698899
--       14125 | Móvil      | 3185171082
-- (6 filas)
