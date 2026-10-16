-- Datos de ejemplo para el proyecto del club.
-- Cargar con:  sqlite3 db.sqlite3 < seed.sql
-- (ejecutar antes las migraciones: python manage.py migrate)

CREATE TABLE IF NOT EXISTS club_province (
    province_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pro_name    VARCHAR(30)
);
INSERT INTO club_province (pro_name) VALUES
    ('Almería'), ('Cádiz'), ('Córdoba'), ('Granada'),
    ('Huelva'), ('Jaén'), ('Málaga'), ('Sevilla');

CREATE TABLE IF NOT EXISTS club_member (
    member_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name   VARCHAR(30),
    phone       INTEGER,
    birth_date  DATE,
    category    VARCHAR(30),
    province_id INTEGER
);
INSERT INTO club_member (full_name, phone, birth_date, category, province_id) VALUES
    ('Smith, John',    600000001, '1957-12-12', 'Senior', 1),
    ('Pérez, Ana',     600000002, '1958-10-23', 'Senior', 2),
    ('García, José',   600000003, '1975-09-08', 'Adult',  2),
    ('Gómez, Eva',     600000004, '2010-10-30', 'Junior', 1),
    ('Kurtiss, Luke',  600000005, '2013-12-30', 'Infant', 3);

SELECT * FROM club_member;
