-- CONSULTA1
SELECT E.cargo, P.total_ganado, P.liquido_pagable, P.fecha_emision,P.fecha_cobro
FROM EMPLEADO E, PAGO P ,PERIODO PE 
WHERE E.nombre='PENELOPE' AND E.id_empleado=P.id_empleado AND PE.fecha_inicio>='2013-07-01' 
AND PE.fecha_inicio<='2013-12-30' AND P.id_periodo=PE.id_periodo;
