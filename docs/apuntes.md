# Apuntes — Base de Datos

## Unidad 1 — Introducción

- Conceptos: dato, información, base de datos.
- Modelos de datos: relacional, jerárquico, de red, orientado a objetos.
- Ventajas de un SGBD frente a archivos planos.

## Unidad 2 — Modelo Entidad-Relación

- Entidades, atributos, relaciones.
- Cardinalidades: 1:1, 1:N, N:M.
- Entidades débiles y dependencias.
- Ver [`modelo_er.md`](./modelo_er.md).

## Unidad 3 — Modelo Relacional

- Tablas, filas (tuplas) y columnas (atributos).
- Claves primarias (PK) y foráneas (FK).
- Integridad referencial y de dominio.
- Normalización: 1FN, 2FN, 3FN, FNBC.

## Unidad 4 — SQL

- **DDL:** `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.
- **DML:** `INSERT`, `UPDATE`, `DELETE`.
- **DQL:** `SELECT` con `WHERE`, `JOIN`, `GROUP BY`, `HAVING`, `ORDER BY`.
- Funciones de agregación: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`.
- Subconsultas, CTEs y funciones de ventana.

## Comandos útiles de `psql`

| Comando | Descripción |
|---|---|
| `\l` | Listar bases de datos |
| `\c nombre_db` | Conectarse a una base de datos |
| `\dt` | Listar tablas |
| `\d tabla` | Describir una tabla |
| `\dv` | Listar vistas |
| `\du` | Listar usuarios/roles |
| `\q` | Salir |

## Recursos

- Documentación oficial PostgreSQL: https://www.postgresql.org/docs/
