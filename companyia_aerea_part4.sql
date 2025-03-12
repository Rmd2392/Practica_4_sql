/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS DAW 1A
    Mòdul: 0484 Bases de dades. 
    AUTORS: Pau Bosch Pérez and Ricardo Martín Díaz
    DATA: 27/02/2025
****************************************************** */

-- Pregunta 1
select
  aeroport.ciutat,
  aeroport.nom as aeroport,
  vol.data,
  vol.codi
from vol
  join aeroport on (aeroport.codi=vol.aeroport_origen)
where
  durada < 40
  and MONTH(data)= 2
  and year(data) = 2024
  and descripcio = 'DELAYED'
order by
  ciutat,
  data;

-- Pregunta 2
select
  any_fabricacio as 'any',
  companyia as 'companyia',
  num_serie,
  tipus
from avio
  join companyia on companyia.nom = avio.companyia
where
  companyia.pais like 'spain'
  and any_fabricacio < 2000
order by
  any_fabricacio desc,
  companyia asc,
  num_serie asc;

-- Pregunta 3
select 
    vol.codi, 
    vol.data, 
    CONCAT(personal.cognom, ', ', personal.nom, ' (', pilot.hores_vol, ')') as pilot, 
    avio.companyia
from vol
  join pilot on vol.pilot = pilot.num_empleat
  join personal on pilot.num_empleat = personal.num_empleat
  join avio on vol.avio = avio.num_serie
where 
    MONTH(vol.data) = 2 
    and YEAR(vol.data) = 2024
    and pilot.hores_vol > 7000
    and personal.sou > 53000
    and vol.descripcio like '%delayed%';

-- Pregunta 4
select
  concat(passatger.cognom, ', ', passatger.nom) as passatger,
  concat(personal.cognom, ', ', personal.nom) as hostessa,
  vol.aeroport_origen,
  vol.aeroport_desti,
  vol.durada
from passatger
  join volar on volar.passatger = passatger.passaport
  join vol on volar.vol = vol.codi
  join hostessa on hostessa.num_empleat = vol.hostessa
  join personal on hostessa.num_empleat = personal.num_empleat
where
  passatger.adreca like '%MADRID%'
  and vol.data = '2023-12-25'
order by
  passatger.cognom;

-- Pregunta 5
select
  vol.codi,
  concat(ao.nom, ' (', ao.ciutat, ')') as origen,
  concat(ad.nom, ' (', ad.ciutat, ')') as desti
from vol
  join aeroport ao on vol.aeroport_origen = ao.codi
  join aeroport ad on vol.aeroport_desti = ad.codi
where
  year(vol.data) = 2024
  and durada > 160
  and ao.ciutat like '__o%'
  and ad.ciutat like '__o%'
order by
  vol.codi;

-- Pregunta 6
select
  companyia.nom, 
  companyia.filial_de, 
  concat(pilot_personal.cognom, ', ', pilot_personal.nom) as pilot, 
  concat(hostessa_personal.cognom, ', ', hostessa_personal.nom) as hostessa
from vol
  join avio on vol.avio = avio.num_serie
  join companyia on avio.companyia = companyia.nom
  join pilot on vol.pilot = pilot.num_empleat
  join personal as pilot_personal on pilot.num_empleat = pilot_personal.num_empleat
  join hostessa on vol.hostessa = hostessa.num_empleat
  join personal as hostessa_personal on hostessa.num_empleat = hostessa_personal.num_empleat
where
    avio.any_fabricacio = 2008 
    and companyia.filial_de is not null
order by 
    pilot_personal.cognom, 
    hostessa_personal.cognom;

-- Pregunta 7
select
  comp.nom,
  coalesce(compfil.nom, '-') as mare
from companyia comp
  left join companyia compfil on comp.filial_de = compfil.nom
order by
  comp.nom;

-- Pregunta 8
<<<<<<< HEAD
select 
    aeroport.nom, 
    aeroport.pais, 
    coalesce(vol.codi, 'Sense vols') as vol
from aeroport
  left join vol on aeroport.codi = vol.aeroport_origen 
  and vol.durada > 200 
  and vol.data between '2024-01-01' and '2024-01-10'
where 
    aeroport.nom like '%z%' 
    and length(aeroport.pais) < 15
order by 
    aeroport.pais, 
    aeroport.nom;
=======
select 'No ho sé';







-- SOLUCIÓN PRACTICA FASE4GPT --

-- Pregunta 1

SELECT aeroport.ciutat, aeroport.nom as aeroport, vol.data, vol.codi
FROM vol
  JOIN aeroport on (aeroport.codi=vol.aeroport_origen)
WHERE vol.durada < 40 AND MONTH(vol.data) = 2 AND YEAR(vol.data) = 2024 AND vol.descripcio = 'DELAYED'
ORDER BY aeroport.ciutat, vol.data;

-- Pregunta 2

SELECT avio.any_fabricacio AS any, companyia.nom AS companyia, avio.num_serie, avio.tipus
FROM avio
  JOIN companyia ON companyia.nom = avio.companyia
WHERE companyia.pais LIKE 'Spain'
  AND avio.any_fabricacio < 2000
ORDER BY avio.any_fabricacio DESC, companyia.nom ASC, avio.num_serie ASC;

-- Pregunta 3

SELECT vol.codi, vol.data,
       CONCAT(personal.cognom, ', ', personal.nom, ' (', pilot.hores_Vol, ')') AS pilot,
       companyia.nom AS companyia
FROM vol
JOIN pilot ON vol.pilot = pilot.num_empleat
JOIN personal ON pilot.num_empleat = personal.num_empleat
JOIN avio ON vol.avio = avio.num_serie
JOIN companyia ON avio.companyia = companyia.nom
WHERE MONTH(vol.data) = 2 AND YEAR(vol.data) = 2024
  AND pilot.hores_Vol > 7000
  AND personal.sou > 53000
  AND vol.descripcio = 'DELAYED'
ORDER BY companyia.nom, vol.data, vol.codi;

-- Pregunta 4

SELECT 
       CONCAT(passatger.cognom, ', ', passatger.nom) AS passatger,
       CONCAT(personal.cognom, ', ', personal.nom) AS hostessa,
       vol.aeroport_origen, vol.aeroport_desti, vol.durada
FROM passatger
JOIN volar ON passatger.passaport = volar.passatger
JOIN vol ON volar.vol = vol.codi
JOIN hostessa ON vol.hostessa = hostessa.num_empleat
JOIN personal ON hostessa.num_empleat = personal.num_empleat
WHERE passatger.adreca LIKE '%Madrid%'
  AND vol.data BETWEEN '2023-12-20' AND '2023-12-31'
ORDER BY passatger.cognom;

-- Pregunta 5

SELECT vol.codi,
       CONCAT(aeroport_origen.nom, ' (', aeroport_origen.ciutat, ')') AS origen,
       CONCAT(aeroport_desti.nom, ' (', aeroport_desti.ciutat, ')') AS desti
FROM vol
JOIN aeroport aeroport_origen ON vol.aeroport_origen = aeroport_origen.codi
JOIN aeroport aeroport_desti ON vol.aeroport_desti = aeroport_desti.codi
WHERE YEAR(vol.data) = 2024
  AND vol.durada > 160
  AND SUBSTRING(aeroport_origen.ciutat, 3, 1) = 'o'
  AND SUBSTRING(aeroport_desti.ciutat, 3, 1) = 'o'
ORDER BY vol.codi;

-- Pregunta 6

SELECT companyia.nom AS companyia, companyia_mare.nom AS companyia_mare,
       CONCAT(personal.cognom, ', ', personal.nom) AS pilot,
       CONCAT(personal.cognom, ', ', personal.nom) AS hostessa
FROM vol
JOIN avio ON vol.avio = avio.num_serie
JOIN companyia ON avio.companyia = companyia.nom
JOIN companyia companyia_mare ON companyia.filial_de = companyia_mare.nom
JOIN pilot ON vol.pilot = pilot.num_empleat
JOIN personal ON pilot.num_empleat = personal.num_empleat
JOIN hostessa ON vol.hostessa = hostessa.num_empleat
JOIN personal personal_hostessa ON hostessa.num_empleat = personal_hostessa.num_empleat
WHERE avio.any_fabricacio = 2008
ORDER BY pilot, hostessa;

-- Pregunta 7

SELECT companyia.nom AS companyia,
       COALESCE(companyia_mare.nom, '-') AS companyia_mare
FROM companyia
LEFT JOIN companyia companyia_mare ON companyia.filial_de = companyia_mare.nom
ORDER BY companyia.nom;

-- Pregunta 8

SELECT aeroport.nom, aeroport.pais, COALESCE(vol.codi, 'Sense vols') AS vol
FROM aeroport
LEFT JOIN vol ON aeroport.codi = vol.aeroport_origen
  AND vol.durada > 200
  AND vol.data BETWEEN '2024-01-01' AND '2024-01-10'
WHERE aeroport.nom LIKE '%z%'
  AND LENGTH(aeroport.pais) < 15
ORDER BY aeroport.pais, aeroport.nom;
>>>>>>> 91ef515dcf6bedc28f94facde34fd06814b3ff68
