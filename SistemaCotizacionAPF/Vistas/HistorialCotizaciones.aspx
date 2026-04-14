<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistorialCotizaciones.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.HistorialCotizaciones" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Historial</title>
    <link href="Estilos/Styles.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="contenedor">
            <h2>Historial de Cotizaciones</h2>
            <asp:GridView ID="gvHistorial" runat="server" AutoGenerateColumns="true"></asp:GridView>
        </div>
    </form>
</body>
</html>
