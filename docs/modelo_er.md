# Modelo Entidad-Relación — Gestión Universitaria

Documentación del modelo de datos usado en `scripts/`.

## Diagrama (representación textual)

```
┌─────────────┐          ┌──────────────┐
│   carrera   │ 1      N │  estudiante  │
│─────────────│──────────│──────────────│
│ id_carrera  │          │ id_estudiante│
│ nombre      │          │ rut          │
│ facultad    │          │ nombres      │
└─────────────┘          │ apellidos    │
                         │ email        │
                         │ fecha_ingreso│
                         │ id_carrera FK│
                         └──────┬───────┘
                                │ N
                                │
                          ┌─────┴──────────┐
                          │  inscripcion   │
                          │────────────────│
                          │ id_inscripcion │
                          │ id_estudiante  │
                          │ id_asignatura  │
                          │ semestre       │
                          │ nota           │
                          └─────┬──────────┘
                                │ N
                                │
┌─────────────┐          ┌──────┴───────┐
│  profesor   │ 1      N │  asignatura  │
│─────────────│──────────│──────────────│
│ id_profesor │          │ id_asignatura│
│ nombres     │          │ codigo       │
│ apellidos   │          │ nombre       │
│ email       │          │ creditos     │
│ grado       │          │ id_profesor  │
└─────────────┘          └──────────────┘
```

## Entidades

### `carrera`
Programa académico al que pertenece un estudiante.
- **PK:** `id_carrera`
- **Atributos:** `nombre` (único), `facultad`

### `estudiante`
Persona inscrita en una carrera.
- **PK:** `id_estudiante`
- **Atributos:** `rut` (único), `nombres`, `apellidos`, `email` (único), `fecha_ingreso`
- **FK:** `id_carrera` → `carrera`

### `profesor`
Docente que dicta una o más asignaturas.
- **PK:** `id_profesor`
- **Atributos:** `nombres`, `apellidos`, `email` (único), `grado`

### `asignatura`
Ramo dictado por un profesor.
- **PK:** `id_asignatura`
- **Atributos:** `codigo` (único), `nombre`, `creditos` (1–30)
- **FK:** `id_profesor` → `profesor`

### `inscripcion`
Tabla intermedia que resuelve la relación **N:M** entre `estudiante` y `asignatura`.
- **PK:** `id_inscripcion`
- **Atributos:** `semestre`, `nota` (1.0–7.0)
- **FK:** `id_estudiante`, `id_asignatura`
- **Restricción única:** (`id_estudiante`, `id_asignatura`, `semestre`)

## Relaciones y cardinalidad

| Relación | Cardinalidad | Descripción |
|---|---|---|
| `carrera` — `estudiante` | 1 : N | Una carrera tiene muchos estudiantes |
| `profesor` — `asignatura` | 1 : N | Un profesor dicta varias asignaturas |
| `estudiante` — `asignatura` | N : M | Resuelta mediante `inscripcion` |

## Reglas de integridad aplicadas

- **ON DELETE RESTRICT** en `estudiante.id_carrera`: no se puede borrar una carrera con estudiantes.
- **ON DELETE SET NULL** en `asignatura.id_profesor`: la asignatura queda sin profesor si se elimina.
- **ON DELETE CASCADE** en `inscripcion`: al borrar estudiante o asignatura se eliminan sus inscripciones.
- **CHECK** en `creditos` y `nota` para validar rangos.

## Diagrama visual

> Pendiente: exportar el diagrama desde pgAdmin / dbdiagram.io / draw.io
> y guardarlo como `docs/modelo_er.png`.
