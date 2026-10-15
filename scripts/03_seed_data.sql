-- ============================================================================
-- 03_seed_data.sql
-- Datos de ejemplo (DML) para el modelo universitario.
-- Uso: psql -U postgres -d universidad_db -f scripts/03_seed_data.sql
-- ============================================================================

BEGIN;

-- Limpieza previa (permite re-ejecutar el script sin duplicar datos).
TRUNCATE inscripcion, asignatura, estudiante, profesor, carrera
    RESTART IDENTITY CASCADE;

-- ---------------------------------------------------------------------------
-- carreras
-- ---------------------------------------------------------------------------
INSERT INTO carrera (nombre, facultad) VALUES
    ('Ingeniería Civil en Computación', 'Facultad de Ingeniería'),
    ('Ingeniería Comercial',            'Facultad de Economía'),
    ('Derecho',                         'Facultad de Ciencias Jurídicas'),
    ('Medicina',                        'Facultad de Ciencias de la Salud');

-- ---------------------------------------------------------------------------
-- profesores
-- ---------------------------------------------------------------------------
INSERT INTO profesor (nombres, apellidos, email, grado) VALUES
    ('Ana',    'Muñoz',   'ana.munoz@userena.cl',   'Doctorado'),
    ('Carlos', 'Rojas',   'carlos.rojas@userena.cl','Magíster'),
    ('Lucía',  'Fernández','lucia.fernandez@userena.cl','Doctorado'),
    ('Pedro',  'Soto',    'pedro.soto@userena.cl',  'Magíster');

-- ---------------------------------------------------------------------------
-- estudiantes
-- ---------------------------------------------------------------------------
INSERT INTO estudiante (rut, nombres, apellidos, email, fecha_ingreso, id_carrera) VALUES
    ('20123456-7', 'Giovanni', 'Eliantonio', 'giovanni.eliantonio@userena.cl', '2023-03-01', 1),
    ('19876543-2', 'María',    'González',   'maria.gonzalez@userena.cl',      '2021-03-01', 1),
    ('20555444-1', 'Javier',   'Pérez',      'javier.perez@userena.cl',        '2022-03-01', 2),
    ('21111222-3', 'Camila',   'Vargas',     'camila.vargas@userena.cl',       '2023-03-01', 3),
    ('20999888-5', 'Diego',    'Ramírez',    'diego.ramirez@userena.cl',       '2020-03-01', 4);

-- ---------------------------------------------------------------------------
-- asignaturas
-- ---------------------------------------------------------------------------
INSERT INTO asignatura (codigo, nombre, creditos, id_profesor) VALUES
    ('BD-101', 'Base de Datos I',            6, 1),
    ('BD-201', 'Base de Datos Avanzada',     6, 1),
    ('PRG-101','Programación I',             8, 2),
    ('MAT-101','Álgebra Lineal',             6, 3),
    ('ING-101','Inglés Técnico',             4, 4),
    ('EST-201','Estadística Aplicada',       6, 4);

-- ---------------------------------------------------------------------------
-- inscripciones (con notas)
-- ---------------------------------------------------------------------------
INSERT INTO inscripcion (id_estudiante, id_asignatura, semestre, nota) VALUES
    (1, 1, '2026-1', 6.3),
    (1, 2, '2026-1', 5.8),
    (1, 3, '2026-1', 6.7),
    (2, 1, '2026-1', 4.5),
    (2, 4, '2026-1', 5.2),
    (3, 2, '2026-1', 6.9),
    (3, 5, '2026-1', 6.1),
    (4, 1, '2026-1', 3.8),
    (4, 6, '2026-1', 5.5),
    (5, 3, '2026-1', 6.0),
    (5, 6, '2026-1', 4.9),
    (1, 5, '2025-2', 6.4);

COMMIT;

-- Verificación rápida
SELECT 'carreras'     AS tabla, COUNT(*) FROM carrera
UNION ALL SELECT 'profesores',   COUNT(*) FROM profesor
UNION ALL SELECT 'estudiantes',  COUNT(*) FROM estudiante
UNION ALL SELECT 'asignaturas',  COUNT(*) FROM asignatura
UNION ALL SELECT 'inscripciones',COUNT(*) FROM inscripcion;
