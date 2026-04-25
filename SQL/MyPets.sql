CREATE DATABASE MyPets;
USE MyPets;

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
