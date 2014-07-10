-- CONSULTA 2
SELECT DISTINCT SE.nombre as diciplina, SA.nombre as sala, H.hora
FROM SESION S, SERVICIO SE, SALA SA, HORARIO H, EMPLEADO E, INSTRUCTOR I
WHERE S.fecha='2013-12-08' AND SE.id_servicio=S.id_servicio AND 
        S.id_horario=H.id_horario AND SA.id_sala=S.id_sala;