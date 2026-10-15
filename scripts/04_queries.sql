-- ============================================================================
-- 04_queries.sql
-- Consultas de práctica (DQL) sobre el modelo universitario.
-- Uso: psql -U postgres -d universidad_db -f scripts/04_queries.sql
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. SELECT básico con proyección y orden
-- ---------------------------------------------------------------------------
SELECT id_estudiante, nombres, apellidos, email
FROM estudiante
ORDER BY apellidos, nombres;

-- ---------------------------------------------------------------------------
-- 2. WHERE con filtro y patrón (ILIKE = case-insensitive en PostgreSQL)
-- ---------------------------------------------------------------------------
SELECT nombres, apellidos, fecha_ingreso
FROM estudiante
WHERE apellidos ILIKE 'g%'
ORDER BY fecha_ingreso;

-- ---------------------------------------------------------------------------
-- 3. INNER JOIN: estudiantes con su carrera
-- ---------------------------------------------------------------------------
SELECT e.rut,
       e.nombres || ' ' || e.apellidos AS estudiante,
       c.nombre                        AS carrera
FROM estudiante e
INNER JOIN carrera c ON c.id_carrera = e.id_carrera
ORDER BY c.nombre, e.apellidos;

-- ---------------------------------------------------------------------------
-- 4. JOIN de varias tablas: inscripciones detalladas
-- ---------------------------------------------------------------------------
SELECT e.nombres || ' ' || e.apellidos AS estudiante,
       a.codigo,
       a.nombre                        AS asignatura,
       i.semestre,
       i.nota
FROM inscripcion i
JOIN estudiante  e ON e.id_estudiante = i.id_estudiante
JOIN asignatura  a ON a.id_asignatura = i.id_asignatura
WHERE i.semestre = '2026-1'
ORDER BY a.codigo, estudiante;

-- ---------------------------------------------------------------------------
-- 5. GROUP BY + agregados: promedio por asignatura
-- ---------------------------------------------------------------------------
SELECT a.codigo,
       a.nombre                       AS asignatura,
       COUNT(i.id_inscripcion)        AS inscritos,
       ROUND(AVG(i.nota), 2)          AS promedio,
       MIN(i.nota)                    AS nota_min,
       MAX(i.nota)                    AS nota_max
FROM asignatura a
LEFT JOIN inscripcion i ON i.id_asignatura = a.id_asignatura
GROUP BY a.id_asignatura, a.codigo, a.nombre
ORDER BY promedio DESC NULLS LAST;

-- ---------------------------------------------------------------------------
-- 6. HAVING: asignaturas con promedio superior a 5.5
-- ---------------------------------------------------------------------------
SELECT a.codigo,
       a.nombre       AS asignatura,
       ROUND(AVG(i.nota), 2) AS promedio
FROM asignatura a
JOIN inscripcion i ON i.id_asignatura = a.id_asignatura
GROUP BY a.id_asignatura, a.codigo, a.nombre
HAVING AVG(i.nota) > 5.5
ORDER BY promedio DESC;

-- ---------------------------------------------------------------------------
-- 7. Subconsulta: estudiantes con promedio general sobre la media
-- ---------------------------------------------------------------------------
SELECT e.nombres || ' ' || e.apellidos AS estudiante,
       ROUND(AVG(i.nota), 2)           AS promedio
FROM estudiante e
JOIN inscripcion i ON i.id_estudiante = e.id_estudiante
GROUP BY e.id_estudiante, e.nombres, e.apellidos
HAVING AVG(i.nota) > (
    SELECT AVG(nota) FROM inscripcion
)
ORDER BY promedio DESC;

-- ---------------------------------------------------------------------------
-- 8. LEFT JOIN: asignaturas sin ningún inscrito (si existieran)
-- ---------------------------------------------------------------------------
SELECT a.codigo, a.nombre
FROM asignatura a
LEFT JOIN inscripcion i ON i.id_asignatura = a.id_asignatura
WHERE i.id_inscripcion IS NULL;

-- ---------------------------------------------------------------------------
-- 9. Función de ventana: ranking de estudiantes por promedio
-- ---------------------------------------------------------------------------
SELECT estudiante,
       promedio,
       RANK() OVER (ORDER BY promedio DESC) AS posicion
FROM (
    SELECT e.nombres || ' ' || e.apellidos AS estudiante,
           ROUND(AVG(i.nota), 2)           AS promedio
    FROM estudiante e
    JOIN inscripcion i ON i.id_estudiante = e.id_estudiante
    GROUP BY e.id_estudiante, e.nombres, e.apellidos
) AS promedios
ORDER BY posicion;

-- ---------------------------------------------------------------------------
-- 10. CTE (WITH): resumen por carrera
-- ---------------------------------------------------------------------------
WITH promedios_carrera AS (
    SELECT e.id_carrera,
           AVG(i.nota) AS promedio
    FROM estudiante e
    JOIN inscripcion i ON i.id_estudiante = e.id_estudiante
    GROUP BY e.id_carrera
)
SELECT c.nombre AS carrera,
       ROUND(pc.promedio, 2) AS promedio_carrera
FROM carrera c
JOIN promedios_carrera pc ON pc.id_carrera = c.id_carrera
ORDER BY promedio_carrera DESC;
