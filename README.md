# Base de Datos — Repositorio de la Asignatura

Repositorio con el material, scripts SQL y trabajos de la asignatura **Base de Datos**.

- **Estudiante:** Giovanni Eliantonio
- **Correo:** giovanni.eliantonio@userena.cl
- **Motor de Base de Datos:** PostgreSQL
- **Período:** _(completar, ej. 2026-1)_

---

## Contenido del repositorio

| Carpeta | Descripción |
|---|---|
| `scripts/` | Scripts SQL ordenados: creación de BD, esquema, datos y consultas |
| `docs/` | Apuntes, modelo entidad-relación y documentación |
| `laboratorios/` | Laboratorios prácticos de cada semana |
| `tareas/` | Tareas y trabajos evaluados |

---

## Requisitos

- **PostgreSQL 14 o superior** → https://www.postgresql.org/download/
- Cliente `psql` en el `PATH`
- (Opcional) [pgAdmin](https://www.pgadmin.org/) o [DBeaver](https://dbeaver.io/) como interfaz gráfica

---

## Cómo ejecutar los scripts

Los scripts están **numerados y se ejecutan en orden**. Desde la raíz del repositorio:

```bash
# 1. Crear la base de datos (conéctate antes como superusuario)
psql -U postgres -f scripts/01_create_database.sql

# 2. Crear las tablas dentro de la base de datos
psql -U postgres -d universidad_db -f scripts/02_schema.sql

# 3. Cargar datos de ejemplo
psql -U postgres -d universidad_db -f scripts/03_seed_data.sql

# 4. Ejecutar consultas de práctica
psql -U postgres -d universidad_db -f scripts/04_queries.sql
```

> **Nota:** Se recomienda crear primero un usuario propio en lugar de usar `postgres`:
> ```sql
> CREATE USER alumno WITH PASSWORD 'tu_password';
> GRANT ALL PRIVILEGES ON DATABASE universidad_db TO alumno;
> ```

---

## Estructura

```
.
├── README.md
├── .gitignore
├── scripts/
│   ├── 01_create_database.sql
│   ├── 02_schema.sql
│   ├── 03_seed_data.sql
│   └── 04_queries.sql
├── docs/
│   ├── modelo_er.md
│   └── apuntes.md
├── laboratorios/
│   ├── README.md
│   └── lab01/
│       └── README.md
└── tareas/
    ├── README.md
    └── tarea01/
        └── README.md
```

---

## Convenciones de trabajo

- **Commits** en formato `tipo: descripción corta` (ej. `feat: agregar consultas de agregación`).
- Tipos sugeridos: `feat`, `fix`, `docs`, `sql`, `refactor`, `test`.
- Un laboratorio o tarea = **un commit significativo como mínimo**.

---

## Licencia

Material con fines académicos.
