-- CONSULTA 3
SELECT DISTINCT PA.nombre, PA.precio, CO.numero_sesiones, CO.fecha_compra, CO.fecha_caducidad 
FROM CLIENTE CL, COMPRA CO, PAQUETE PA, PAQUETE_EXTENDIDO PE
WHERE CL.nombre='ZERO' AND CO.id_cliente=CL.id_cliente AND PA.id_paquete=CO.id_paquete AND 
        CO.id_compra NOT IN (SELECT id_compra FROM PAQUETE_EXTENDIDO);