/* ============================================================
   SISTEMA DE COTIZACIÓN PARA INVERSIONES EN AHORROS A PLAZO FIJO
   SCRIPT COMPLETO SQL SERVER
   Base de datos alineada con:
   - ASP.NET Web Forms
   - ADO.NET
   - Controladores y modelos del proyecto
   ============================================================ */

USE master;
GO

IF DB_ID('SistemaCotizacionAPF') IS NOT NULL
BEGIN
    ALTER DATABASE SistemaCotizacionAPF SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SistemaCotizacionAPF;
END
GO

CREATE DATABASE SistemaCotizacionAPF;
GO

USE SistemaCotizacionAPF;
GO

/* ============================================================
   1. TABLAS
   ============================================================ */

CREATE TABLE roles
(
    id_rol              INT IDENTITY(1,1) PRIMARY KEY,
    nombre_rol          VARCHAR(50) NOT NULL,
    descripcion         VARCHAR(200) NULL,
    estado              BIT NOT NULL CONSTRAINT DF_roles_estado DEFAULT(1),
    fecha_creacion      DATETIME NOT NULL CONSTRAINT DF_roles_fecha_creacion DEFAULT(GETDATE()),
    usuario_creacion    VARCHAR(50) NOT NULL CONSTRAINT DF_roles_usuario_creacion DEFAULT('sistema'),
    fecha_modificacion  DATETIME NULL,
    usuario_modificacion VARCHAR(50) NULL,
    CONSTRAINT UQ_roles_nombre_rol UNIQUE(nombre_rol)
);
GO

CREATE TABLE usuarios
(
    id_usuario          INT IDENTITY(1,1) PRIMARY KEY,
    id_rol              INT NOT NULL,
    nombre_usuario      VARCHAR(50) NOT NULL,
    nombre_completo     VARCHAR(150) NOT NULL,
    correo              VARCHAR(120) NOT NULL,
    contrasena          VARCHAR(256) NOT NULL,
    telefono            VARCHAR(20) NULL,
    estado              BIT NOT NULL CONSTRAINT DF_usuarios_estado DEFAULT(1),
    ultimo_acceso       DATETIME NULL,
    fecha_creacion      DATETIME NOT NULL CONSTRAINT DF_usuarios_fecha_creacion DEFAULT(GETDATE()),
    usuario_creacion    VARCHAR(50) NOT NULL CONSTRAINT DF_usuarios_usuario_creacion DEFAULT('sistema'),
    fecha_modificacion  DATETIME NULL,
    usuario_modificacion VARCHAR(50) NULL,

    CONSTRAINT FK_usuarios_roles FOREIGN KEY(id_rol) REFERENCES roles(id_rol),
    CONSTRAINT UQ_usuarios_nombre_usuario UNIQUE(nombre_usuario),
    CONSTRAINT UQ_usuarios_correo UNIQUE(correo),
    CONSTRAINT CK_usuarios_correo CHECK(correo LIKE '%@%.%')
);
GO

CREATE TABLE monedas
(
    id_moneda           INT IDENTITY(1,1) PRIMARY KEY,
    codigo_moneda       VARCHAR(10) NOT NULL,
    nombre_moneda       VARCHAR(50) NOT NULL,
    simbolo             VARCHAR(10) NOT NULL,
    estado              BIT NOT NULL CONSTRAINT DF_monedas_estado DEFAULT(1),
    fecha_creacion      DATETIME NOT NULL CONSTRAINT DF_monedas_fecha_creacion DEFAULT(GETDATE()),
    usuario_creacion    VARCHAR(50) NOT NULL CONSTRAINT DF_monedas_usuario_creacion DEFAULT('sistema'),
    fecha_modificacion  DATETIME NULL,
    usuario_modificacion VARCHAR(50) NULL,

    CONSTRAINT UQ_monedas_codigo_moneda UNIQUE(codigo_moneda),
    CONSTRAINT UQ_monedas_nombre_moneda UNIQUE(nombre_moneda)
);
GO

CREATE TABLE clientes
(
    id_cliente          INT IDENTITY(1,1) PRIMARY KEY,
    identificacion      VARCHAR(30) NOT NULL,
    nombre_cliente      VARCHAR(150) NOT NULL,
    telefono            VARCHAR(20) NULL,
    correo              VARCHAR(120) NULL,
    id_usuario          INT NULL,
    estado              BIT NOT NULL CONSTRAINT DF_clientes_estado DEFAULT(1),
    fecha_creacion      DATETIME NOT NULL CONSTRAINT DF_clientes_fecha_creacion DEFAULT(GETDATE()),
    usuario_creacion    VARCHAR(50) NOT NULL CONSTRAINT DF_clientes_usuario_creacion DEFAULT('sistema'),
    fecha_modificacion  DATETIME NULL,
    usuario_modificacion VARCHAR(50) NULL,

    CONSTRAINT FK_clientes_usuarios FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT UQ_clientes_identificacion UNIQUE(identificacion),
    CONSTRAINT CK_clientes_correo CHECK(correo IS NULL OR correo LIKE '%@%.%')
);
GO

CREATE TABLE productos
(
    id_producto         INT IDENTITY(1,1) PRIMARY KEY,
    id_moneda           INT NOT NULL,
    codigo_producto     VARCHAR(30) NOT NULL,
    nombre_producto     VARCHAR(100) NOT NULL,
    descripcion         VARCHAR(250) NULL,
    estado              BIT NOT NULL CONSTRAINT DF_productos_estado DEFAULT(1),
    fecha_creacion      DATETIME NOT NULL CONSTRAINT DF_productos_fecha_creacion DEFAULT(GETDATE()),
    usuario_creacion    VARCHAR(50) NOT NULL CONSTRAINT DF_productos_usuario_creacion DEFAULT('sistema'),
    fecha_modificacion  DATETIME NULL,
    usuario_modificacion VARCHAR(50) NULL,

    CONSTRAINT FK_productos_monedas FOREIGN KEY(id_moneda) REFERENCES monedas(id_moneda),
    CONSTRAINT UQ_productos_codigo_producto UNIQUE(codigo_producto)
);
GO

CREATE TABLE plazos
(
    id_plazo            INT IDENTITY(1,1) PRIMARY KEY,
    plazo_meses         INT NOT NULL,
    plazo_dias          INT NOT NULL,
    descripcion         VARCHAR(150) NOT NULL,
    estado              BIT NOT NULL CONSTRAINT DF_plazos_estado DEFAULT(1),
    fecha_creacion      DATETIME NOT NULL CONSTRAINT DF_plazos_fecha_creacion DEFAULT(GETDATE()),
    usuario_creacion    VARCHAR(50) NOT NULL CONSTRAINT DF_plazos_usuario_creacion DEFAULT('sistema'),
    fecha_modificacion  DATETIME NULL,
    usuario_modificacion VARCHAR(50) NULL,

    CONSTRAINT CK_plazos_meses CHECK(plazo_meses > 0),
    CONSTRAINT CK_plazos_dias CHECK(plazo_dias > 0),
    CONSTRAINT UQ_plazos_descripcion UNIQUE(descripcion)
);
GO

CREATE TABLE tasas
(
    id_tasa             INT IDENTITY(1,1) PRIMARY KEY,
    id_producto         INT NOT NULL,
    id_plazo            INT NOT NULL,
    tasa_anual          DECIMAL(10,4) NOT NULL,
    impuesto            DECIMAL(10,4) NOT NULL,
    fecha_vigencia      DATETIME NOT NULL,
    estado              BIT NOT NULL CONSTRAINT DF_tasas_estado DEFAULT(1),
    fecha_creacion      DATETIME NOT NULL CONSTRAINT DF_tasas_fecha_creacion DEFAULT(GETDATE()),
    usuario_creacion    VARCHAR(50) NOT NULL CONSTRAINT DF_tasas_usuario_creacion DEFAULT('sistema'),
    fecha_modificacion  DATETIME NULL,
    usuario_modificacion VARCHAR(50) NULL,

    CONSTRAINT FK_tasas_productos FOREIGN KEY(id_producto) REFERENCES productos(id_producto),
    CONSTRAINT FK_tasas_plazos FOREIGN KEY(id_plazo) REFERENCES plazos(id_plazo),
    CONSTRAINT CK_tasas_tasa_anual CHECK(tasa_anual > 0 AND tasa_anual <= 100),
    CONSTRAINT CK_tasas_impuesto CHECK(impuesto >= 0 AND impuesto <= 1)
);
GO

CREATE TABLE cotizaciones
(
    id_cotizacion               INT IDENTITY(1,1) PRIMARY KEY,
    numero_cotizacion           VARCHAR(30) NOT NULL,
    id_cliente                  INT NOT NULL,
    id_usuario                  INT NOT NULL,
    id_producto                 INT NOT NULL,
    id_plazo                    INT NOT NULL,
    id_tasa                     INT NOT NULL,
    monto                       DECIMAL(18,2) NOT NULL,
    tasa_aplicada               DECIMAL(10,4) NOT NULL,
    impuesto_aplicado           DECIMAL(10,4) NOT NULL,
    monto_total_interes_bruto   DECIMAL(18,2) NOT NULL,
    monto_total_impuesto        DECIMAL(18,2) NOT NULL,
    monto_total_neto            DECIMAL(18,2) NOT NULL,
    fecha_cotizacion            DATETIME NOT NULL CONSTRAINT DF_cotizaciones_fecha_cotizacion DEFAULT(GETDATE()),
    estado                      BIT NOT NULL CONSTRAINT DF_cotizaciones_estado DEFAULT(1),
    fecha_creacion              DATETIME NOT NULL CONSTRAINT DF_cotizaciones_fecha_creacion DEFAULT(GETDATE()),
    usuario_creacion            VARCHAR(50) NOT NULL CONSTRAINT DF_cotizaciones_usuario_creacion DEFAULT('sistema'),
    fecha_modificacion          DATETIME NULL,
    usuario_modificacion        VARCHAR(50) NULL,

    CONSTRAINT FK_cotizaciones_clientes FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT FK_cotizaciones_usuarios FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT FK_cotizaciones_productos FOREIGN KEY(id_producto) REFERENCES productos(id_producto),
    CONSTRAINT FK_cotizaciones_plazos FOREIGN KEY(id_plazo) REFERENCES plazos(id_plazo),
    CONSTRAINT FK_cotizaciones_tasas FOREIGN KEY(id_tasa) REFERENCES tasas(id_tasa),
    CONSTRAINT UQ_cotizaciones_numero_cotizacion UNIQUE(numero_cotizacion),
    CONSTRAINT CK_cotizaciones_monto CHECK(monto > 0)
);
GO

CREATE TABLE detalle_cotizacion
(
    id_detalle          INT IDENTITY(1,1) PRIMARY KEY,
    id_cotizacion       INT NOT NULL,
    numero_mes          INT NOT NULL,
    monto               DECIMAL(18,2) NOT NULL,
    interes_bruto       DECIMAL(18,2) NOT NULL,
    impuesto            DECIMAL(18,2) NOT NULL,
    interes_neto        DECIMAL(18,2) NOT NULL,
    fecha_creacion      DATETIME NOT NULL CONSTRAINT DF_detalle_fecha_creacion DEFAULT(GETDATE()),

    CONSTRAINT FK_detalle_cotizacion_cotizaciones FOREIGN KEY(id_cotizacion) REFERENCES cotizaciones(id_cotizacion),
    CONSTRAINT UQ_detalle_cotizacion_mes UNIQUE(id_cotizacion, numero_mes),
    CONSTRAINT CK_detalle_numero_mes CHECK(numero_mes > 0)
);
GO

CREATE TABLE historial_cotizaciones
(
    id_historial        INT IDENTITY(1,1) PRIMARY KEY,
    id_cotizacion       INT NOT NULL,
    accion              VARCHAR(50) NOT NULL,
    detalle             VARCHAR(300) NOT NULL,
    fecha_evento        DATETIME NOT NULL CONSTRAINT DF_historial_fecha_evento DEFAULT(GETDATE()),
    id_usuario          INT NULL,
    usuario_evento      VARCHAR(50) NOT NULL CONSTRAINT DF_historial_usuario_evento DEFAULT('sistema'),

    CONSTRAINT FK_historial_cotizaciones FOREIGN KEY(id_cotizacion) REFERENCES cotizaciones(id_cotizacion),
    CONSTRAINT FK_historial_usuario FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario)
);
GO

CREATE TABLE auditoria
(
    id_auditoria        INT IDENTITY(1,1) PRIMARY KEY,
    tabla_afectada      VARCHAR(100) NOT NULL,
    accion              VARCHAR(20) NOT NULL,
    id_registro         VARCHAR(50) NULL,
    descripcion         VARCHAR(500) NULL,
    usuario_evento      VARCHAR(50) NOT NULL CONSTRAINT DF_auditoria_usuario_evento DEFAULT('sistema'),
    fecha_evento        DATETIME NOT NULL CONSTRAINT DF_auditoria_fecha_evento DEFAULT(GETDATE())
);
GO

CREATE TABLE bitacora_acceso
(
    id_bitacora         INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario          INT NOT NULL,
    fecha_acceso        DATETIME NOT NULL CONSTRAINT DF_bitacora_fecha_acceso DEFAULT(GETDATE()),
    ip_acceso           VARCHAR(50) NULL,
    resultado           VARCHAR(20) NOT NULL,
    observacion         VARCHAR(250) NULL,

    CONSTRAINT FK_bitacora_usuario FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT CK_bitacora_resultado CHECK(resultado IN ('EXITOSO', 'FALLIDO'))
);
GO

/* ============================================================
   2. ÍNDICES
   ============================================================ */

CREATE INDEX idx_usuarios_nombre_usuario ON usuarios(nombre_usuario);
GO
CREATE INDEX idx_usuarios_correo ON usuarios(correo);
GO
CREATE INDEX idx_clientes_identificacion ON clientes(identificacion);
GO
CREATE INDEX idx_productos_codigo_producto ON productos(codigo_producto);
GO
CREATE INDEX idx_tasas_producto_plazo_fecha ON tasas(id_producto, id_plazo, fecha_vigencia DESC);
GO
CREATE INDEX idx_cotizaciones_cliente_fecha ON cotizaciones(id_cliente, fecha_cotizacion DESC);
GO
CREATE INDEX idx_cotizaciones_usuario_fecha ON cotizaciones(id_usuario, fecha_cotizacion DESC);
GO
CREATE INDEX idx_detalle_cotizacion_id_cotizacion ON detalle_cotizacion(id_cotizacion);
GO
CREATE INDEX idx_historial_cotizacion_fecha ON historial_cotizaciones(id_cotizacion, fecha_evento DESC);
GO
CREATE INDEX idx_bitacora_acceso_usuario_fecha ON bitacora_acceso(id_usuario, fecha_acceso DESC);
GO

/* ============================================================
   3. FUNCIONES
   ============================================================ */

IF OBJECT_ID('dbo.fn_calcular_interes_bruto_mensual', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_calcular_interes_bruto_mensual;
GO

CREATE FUNCTION dbo.fn_calcular_interes_bruto_mensual
(
    @monto DECIMAL(18,2),
    @tasa_anual DECIMAL(10,4)
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @resultado DECIMAL(18,2);

    SET @resultado = ROUND((@monto * (@tasa_anual / 100.0) / 360.0) * 30.0, 2);

    RETURN @resultado;
END;
GO

IF OBJECT_ID('dbo.fn_calcular_impuesto_mensual', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_calcular_impuesto_mensual;
GO

CREATE FUNCTION dbo.fn_calcular_impuesto_mensual
(
    @interes_bruto DECIMAL(18,2),
    @impuesto DECIMAL(10,4)
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @resultado DECIMAL(18,2);

    SET @resultado = ROUND(@interes_bruto * @impuesto, 2);

    RETURN @resultado;
END;
GO

IF OBJECT_ID('dbo.fn_calcular_interes_neto_mensual', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_calcular_interes_neto_mensual;
GO

CREATE FUNCTION dbo.fn_calcular_interes_neto_mensual
(
    @interes_bruto DECIMAL(18,2),
    @impuesto_monto DECIMAL(18,2)
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @resultado DECIMAL(18,2);

    SET @resultado = ROUND(@interes_bruto - @impuesto_monto, 2);

    RETURN @resultado;
END;
GO

IF OBJECT_ID('dbo.fn_generar_numero_cotizacion', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_generar_numero_cotizacion;
GO

CREATE FUNCTION dbo.fn_generar_numero_cotizacion
(
    @id_cotizacion INT
)
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE @numero VARCHAR(30);

    SET @numero = 'COT-'
                + CONVERT(VARCHAR(8), GETDATE(), 112)
                + '-'
                + RIGHT('00000' + CAST(@id_cotizacion AS VARCHAR(5)), 5);

    RETURN @numero;
END;
GO

/* ============================================================
   4. VISTAS
   ============================================================ */

IF OBJECT_ID('dbo.vw_clientes_activos', 'V') IS NOT NULL
    DROP VIEW dbo.vw_clientes_activos;
GO

CREATE VIEW dbo.vw_clientes_activos
AS
SELECT
    c.id_cliente,
    c.identificacion,
    c.nombre_cliente,
    c.telefono,
    c.correo,
    c.id_usuario,
    c.estado,
    c.fecha_creacion
FROM clientes c
WHERE c.estado = 1;
GO

IF OBJECT_ID('dbo.vw_productos_vigentes', 'V') IS NOT NULL
    DROP VIEW dbo.vw_productos_vigentes;
GO

CREATE VIEW dbo.vw_productos_vigentes
AS
SELECT
    p.id_producto,
    p.id_moneda,
    m.codigo_moneda,
    m.nombre_moneda,
    m.simbolo,
    p.codigo_producto,
    p.nombre_producto,
    p.descripcion,
    p.estado,
    p.fecha_creacion
FROM productos p
INNER JOIN monedas m ON p.id_moneda = m.id_moneda
WHERE p.estado = 1
  AND m.estado = 1;
GO

IF OBJECT_ID('dbo.vw_tasas_vigentes', 'V') IS NOT NULL
    DROP VIEW dbo.vw_tasas_vigentes;
GO

CREATE VIEW dbo.vw_tasas_vigentes
AS
SELECT
    t.id_tasa,
    t.id_producto,
    p.nombre_producto,
    t.id_plazo,
    pl.descripcion AS descripcion_plazo,
    pl.plazo_meses,
    t.tasa_anual,
    t.impuesto,
    t.fecha_vigencia,
    t.estado
FROM tasas t
INNER JOIN productos p ON t.id_producto = p.id_producto
INNER JOIN plazos pl ON t.id_plazo = pl.id_plazo
WHERE t.estado = 1
  AND p.estado = 1
  AND pl.estado = 1;
GO

IF OBJECT_ID('dbo.vw_historial_cotizaciones_detallado', 'V') IS NOT NULL
    DROP VIEW dbo.vw_historial_cotizaciones_detallado;
GO

CREATE VIEW dbo.vw_historial_cotizaciones_detallado
AS
SELECT
    h.id_historial,
    h.id_cotizacion,
    c.numero_cotizacion,
    h.accion,
    h.detalle,
    h.fecha_evento,
    h.id_usuario,
    u.nombre_completo,
    h.usuario_evento
FROM historial_cotizaciones h
INNER JOIN cotizaciones c ON h.id_cotizacion = c.id_cotizacion
LEFT JOIN usuarios u ON h.id_usuario = u.id_usuario;
GO

/* ============================================================
   7. DATOS DE PRUEBA
   ============================================================ */

INSERT INTO roles(nombre_rol, descripcion, usuario_creacion)
VALUES
('Administrador', 'Usuario administrador del sistema', 'script'),
('Usuario', 'Usuario operativo del sistema', 'script');
GO

INSERT INTO monedas(codigo_moneda, nombre_moneda, simbolo, usuario_creacion)
VALUES
('CRC', 'Colón costarricense', '₡', 'script'),
('USD', 'Dólar estadounidense', '$', 'script');
GO

INSERT INTO usuarios
(
    id_rol, nombre_usuario, nombre_completo, correo, contrasena,
    telefono, estado, usuario_creacion
)
VALUES
(
    1,
    'admin',
    'Administrador General',
    'admin@apf.com',
    '240be518fabd2724ddb6f04eeb1da7f8dd6fdaa3259b08abab7c0cc7fe9b49f3', -- admin123
    '88888888',
    1,
    'script'
),
(
    2,
    'maria',
    'Maria Agüero',
    'maria@apf.com',
    '240be518fabd2724ddb6f04eeb1da7f8dd6fdaa3259b08abab7c0cc7fe9b49f3', -- admin123
    '87776655',
    1,
    'script'
);
GO

INSERT INTO clientes
(
    identificacion, nombre_cliente, telefono, correo, id_usuario, estado, usuario_creacion
)
VALUES
('101110111', 'Carlos Rodríguez', '88887777', 'carlos@email.com', 2, 1, 'script'),
('202220222', 'Ana Fernández', '87778899', 'ana@email.com', 2, 1, 'script'),
('303330333', 'Luis Gómez', '86665544', 'luis@email.com', 1, 1, 'script');
GO

INSERT INTO productos
(
    id_moneda, codigo_producto, nombre_producto, descripcion, estado, usuario_creacion
)
VALUES
(1, 'APF-CRC-06', 'APF en Colones', 'Producto de ahorro a plazo fijo en moneda CRC', 1, 'script'),
(2, 'APF-USD-12', 'APF en Dólares', 'Producto de ahorro a plazo fijo en moneda USD', 1, 'script');
GO

INSERT INTO plazos
(
    plazo_meses, plazo_dias, descripcion, estado, usuario_creacion
)
VALUES
(3, 90, '3 meses', 1, 'script'),
(6, 180, '6 meses', 1, 'script'),
(12, 360, '12 meses', 1, 'script');
GO

INSERT INTO tasas
(
    id_producto, id_plazo, tasa_anual, impuesto, fecha_vigencia, estado, usuario_creacion
)
VALUES
(1, 1, 5.5000, 0.1300, GETDATE(), 1, 'script'),
(1, 2, 6.2500, 0.1300, GETDATE(), 1, 'script'),
(1, 3, 7.0000, 0.1300, GETDATE(), 1, 'script'),
(2, 1, 4.2500, 0.1300, GETDATE(), 1, 'script'),
(2, 2, 4.8000, 0.1300, GETDATE(), 1, 'script'),
(2, 3, 5.2500, 0.1300, GETDATE(), 1, 'script');
GO




/* ============================================================
   8. CONSULTAS DE VERIFICACIÓN
   ============================================================ */
SELECT * FROM roles;
SELECT * FROM usuarios;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM monedas;
SELECT * FROM plazos;
SELECT * FROM tasas;
SELECT * FROM cotizaciones;
SELECT * FROM detalle_cotizacion;
SELECT * FROM historial_cotizaciones;
SELECT * FROM auditoria;
SELECT * FROM bitacora_acceso;

GO

/* ============================================================
   9. PROCEDIMIENTOS DE NEGOCIO (LO QUE USA TU SISTEMA)
   ============================================================ */

IF OBJECT_ID('dbo.sp_login_usuario', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_login_usuario;
GO

CREATE PROCEDURE dbo.sp_login_usuario
    @usuario_o_correo VARCHAR(120),
    @contrasena VARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_usuario INT;

    SELECT TOP 1
        @id_usuario = u.id_usuario
    FROM usuarios u
    INNER JOIN roles r ON u.id_rol = r.id_rol
    WHERE (u.nombre_usuario = @usuario_o_correo OR u.correo = @usuario_o_correo)
      AND u.contrasena = @contrasena
      AND u.estado = 1
      AND r.estado = 1;

    IF @id_usuario IS NOT NULL
    BEGIN
        UPDATE usuarios
        SET ultimo_acceso = GETDATE()
        WHERE id_usuario = @id_usuario;

        INSERT INTO bitacora_acceso(id_usuario, resultado, observacion)
        VALUES(@id_usuario, 'EXITOSO', 'Inicio de sesión correcto');

        SELECT
            u.id_usuario,
            u.nombre_usuario,
            u.nombre_completo,
            u.correo,
            r.nombre_rol
        FROM usuarios u
        INNER JOIN roles r ON u.id_rol = r.id_rol
        WHERE u.id_usuario = @id_usuario;
    END
END;
GO

IF OBJECT_ID('dbo.sp_registrar_usuario_nuevo', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_registrar_usuario_nuevo;
GO

CREATE PROCEDURE dbo.sp_registrar_usuario_nuevo
    @id_rol INT,
    @nombre_usuario VARCHAR(50),
    @nombre_completo VARCHAR(150),
    @correo VARCHAR(120),
    @contrasena VARCHAR(256),
    @telefono VARCHAR(20) = NULL,
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(SELECT 1 FROM usuarios WHERE nombre_usuario = @nombre_usuario)
    BEGIN
        RAISERROR('El nombre de usuario ya existe.', 16, 1);
        RETURN;
    END

    IF EXISTS(SELECT 1 FROM usuarios WHERE correo = @correo)
    BEGIN
        RAISERROR('El correo ya existe.', 16, 1);
        RETURN;
    END

    INSERT INTO usuarios
    (
        id_rol, nombre_usuario, nombre_completo, correo,
        contrasena, telefono, estado, usuario_creacion
    )
    VALUES
    (
        @id_rol, @nombre_usuario, @nombre_completo, @correo,
        @contrasena, @telefono, 1, @usuario_creacion
    );
END;
GO

IF OBJECT_ID('dbo.sp_insertar_cliente', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_insertar_cliente;
GO

CREATE PROCEDURE dbo.sp_insertar_cliente
    @identificacion VARCHAR(30),
    @nombre_cliente VARCHAR(150),
    @telefono VARCHAR(20) = NULL,
    @correo VARCHAR(120) = NULL,
    @id_usuario INT = NULL,
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(SELECT 1 FROM clientes WHERE identificacion = @identificacion)
    BEGIN
        RAISERROR('Ya existe un cliente con esa identificación.', 16, 1);
        RETURN;
    END

    INSERT INTO clientes
    (
        identificacion, nombre_cliente, telefono, correo, id_usuario, estado, usuario_creacion
    )
    VALUES
    (
        @identificacion, @nombre_cliente, @telefono, @correo, @id_usuario, 1, @usuario_creacion
    );
END;
GO

IF OBJECT_ID('dbo.sp_insertar_producto', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_insertar_producto;
GO

CREATE PROCEDURE dbo.sp_insertar_producto
    @id_moneda INT,
    @codigo_producto VARCHAR(30),
    @nombre_producto VARCHAR(100),
    @descripcion VARCHAR(250) = NULL,
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(SELECT 1 FROM productos WHERE codigo_producto = @codigo_producto)
    BEGIN
        RAISERROR('Ya existe un producto con ese código.', 16, 1);
        RETURN;
    END

    INSERT INTO productos
    (
        id_moneda, codigo_producto, nombre_producto, descripcion, estado, usuario_creacion
    )
    VALUES
    (
        @id_moneda, @codigo_producto, @nombre_producto, @descripcion, 1, @usuario_creacion
    );
END;
GO

IF OBJECT_ID('dbo.sp_insertar_plazo', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_insertar_plazo;
GO

CREATE PROCEDURE dbo.sp_insertar_plazo
    @plazo_meses INT,
    @plazo_dias INT,
    @descripcion VARCHAR(150),
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(SELECT 1 FROM plazos WHERE descripcion = @descripcion)
    BEGIN
        RAISERROR('Ya existe un plazo con esa descripción.', 16, 1);
        RETURN;
    END

    INSERT INTO plazos
    (
        plazo_meses, plazo_dias, descripcion, estado, usuario_creacion
    )
    VALUES
    (
        @plazo_meses, @plazo_dias, @descripcion, 1, @usuario_creacion
    );
END;
GO

IF OBJECT_ID('dbo.sp_insertar_tasa', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_insertar_tasa;
GO

CREATE PROCEDURE dbo.sp_insertar_tasa
    @id_producto INT,
    @id_plazo INT,
    @tasa_anual DECIMAL(10,4),
    @impuesto DECIMAL(10,4),
    @fecha_vigencia DATETIME,
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO tasas
    (
        id_producto, id_plazo, tasa_anual, impuesto, fecha_vigencia, estado, usuario_creacion
    )
    VALUES
    (
        @id_producto, @id_plazo, @tasa_anual, @impuesto, @fecha_vigencia, 1, @usuario_creacion
    );
END;
GO

IF OBJECT_ID('dbo.sp_generar_detalle_mensual', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_generar_detalle_mensual;
GO

CREATE PROCEDURE dbo.sp_generar_detalle_mensual
    @id_cotizacion INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @monto DECIMAL(18,2);
    DECLARE @tasa_aplicada DECIMAL(10,4);
    DECLARE @impuesto_aplicado DECIMAL(10,4);
    DECLARE @plazo_meses INT;
    DECLARE @mes INT = 1;
    DECLARE @interes_bruto DECIMAL(18,2);
    DECLARE @impuesto_monto DECIMAL(18,2);
    DECLARE @interes_neto DECIMAL(18,2);

    SELECT
        @monto = c.monto,
        @tasa_aplicada = c.tasa_aplicada,
        @impuesto_aplicado = c.impuesto_aplicado,
        @plazo_meses = p.plazo_meses
    FROM cotizaciones c
    INNER JOIN plazos p ON c.id_plazo = p.id_plazo
    WHERE c.id_cotizacion = @id_cotizacion;

    IF @plazo_meses IS NULL OR @plazo_meses <= 0
    BEGIN
        RAISERROR('No se encontró la cotización o el plazo es inválido.', 16, 1);
        RETURN;
    END

    DELETE FROM detalle_cotizacion
    WHERE id_cotizacion = @id_cotizacion;

    WHILE @mes <= @plazo_meses
    BEGIN
        SET @interes_bruto = dbo.fn_calcular_interes_bruto_mensual(@monto, @tasa_aplicada);
        SET @impuesto_monto = dbo.fn_calcular_impuesto_mensual(@interes_bruto, @impuesto_aplicado);
        SET @interes_neto = dbo.fn_calcular_interes_neto_mensual(@interes_bruto, @impuesto_monto);

        INSERT INTO detalle_cotizacion
        (
            id_cotizacion,
            numero_mes,
            monto,
            interes_bruto,
            impuesto,
            interes_neto
        )
        VALUES
        (
            @id_cotizacion,
            @mes,
            @monto,
            @interes_bruto,
            @impuesto_monto,
            @interes_neto
        );

        SET @mes = @mes + 1;
    END
END;
GO

IF OBJECT_ID('dbo.sp_crear_cotizacion', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_crear_cotizacion;
GO

CREATE PROCEDURE dbo.sp_crear_cotizacion
    @numero_cotizacion VARCHAR(30),
    @id_cliente INT,
    @id_usuario INT,
    @id_producto INT,
    @id_plazo INT,
    @id_tasa INT,
    @monto DECIMAL(18,2),
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @tasa_aplicada DECIMAL(10,4);
    DECLARE @impuesto_aplicado DECIMAL(10,4);
    DECLARE @plazo_meses INT;
    DECLARE @interes_bruto_mensual DECIMAL(18,2);
    DECLARE @impuesto_mensual DECIMAL(18,2);
    DECLARE @interes_neto_mensual DECIMAL(18,2);
    DECLARE @monto_total_interes_bruto DECIMAL(18,2);
    DECLARE @monto_total_impuesto DECIMAL(18,2);
    DECLARE @monto_total_neto DECIMAL(18,2);
    DECLARE @id_cotizacion INT;

    BEGIN TRANSACTION;

    BEGIN TRY
        IF EXISTS(SELECT 1 FROM cotizaciones WHERE numero_cotizacion = @numero_cotizacion)
        BEGIN
            RAISERROR('El número de cotización ya existe.', 16, 1);
        END

        SELECT
            @tasa_aplicada = t.tasa_anual,
            @impuesto_aplicado = t.impuesto
        FROM tasas t
        WHERE t.id_tasa = @id_tasa
          AND t.id_producto = @id_producto
          AND t.id_plazo = @id_plazo
          AND t.estado = 1;

        IF @tasa_aplicada IS NULL
        BEGIN
            RAISERROR('La tasa seleccionada no corresponde al producto y plazo indicados.', 16, 1);
        END

        SELECT
            @plazo_meses = p.plazo_meses
        FROM plazos p
        WHERE p.id_plazo = @id_plazo
          AND p.estado = 1;

        IF @plazo_meses IS NULL OR @plazo_meses <= 0
        BEGIN
            RAISERROR('El plazo seleccionado es inválido.', 16, 1);
        END

        SET @interes_bruto_mensual = dbo.fn_calcular_interes_bruto_mensual(@monto, @tasa_aplicada);
        SET @impuesto_mensual = dbo.fn_calcular_impuesto_mensual(@interes_bruto_mensual, @impuesto_aplicado);
        SET @interes_neto_mensual = dbo.fn_calcular_interes_neto_mensual(@interes_bruto_mensual, @impuesto_mensual);

        SET @monto_total_interes_bruto = ROUND(@interes_bruto_mensual * @plazo_meses, 2);
        SET @monto_total_impuesto = ROUND(@impuesto_mensual * @plazo_meses, 2);
        SET @monto_total_neto = ROUND(@interes_neto_mensual * @plazo_meses, 2);

        INSERT INTO cotizaciones
        (
            numero_cotizacion,
            id_cliente,
            id_usuario,
            id_producto,
            id_plazo,
            id_tasa,
            monto,
            tasa_aplicada,
            impuesto_aplicado,
            monto_total_interes_bruto,
            monto_total_impuesto,
            monto_total_neto,
            estado,
            usuario_creacion
        )
        VALUES
        (
            @numero_cotizacion,
            @id_cliente,
            @id_usuario,
            @id_producto,
            @id_plazo,
            @id_tasa,
            @monto,
            @tasa_aplicada,
            @impuesto_aplicado,
            @monto_total_interes_bruto,
            @monto_total_impuesto,
            @monto_total_neto,
            1,
            @usuario_creacion
        );

        SET @id_cotizacion = SCOPE_IDENTITY();

        EXEC dbo.sp_generar_detalle_mensual @id_cotizacion = @id_cotizacion;

        INSERT INTO historial_cotizaciones
        (
            id_cotizacion,
            accion,
            detalle,
            id_usuario,
            usuario_evento
        )
        VALUES
        (
            @id_cotizacion,
            'CREACION',
            'Se registró la cotización y se generó el detalle mensual.',
            @id_usuario,
            @usuario_creacion
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @mensaje_error VARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@mensaje_error, 16, 1);
    END CATCH
END;
GO

IF OBJECT_ID('dbo.sp_consultar_historial', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_consultar_historial;
GO

CREATE PROCEDURE dbo.sp_consultar_historial
    @id_usuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.id_cotizacion,
        c.numero_cotizacion,
        cl.nombre_cliente,
        p.nombre_producto,
        pl.descripcion AS plazo,
        c.monto,
        c.tasa_aplicada,
        c.impuesto_aplicado,
        c.monto_total_interes_bruto,
        c.monto_total_impuesto,
        c.monto_total_neto,
        c.fecha_cotizacion
    FROM cotizaciones c
    INNER JOIN clientes cl ON c.id_cliente = cl.id_cliente
    INNER JOIN productos p ON c.id_producto = p.id_producto
    INNER JOIN plazos pl ON c.id_plazo = pl.id_plazo
    WHERE c.id_usuario = @id_usuario
    ORDER BY c.fecha_cotizacion DESC, c.id_cotizacion DESC;
END;
GO

IF OBJECT_ID('dbo.sp_obtener_detalle_cotizacion', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_obtener_detalle_cotizacion;
GO

CREATE PROCEDURE dbo.sp_obtener_detalle_cotizacion
    @id_cotizacion INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_detalle,
        id_cotizacion,
        numero_mes,
        monto,
        interes_bruto,
        impuesto,
        interes_neto
    FROM detalle_cotizacion
    WHERE id_cotizacion = @id_cotizacion
    ORDER BY numero_mes;
END;
GO

/* ============================================================
   10. COTIZACIÓN DE PRUEBA
   ============================================================ */

EXEC dbo.sp_crear_cotizacion
    @numero_cotizacion = 'COT-PRUEBA-0001',
    @id_cliente = 1,
    @id_usuario = 2,
    @id_producto = 1,
    @id_plazo = 2,
    @id_tasa = 2,
    @monto = 1000000.00,
    @usuario_creacion = 'script';
GO