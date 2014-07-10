-- ----------------------
--  PAQUETE_NO_USADO  ---
-- ----------------------
DROP TABLE IF EXISTS PAQUETE_NO_USADO;                                             
   CREATE TABLE IF NOT EXISTS PAQUETE_NO_USADO(
        id_compra INT UNSIGNED NOT NULL,
        nombre VARCHAR(40) NULL,
        telefono_celular INT NULL,
        paquete VARCHAR(30) NULL,
        sesiones_restantes INT NULL,
        FOREIGN KEY(id_compra) REFERENCES COMPRA(id_compra)
    ); 

DELIMITER #
DROP TRIGGER IF EXISTS verificador;
CREATE TRIGGER verificador 
    BEFORE INSERT ON ACCESO_SESION FOR EACH ROW
        BEGIN
            DECLARE sesiones INT;
            DECLARE cliente VARCHAR(40);
            DECLARE paquete VARCHAR(30);
            DECLARE telefono INT;
            DECLARE faltantes INT;
 
            SET faltantes = (SELECT DATEDIFF(NOW(),fecha_caducidad) AS faltantes
                    FROM COMPRA
                    WHERE NEW.id_compra=id_compra);

            SET sesiones = (SELECT sesiones_restantes
                    FROM COMPRA 
                    WHERE NEW.id_compra=id_compra);

            INSERT INTO PRUEBA VALUES(faltantes,sesiones);

            IF faltantes>0 AND sesiones > 0  
                    THEN
                    SET paquete = (SELECT PA.nombre
                                FROM PAQUETE PA, COMPRA CO 
                                WHERE CO.id_paquete=PA.id_paquete AND id_compra=NEW.id_compra);

                    SET telefono = (SELECT telefono_celular
                                FROM CLIENTE
                                WHERE NEW.id_cliente=id_cliente);

                    SET cliente = (SELECT CONCAT(nombre,' ',apellido_paterno)
                                FROM CLIENTE
                                WHERE NEW.id_cliente=id_cliente);

                    INSERT INTO PAQUETE_NO_USADO VALUES(NEW.id_compra,cliente,telefono,paquete,sesiones);
            END IF;
            
        END; #
DELIMITER ;
        