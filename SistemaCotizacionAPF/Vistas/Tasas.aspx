<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tasas.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Tasas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Tasas</title>
    <link href="Estilos/Styles.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="contenedor">
            <h2>Tasas</h2>
            <asp:TextBox ID="txtIdProducto" runat="server" placeholder="Id Producto"></asp:TextBox>
            <asp:TextBox ID="txtIdPlazo" runat="server" placeholder="Id Plazo"></asp:TextBox>
            <asp:TextBox ID="txtTasa" runat="server" placeholder="Tasa anual"></asp:TextBox>
            <asp:TextBox ID="txtImpuesto" runat="server" placeholder="Impuesto"></asp:TextBox>
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" />
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            <asp:GridView ID="gvTasas" runat="server"></asp:GridView>
        </div>
    </form>
</body>
</html>
