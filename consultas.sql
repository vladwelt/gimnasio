SELECT E.cargo, P.total_ganado, P.liquido_pagable, P.fecha_emision,P.fecha_cobro
FROM EMPLEADO E, PAGO P ,PERIODO PE 
WHERE E.nombre='PENELOPE' AND E.id_empleado=P.id_empleado AND PE.fecha_inicio>='2013-07-01' 
    AND PE.fecha_inicio<='2013-12-30' AND P.id_periodo=PE.id_periodo;

SELECT DISTINCT SE.nombre as diciplina, SA.nombre as sala, H.hora
FROM SESION S, SERVICIO SE, SALA SA, HORARIO H, EMPLEADO E, INSTRUCTOR I
WHERE S.fecha='2013-12-08' AND SE.id_servicio=S.id_servicio AND 
        S.id_horario=H.id_horario AND SA.id_sala=S.id_sala;

SELECT DISTINCT PA.nombre, PA.precio, CO.numero_sesiones, CO.fecha_compra, PA.fecha_vigencia, CO.id_compra 
FROM CLIENTE CL, COMPRA CO, PAQUETE PA, PAQUETE_EXTENDIDO PE
WHERE CL.nombre='ZERO' AND CO.id_cliente=CL.id_cliente AND PA.id_paquete=CO.id_paquete AND 
        CO.id_compra NOT IN (SELECT id_compra FROM PAQUETE_EXTENDIDO);

SELECT SER.nombre, EM.nombre, SE.fecha, AC.hora_ingreso
FROM CLIENTE CL, ACCESO_SESION AC, EMPLEADO EM,SERVICIO SER, SESION SE 
WHERE CL.nombre='ZERO' AND CL.id_cliente=AC.id_cliente AND SE.id_sesion=AC.id_sesion AND
        EM.id_empleado=SE.id_empleado AND SER.id_servicio=SE.id_servicio;

