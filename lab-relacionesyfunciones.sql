drop database if exists empresa;

create database empresa;

use empresa;

create table departamentos (
departamento_id INT auto_increment primary key,
nombre VARCHAR(100) not null
);

create table empleados (
empleado_id INT auto_increment primary key,
nombre VARCHAR(100) not null,
salario DECIMAL(10,2) not null,
departamento_id INT,
constraint fk_departamento_empleado foreign key (departamento_id) references departamentos(departamento_id)
);

create table proyectos (
proyecto_id INT auto_increment primary key,
nombre VARCHAR(100) not null
);

create table empleado_proyecto (
empleado_id INT,
proyecto_id INT,
primary key (empleado_id, proyecto_id),
foreign key (empleado_id) references empleados (empleado_id),
foreign key (proyecto_id) references proyectos (proyecto_id)
);

create table detalles_empleado (
detalle_id INT auto_increment primary key,
empleado_id INT,
direccion VARCHAR(255) not null,
telefono VARCHAR(15) not null,
foreign key (empleado_id) references empleados (empleado_id)
);

alter table empleados 
add column detalle_id INT,
add constraint fk_detalle_id 
foreign key (detalle_id) 
references detalles_empleado(detalle_id);

-- Insertar datos en la tabla departamentos
INSERT INTO departamentos (nombre) VALUES
('Recursos Humanos'),
('Finanzas'),
('Desarrollo'),
('Marketing'),
('Ventas'),
('Soporte Técnico'),
('Administración');

-- Insertar datos en la tabla empleados
INSERT INTO empleados (nombre, salario, departamento_id) VALUES
('Juan Pérez', 50000.00, 1),
('María Gómez', 55000.00, 2),
('Luis Rodríguez', 60000.00, 3),
('Ana Martínez', 48000.00, 4),
('Carlos López', 45000.00, 5),
('Laura Fernández', 47000.00, 6),
('José Sánchez', 52000.00, 7);

-- Insertar datos en la tabla proyectos
INSERT INTO proyectos (nombre) VALUES
('Proyecto Alfa'),
('Proyecto Beta'),
('Proyecto Gamma'),
('Proyecto Delta'),
('Proyecto Épsilon'),
('Proyecto Zeta'),
('Proyecto Eta');

-- Insertar datos en la tabla empleado_proyecto
INSERT INTO empleado_proyecto (empleado_id, proyecto_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

-- Insertar datos en la tabla detalles_empleado
INSERT INTO detalles_empleado (empleado_id, direccion, telefono) VALUES
(1, 'Calle 123, Ciudad A', '123456789'),
(2, 'Avenida 456, Ciudad B', '987654321'),
(3, 'Carrera 789, Ciudad C', '456123789'),
(4, 'Calle 321, Ciudad D', '789456123'),
(5, 'Avenida 654, Ciudad E', '321789654'),
(6, 'Carrera 987, Ciudad F', '654321987'),
(7, 'Calle 147, Ciudad G', '147258369');

-- Actualizar la tabla empleados con detalle_id
UPDATE empleados SET detalle_id = 1 WHERE empleado_id = 1;
UPDATE empleados SET detalle_id = 2 WHERE empleado_id = 2;
UPDATE empleados SET detalle_id = 3 WHERE empleado_id = 3;
UPDATE empleados SET detalle_id = 4 WHERE empleado_id = 4;
UPDATE empleados SET detalle_id = 5 WHERE empleado_id = 5;
UPDATE empleados SET detalle_id = 6 WHERE empleado_id = 6;
UPDATE empleados SET detalle_id = 7 WHERE empleado_id = 7;

DELIMITER $$

create function calcular_bonificacion(empleado_id_f DECIMAL(10,2)) 
returns DECIMAL(10,2) DETERMINISTIC
	begin
		declare salario_base DECIMAL(10,2);
		declare bonus DECIMAL(10,2);
	
		select salario into salario_base 
		from empleados where empleado_id = empleado_id_f;
	
		set bonus = salario_base * 0.1;
	
		return bonus;
	end$$
	
DELIMITER ;


-- PASO 5, descomentar esto supone eliminar la relación entre departamentos y empleados,
-- por eso lo dejo comentado.

-- alter table empleados 
-- drop constraint fk_departamento_empleado;






