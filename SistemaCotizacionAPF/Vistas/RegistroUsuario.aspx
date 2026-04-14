<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistroUsuario.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.RegistroUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Registro</title>
    <link href="Estilos/Styles.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">
<div class="contenedor">
    <asp:Label ID="lblTitulo" runat="server" Text="Registro de Usuario" CssClass="titulo"></asp:Label><br />

    <asp:TextBox ID="txtNombreCompleto" runat="server" placeholder="Nombre completo"></asp:TextBox><br />
    <asp:TextBox ID="txtNombreUsuario" runat="server" placeholder="Nombre de usuario"></asp:TextBox><br />
    <asp:TextBox ID="txtCorreo" runat="server" placeholder="Correo"></asp:TextBox><br />
    <asp:TextBox ID="txtTelefono" runat="server" placeholder="Teléfono"></asp:TextBox><br />
    <asp:TextBox ID="txtContrasena" runat="server" TextMode="Password" placeholder="Contraseña"></asp:TextBox><br />

    <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" OnClick="btnRegistrar_Click" />
    <asp:Label ID="lblMensaje" runat="server"></asp:Label>
</div>
</form>
</body>
</html>