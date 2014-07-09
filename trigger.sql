CREATE TRIGGER incrementador BEFORE INSERT ON ACCESO_SESION
    FOR EACH ROW 
    BEGIN
        UPDATE COMPRA SET numero_sesion_actual = numero_sesion_actual-1 WHERE 

