<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Clientes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Clientes</title>
    <link href="Estilos/Styles.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="contenedor">
            <h2>Clientes</h2>
            <asp:TextBox ID="txtIdentificacion" runat="server" placeholder="Identificación"></asp:TextBox>
            <asp:TextBox ID="txtNombreCliente" runat="server" placeholder="Nombre"></asp:TextBox>
            <asp:TextBox ID="txtTelefono" runat="server" placeholder="Teléfono"></asp:TextBox>
            <asp:TextBox ID="txtCorreo" runat="server" placeholder="Correo"></asp:TextBox>
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" />
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="true"></asp:GridView>
        </div>
    </form>
</body>
</html>
