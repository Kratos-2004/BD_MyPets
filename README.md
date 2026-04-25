# 🐾 BD MyPets — Base de Datos para Clínica Veterinaria

Base de datos relacional diseñada para la gestión integral de una clínica veterinaria con múltiples sedes. Incluye el modelo entidad-relación, scripts SQL completos y 16 consultas para reportes operativos.

---

## 📋 Tabla de Contenidos

- [Descripción](#-descripción)
- [Estructura del Repositorio](#-estructura-del-repositorio)
- [Modelo Entidad-Relación](#-modelo-entidad-relación)
- [Tablas de la Base de Datos](#-tablas-de-la-base-de-datos)
- [Instalación y Uso](#-instalación-y-uso)
- [Consultas SQL Disponibles](#-consultas-sql-disponibles)
- [Datos de Prueba](#-datos-de-prueba)
- [Documentación](#-documentación)

---

## 📖 Descripción

**MyPets** es un sistema de base de datos relacional que permite administrar:

- Clínicas veterinarias y su personal
- Propietarios y sus mascotas
- Exámenes médicos y tratamientos
- Corrales para hospitalización
- Facturación y pagos
- Suministros y stock
- Citas programadas

Diseñado para ejecutarse en **MariaDB / MySQL** con soporte para múltiples clínicas.

---

## 📁 Estructura del Repositorio

```
BD_MyPets/
├── README.md
├── Diagrama_ER/
│   ├── Diagrama_ER_MyPets.mmd       # Fuente editable (Mermaid)
│   └── Diagrama_ER_MyPets.png       # Diagrama visual
├── Docs/
│   └── Documentacion_BD_MyPets.pdf  # Documentación completa
└── SQL/
    ├── MyPets.sql                   # Creación de tablas + datos de prueba
    └── BD_MyPets_MariaDB.sql        # Scripts de consultas para reportes
```

---

## 🗂️ Modelo Entidad-Relación

![Diagrama ER](Diagrama_ER/Diagrama_ER_MyPets.png)

---

## 🗃️ Tablas de la Base de Datos

| Tabla | Descripción |
|---|---|
| `CLINICA` | Información de cada sede de la clínica |
| `EMPLEADO` | Personal (veterinarios, enfermeras, secretarios, gerentes) |
| `PROPIETARIO` | Dueños de mascotas registrados |
| `MASCOTA` | Datos de cada mascota y su propietario |
| `EXAMEN` | Exámenes médicos realizados por veterinarios |
| `TRATAMIENTO` | Catálogo de tratamientos y sus costos |
| `EXAMEN_TRATAMIENTO` | Relación entre exámenes y tratamientos aplicados |
| `CORRAL` | Corrales disponibles por clínica |
| `MASCOTA_CORRAL` | Historial de hospitalizaciones por corral |
| `FACTURA` | Facturación generada por atenciones |
| `SUMINISTRO` | Inventario de suministros por clínica |
| `CITA` | Citas programadas por propietario y mascota |

---

## ⚙️ Instalación y Uso

### Prerrequisitos

- [XAMPP](https://www.apachefriends.org/) con MariaDB/MySQL activo, **o**
- MariaDB / MySQL instalado directamente

### Opción 1 — Desde la terminal (recomendado)

```bash
# 1. Accede a MariaDB
color a
cd mysql/bin
mysql -u root

```

### Opción 2 — Desde phpMyAdmin

1. Abre `http://localhost/phpmyadmin`
2. Crea una nueva base de datos llamada `MyPets`
3. Ve a la pestaña **Importar**
4. Selecciona el archivo `SQL/MyPets.sql` y haz clic en **Continuar**

### Verificar la instalación

```sql
USE MyPets;
SHOW TABLES;
```

Deberías ver las 12 tablas listadas.

---

## 📊 Consultas SQL Disponibles

El archivo `SQL/BD_MyPets_MariaDB.sql` contiene 16 reportes listos para usar:

| # | Reporte |
|---|---|
| 1 | Gerente, dirección y teléfono de cada clínica |
| 2 | Propietarios con los detalles de sus mascotas |
| 3 | Tratamientos aplicados por examen |
| 4 | Facturas pendientes de pago por propietario |
| 5 | Facturas sin pagar hasta una fecha determinada |
| 6 | Corrales disponibles en Bogotá por fecha |
| 7 | Salario mensual total del personal por clínica |
| 8 | Costo máximo, mínimo y promedio de tratamientos |
| 9 | Total de mascotas por tipo |
| 10 | Veterinarios y enfermeras mayores de 50 años |
| 11 | Citas por fecha y clínica |
| 12 | Total de corrales por clínica |
| 13 | Facturas entre 2020 y 2023 |
| 14 | Mascotas de un propietario específico |
| 15 | Suministros farmacéuticos que necesitan reorden |
| 16 | Costo total de suministros en stock por clínica |

---

## 🧪 Datos de Prueba

El script `MyPets.sql` incluye datos de ejemplo para comenzar a trabajar de inmediato:

- **3 clínicas** en Bogotá, Medellín y Cali
- **5 empleados** (gerente, veterinarios, enfermera, secretario)
- **4 propietarios** y **4 mascotas**
- **4 exámenes** con tratamientos asociados
- **6 corrales**, facturas, suministros y citas de ejemplo

---

## 📄 Documentación

La documentación completa del proyecto se encuentra en:

📁 [`Docs/Documentacion_BD_MyPets.pdf`](Docs/Documentacion_BD_MyPets.pdf)

Incluye:
- Guía de acceso a XAMPP y MariaDB
- Explicación de cada tabla y sus atributos
- Todos los scripts SQL comentados
- El diagrama entidad-relación
