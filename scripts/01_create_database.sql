-- ============================================================================
-- 01_create_database.sql
-- Crea la base de datos de la asignatura.
-- Motor: PostgreSQL 14+
-- Uso:   psql -U postgres -f scripts/01_create_database.sql
-- ============================================================================

-- OJO: DROP DATABASE borra todo. Úsalo solo en tu entorno local.
DROP DATABASE IF EXISTS universidad_db;

CREATE DATABASE universidad_db
    WITH ENCODING 'UTF8'
         TEMPLATE template0;

-- Verificar
SELECT datname AS base_de_datos
FROM pg_database
WHERE datname = 'universidad_db';

-- Para continuar con los siguientes scripts, conéctate a la base:
--   \c universidad_db
