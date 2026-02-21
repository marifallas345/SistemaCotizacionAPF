<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NuevaCotizacion.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.NuevaCotizacion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Nueva Cotización</title>
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
            <a href="Login.aspx">Cerrar Sesión</a>
        </div>

        <div class="card">
            <h2>Nueva Cotización</h2>

            <label>Producto</label>
            <asp:DropDownList ID="ddlProducto" runat="server">
                <asp:ListItem Text="Colón Crece (CC)" />
                <asp:ListItem Text="Colón Futuro Plus (CF)"/>
                <asp:ListItem Text="Dólar Segurp (DS)"/>
                <asp:ListItem Text="Dólar Visión (DV)"/>
            </asp:DropDownList>

            <label>Monto</label>
            <asp:TextBox ID="txtMonto" runat="server"></asp:TextBox>

            <label>Plazo (meses)</label>
            <asp:TextBox ID="txtPlazo" runat="server"></asp:TextBox>

            <asp:Button ID="btnCalcular"
                runat="server"
                Text="Calcular"
                CssClass="btn-primary"
                OnClick="btnCalcular_Click" />

            <br />
            <br />

            <asp:Label ID="lblResultado"
                runat="server"
                ForeColor="Green">
                </asp:Label>

        </div>
    </form>
</body>
</html>
