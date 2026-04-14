using SistemaCotizacionAPF.Modelos;
using SistemaCotizacionAPF.Controladores;
using System;
using System.Web.UI;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Cotizaciones : Page
    {
        private readonly CotizacionController controller = new CotizacionController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["IdUsuario"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            try
            {
                int idCliente;
                int idProducto;
                int idPlazo;
                int idTasa;
                decimal monto;

                if (Session["IdUsuario"] == null)
                {
                    lblMensaje.Text = "La sesión ha expirado. Inicie sesión nuevamente.";
                    return;
                }

                if (!int.TryParse(txtIdCliente.Text.Trim(), out idCliente) ||
                    !int.TryParse(txtIdProducto.Text.Trim(), out idProducto) ||
                    !int.TryParse(txtIdPlazo.Text.Trim(), out idPlazo) ||
                    !int.TryParse(txtIdTasa.Text.Trim(), out idTasa) ||
                    !decimal.TryParse(txtMonto.Text.Trim(), out monto))
                {
                    lblMensaje.Text = "Debe ingresar valores numéricos válidos.";
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtNumero.Text))
                {
                    lblMensaje.Text = "Debe ingresar el número de cotización.";
                    return;
                }

                Cotizacion c = new Cotizacion
                {
                    NumeroCotizacion = txtNumero.Text.Trim(),
                    IdCliente = idCliente,
                    IdUsuario = Convert.ToInt32(Session["IdUsuario"]),
                    IdProducto = idProducto,
                    IdPlazo = idPlazo,
                    IdTasa = idTasa,
                    Monto = monto
                };

                string mensaje;
                bool ok = controller.CrearCotizacion(c, out mensaje);
                lblMensaje.Text = mensaje;

                if (ok)
                {
                    LimpiarFormulario();
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al procesar la cotización: " + ex.Message;
            }
        }

        private void LimpiarFormulario()
        {
            txtNumero.Text = string.Empty;
            txtIdCliente.Text = string.Empty;
            txtIdProducto.Text = string.Empty;
            txtIdPlazo.Text = string.Empty;
            txtIdTasa.Text = string.Empty;
            txtMonto.Text = string.Empty;
        }
    }
}