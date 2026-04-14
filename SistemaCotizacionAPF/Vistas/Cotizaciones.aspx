<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cotizaciones.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Cotizaciones" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Cotizaciones</title>
    <link href="Estilos/Styles.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="contenedor">
            <h2>Cotizaciones</h2>
            <asp:TextBox ID="txtNumero" runat="server" placeholder="Número de cotización"></asp:TextBox>
            <asp:TextBox ID="txtIdCliente" runat="server" placeholder="Id Cliente"></asp:TextBox>
            <asp:TextBox ID="txtIdProducto" runat="server" placeholder="Id Producto"></asp:TextBox>
            <asp:TextBox ID="txtIdPlazo" runat="server" placeholder="Id Plazo"></asp:TextBox>
            <asp:TextBox ID="txtIdTasa" runat="server" placeholder="Id Tasa"></asp:TextBox>
            <asp:TextBox ID="txtMonto" runat="server" placeholder="Monto"></asp:TextBox>
            <asp:Button ID="btnCalcular" runat="server" Text="Calcular y Guardar" OnClick="btnCalcular_Click" />
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
