<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NuevaCotizacion.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.NuevaCotizacion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Nueva Cotización - Sistema APF</title>
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
                <h2>Registro de Nueva Cotización</h2>

                <div class="two-columns">

                    <div class="left-column">
                        <div class="form-group">
                            <label for="txtIdentificacion">Identificación</label>
                            <asp:TextBox ID="txtIdentificacion" runat="server"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtCliente">Nombre del Cliente</label>
                            <asp:TextBox ID="txtCliente" runat="server"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtTelefono">Teléfono</label>
                            <asp:TextBox ID="txtTelefono" runat="server"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtCorreoCliente">Correo</label>
                            <asp:TextBox ID="txtCorreoCliente" runat="server" TextMode="Email"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="ddlTipoCliente">Tipo de Cliente</label>
                            <asp:DropDownList ID="ddlTipoCliente" runat="server">
                                <asp:ListItem Text="Seleccione una opción" Value=""></asp:ListItem>
                                <asp:ListItem Text="FISICO" Value="FISICO"></asp:ListItem>
                                <asp:ListItem Text="JURIDICO" Value="JURIDICO"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="ddlProducto">Producto</label>
                            <asp:DropDownList ID="ddlProducto" runat="server"></asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="txtMonto">Monto</label>
                            <asp:TextBox ID="txtMonto" runat="server"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtPlazo">Plazo (meses)</label>
                            <asp:TextBox ID="txtPlazo" runat="server"></asp:TextBox>
                        </div>

                        <asp:Button
                            ID="btnCalcularGuardar"
                            runat="server"
                            Text="Calcular y Guardar"
                            CssClass="btn-primary btn-block"
                            OnClick="btnCalcularGuardar_Click" />

                        <div class="button-group">
                            <a href="Dashboard.aspx" class="btn-secondary">Volver al Dashboard</a>
                            <a href="HistorialCotizaciones.aspx" class="btn-primary">Ver Historial</a>
                        </div>
                    </div>

                    <div class="right-column">
                        <div class="resultado-box">
                            <h3 class="text-center">Resultado de la Cotización</h3>
                            <asp:Label ID="lblResultado" runat="server" Text="Aquí se mostrará el resultado una vez realizada la cotización."></asp:Label>
                        </div>
                    </div>

                </div>
            </div>

        </div>

    </form>
</body>
</html>