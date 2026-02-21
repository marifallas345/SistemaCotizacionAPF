<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Login-SistemaAPF</title>
    <link href="../Estilos/Styles.css" rel="stylesheet"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            Sistema de Cotización APF
        </div>

        <div class="container"> 
            <div class="card" style="max-width:400px;margin:auto;">
                <h2>Iniciar Sesión</h2>

                <asp:TextBox ID="txtCorreo" runat="server" placeholder="Correo"></asp:TextBox>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Contraseña"></asp:TextBox>

                <asp:Button ID="btnLogin" runat="server" Text="Ingresar" 
                    CssClass="btn-primary"
                    OnClick="btnLogin_Click"/>

                <br /><br />
                <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>

            </div>

        </div>
    </form>
</body>
</html>
