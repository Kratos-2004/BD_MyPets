CREATE DATABASE mypets;
USE mypets;

CREATE TABLE CLINICA (
    numero_clinica INT PRIMARY KEY,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fax VARCHAR(20)
);

CREATE TABLE EMPLEADO (
    tipo_documento VARCHAR(10) NOT NULL,
    numero_documento VARCHAR(20) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    posicion VARCHAR(30) NOT NULL,
    salario_anual DECIMAL(10, 2) NOT NULL,
    numero_clinica INT NOT NULL,
    PRIMARY KEY (tipo_documento, numero_documento),
    FOREIGN KEY (numero_clinica) REFERENCES CLINICA(numero_clinica)
);

CREATE TABLE PROPIETARIO (
    tipo_documento VARCHAR(10) NOT NULL,
    numero_documento VARCHAR(20) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    PRIMARY KEY (tipo_documento, numero_documento)
);

CREATE TABLE MASCOTA (
    id_mascota INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo_mascota VARCHAR(30) NOT NULL,
    descripcion VARCHAR(200),
    fecha_nacimiento DATE,
    fecha_registro DATE NOT NULL,
    estado VARCHAR(10) NOT NULL, -- 'vivo' o 'fallecido'
    tipo_documento_propietario VARCHAR(10) NOT NULL,
    numero_documento_propietario VARCHAR(20) NOT NULL,
    FOREIGN KEY (tipo_documento_propietario, numero_documento_propietario)
        REFERENCES PROPIETARIO(tipo_documento, numero_documento)
);

CREATE TABLE EXAMEN (
    id_examen INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME NOT NULL,
    tipo_documento_veterinario VARCHAR(10) NOT NULL,
    numero_documento_veterinario VARCHAR(20) NOT NULL,
    id_mascota INT NOT NULL,
    descripcion_resultados TEXT NOT NULL,
    FOREIGN KEY (tipo_documento_veterinario, numero_documento_veterinario)
        REFERENCES EMPLEADO(tipo_documento, numero_documento),
    FOREIGN KEY (id_mascota) REFERENCES MASCOTA(id_mascota)
);

CREATE TABLE TRATAMIENTO (
    codigo_tratamiento VARCHAR(10) PRIMARY KEY,
    descripcion TEXT NOT NULL,
    costo DECIMAL(10, 2) NOT NULL
);

CREATE TABLE EXAMEN_TRATAMIENTO (
    id_examen INT NOT NULL,
    codigo_tratamiento VARCHAR(10) NOT NULL,
    cantidad INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    comentarios TEXT,
    PRIMARY KEY (id_examen, codigo_tratamiento),
    FOREIGN KEY (id_examen) REFERENCES EXAMEN(id_examen),
    FOREIGN KEY (codigo_tratamiento) REFERENCES TRATAMIENTO(codigo_tratamiento)
);

CREATE TABLE CORRAL (
    id_corral INT PRIMARY KEY,
    numero_clinica INT NOT NULL,
    capacidad INT NOT NULL,
    estado VARCHAR(20) NOT NULL, -- 'disponible' o 'ocupado'
    FOREIGN KEY (numero_clinica) REFERENCES CLINICA(numero_clinica)
);

CREATE TABLE MASCOTA_CORRAL (
    id_mascota INT NOT NULL,
    id_corral INT NOT NULL,
    fecha_ingreso DATETIME NOT NULL,
    fecha_salida DATETIME,
    comentarios TEXT,
    PRIMARY KEY (id_mascota, id_corral, fecha_ingreso),
    FOREIGN KEY (id_mascota) REFERENCES MASCOTA(id_mascota),
    FOREIGN KEY (id_corral) REFERENCES CORRAL(id_corral)
);

CREATE TABLE FACTURA (
    numero_factura INT PRIMARY KEY,
    fecha_factura DATE NOT NULL,
    tipo_documento_propietario VARCHAR(10) NOT NULL,
    numero_documento_propietario VARCHAR(20) NOT NULL,
    id_mascota INT NOT NULL,
    costo_total DECIMAL(10, 2) NOT NULL,
    fecha_pago DATE,
    metodo_pago VARCHAR(30),
    FOREIGN KEY (tipo_documento_propietario, numero_documento_propietario)
        REFERENCES PROPIETARIO(tipo_documento, numero_documento),
    FOREIGN KEY (id_mascota) REFERENCES MASCOTA(id_mascota)
);

CREATE TABLE SUMINISTRO (
    id_suministro INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    tipo VARCHAR(20) NOT NULL, -- 'quirurgico' o 'no quirurgico' o 'farmaceutico'
    cantidad_stock INT NOT NULL,
    nivel_reorden INT NOT NULL,
    cantidad_repedido INT NOT NULL,
    costo DECIMAL(10, 2) NOT NULL,
    numero_clinica INT NOT NULL,
    FOREIGN KEY (numero_clinica) REFERENCES CLINICA(numero_clinica)
);

CREATE TABLE CITA (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    tipo_documento_propietario VARCHAR(10) NOT NULL,
    numero_documento_propietario VARCHAR(20) NOT NULL,
    id_mascota INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    FOREIGN KEY (tipo_documento_propietario, numero_documento_propietario)
        REFERENCES PROPIETARIO(tipo_documento, numero_documento),
    FOREIGN KEY (id_mascota) REFERENCES MASCOTA(id_mascota)
);

SHOW TABLES;

INSERT INTO CLINICA (numero_clinica, direccion, telefono, fax) VALUES
(1, 'Calle 123, Bogota', '3101234567', '3101234568'),
(2, 'Avenida 456, Medellín', '3112345678', '3112345679'),
(3, 'Carrera 789, Cali', '3123456789', '3123456790');

INSERT INTO EMPLEADO (tipo_documento, numero_documento, nombre, apellido, direccion, telefono, fecha_nacimiento, sexo, posicion, salario_anual, numero_clinica) VALUES
('CC', '123456789', 'Juan', 'Perez', 'Calle 456, Bogota', '3111234567', '1980-01-15', 'M', 'Gerente', 60000000, 1),
('CC', '987654321', 'Ana', 'Gomez', 'Avenida 789, Bogota', '3122345678', '1985-05-20', 'F', 'Veterinario', 48000000, 1),
('CC', '456789123', 'Carlos', 'Lopez', 'Carrera 123, Medellín', '3133456789', '1978-11-30', 'M', 'Veterinario', 45000000, 2),
('CC', '789123456', 'Laura', 'Martinez', 'Calle 321, Cali', '3144567890', '1990-07-10', 'F', 'Enfermera', 30000000, 3),
('CC', '321654987', 'Pedro', 'Ramirez', 'Avenida 654, Medellín', '3155678901', '1982-03-25', 'M', 'Secretario', 24000000, 2);

INSERT INTO PROPIETARIO (tipo_documento, numero_documento, nombre, apellido, direccion, telefono) VALUES
('CC', '111222333', 'Maria', 'Rodriguez', 'Calle 100, Bogota', '3201234567'),
('CC', '222333444', 'Luis', 'Sanchez', 'Avenida 200, Medellín', '3212345678'),
('CC', '333444555', 'Carla', 'Diaz', 'Carrera 300, Cali', '3223456789'),
('CC', '444555666', 'Jorge', 'Mendoza', 'Calle 400, Bogota', '3234567890');

INSERT INTO MASCOTA (nombre, tipo_mascota, descripcion, fecha_nacimiento, fecha_registro, estado, tipo_documento_propietario, numero_documento_propietario) VALUES
('Firulais', 'Perro', 'Labrador color cafe', '2018-05-10', '2020-01-15', 'vivo', 'CC', '111222333'),
('Miau', 'Gato', 'Gato domestico color negro', '2019-02-20', '2020-02-10', 'vivo', 'CC', '222333444'),
('Paco', 'Perro', 'Chihuahua pequeño', '2017-11-15', '2020-03-05', 'vivo', 'CC', '333444555'),
('Luna', 'Gato', 'Gata siamesa', '2020-01-01', '2021-01-10', 'vivo', 'CC', '444555666');

INSERT INTO EXAMEN (fecha_hora, tipo_documento_veterinario, numero_documento_veterinario, id_mascota, descripcion_resultados) VALUES
('2023-01-15 10:00:00', 'CC', '987654321', 1, 'Examen general. Paciente en buen estado.'),
('2023-02-10 11:30:00', 'CC', '456789123', 2, 'Examen por fiebre. Se recomienda antibiotico.'),
('2023-03-05 09:15:00', 'CC', '987654321', 3, 'Examen de rutina. Todo normal.'),
('2023-01-10 14:45:00', 'CC', '456789123', 4, 'Examen por dolor abdominal. Se recomienda radiografia.');

INSERT INTO TRATAMIENTO (codigo_tratamiento, descripcion, costo) VALUES
('ANT001', 'Antibiotico de penicilina', 50000.00),
('CIR001', 'Histerectomia felina', 200000.00),
('VAC001', 'Vacunacion contra la gripe felina', 70000.00),
('COR001', 'Permanecer en corral por dia (incluye alimentacion) - Perro pequeño', 20000.00),
('EXA001', 'Tarifa estandar por examen', 20000.00);

INSERT INTO EXAMEN_TRATAMIENTO (id_examen, codigo_tratamiento, cantidad, fecha_inicio, fecha_fin, comentarios) VALUES
(1, 'EXA001', 1, '2023-01-15', '2023-01-15', 'Examen de rutina.'),
(2, 'ANT001', 1, '2023-02-10', '2023-02-17', 'Recetado por fiebre.'),
(2, 'EXA001', 1, '2023-02-10', '2023-02-10', 'Tarifa por examen.'),
(3, 'EXA001', 1, '2023-03-05', '2023-03-05', 'Tarifa por examen.'),
(4, 'EXA001', 1, '2023-01-10', '2023-01-10', 'Tarifa por examen.');

INSERT INTO CORRAL (id_corral, numero_clinica, capacidad, estado) VALUES
(1, 1, 4, 'disponible'),
(2, 1, 2, 'disponible'),
(3, 1, 3, 'ocupado'),
(4, 2, 4, 'disponible'),
(5, 2, 1, 'disponible'),
(6, 3, 2, 'disponible');

INSERT INTO MASCOTA_CORRAL (id_mascota, id_corral, fecha_ingreso, fecha_salida, comentarios) VALUES
(2, 3, '2023-02-10 12:00:00', '2023-02-15 18:00:00', 'Internado por fiebre.'),
(4, 6, '2023-01-10 15:00:00', '2023-01-12 10:00:00', 'Internado por observacion.');

INSERT INTO FACTURA (numero_factura, fecha_factura, tipo_documento_propietario, numero_documento_propietario, id_mascota, costo_total, fecha_pago, metodo_pago) VALUES
(1, '2023-01-15', 'CC', '111222333', 1, 70000.00, '2023-01-16', 'Tarjeta de credito'),
(2, '2023-02-10', 'CC', '222333444', 2, 270000.00, '2023-02-11', 'Efectivo'),
(3, '2023-03-05', 'CC', '333444555', 3, 90000.00, NULL, NULL),
(4, '2023-01-10', 'CC', '444555666', 4, 110000.00, '2023-01-11', 'Transferencia');

INSERT INTO SUMINISTRO (id_suministro, nombre, descripcion, tipo, cantidad_stock, nivel_reorden, cantidad_repedido, costo, numero_clinica) VALUES
(1, 'Jeringas', 'Jeringas desechables', 'quirurgico', 50, 20, 100, 1500.00, 1),
(2, 'Vendajes', 'Vendajes esteriles', 'quirurgico', 30, 10, 50, 3000.00, 1),
(3, 'Antibiotico A', 'Antibiotico para infecciones', 'farmaceutico', 20, 5, 30, 5000.00, 1),
(4, 'Alimento para perros', 'Alimento premium para perros', 'no quirurgico', 100, 30, 200, 25000.00, 1),
(5, 'Bolsas plasticas', 'Bolsas para desechos', 'no quirurgico', 200, 50, 500, 500.00, 2);

INSERT INTO CITA (tipo_documento_propietario, numero_documento_propietario, id_mascota, fecha_hora) VALUES
('CC', '111222333', 1, '2023-04-15 10:00:00'),
('CC', '222333444', 2, '2023-04-16 11:30:00'),
('CC', '333444555', 3, '2023-04-17 09:15:00'),
('CC', '444555666', 4, '2023-04-18 14:45:00');

-- Conusltas

-- 1. Reporte: Nombre del gerente, dirección y teléfono de cada clínica, ordenados por número de clínica

SELECT
    e.nombre,
    e.apellido,
    c.direccion,
    c.telefono
FROM
    CLINICA c
JOIN
    EMPLEADO e ON c.numero_clinica = e.numero_clinica
WHERE
    e.posicion = 'Gerente'
ORDER BY
    c.numero_clinica;


-- 2. Reporte: Nombres y números de propietarios de los dueños de mascotas con los detalles de sus mascotas

SELECT
    p.nombre,
    p.apellido,
    p.tipo_documento,
    p.numero_documento,
    m.nombre AS nombre_mascota,
    m.tipo_mascota,
    m.descripcion,
    m.fecha_nacimiento,
    m.estado
FROM
    PROPIETARIO p
JOIN
    MASCOTA m ON p.tipo_documento = m.tipo_documento_propietario
              AND p.numero_documento = m.numero_documento_propietario
ORDER BY
    p.apellido, p.nombre;


-- 3. Reporte: Detalles de los tratamientos proporcionados a una mascota en función de los resultados de un examen determinado

SELECT
    m.nombre AS nombre_mascota,
    m.tipo_mascota,
    e.fecha_hora AS fecha_examen,
    e.descripcion_resultados,
    t.descripcion AS tratamiento,
    t.costo,
    et.cantidad,
    et.fecha_inicio,
    et.fecha_fin,
    et.comentarios
FROM
    EXAMEN e
JOIN
    MASCOTA m ON e.id_mascota = m.id_mascota
JOIN
    EXAMEN_TRATAMIENTO et ON e.id_examen = et.id_examen
JOIN
    TRATAMIENTO t ON et.codigo_tratamiento = t.codigo_tratamiento
WHERE
    e.id_examen = [ID_DEL_EXAMEN]; -- Reemplaza [ID_DEL_EXAMEN] con el ID del examen que desees consultar


-- 4. Reporte: Detalles de una factura por pagar (no pagada) para un dueño de mascota determinado

SELECT
    f.numero_factura,
    f.fecha_factura,
    p.nombre,
    p.apellido,
    p.direccion,
    p.telefono,
    m.nombre AS nombre_mascota,
    f.costo_total,
    f.metodo_pago
FROM
    FACTURA f
JOIN
    PROPIETARIO p ON f.tipo_documento_propietario = p.tipo_documento
                  AND f.numero_documento_propietario = p.numero_documento
JOIN
    MASCOTA m ON f.id_mascota = m.id_mascota
WHERE
    f.fecha_pago IS NULL
    AND p.tipo_documento = '[TIPO_DOCUMENTO]' -- Reemplaza con el tipo de documento del propietario
    AND p.numero_documento = '[NUMERO_DOCUMENTO]'; -- Reemplaza con el número de documento del propietario


-- 5. Reporte: Facturas que no se han pagado en una fecha determinada, ordenadas por número de factura

SELECT
    f.numero_factura,
    f.fecha_factura,
    p.nombre,
    p.apellido,
    m.nombre AS nombre_mascota,
    f.costo_total
FROM
    FACTURA f
JOIN
    PROPIETARIO p ON f.tipo_documento_propietario = p.tipo_documento
                  AND f.numero_documento_propietario = p.numero_documento
JOIN
    MASCOTA m ON f.id_mascota = m.id_mascota
WHERE
    f.fecha_pago IS NULL
    AND f.fecha_factura <= '[FECHA_DETERMINADA]' -- Reemplaza con la fecha que desees consultar
ORDER BY
    f.numero_factura;


-- 6. Reporte: Detalles de los corrales disponibles en una fecha determinada para clínicas en Bogotá, ordenados por número de clínica

SELECT
    c.numero_clinica,
    c.direccion,
    co.id_corral,
    co.capacidad,
    co.estado
FROM
    CORRAL co
JOIN
    CLINICA c ON co.numero_clinica = c.numero_clinica
WHERE
    co.estado = 'disponible'
    AND c.direccion LIKE '%Bogota%'
    AND co.id_corral NOT IN (
        SELECT id_corral
        FROM MASCOTA_CORRAL
        WHERE fecha_ingreso <= '[FECHA_DETERMINADA]' -- Reemplaza con la fecha que desees consultar
          AND (fecha_salida IS NULL OR fecha_salida >= '[FECHA_DETERMINADA]') -- Reemplaza con la fecha que desees consultar
    )
ORDER BY
    c.numero_clinica, co.id_corral;


-- 7. Reporte: Salario mensual total para el personal de cada clínica, ordenado por número de clínica

SELECT
    c.numero_clinica,
    c.direccion,
    SUM(e.salario_anual / 12) AS salario_mensual_total
FROM
    EMPLEADO e
JOIN
    CLINICA c ON e.numero_clinica = c.numero_clinica
GROUP BY
    c.numero_clinica, c.direccion
ORDER BY
    c.numero_clinica;


-- 8. Reporte: Costo máximo, mínimo y promedio de los tratamientos

SELECT
    MAX(t.costo) AS costo_maximo,
    MIN(t.costo) AS costo_minimo,
    AVG(t.costo) AS costo_promedio
FROM
    TRATAMIENTO t;


-- 9. Reporte: Número total de mascotas en cada tipo de mascota, ordenadas por tipo de mascota

SELECT
    tipo_mascota,
    COUNT(*) AS total_mascotas
FROM
    MASCOTA
GROUP BY
    tipo_mascota
ORDER BY
    tipo_mascota;


-- 10. Reporte: Nombres y números de personal de todos los veterinarios y enfermeras mayores de 50 años, ordenados por nombre del personal

SELECT
    e.nombre,
    e.apellido,
    e.tipo_documento,
    e.numero_documento,
    e.posicion
FROM
    EMPLEADO e
WHERE
    (e.posicion = 'Veterinario' OR e.posicion = 'Enfermera')
    AND TIMESTAMPDIFF(YEAR, e.fecha_nacimiento, CURDATE()) > 50
ORDER BY
    e.nombre, e.apellido;


-- 11. Reporte: Citas para una fecha determinada y para una clínica en particular

SELECT
    c.fecha_hora,
    p.nombre,
    p.apellido,
    p.telefono,
    m.nombre AS nombre_mascota,
    m.tipo_mascota
FROM
    CITA c
JOIN
    PROPIETARIO p ON c.tipo_documento_propietario = p.tipo_documento
                  AND c.numero_documento_propietario = p.numero_documento
JOIN
    MASCOTA m ON c.id_mascota = m.id_mascota
JOIN
    EXAMEN e ON m.id_mascota = e.id_mascota
JOIN
    EMPLEADO em ON e.tipo_documento_veterinario = em.tipo_documento
                AND e.numero_documento_veterinario = em.numero_documento
JOIN
    CLINICA cl ON em.numero_clinica = cl.numero_clinica
WHERE
    DATE(c.fecha_hora) = '[FECHA_DETERMINADA]' -- Reemplaza con la fecha que desees consultar
    AND cl.numero_clinica = [NUMERO_CLINICA] -- Reemplaza con el número de la clínica
ORDER BY
    c.fecha_hora;


-- 12. Reporte: Número total de corrales en cada clínica, ordenados por nombre de clínica

SELECT
    c.numero_clinica,
    c.direccion AS nombre_clinica,
    COUNT(co.id_corral) AS total_corrales
FROM
    CORRAL co
JOIN
    CLINICA c ON co.numero_clinica = c.numero_clinica
GROUP BY
    c.numero_clinica, c.direccion
ORDER BY
    c.direccion;


13. Reporte: Detalles de las facturas de los dueños de mascotas entre 2020 y 2023, ordenadas por fecha de factura (de la mayor a la menor)

SELECT
    f.numero_factura,
    f.fecha_factura,
    p.nombre,
    p.apellido,
    m.nombre AS nombre_mascota,
    f.costo_total,
    f.fecha_pago,
    f.metodo_pago
FROM
    FACTURA f
JOIN
    PROPIETARIO p ON f.tipo_documento_propietario = p.tipo_documento
                  AND f.numero_documento_propietario = p.numero_documento
JOIN
    MASCOTA m ON f.id_mascota = m.id_mascota
WHERE
    f.fecha_factura BETWEEN '2020-01-01' AND '2023-12-31'
ORDER BY
    f.fecha_factura DESC;


-- 14. Reporte: Nombre y descripción de las mascotas propiedad de un dueño en particular

SELECT
    m.nombre,
    m.descripcion,
    m.tipo_mascota,
    m.fecha_nacimiento,
    m.estado
FROM
    MASCOTA m
WHERE
    m.tipo_documento_propietario = '[TIPO_DOCUMENTO]' -- Reemplaza con el tipo de documento del propietario
    AND m.numero_documento_propietario = '[NUMERO_DOCUMENTO]'; -- Reemplaza con el número de documento del propietario


-- 15. Reporte: Suministros farmacéuticos que deben reordenarse en cada clínica, ordenados por nombre de clínica

SELECT
    c.numero_clinica,
    c.direccion AS nombre_clinica,
    s.nombre AS suministro,
    s.cantidad_stock,
    s.nivel_reorden,
    s.cantidad_repedido
FROM
    SUMINISTRO s
JOIN
    CLINICA c ON s.numero_clinica = c.numero_clinica
WHERE
    s.tipo = 'farmaceutico'
    AND s.cantidad_stock <= s.nivel_reorden
ORDER BY
    c.direccion, s.nombre;


-- 16. Reporte: Costo total de los suministros quirúrgicos y no quirúrgicos actualmente en stock en cada clínica, ordenados por nombre de clínica

SELECT
    c.numero_clinica,
    c.direccion AS nombre_clinica,
    SUM(CASE WHEN s.tipo IN ('quirurgico', 'no quirurgico') THEN s.cantidad_stock * s.costo ELSE 0 END) AS costo_total_suministros
FROM
    SUMINISTRO s
JOIN
    CLINICA c ON s.numero_clinica = c.numero_clinica
GROUP BY
    c.numero_clinica, c.direccion
ORDER BY
    c.direccion;
