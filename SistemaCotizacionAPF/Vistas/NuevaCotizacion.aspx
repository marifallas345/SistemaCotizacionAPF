<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NuevaCotizacion.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.NuevaCotizacion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Nueva Cotización</title>
    <link href="../Estilos/Styles.css" rel="stylesheet" />
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

                <h2>Registro de Nueva Cotización</h2>

                <div class="form-group">
                    <label>Identificación</label>
                    <asp:TextBox ID="txtIdentificacion" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Nombre del Cliente</label>
                    <asp:TextBox ID="txtCliente" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Teléfono</label>
                    <asp:TextBox ID="txtTelefono" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Correo</label>
                    <asp:TextBox ID="txtCorreoCliente" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Tipo de Cliente</label>
                    <asp:DropDownList ID="ddlTipoCliente" runat="server">
                        <asp:ListItem Text="Seleccione una opción" Value=""></asp:ListItem>
                        <asp:ListItem Text="FISICO" Value="FISICO"></asp:ListItem>
                        <asp:ListItem Text="JURIDICO" Value="JURIDICO"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Producto</label>
                    <asp:DropDownList ID="ddlProducto" runat="server"></asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Monto</label>
                    <asp:TextBox ID="txtMonto" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Plazo (meses)</label>
                    <asp:TextBox ID="txtPlazo" runat="server"></asp:TextBox>
                </div>

                <asp:Button
                    ID="btnCalcularGuardar"
                    runat="server"
                    Text="Calcular y Guardar"
                    CssClass="btn-primary"
                    OnClick="btnCalcularGuardar_Click" />

                <asp:Label ID="lblResultado" runat="server"></asp:Label>

            </div>
        </div>

    </form>
</body>
</html>
