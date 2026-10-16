-- Datos de ejemplo para el tutorial "my_tennis_club".
-- Cargar con:  sqlite3 db.sqlite3 < seed.sql
-- (ejecutar antes: python manage.py migrate)

INSERT INTO members_member (firstname, lastname, phone, joined_date) VALUES
    ('John',  'Smith',   600000001, '2025-02-14'),
    ('Pedro', 'López',   600000002, '2025-01-10'),
    ('Emil',  'Refsnes', 600000003, '2025-01-12'),
    ('José',  'García',  600000004, '2025-02-01'),
    ('Ana',   'López',   600000005, '2025-02-20');

INSERT INTO members_court (description, court_type) VALUES
    ('Ext1', 1), ('Ext2', 1), ('Ext3', 2), ('Int1', 2);

SELECT * FROM members_member;
SELECT * FROM members_court;
