-- Crea usuario
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER _alke_wallet_ IDENTIFIED BY "1234"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
ALTER USER _alke_wallet_ QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION TO _alke_wallet_;
GRANT "RESOURCE" TO _alke_wallet_;
ALTER USER _alke_wallet_ DEFAULT ROLE "RESOURCE";

-- Crear tablas
CREATE TABLE USUARIO (
    usuario_id VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(20),
    correo VARCHAR(50),
    contrasena VARCHAR (20),
    saldo INT
    );
   
CREATE TABLE MONEDA (
    divisa_id INT PRIMARY KEY,
    divisa_nombre VARCHAR (30),
    divisa_simbolo VARCHAR (5)
    );
    
CREATE TABLE TRANSACCION (
    transaccion_id VARCHAR(12) PRIMARY KEY,
    remitente_usuario_id VARCHAR(12),
    receptor_usuario_id VARCHAR(12),
    importe INT,
    fecha_transaccion DATE,
    divisa_id INT,
    FOREIGN KEY (remitente_usuario_id) REFERENCES USUARIO(usuario_id),
    FOREIGN KEY (receptor_usuario_id) REFERENCES USUARIO(usuario_id),
    FOREIGN KEY (divisa_id) REFERENCES MONEDA(divisa_id)
    );



    ALTER TABLE TRANSACCION
    ADD CONSTRAINT fk_remitente_usuario_id FOREIGN KEY (remitente_usuario_id) REFERENCES USUARIO(usuario_id);

    ALTER TABLE TRANSACCION
    ADD CONSTRAINT fk_receptor_usuario_id FOREIGN KEY (receptor_usuario_id) REFERENCES USUARIO(usuario_id);
    
    ALTER TABLE TRANSACCION DROP CONSTRAINT fk_remitente_usuario_id;
    
    ALTER TABLE TRANSACCION DROP CONSTRAINT fk_receptor_usuario_id;
    
/* Borrar tablas*/
    DROP TABLE USUARIO;
    DROP TABLE MONEDA;
    DROP TABLE TRANSACCION;
-- borrar 
DELETE FROM USUARIO WHERE usuario_id = '1';

-- poblar tablas usuario

INSERT INTO USUARIO (usuario_id, nombre, correo, contrasena, saldo)
VALUES ('1', 'pedro', 'pedro.pe@bancodechile.cl', 'contrasena', 100);

INSERT INTO USUARIO (usuario_id, nombre, correo, contrasena, saldo)
VALUES ('2', 'juan', 'juan.ju@bancobci.cl', 'contrasena', 200);

INSERT INTO USUARIO (usuario_id, nombre, correo, contrasena, saldo)
VALUES ('3', 'diego', 'diego@bancosantander.cl', 'contrasena', 300);

-- Insertar monedas
INSERT INTO MONEDA (divisa_id, divisa_nombre, divisa_simbolo)
VALUES (1, 'dolar', 'usd');

INSERT INTO MONEDA (divisa_id, divisa_nombre, divisa_simbolo)
VALUES (2, 'euro', 'eur');

INSERT INTO MONEDA (divisa_id, divisa_nombre, divisa_simbolo)
VALUES (3, 'peso chileno', 'clp');

-- Insertar transacciones
INSERT INTO TRANSACCION (transaccion_id, remitente_usuario_id, receptor_usuario_id, importe, fecha_transaccion, divisa_id)
VALUES ('10', '2', '1', 50, TO_DATE('2024-04-26', 'YYYY-MM-DD'), 1);

INSERT INTO TRANSACCION (transaccion_id, remitente_usuario_id, receptor_usuario_id, importe, fecha_transaccion, divisa_id)
VALUES ('11', '1', '2', 100, TO_DATE('2024-04-27', 'YYYY-MM-DD'), 2);

INSERT INTO TRANSACCION (transaccion_id, remitente_usuario_id, receptor_usuario_id, importe, fecha_transaccion, divisa_id)
VALUES ('12', '3', '1', 150, TO_DATE('2024-04-28', 'YYYY-MM-DD'), 3);
    -- CONSULTAS
-- Consulta para obtener el nombre de la moneda elegida por un usuario específico:
SELECT m.divisa_nombre
FROM MONEDA m
JOIN TRANSACCION t ON m.divisa_id = t.divisa_id
WHERE t.remitente_usuario_id = '1';

--Consulta para obtener todas las transacciones registradas:
SELECT *
FROM TRANSACCION;

--Consulta para obtener todas las transacciones realizadas por un usuario específico:
SELECT *
FROM TRANSACCION
WHERE remitente_usuario_id = '1' OR receptor_usuario_id = '1';

--Sentencia DML para modificar el campo correo electrónico de un usuario específico:
UPDATE USUARIO
SET correo = 'nuevo_correo@example.com'
WHERE usuario_id = '1';

--Sentencia para eliminar los datos de una transacción (eliminado de la fila completa):
DELETE FROM TRANSACCION
WHERE transaccion_id = '1';


 
    