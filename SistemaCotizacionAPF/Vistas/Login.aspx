<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Login - Sistema APF</title>
    <link href="../Estilos/Styles.css" rel="stylesheet"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            Sistema de Cotización APF
        </div>

        <div class="container">
            <div class="card form-center">
                <h2>Iniciar Sesión</h2>

                <label for="txtCorreo">Correo</label>
                <asp:TextBox ID="txtCorreo" runat="server"></asp:TextBox>

                <label for="txtPassword">Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>

                <asp:Button ID="btnLogin"
                    runat="server"
                    Text="Ingresar"
                    CssClass="btn-primary"
                    OnClick="btnLogin_Click" />

                <br /><br />

                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>