/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS _____________________________
    Mòdul: 0484 Bases de dades. 
    AUTORS: Pau Bosch Pérez and Ricardo Martín Díaz
    DATA: ________________
****************************************************** */

-- Pregunta 1

SELECT aeroport.ciutat, aeroport.nom as aeroport, vol.data, vol.codi
FROM vol
  JOIN aeroport on (aeroport.codi=vol.aeroport_origen)
WHERE durada < 40 and MONTH(data)= 2 and year(data) = 2024 and descripcio = 'DELAYED' order by ciutat, data;

-- Pregunta 2
select any_fabricacio as 'any', companyia as 'companyia', num_serie, tipus
from avio
  join companyia on companyia.nom = avio.companyia
where companyia.pais like 'spain'
  and any_fabricacio < 2000
order by any_fabricacio desc, companyia asc, num_serie asc;

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
