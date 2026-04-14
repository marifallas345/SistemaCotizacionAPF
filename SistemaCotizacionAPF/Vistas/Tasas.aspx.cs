using SistemaCotizacionAPF.Controladores;
using SistemaCotizacionAPF.Modelos;
using System;
using System.Web.UI;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Tasas : Page
    {
        private readonly TasaController controller = new TasaController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTasas();
            }
        }

        private void CargarTasas()
        {
            gvTasas.DataSource = controller.Listar();
            gvTasas.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                int idProducto;
                int idPlazo;
                decimal tasaAnual;
                decimal impuesto;

                if (!int.TryParse(txtIdProducto.Text.Trim(), out idProducto) ||
                    !int.TryParse(txtIdPlazo.Text.Trim(), out idPlazo) ||
                    !decimal.TryParse(txtTasa.Text.Trim(), out tasaAnual) ||
                    !decimal.TryParse(txtImpuesto.Text.Trim(), out impuesto))
                {
                    lblMensaje.Text = "Debe ingresar valores numéricos válidos.";
                    return;
                }

                Tasa t = new Tasa
                {
                    IdProducto = idProducto,
                    IdPlazo = idPlazo,
                    TasaAnual = tasaAnual,
                    Impuesto = impuesto,
                    FechaVigencia = DateTime.Now,
                    Estado = true
                };

                string mensaje;
                bool ok = controller.Insertar(t, out mensaje);
                lblMensaje.Text = mensaje;

                if (ok)
                {
                    LimpiarFormulario();
                    CargarTasas();
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al guardar la tasa: " + ex.Message;
            }
        }

        private void LimpiarFormulario()
        {
            txtIdProducto.Text = string.Empty;
            txtIdPlazo.Text = string.Empty;
            txtTasa.Text = string.Empty;
            txtImpuesto.Text = string.Empty;
        }
    }
}