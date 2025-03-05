/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS DAW 1A
    Mòdul: 0484 Bases de dades. 
    AUTORS: Pau Bosch Pérez and Ricardo Martín Díaz
    DATA: 27/02/2025
****************************************************** */

-- Pregunta 1

SELECT a.ciutat, ao.nom AS aeroport_origen, v.data, v.codi
FROM vols v
JOIN aeroports ao ON v.id_aeroport_origen = ao.id
JOIN aeroports a ON ao.id_ciutat = a.id
WHERE v.durada < 40
  AND MONTH(v.data) = 2 AND YEAR(v.data) = 2024
  AND v.estat = 'delayed'
ORDER BY a.ciutat, v.data;

-- Pregunta 2
select 'No ho sé';

-- Pregunta 3
select 'No ho sé';

-- Pregunta 4
select 'No ho sé';

-- Pregunta 5
select 'No ho sé';

-- Pregunta 6
select 'No ho sé';

-- Pregunta 7
select 'No ho sé';

-- Pregunta 8
select 'No ho sé';
