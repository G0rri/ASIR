-- ============================================================
-- Chuleta de administración de Oracle Database (19c)
-- Recopilación de las órdenes usadas durante el curso.
-- ============================================================

-- ---- Conexión con SQL*Plus ---------------------------------
--   sqlplus / as sysdba        (autenticación por el SO, rol administrador)
--   sqlplus system             (pide la contraseña)
--   sqlplus hr/hr @inicio.sql   (conecta y lanza un script)
-- Dentro de SQL*Plus:
--   CONNECT hr
--   CONNECT / as sysdba
--   SHOW PARAMETERS
--   @inicio.sql

-- ---- Ciclo de vida de la instancia -------------------------
-- Estados: SHUTDOWN -> NOMOUNT -> MOUNT -> OPEN
STARTUP;                 -- arranca en OPEN
STARTUP NOMOUNT;         -- solo instancia en memoria
STARTUP MOUNT;           -- lee los ficheros de control
STARTUP RESTRICTED;      -- solo usuarios con privilegio RESTRICTED SESSION
ALTER DATABASE MOUNT;
ALTER DATABASE OPEN;
ALTER SYSTEM ENABLE RESTRICTED SESSION;

-- Parada ordenada o inmediata
SHUTDOWN IMMEDIATE;      -- también: NORMAL | TRANSACTIONAL | ABORT

-- Fichero de parámetros de arranque (SPFILE)
CREATE SPFILE = 'C:\ruta\archivo_spfile' FROM MEMORY;

-- ---- Vistas dinámicas de rendimiento (V$) ------------------
SELECT * FROM V$PARAMETER;
SELECT * FROM V$DATAFILE;
-- Sesiones activas y cómo cerrar una
SELECT * FROM V$SESSION WHERE username IS NOT NULL;
ALTER SYSTEM KILL SESSION 'SID,SERIAL#';   -- desconecta la sesión

-- ---- Tablespaces -------------------------------------------
SELECT * FROM DBA_TABLESPACES;
SELECT * FROM USER_TABLESPACES;
SELECT * FROM DBA_TABLESPACES WHERE contents = 'PERMANENT';
SELECT * FROM DBA_DATA_FILES WHERE tablespace_name = 'ASIR';

ALTER TABLESPACE users ONLINE;     -- u OFFLINE
-- Ampliar un tablespace con un datafile nuevo
ALTER TABLESPACE ASIR ADD DATAFILE 'C:\datafiles\ASIR002.DAT' SIZE 3M;

-- Espacio libre y segmentos de un tablespace
SELECT * FROM DBA_FREE_SPACE  WHERE tablespace_name = 'USERS';
SELECT * FROM DBA_SEGMENTS    WHERE tablespace_name = 'USERS';
SELECT * FROM DBA_SEGMENTS    WHERE owner = 'HR';

-- ---- Usuarios y cuotas -------------------------------------
-- (en algunas versiones hace falta habilitar scripts internos)
ALTER SESSION SET "_oracle_script" = TRUE;

CREATE USER alumno IDENTIFIED BY 123;
ALTER USER alumno DEFAULT TABLESPACE ASIR;
ALTER USER alumno QUOTA 2M ON ASIR;        -- cuota en un tablespace
ALTER USER alumno QUOTA UNLIMITED ON USERS;

-- ---- Privilegios de sistema y de objeto --------------------
GRANT CREATE SESSION TO alumno;
GRANT CREATE TABLE   TO alumno;
SELECT * FROM USER_SYS_PRIVS;                               -- los míos
SELECT * FROM DBA_SYS_PRIVS WHERE grantee = 'ALUMNO';       -- como admin
SELECT * FROM SESSION_PRIVS ORDER BY 1;                     -- privilegios activos

-- Privilegios sobre objetos de otro esquema
GRANT SELECT ON hr.jobs TO alumno;
GRANT SELECT, INSERT ON hr.jobs TO alumno WITH GRANT OPTION;
SELECT grantee, table_name, grantable FROM USER_TAB_PRIVS_MADE ORDER BY 1,2,3;

-- ---- Roles -------------------------------------------------
GRANT CREATE ROLE TO alumno;
CREATE ROLE mirol;
GRANT CREATE SESSION, CREATE TABLE TO mirol;
GRANT mirol TO alumno;
DROP ROLE mirol;

-- ---- Perfiles (límites de recursos y de contraseña) --------
CREATE PROFILE miprofile LIMIT
    FAILED_LOGIN_ATTEMPTS 3
    SESSIONS_PER_USER     2;
ALTER PROFILE miprofile LIMIT SESSIONS_PER_USER 2;
ALTER USER alumno PROFILE miprofile;
ALTER USER alumno ACCOUNT UNLOCK;
SELECT * FROM DBA_PROFILES WHERE profile = 'MIPROFILE';
-- Parámetros útiles de un perfil:
--   IDLE_TIME, CONNECT_TIME, PASSWORD_LIFE_TIME, PASSWORD_GRACE_TIME,
--   PASSWORD_LOCK_TIME, PASSWORD_REUSE_TIME, PASSWORD_REUSE_MAX,
--   PASSWORD_VERIFY_FUNCTION, INACTIVE_ACCOUNT_TIME

-- ---- Consultas útiles del diccionario ----------------------
SELECT * FROM DICT WHERE table_name LIKE '%TABLESPACE%';
-- Espacio ocupado por cada usuario:
SELECT username, tablespace_name, SUM(bytes)
FROM   DBA_TS_QUOTAS
GROUP  BY username, tablespace_name;
