using SistemaCotizacionAPF.Controladores;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class NuevaCotizacion : System.Web.UI.Page
    {
        private readonly ProductoController _productoController = new ProductoController();
        private readonly CotizacionController _cotizacionController = new CotizacionController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IdUsuario"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarProductos();
            }
        }

        private void CargarProductos()
        {
            ddlProducto.DataSource = _productoController.ListarProductos();
            ddlProducto.DataTextField = "NombreProducto";
            ddlProducto.DataValueField = "IdProducto";
            ddlProducto.DataBind();

            ddlProducto.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Seleccione un producto", "0"));
        }

        protected void btnCalcularGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                // VALIDACIONES
                if (ddlProducto.SelectedValue == "0")
                    throw new Exception("Debe seleccionar un producto.");

                decimal monto;
                int plazo;
                int idProducto;
                int idUsuario;
                int idCliente;

                if (!decimal.TryParse(txtMonto.Text.Trim(), out monto))
                    throw new Exception("El monto ingresado no es válido.");

                if (!int.TryParse(txtPlazo.Text.Trim(), out plazo))
                    throw new Exception("El plazo ingresado no es válido.");

                if (!int.TryParse(ddlProducto.SelectedValue, out idProducto))
                    throw new Exception("El producto seleccionado no es válido.");

                if (!int.TryParse(Session["IdUsuario"]?.ToString(), out idUsuario))
                    throw new Exception("No se pudo identificar el usuario en sesión.");

                if (!int.TryParse(Session["IdCliente"]?.ToString(), out idCliente) || idCliente == 0)
                    throw new Exception("El usuario no tiene un cliente asociado.");

                if (monto <= 0)
                    throw new Exception("El monto debe ser mayor que cero.");

                if (plazo <= 0)
                    throw new Exception("El plazo debe ser mayor que cero.");

                // OBTENER TASA
                decimal tasa = _productoController.ObtenerTasa(idProducto, plazo);

                if (tasa <= 0)
                    throw new Exception("No existe una tasa configurada para el producto y plazo seleccionados.");

                // CÁLCULOS
                string nombreProducto = ddlProducto.SelectedItem.Text;
                string simbolo = nombreProducto.Contains("Dólar") ? "$" : "₡";

                decimal interesMensual = (monto * (tasa / 100m) / 360m) * 30m;
                decimal interesBruto = interesMensual * plazo;
                decimal impuestoMonto = interesBruto * 0.13m;
                decimal interesNeto = interesBruto - impuestoMonto;

                // GENERAR NÚMERO DE COTIZACIÓN
                int numeroCotizacion = new Random().Next(1000, 9999);

                // INSERTAR COTIZACIÓN
                int idCotizacion = _cotizacionController.InsertarCotizacion(
                    numeroCotizacion,
                    idCliente,
                    idProducto,
                    idUsuario,
                    monto,
                    plazo,
                    tasa,
                    13.00m,
                    interesBruto,
                    impuestoMonto,
                    interesNeto
                );

                // INSERTAR DETALLE MENSUAL
                for (int mes = 1; mes <= plazo; mes++)
                {
                    decimal impuestoMensual = interesMensual * 0.13m;
                    decimal netoMensual = interesMensual - impuestoMensual;

                    _cotizacionController.InsertarDetalleCotizacion(
                        idCotizacion,
                        mes,
                        monto,
                        interesMensual,
                        impuestoMensual,
                        netoMensual
                    );
                }

                // RESULTADO
                lblResultado.CssClass = "mensaje-exito";
                lblResultado.Text =
                    "<strong>Cotización guardada correctamente</strong><br/><br/>" +
                    "<strong>Número de cotización:</strong> " + numeroCotizacion + "<br/>" +
                    "<strong>Producto:</strong> " + nombreProducto + "<br/>" +
                    "<strong>Tasa anual:</strong> " + tasa.ToString("N2") + "%<br/>" +
                    "<strong>Monto invertido:</strong> " + simbolo + " " + monto.ToString("N2") + "<br/>" +
                    "<strong>Plazo:</strong> " + plazo + " meses<br/>" +
                    "<strong>Interés bruto:</strong> " + simbolo + " " + interesBruto.ToString("N2") + "<br/>" +
                    "<strong>Impuesto:</strong> " + simbolo + " " + impuestoMonto.ToString("N2") + "<br/>" +
                    "<strong>Interés neto:</strong> " + simbolo + " " + interesNeto.ToString("N2");
                Session["IdCotizacionGenerada"] = idCotizacion;
                LimpiarFormulario();
            }
            catch (Exception ex)
            {
                lblResultado.CssClass = "mensaje-error";
                lblResultado.Text = ex.Message;
            }
        }

        private void LimpiarFormulario()
        {
            txtMonto.Text = "";
            txtPlazo.Text = "";

            if (ddlProducto.Items.Count > 0)
                ddlProducto.SelectedIndex = 0;
        }
        protected void btnPDF_Click(object sender, EventArgs e)
        {
            if (Session["IdCotizacionGenerada"] == null)
                return;

            int idCotizacion = Convert.ToInt32(Session["IdCotizacionGenerada"]);

            DataTable dt = _cotizacionController.ObtenerCotizacionPorId(idCotizacion);

            if (dt.Rows.Count == 0)
                return;

            var row = dt.Rows[0];

            string filePath = Server.MapPath("~/Reportes/Cotizacion.pdf");

            using (var writer = new iText.Kernel.Pdf.PdfWriter(filePath))
            {
                using (var pdf = new iText.Kernel.Pdf.PdfDocument(writer))
                {
                    var document = new iText.Layout.Document(pdf);

                    document.Add(new iText.Layout.Element.Paragraph("REPORTE DE COTIZACIÓN APF"));
                    document.Add(new iText.Layout.Element.Paragraph("----------------------------------"));

                    document.Add(new iText.Layout.Element.Paragraph("Número: " + row["NumeroCotizacion"]));
                    document.Add(new iText.Layout.Element.Paragraph("Cliente: " + row["Cliente"]));
                    document.Add(new iText.Layout.Element.Paragraph("Identificación: " + row["Identificacion"]));
                    document.Add(new iText.Layout.Element.Paragraph("Correo: " + row["Correo"]));
                    document.Add(new iText.Layout.Element.Paragraph("Producto: " + row["NombreProducto"]));
                    document.Add(new iText.Layout.Element.Paragraph("Moneda: " + row["Moneda"]));
                    document.Add(new iText.Layout.Element.Paragraph("Monto: " + row["Monto"]));
                    document.Add(new iText.Layout.Element.Paragraph("Plazo: " + row["PlazoMeses"] + " meses"));
                    document.Add(new iText.Layout.Element.Paragraph("Tasa: " + row["TasaAnual"] + "%"));
                    document.Add(new iText.Layout.Element.Paragraph("Interés Bruto: " + row["InteresBruto"]));
                    document.Add(new iText.Layout.Element.Paragraph("Impuesto: " + row["ImpuestoMonto"]));
                    document.Add(new iText.Layout.Element.Paragraph("Interés Neto: " + row["InteresNeto"]));
                    document.Add(new iText.Layout.Element.Paragraph("Fecha: " + row["FechaCotizacion"]));

                    document.Close();
                }
            }

            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=Cotizacion.pdf");
            Response.TransmitFile(filePath);
            Response.End();
        }
        protected void btnExcel_Click(object sender, EventArgs e)
        {
            if (Session["IdCotizacionGenerada"] == null)
                return;

            int idCotizacion = Convert.ToInt32(Session["IdCotizacionGenerada"]);

            DataTable dt = _cotizacionController.ObtenerCotizacionPorId(idCotizacion);

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Cotizacion.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            System.IO.StringWriter sw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);

            GridView gv = new GridView();
            gv.DataSource = dt;
            gv.DataBind();

            gv.RenderControl(hw);

            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            // requerido para exportar a Excel
        }

    }
}