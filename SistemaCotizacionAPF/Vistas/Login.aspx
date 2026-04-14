<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Login</title>
    <link href="Estilos/Styles.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">
    <div class="contenedor">
        <asp:Label ID="lblTitulo" runat="server" Text="Inicio de Sesión" CssClass="titulo"></asp:Label><br />
        <asp:Label ID="lblUsuario" runat="server" Text="Usuario o correo"></asp:Label>
        <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox><br />

        <asp:Label ID="lblContrasena" runat="server" Text="Contraseña"></asp:Label>
        <asp:TextBox ID="txtContrasena" runat="server" TextMode="Password"></asp:TextBox><br />

        <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" OnClick="btnIngresar_Click" />
        <asp:Button ID="btnRegistro" runat="server" Text="Registrarse" PostBackUrl="~/RegistroUsuario.aspx" />
        <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>
    </div>
</form>
</body>
</html>