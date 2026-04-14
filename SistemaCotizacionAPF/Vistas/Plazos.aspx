<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Plazos.aspx.cs" Inherits="SistemaCotizacionAPF.Vistas.Plazos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Plazos</title>
    <link href="Estilos/Styles.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="contenedor">
            <h2>Plazos</h2>
            <asp:TextBox ID="txtMeses" runat="server" placeholder="Meses"></asp:TextBox>
            <asp:TextBox ID="txtDias" runat="server" placeholder="Días"></asp:TextBox>
            <asp:TextBox ID="txtDescripcion" runat="server" placeholder="Descripción"></asp:TextBox>
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" />
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            <asp:GridView ID="gvPlazos" runat="server"></asp:GridView>
        </div>
    </form>
</body>
</html>
