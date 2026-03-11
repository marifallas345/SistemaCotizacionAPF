USE SistemaCotizacionAPFDB;
GO

/*
   ============================================================
   PROCEDIMIENTOS DE ALMACENAMIENTO
   ============================================================
*/
CREATE PROCEDURE sp_LoginUsuario
    @Correo VARCHAR(120),
    @Contrasena VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        u.IdUsuario,
        u.NombreCompleto,
        u.Correo,
        r.NombreRol
    FROM Usuarios u
    INNER JOIN Roles r ON u.IdRol = r.IdRol
    WHERE u.Correo = @Correo
      AND u.Contrasena = @Contrasena
      AND u.Estado = 1;
END;
GO

CREATE PROCEDURE sp_ListarProductos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        IdProducto,
        CodigoProducto,
        NombreProducto,
        Moneda,
        Descripcion
    FROM ProductosAPF
    WHERE Estado = 1
    ORDER BY NombreProducto;
END;
GO

CREATE PROCEDURE sp_ObtenerTasaProducto
    @IdProducto INT,
    @PlazoMeses INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        IdTasa,
        IdProducto,
        PlazoMeses,
        TasaAnual
    FROM TasasProducto
    WHERE IdProducto = @IdProducto
      AND PlazoMeses = @PlazoMeses
      AND Estado = 1;
END;
GO

CREATE PROCEDURE sp_InsertarCliente
    @Identificacion VARCHAR(30),
    @NombreCompleto VARCHAR(150),
    @Telefono VARCHAR(30),
    @Correo VARCHAR(120),
    @TipoCliente VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Clientes
    (
        Identificacion,
        NombreCompleto,
        Telefono,
        Correo,
        TipoCliente
    )
    VALUES
    (
        @Identificacion,
        @NombreCompleto,
        @Telefono,
        @Correo,
        @TipoCliente
    );

    SELECT SCOPE_IDENTITY() AS IdCliente;
END;
GO

CREATE PROCEDURE sp_InsertarCotizacion
    @NumeroCotizacion INT,
    @IdCliente INT,
    @IdProducto INT,
    @IdUsuario INT,
    @Monto DECIMAL(18,2),
    @PlazoMeses INT,
    @TasaAnual DECIMAL(8,4),
    @ImpuestoPorcentaje DECIMAL(5,2),
    @InteresBruto DECIMAL(18,2),
    @ImpuestoMonto DECIMAL(18,2),
    @InteresNeto DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cotizaciones
    (
        NumeroCotizacion,
        IdCliente,
        IdProducto,
        IdUsuario,
        Monto,
        PlazoMeses,
        TasaAnual,
        ImpuestoPorcentaje,
        InteresBruto,
        ImpuestoMonto,
        InteresNeto
    )
    VALUES
    (
        @NumeroCotizacion,
        @IdCliente,
        @IdProducto,
        @IdUsuario,
        @Monto,
        @PlazoMeses,
        @TasaAnual,
        @ImpuestoPorcentaje,
        @InteresBruto,
        @ImpuestoMonto,
        @InteresNeto
    );

    SELECT SCOPE_IDENTITY() AS IdCotizacion;
END;
GO

CREATE PROCEDURE sp_InsertarDetalleCotizacion
    @IdCotizacion INT,
    @NumeroMes INT,
    @MontoBase DECIMAL(18,2),
    @InteresBrutoMes DECIMAL(18,2),
    @ImpuestoMes DECIMAL(18,2),
    @InteresNetoMes DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO DetalleCotizacion
    (
        IdCotizacion,
        NumeroMes,
        MontoBase,
        InteresBrutoMes,
        ImpuestoMes,
        InteresNetoMes
    )
    VALUES
    (
        @IdCotizacion,
        @NumeroMes,
        @MontoBase,
        @InteresBrutoMes,
        @ImpuestoMes,
        @InteresNetoMes
    );
END;
GO

CREATE PROCEDURE sp_ListarCotizaciones
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.IdCotizacion,
        c.NumeroCotizacion,
        cl.Identificacion,
        cl.NombreCompleto AS Cliente,
        cl.Correo,
        p.NombreProducto,
        p.Moneda,
        c.Monto,
        c.PlazoMeses,
        c.TasaAnual,
        c.ImpuestoPorcentaje,
        c.InteresBruto,
        c.ImpuestoMonto,
        c.InteresNeto,
        c.FechaCotizacion,
        u.NombreCompleto AS UsuarioRegistro
    FROM Cotizaciones c
    INNER JOIN Clientes cl ON c.IdCliente = cl.IdCliente
    INNER JOIN ProductosAPF p ON c.IdProducto = p.IdProducto
    INNER JOIN Usuarios u ON c.IdUsuario = u.IdUsuario
    ORDER BY c.IdCotizacion DESC;
END;
GO