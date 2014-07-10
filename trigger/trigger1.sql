DROP TRIGGER IF EXISTS descontador;
DELIMITER #
CREATE TRIGGER descontador BEFORE INSERT ON ACCESO_SESION
    FOR EACH ROW 
        BEGIN
        DECLARE sesiones INT;
        SET sesiones = (SELECT DISTINCT sesiones_restantes
                    FROM ACCESO_SESION AC,COMPRA CO 
                                    WHERE NEW.id_compra=CO.id_compra AND CO.id_compra=AC.id_compra);
        IF (sesiones > 0) THEN
            UPDATE COMPRA SET sesiones_restantes=sesiones_restantes-1 WHERE id_compra=NEW.id_compra;
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No tiene mas sesiones disponibles.';
        END IF;
 END; #
DELIMITER ;



