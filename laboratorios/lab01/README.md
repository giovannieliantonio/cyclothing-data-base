# Laboratorio 01 — Instalación y primeros pasos con PostgreSQL

## Objetivos

- Instalar y verificar PostgreSQL.
- Crear una base de datos y una tabla sencilla.
- Insertar y consultar datos con `psql`.

## Enunciado

1. Verifica que PostgreSQL esté instalado:
   ```bash
   psql --version
   ```
2. Crea una base de datos llamada `lab01_db`.
3. Crea una tabla `alumno` con: `id`, `nombre`, `edad`.
4. Inserta 3 registros.
5. Consulta todos los registros ordenados por edad.

## Solución

```sql
-- Crear la base de datos (desde otra base, ej. postgres)
DROP DATABASE IF EXISTS lab01_db;
CREATE DATABASE lab01_db;

-- Conectarse
-- \c lab01_db

CREATE TABLE alumno (
    id     SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    edad   SMALLINT    NOT NULL CHECK (edad > 0)
);

INSERT INTO alumno (nombre, edad) VALUES
    ('Ana', 20),
    ('Luis', 22),
    ('Sofía', 19);

SELECT id, nombre, edad
FROM alumno
ORDER BY edad;
```

## Resultado esperado

| id | nombre | edad |
|----|--------|------|
| 3  | Sofía  | 19   |
| 1  | Ana    | 20   |
| 2  | Luis   | 22   |

## Evidencia

> Agrega aquí capturas de pantalla o la salida de `psql`.
