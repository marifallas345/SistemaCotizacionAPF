/* 
   ============================================================
   PROYECTO: Sistema de Cotización para Inversiones APF
   MOTOR: SQL Server
   DESCRIPCIÓN:
   Este script crea la base de datos principal del sistema,
   la cual almacenará la información de usuarios, clientes,
   productos, tasas, cotizaciones y detalle mensual.
   ============================================================
*/

CREATE DATABASE SistemaCotizacionAPFDB;
GO

USE SistemaCotizacionAPFDB;
GO

/*
   ============================================================
   Creación Tabla: Roles
   ============================================================
*/

CREATE TABLE Roles
(
    IdRol INT IDENTITY(1,1) PRIMARY KEY,
    NombreRol VARCHAR(50) NOT NULL UNIQUE,
    Estado BIT NOT NULL DEFAULT 1
);
GO

/*
   ============================================================
   Creación de Tablas
   ============================================================
*/
CREATE TABLE Usuarios
(
    IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
    NombreCompleto VARCHAR(150) NOT NULL,
    Correo VARCHAR(120) NOT NULL UNIQUE,
    Contrasena VARCHAR(100) NOT NULL,
    IdRol INT NOT NULL,
    Estado BIT NOT NULL DEFAULT 1,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Usuarios_Roles
        FOREIGN KEY (IdRol) REFERENCES Roles(IdRol)
);
GO

CREATE TABLE Clientes
(
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    Identificacion VARCHAR(30) NOT NULL UNIQUE,
    NombreCompleto VARCHAR(150) NOT NULL,
    Telefono VARCHAR(30) NOT NULL,
    Correo VARCHAR(120) NOT NULL,
    TipoCliente VARCHAR(30) NOT NULL,
    Estado BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE ProductosAPF
(
    IdProducto INT IDENTITY(1,1) PRIMARY KEY,
    CodigoProducto VARCHAR(10) NOT NULL UNIQUE,
    NombreProducto VARCHAR(100) NOT NULL,
    Moneda VARCHAR(10) NOT NULL,
    Descripcion VARCHAR(200) NULL,
    Estado BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE TasasProducto
(
    IdTasa INT IDENTITY(1,1) PRIMARY KEY,
    IdProducto INT NOT NULL,
    PlazoMeses INT NOT NULL,
    TasaAnual DECIMAL(8,4) NOT NULL,
    Estado BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_TasasProducto_ProductosAPF
        FOREIGN KEY (IdProducto) REFERENCES ProductosAPF(IdProducto)
);
GO

CREATE TABLE Cotizaciones
(
    IdCotizacion INT IDENTITY(1,1) PRIMARY KEY,
    NumeroCotizacion INT NOT NULL UNIQUE,
    IdCliente INT NOT NULL,
    IdProducto INT NOT NULL,
    IdUsuario INT NOT NULL,
    Monto DECIMAL(18,2) NOT NULL,
    PlazoMeses INT NOT NULL,
    TasaAnual DECIMAL(8,4) NOT NULL,
    ImpuestoPorcentaje DECIMAL(5,2) NOT NULL DEFAULT 13.00,
    InteresBruto DECIMAL(18,2) NOT NULL,
    ImpuestoMonto DECIMAL(18,2) NOT NULL,
    InteresNeto DECIMAL(18,2) NOT NULL,
    FechaCotizacion DATETIME NOT NULL DEFAULT GETDATE(),
    Estado VARCHAR(20) NOT NULL DEFAULT 'ACTIVA',

    CONSTRAINT FK_Cotizaciones_Clientes
        FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),

    CONSTRAINT FK_Cotizaciones_ProductosAPF
        FOREIGN KEY (IdProducto) REFERENCES ProductosAPF(IdProducto),

    CONSTRAINT FK_Cotizaciones_Usuarios
        FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);
GO

CREATE TABLE DetalleCotizacion
(
    IdDetalleCotizacion INT IDENTITY(1,1) PRIMARY KEY,
    IdCotizacion INT NOT NULL,
    NumeroMes INT NOT NULL,
    MontoBase DECIMAL(18,2) NOT NULL,
    InteresBrutoMes DECIMAL(18,2) NOT NULL,
    ImpuestoMes DECIMAL(18,2) NOT NULL,
    InteresNetoMes DECIMAL(18,2) NOT NULL,

    CONSTRAINT FK_DetalleCotizacion_Cotizaciones
        FOREIGN KEY (IdCotizacion) REFERENCES Cotizaciones(IdCotizacion)
);
GO

CREATE TABLE BitacoraSistema
(
    IdBitacora INT IDENTITY(1,1) PRIMARY KEY,
    IdUsuario INT NULL,
    Accion VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(250) NOT NULL,
    FechaRegistro DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_BitacoraSistema_Usuarios
        FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);
GO

/*
   ============================================================
   RESTRICCIONES DE INTEGRIDAD
   ============================================================
*/

/* Permite únicamente CRC o USD como moneda */
ALTER TABLE ProductosAPF
ADD CONSTRAINT CHK_ProductosAPF_Moneda
CHECK (Moneda IN ('CRC', 'USD'));
GO

/* Permite únicamente clientes físicos o jurídicos */
ALTER TABLE Clientes
ADD CONSTRAINT CHK_Clientes_TipoCliente
CHECK (TipoCliente IN ('FISICO', 'JURIDICO'));
GO

/* El monto de la cotización debe ser mayor que cero */
ALTER TABLE Cotizaciones
ADD CONSTRAINT CHK_Cotizaciones_Monto
CHECK (Monto > 0);
GO

/* El plazo de la cotización debe ser mayor que cero */
ALTER TABLE Cotizaciones
ADD CONSTRAINT CHK_Cotizaciones_PlazoMeses
CHECK (PlazoMeses > 0);
GO

/* La tasa anual debe ser mayor que cero */
ALTER TABLE TasasProducto
ADD CONSTRAINT CHK_TasasProducto_Tasa
CHECK (TasaAnual > 0);
GO

/* El plazo de la tasa debe ser mayor que cero */
ALTER TABLE TasasProducto
ADD CONSTRAINT CHK_TasasProducto_Plazo
CHECK (PlazoMeses > 0);
GO

/*
   ============================================================
   INSERCIÓN DE ROLES
   DESCRIPCIÓN:
   Se insertan los roles básicos del sistema.
   ============================================================
*/
INSERT INTO Roles (NombreRol)
VALUES 
('ADMINISTRADOR'),
('USUARIO');
GO

/*
   ============================================================
   INSERCCIONES
   ============================================================
*/

INSERT INTO Usuarios (NombreCompleto, Correo, Contrasena, IdRol)
VALUES
('Administrador General', 'admin@apf.com', '1234', 1),
('Usuario Operativo', 'usuario@apf.com', '1234', 2);
GO

INSERT INTO Clientes (Identificacion, NombreCompleto, Telefono, Correo, TipoCliente)
VALUES 
('01-1234-5678', 'Maria Fernanda Borbon Granados', '8721-8721', 'mfbg@ice.go.cr', 'FISICO'),
('ASF589DDF', 'Adrian Jose Hernandez Moncada', '61616969', 'ajhm@hotmail.com', 'FISICO'),
('3-101-123456', 'Cooperativa de Ahorro Estudiantes CR', '2785-2785', 'coopeahorroestudiantescr@estudiantescr.com', 'JURIDICO'),
('123456789012', 'Alexandrine De La Rochefoucauld', '33470023030', 'alexadlr20.1@gmail.com', 'FISICO');
GO

INSERT INTO ProductosAPF (CodigoProducto, NombreProducto, Moneda, Descripcion)
VALUES
('CC', 'Colón Crece', 'CRC', 'Producto de ahorro a plazo fijo en colones'),
('CF', 'Colón Futuro Plus', 'CRC', 'Producto de ahorro a plazo fijo premium en colones'),
('DS', 'Dólar Seguro', 'USD', 'Producto de ahorro a plazo fijo en dólares'),
('DV', 'Dólar Visión', 'USD', 'Producto de ahorro a plazo fijo premium en dólares');
GO

INSERT INTO TasasProducto (IdProducto, PlazoMeses, TasaAnual)
VALUES
(1, 1, 3.2500),
(1, 2, 3.4000),
(1, 3, 3.6000),
(1, 4, 3.7500),
(1, 5, 3.9000),
(1, 6, 4.1000),
(1, 7, 4.2500),
(1, 8, 4.4000),
(1, 9, 4.5500),
(1, 10, 4.7000),
(1, 11, 4.8500),
(1, 12, 5.0000),
(1, 13, 5.1000),
(1, 14, 5.2000),
(1, 15, 5.3000),
(1, 16, 5.4000),
(1, 17, 5.5000),
(1, 18, 5.6500),
(1, 19, 5.8000),
(1, 20, 5.9500),
(1, 21, 6.1000),
(1, 22, 6.2500),
(1, 23, 6.4000),
(1, 24, 6.5500);
GO


INSERT INTO TasasProducto (IdProducto, PlazoMeses, TasaAnual)
VALUES
(2, 3, 3.8500),
(2, 4, 4.0000),
(2, 5, 4.1500),
(2, 6, 4.3500),
(2, 7, 4.5000),
(2, 8, 4.6500),
(2, 9, 4.8000),
(2, 10, 4.9500),
(2, 11, 5.1000),
(2, 12, 5.3000),
(2, 13, 5.4000),
(2, 14, 5.5000),
(2, 15, 5.6000),
(2, 16, 5.7000),
(2, 17, 5.8000),
(2, 18, 5.9500),
(2, 19, 6.1000),
(2, 20, 6.2500),
(2, 21, 6.4000),
(2, 22, 6.5500),
(2, 23, 6.7000),
(2, 24, 6.9000);
GO

INSERT INTO TasasProducto (IdProducto, PlazoMeses, TasaAnual)
VALUES
(3, 1, 1.0000),
(3, 2, 1.2500),
(3, 3, 1.5000),
(3, 4, 1.6500),
(3, 5, 1.8000),
(3, 6, 2.0000),
(3, 7, 2.1500),
(3, 8, 2.3000),
(3, 9, 2.4500),
(3, 10, 2.6000),
(3, 11, 2.7500),
(3, 12, 2.9000),
(3, 13, 3.0000),
(3, 14, 3.1000),
(3, 15, 3.2000),
(3, 16, 3.3000),
(3, 17, 3.4000),
(3, 18, 3.5500),
(3, 19, 3.7000),
(3, 20, 3.8500),
(3, 21, 4.0000),
(3, 22, 4.1500),
(3, 23, 4.3000),
(3, 24, 4.4500);
GO

INSERT INTO TasasProducto (IdProducto, PlazoMeses, TasaAnual)
VALUES
(4, 3, 2.7500),
(4, 4, 2.9000),
(4, 5, 3.0500),
(4, 6, 3.2500),
(4, 7, 3.4000),
(4, 8, 3.5500),
(4, 9, 3.7000),
(4, 10, 3.8500),
(4, 11, 4.0000),
(4, 12, 4.2000),
(4, 13, 4.3000),
(4, 14, 4.4000),
(4, 15, 4.5000),
(4, 16, 4.6000),
(4, 17, 4.7000),
(4, 18, 4.8500),
(4, 19, 5.0000),
(4, 20, 5.1500),
(4, 21, 5.3000),
(4, 22, 5.4500),
(4, 23, 5.6000),
(4, 24, 6.8500);
GO