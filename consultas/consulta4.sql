-- CONSULTA 4
SELECT SER.nombre, EM.nombre, SE.fecha, AC.hora_ingreso
FROM CLIENTE CL, ACCESO_SESION AC, EMPLEADO EM,SERVICIO SER, SESION SE 
WHERE CL.nombre='ZERO' AND CL.id_cliente=AC.id_cliente AND SE.id_sesion=AC.id_sesion AND
        EM.id_empleado=SE.id_empleado AND SER.id_servicio=SE.id_servicio;
