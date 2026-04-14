<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Registro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Registro - Sistema APF</title>
    <link href="../Estilos/Styles.css" rel="stylesheet" />
</head>
<body>

<form id="form1" runat="server">

    <div class="header">
        Sistema de Cotización APF
    </div>

    <div class="login-wrapper">
        <div class="card form-center">
            <h2>Crear Cuenta</h2>
            <p class="login-subtitle">Complete sus datos para registrarse.</p>

            <div class="form-group">
                <label>Identificación</label>
                <asp:TextBox ID="txtIdentificacion" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Nombre Completo</label>
                <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Teléfono</label>
                <asp:TextBox ID="txtTelefono" runat="server"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Correo</label>
                <asp:TextBox ID="txtCorreo" runat="server" TextMode="Email"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Tipo de Cliente</label>
                <asp:DropDownList ID="ddlTipoCliente" runat="server">
                    <asp:ListItem Text="Seleccione" Value=""></asp:ListItem>
                    <asp:ListItem Text="FISICO" Value="FISICO"></asp:ListItem>
                    <asp:ListItem Text="JURIDICO" Value="JURIDICO"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>

            <asp:Button ID="btnRegistrar"
                runat="server"
                Text="Registrarse"
                CssClass="btn-primary btn-block"
                OnClick="btnRegistrar_Click" />

            <div class="registro-link">
                <asp:LinkButton ID="btnVolver"
                    runat="server"
                    CssClass="link-registro"
                    OnClick="btnVolver_Click">
                    Volver al login
                </asp:LinkButton>
            </div>

            <asp:Label ID="lblMensaje" runat="server"></asp:Label>

        </div>
    </div>

</form>
</body>
</html>