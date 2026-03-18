<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Dashboard - Sistema APF</title>
    <link href="../Estilos/Styles.css" rel="stylesheet" />
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
            <a href="HistorialCotizaciones.aspx">Historial</a>
            <a href="Login.aspx">Cerrar Sesión</a>
        </div>

        <div class="container">

            <div class="card">
                <h2>Bienvenido</h2>
                <asp:Label ID="lblBienvenida" runat="server" CssClass="bienvenida"></asp:Label>
            </div>

            <div class="dashboard-stats">
                <div class="card stat-card">
                    <h3>Total de cotizaciones</h3>
                    <asp:Label ID="lblTotalCotizaciones" runat="server" CssClass="stat-number" Text="0"></asp:Label>
                </div>

                <div class="card stat-card">
                    <h3>Usuario activo</h3>
                    <asp:Label ID="lblUsuarioActivo" runat="server" CssClass="stat-number" Text="-"></asp:Label>
                </div>

                <div class="card stat-card">
                    <h3>Rol</h3>
                    <asp:Label ID="lblRol" runat="server" CssClass="stat-number" Text="-"></asp:Label>
                </div>
            </div>

            <div class="card">
                <h2>Acciones rápidas</h2>
                <div class="quick-actions">
                    <a href="NuevaCotizacion.aspx" class="btn-primary">Nueva Cotización</a>
                    <a href="HistorialCotizaciones.aspx" class="btn-primary">Ver Historial</a>
                </div>
            </div>

            <div class="card">
                <h2>Últimas Cotizaciones</h2>

                <div class="table-responsive">
                    <asp:GridView ID="gvCotizaciones"
                        runat="server"
                        AutoGenerateColumns="true"
                        GridLines="None"
                        EmptyDataText="No hay cotizaciones registradas todavía.">
                    </asp:GridView>
                </div>
            </div>

        </div>

    </form>
</body>
</html>