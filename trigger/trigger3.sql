DROP TRIGGER IF EXISTS controlador_pagos;
DELIMITER #
CREATE TRIGGER controlador_pagos
    BEFORE INSERT ON PAGO
    FOR EACH ROW
    BEGIN
        DECLARE diferencia INT;
        IF NEW.total_ganado < 1
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede ingresar valores menores a 0.';
        END IF;
        IF NEW.liquido_pagable < 1
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede ingresar valores menores a 0.';
        END IF;
        SET diferencia = (SELECT DATEDIFF(NEW.fecha_emision,NEW.fecha_cobro));
        IF diferencia > 0
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Fecha cobro menor a fecha emision.';
        END IF;
    END; #
DELIMITER ;