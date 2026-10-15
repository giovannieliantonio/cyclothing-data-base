-- ============================================================================
-- 02_schema.sql
-- Esquema (DDL) del modelo de ejemplo: gestión universitaria.
-- Uso: psql -U postgres -d universidad_db -f scripts/02_schema.sql
-- ============================================================================

BEGIN;

-- Se eliminan en orden inverso a las dependencias (CASCADE por seguridad).
DROP TABLE IF EXISTS inscripcion CASCADE;
DROP TABLE IF EXISTS asignatura  CASCADE;
DROP TABLE IF EXISTS profesor    CASCADE;
DROP TABLE IF EXISTS estudiante  CASCADE;
DROP TABLE IF EXISTS carrera     CASCADE;

-- ---------------------------------------------------------------------------
-- carrera
-- ---------------------------------------------------------------------------
CREATE TABLE carrera (
    id_carrera SERIAL       PRIMARY KEY,
    nombre     VARCHAR(120) NOT NULL UNIQUE,
    facultad   VARCHAR(120) NOT NULL
);

-- ---------------------------------------------------------------------------
-- estudiante
-- ---------------------------------------------------------------------------
CREATE TABLE estudiante (
    id_estudiante SERIAL       PRIMARY KEY,
    rut           VARCHAR(12)  NOT NULL UNIQUE,
    nombres       VARCHAR(80)  NOT NULL,
    apellidos     VARCHAR(80)  NOT NULL,
    email         VARCHAR(120) NOT NULL UNIQUE,
    fecha_ingreso DATE         NOT NULL DEFAULT CURRENT_DATE,
    id_carrera    INTEGER      NOT NULL,
    CONSTRAINT fk_estudiante_carrera
        FOREIGN KEY (id_carrera) REFERENCES carrera (id_carrera)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------------
-- profesor
-- ---------------------------------------------------------------------------
CREATE TABLE profesor (
    id_profesor SERIAL       PRIMARY KEY,
    nombres     VARCHAR(80)  NOT NULL,
    apellidos   VARCHAR(80)  NOT NULL,
    email       VARCHAR(120) NOT NULL UNIQUE,
    grado       VARCHAR(40)  NOT NULL
);

-- ---------------------------------------------------------------------------
-- asignatura
-- ---------------------------------------------------------------------------
CREATE TABLE asignatura (
    id_asignatura SERIAL       PRIMARY KEY,
    codigo        VARCHAR(12)  NOT NULL UNIQUE,
    nombre        VARCHAR(120) NOT NULL,
    creditos      SMALLINT     NOT NULL,
    id_profesor   INTEGER,
    CONSTRAINT chk_creditos CHECK (creditos BETWEEN 1 AND 30),
    CONSTRAINT fk_asignatura_profesor
        FOREIGN KEY (id_profesor) REFERENCES profesor (id_profesor)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- ---------------------------------------------------------------------------
-- inscripcion  (tabla intermedia N:M entre estudiante y asignatura)
-- ---------------------------------------------------------------------------
CREATE TABLE inscripcion (
    id_inscripcion SERIAL        PRIMARY KEY,
    id_estudiante  INTEGER       NOT NULL,
    id_asignatura  INTEGER       NOT NULL,
    semestre       VARCHAR(10)   NOT NULL,
    nota           NUMERIC(3,1),
    CONSTRAINT chk_nota CHECK (nota BETWEEN 1.0 AND 7.0),
    CONSTRAINT fk_inscripcion_estudiante
        FOREIGN KEY (id_estudiante) REFERENCES estudiante (id_estudiante)
        ON DELETE CASCADE,
    CONSTRAINT fk_inscripcion_asignatura
        FOREIGN KEY (id_asignatura) REFERENCES asignatura (id_asignatura)
        ON DELETE CASCADE,
    CONSTRAINT uq_inscripcion UNIQUE (id_estudiante, id_asignatura, semestre)
);

-- Índices para acelerar las búsquedas por clave foránea.
CREATE INDEX idx_estudiante_carrera     ON estudiante  (id_carrera);
CREATE INDEX idx_asignatura_profesor    ON asignatura  (id_profesor);
CREATE INDEX idx_inscripcion_estudiante ON inscripcion (id_estudiante);
CREATE INDEX idx_inscripcion_asignatura ON inscripcion (id_asignatura);

COMMIT;

-- Verificación: listar las tablas creadas.
SELECT table_name AS tabla
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
