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

        <div class="login-wrapper">
            <div class="card form-center">
                <h2>Iniciar Sesión</h2>
                <p class="login-subtitle">Ingrese sus credenciales para acceder al sistema.</p>

                <div class="form-group">
                    <label for="txtCorreo">Correo</label>
                    <asp:TextBox ID="txtCorreo" runat="server" TextMode="Email"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtPassword">Contraseña</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                </div>

                <asp:Button ID="btnLogin"
                    runat="server"
                    Text="Ingresar"
                    CssClass="btn-primary btn-block"
                    OnClick="btnLogin_Click" />

                <asp:Label ID="lblMensaje" runat="server"></asp:Label>
         
             <div class="login-extra">
            <asp:LinkButton ID="btnRegistro"
                runat="server"
                OnClick="btnRegistro_Click"
                CssClass="link-registro">
                ¿No tienes cuenta? Registrarse
            </asp:LinkButton>
        </div>
        </div>

    </form>
</body>
</html>