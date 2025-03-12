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
ORDER BY aeroport.pais, aeroport.nom;