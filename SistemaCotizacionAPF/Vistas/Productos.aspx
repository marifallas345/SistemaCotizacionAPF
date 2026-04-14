<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Productos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Productos</title>
    <link href="Estilos/Styles.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">
<div class="contenedor">
    <h2>Productos</h2>
    <asp:DropDownList ID="ddlMoneda" runat="server">
        <asp:ListItem Value="1">CRC</asp:ListItem>
        <asp:ListItem Value="2">USD</asp:ListItem>
    </asp:DropDownList>
    <asp:TextBox ID="txtCodigo" runat="server" placeholder="Código"></asp:TextBox>
    <asp:TextBox ID="txtNombre" runat="server" placeholder="Nombre"></asp:TextBox>
    <asp:TextBox ID="txtDescripcion" runat="server" placeholder="Descripción"></asp:TextBox>
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" />
    <asp:Label ID="lblMensaje" runat="server"></asp:Label>
    <asp:GridView ID="gvProductos" runat="server"></asp:GridView>
</div>
</form>
</body>
</html>