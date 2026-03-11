USE SistemaCotizacionAPFDB
GO

/*
   ============================================================
   VISTAS
   ============================================================
*/

CREATE VIEW vw_CotizacionesResumen
AS
SELECT
    c.NumeroCotizacion,
    cl.NombreCompleto AS Cliente,
    p.NombreProducto,
    p.Moneda,
    c.Monto,
    c.PlazoMeses,
    c.TasaAnual,
    c.InteresNeto,
    c.FechaCotizacion
FROM Cotizaciones c
INNER JOIN Clientes cl ON c.IdCliente = cl.IdCliente
INNER JOIN ProductosAPF p ON c.IdProducto = p.IdProducto;
GO

CREATE VIEW vw_TasasProductos
AS
SELECT
    p.CodigoProducto,
    p.NombreProducto,
    p.Moneda,
    t.PlazoMeses,
    t.TasaAnual
FROM TasasProducto t
INNER JOIN ProductosAPF p ON t.IdProducto = p.IdProducto
WHERE t.Estado = 1;
GO

/* Consulta todos los roles registrados */
SELECT * FROM Roles;
GO

/* Consulta todos los usuarios del sistema */
SELECT * FROM Usuarios;
GO

/* Consulta todos los clientes registrados */
SELECT * FROM Clientes;
GO

/* Consulta todos los productos APF */
SELECT * FROM ProductosAPF;
GO

/* Consulta todas las tasas parametrizadas */
SELECT * FROM TasasProducto;
GO

/* Consulta el historial resumido de cotizaciones */
SELECT * FROM vw_CotizacionesResumen;
GO

/* Consulta las tasas por producto desde la vista */
SELECT * FROM vw_TasasProductos;
GO


SELECT name
FROM sys.databases
WHERE name = 'SistemaCotizacionAPFDB';

USE SistemaCotizacionAPFDB;
GO

EXEC sp_LoginUsuario
    @Correo = 'admin@apf.com',
    @Contrasena = '1234';
GO

SELECT @@SERVERNAME AS Servidor;
GO

EXEC sp_LoginUsuario
    @Correo = 'admin@apf.com',
    @Contrasena = '1234';

    SELECT * FROM Clientes