-- Base de datos del CRUD de contactos.
-- Crear con:  mysql -u root -p < schema.sql
CREATE DATABASE IF NOT EXISTS contacts_db CHARACTER SET utf8mb4;
USE contacts_db;

CREATE TABLE IF NOT EXISTS contacts (
    id    INT AUTO_INCREMENT PRIMARY KEY,
    name  VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20)
);

INSERT INTO contacts (name, email, phone) VALUES
    ('María López',  'maria.lopez@example.com',  '600000001'),
    ('Carlos García','carlos.garcia@example.com','600000002');
