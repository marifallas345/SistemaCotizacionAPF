<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistorialCotizaciones.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.HistorialCotizaciones" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Historial de Cotizaciones</title>
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
                <h2>Historial de Cotizaciones</h2>

                <div class="table-responsive">
                    <asp:GridView ID="gvHistorial"
                        runat="server"
                        AutoGenerateColumns="true"
                        GridLines="None"
                        EmptyDataText="No hay cotizaciones registradas.">
                    </asp:GridView>
                </div>

                <div class="button-group">
                    <a href="Dashboard.aspx" class="btn-secondary">Volver al Dashboard</a>
                    <a href="NuevaCotizacion.aspx" class="btn-primary">Ir a Nueva Cotización</a>
                </div>
                <div class="button-group">
                    <asp:Button ID="btnPDFHistorial"
                        runat="server"
                        Text="Descargar PDF"
                        CssClass="btn-primary"
                        OnClick="btnPDFHistorial_Click" />

                    <asp:Button ID="btnExcelHistorial"
                        runat="server"
                        Text="Descargar Excel"
                        CssClass="btn-secondary"
                        OnClick="btnExcelHistorial_Click" />
                </div>
            </div>

        </div>
    </form>
</body>
</html>