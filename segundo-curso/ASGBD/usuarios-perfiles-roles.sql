-- ============================================================
-- Práctica: usuarios, privilegios, perfiles y roles en Oracle
-- Soluciones SQL de los ejercicios resueltos durante el curso.
-- Se ejecutan por partes desde SQL*Plus / SQL Developer,
-- cambiando de usuario (SYSTEM / administrador / pruebaNN) según el enunciado.
-- ============================================================

-- 2) Como SYSTEM: crear el usuario "administrador"
CREATE USER administrador
    IDENTIFIED BY 123
    DEFAULT TABLESPACE   USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA 500K ON USERS;

-- 3) Intentar conectar como "administrador" -> falla: no tiene CREATE SESSION.

-- 4) Privilegios/roles del usuario "administrador"
SELECT * FROM DBA_ROLE_PRIVS WHERE grantee = 'ADMINISTRADOR';

-- 5) Darle CREATE SESSION y volver a conectar
GRANT CREATE SESSION TO administrador;

-- 6) Como "administrador": crear "prueba00" con cuota 0K
CREATE USER prueba00 IDENTIFIED BY password
    DEFAULT TABLESPACE   USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA 0K ON USERS;
-- (falla: "administrador" aún no tiene CREATE USER)

-- 7) Como SYSTEM: otorgar CREATE USER y repetir
GRANT CREATE USER TO administrador;

-- 8-9) Quién tiene un privilegio de sistema concreto
SELECT * FROM DBA_SYS_PRIVS WHERE privilege = 'CREATE USER';
SELECT * FROM DBA_SYS_PRIVS WHERE privilege = 'CREATE SESSION';

-- 12-13) Crear un rol llamado "administrador" -> error: el nombre ya existe
--        como usuario. Como SYSTEM sí se puede crear un rol con otro nombre.
CREATE ROLE administrador;   -- (ejercicio: comprobar el conflicto de nombres)

-- 14) Quién tiene CREATE ROLE
SELECT * FROM DBA_SYS_PRIVS WHERE privilege = 'CREATE ROLE';

-- 15) Rol ADMIN con varios privilegios, asignado a "administrador"
CREATE ROLE ADMIN;
GRANT CREATE SESSION, CREATE USER, CREATE ROLE TO ADMIN;
GRANT ADMIN TO administrador;

-- 16) Revocar los privilegios directos y dejar solo el rol
SELECT * FROM DBA_SYS_PRIVS WHERE grantee = 'ADMINISTRADOR';
REVOKE CREATE USER, CREATE ROLE, CREATE SESSION FROM administrador;
GRANT ADMIN TO administrador;

-- 17) Usuario sin tablespaces por defecto ni temporal
CREATE USER prueba01 IDENTIFIED BY password;

-- 18) Tablespaces y cuotas de varios usuarios
SELECT * FROM DBA_TS_QUOTAS
WHERE username IN ('SYS','SYSTEM','ADMINISTRADOR','PRUEBA00','PRUEBA01');

-- 19) Usuario con tablespace por defecto y temporal concretos
CREATE USER prueba02 IDENTIFIED BY password
    DEFAULT TABLESPACE   NOMINA
    TEMPORARY TABLESPACE TEMP_NOMINA
    QUOTA 0K ON NOMINA;

-- 20) Cambiar los tablespaces de "prueba01"
ALTER USER prueba01 DEFAULT TABLESPACE ACADEMO TEMPORARY TABLESPACE TEMP_ACADEMO;

-- 22-24) Rol CONEXION con CREATE SESSION, asignado a tres usuarios
CREATE ROLE CONEXION;
GRANT CREATE SESSION TO CONEXION;
GRANT CONEXION TO prueba00, prueba01, prueba02;
SELECT * FROM DBA_ROLE_PRIVS WHERE grantee IN ('PRUEBA00','PRUEBA01','PRUEBA02');

-- 25) Como "prueba01": crear una tabla en ACADEMO -> falla (sin CREATE TABLE)
CREATE TABLE CODIGOS (
    CODIGO      VARCHAR2(3),
    DESCRIPCION VARCHAR2(20)
)
TABLESPACE ACADEMO
STORAGE (INITIAL 64K NEXT 64K MINEXTENTS 5 MAXEXTENTS 10);

-- 26) Rol DESARROLLO con privilegios de desarrollo
CREATE ROLE DESARROLLO;
GRANT CREATE SEQUENCE, CREATE SESSION, CREATE SYNONYM, CREATE TABLE, CREATE VIEW
    TO DESARROLLO;
GRANT DESARROLLO TO prueba00, prueba01, prueba02;

-- 27-28) Dar cuota ilimitada en ACADEMO y repetir la creación de la tabla
ALTER USER prueba01 QUOTA UNLIMITED ON ACADEMO;

-- 29) Cuota ilimitada a prueba02 en NOMINA
ALTER USER prueba02 QUOTA UNLIMITED ON NOMINA;

-- 30) Información de roles, privilegios, tablespaces y cuotas
SELECT * FROM DBA_ROLE_PRIVS WHERE grantee IN ('PRUEBA00','PRUEBA01','PRUEBA02');
SELECT * FROM DBA_SYS_PRIVS  WHERE grantee IN ('PRUEBA00','PRUEBA01','PRUEBA02');
SELECT * FROM DBA_TS_QUOTAS  WHERE username IN ('PRUEBA00','PRUEBA01','PRUEBA02');

-- 31) Cuota 0K en el tablespace por defecto
ALTER USER prueba01 QUOTA 0K ON ACADEMO;

-- 33) Un usuario sí puede cambiar su propia contraseña
ALTER USER prueba01 IDENTIFIED BY nueva_clave;

-- 34) Quién tiene el privilegio ALTER USER
SELECT * FROM DBA_SYS_PRIVS WHERE privilege = 'ALTER USER';

-- 35) Como "administrador": borrar el usuario "prueba02"
DROP USER prueba02;
