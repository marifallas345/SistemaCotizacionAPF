using System;
using SistemaCotizacionAPF.Controladores;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class NuevaCotizacion : System.Web.UI.Page
    {
        private readonly ProductoController _productoController = new ProductoController();
        private readonly CotizacionController _cotizacionController = new CotizacionController();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Verifica que exista una sesión activa
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

        /// <summary>
        /// Carga el catálogo de productos APF en el DropDownList.
        /// </summary>
        private void CargarProductos()
        {
            ddlProducto.DataSource = _productoController.ListarProductos();
            ddlProducto.DataTextField = "NombreProducto";
            ddlProducto.DataValueField = "IdProducto";
            ddlProducto.DataBind();

            ddlProducto.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Seleccione un producto", "0"));
        }

        /// <summary>
        /// Evento que calcula la cotización, guarda cliente, encabezado
        /// y detalle mensual en la base de datos.
        /// </summary>
        protected void btnCalcularGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                // Validación de selección de producto
                if (ddlProducto.SelectedValue == "0")
                    throw new Exception("Debe seleccionar un producto.");

                // Validación de tipo de cliente
                if (string.IsNullOrWhiteSpace(ddlTipoCliente.SelectedValue))
                    throw new Exception("Debe seleccionar el tipo de cliente.");

                // Conversión de datos numéricos
                decimal monto;
                int plazo;
                int idProducto;
                int idUsuario;

                if (!decimal.TryParse(txtMonto.Text.Trim(), out monto))
                    throw new Exception("El monto ingresado no es válido.");

                if (!int.TryParse(txtPlazo.Text.Trim(), out plazo))
                    throw new Exception("El plazo ingresado no es válido.");

                if (!int.TryParse(ddlProducto.SelectedValue, out idProducto))
                    throw new Exception("El producto seleccionado no es válido.");

                if (!int.TryParse(Session["IdUsuario"].ToString(), out idUsuario))
                    throw new Exception("No se pudo identificar al usuario en sesión.");

                if (monto <= 0)
                    throw new Exception("El monto debe ser mayor que cero.");

                if (plazo <= 0)
                    throw new Exception("El plazo debe ser mayor que cero.");

                // Obtener tasa desde la base de datos
                decimal tasa = _productoController.ObtenerTasa(idProducto, plazo);

                if (tasa <= 0)
                    throw new Exception("No existe una tasa configurada para el producto y plazo seleccionados.");

                // Determinar símbolo de moneda según el nombre del producto
                string nombreProducto = ddlProducto.SelectedItem.Text;
                string simbolo = nombreProducto.Contains("Dólar") ? "$" : "₡";

                // Cálculo de intereses
                decimal interesMensual = (monto * (tasa / 100m) / 360m) * 30m;
                decimal interesBruto = interesMensual * plazo;
                decimal impuestoMonto = interesBruto * 0.13m;
                decimal interesNeto = interesBruto - impuestoMonto;

                // Insertar cliente
                int idCliente = _cotizacionController.InsertarCliente(
                    txtIdentificacion.Text.Trim(),
                    txtCliente.Text.Trim(),
                    txtTelefono.Text.Trim(),
                    txtCorreoCliente.Text.Trim(),
                    ddlTipoCliente.SelectedValue
                );

                // Generar número de cotización
                int numeroCotizacion = new Random().Next(1000, 9999);

                // Insertar encabezado de cotización
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

                // Insertar detalle mensual
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

                // Mostrar resultado bonito
                lblResultado.CssClass = "resultado-box";
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

                // Limpiar formulario si quieres dejarlo listo para una nueva cotización
                LimpiarFormulario();
            }
            catch (Exception ex)
            {
                lblResultado.CssClass = "mensaje-error";
                lblResultado.Text = ex.Message;
            }
        }

        /// <summary>
        /// Limpia los controles del formulario después de guardar.
        /// </summary>
        private void LimpiarFormulario()
        {
            txtIdentificacion.Text = string.Empty;
            txtCliente.Text = string.Empty;
            txtTelefono.Text = string.Empty;
            txtCorreoCliente.Text = string.Empty;
            txtMonto.Text = string.Empty;
            txtPlazo.Text = string.Empty;

            if (ddlTipoCliente.Items.Count > 0)
                ddlTipoCliente.SelectedIndex = 0;

            if (ddlProducto.Items.Count > 0)
                ddlProducto.SelectedIndex = 0;
        }
    }
}