<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Dashboard</title>
    <link href="../Estilos/Styles.css" rel="stylesheet"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            Sistema de Cotización APF
        </div>

        <div class="navbar">
            <a href="Dashboard.aspx">Dashboard</a>
            <a href="NuevaCotizacion.aspx">Nueva Cotización</a>
            <a href="Login.aspx">Cerrar Sesión</a>
        </div>

        <div class="card">
            <h2>Historia</h2>

            <asp:GridView ID="gvCotizaciones" runat="server" AutoGenerateColumns="true"></asp:GridView>

        </div>
    </form>
</body>
</html>
