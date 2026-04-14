using SistemaCotizacionAPF.Controladores;
using SistemaCotizacionAPF.Modelos;
using System;
using System.Web.UI;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Plazos : Page
    {
        private readonly PlazoController controller = new PlazoController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPlazos();
            }
        }

        private void CargarPlazos()
        {
            gvPlazos.DataSource = controller.Listar();
            gvPlazos.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                int meses;
                int dias;

                if (!int.TryParse(txtMeses.Text.Trim(), out meses) ||
                    !int.TryParse(txtDias.Text.Trim(), out dias))
                {
                    lblMensaje.Text = "Debe ingresar valores numéricos válidos para meses y días.";
                    return;
                }

                Plazo p = new Plazo
                {
                    PlazoMeses = meses,
                    PlazoDias = dias,
                    Descripcion = txtDescripcion.Text.Trim(),
                    Estado = true
                };

                string mensaje;
                bool ok = controller.Insertar(p, out mensaje);
                lblMensaje.Text = mensaje;

                if (ok)
                {
                    LimpiarFormulario();
                    CargarPlazos();
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al guardar el plazo: " + ex.Message;
            }
        }

        private void LimpiarFormulario()
        {
            txtMeses.Text = string.Empty;
            txtDias.Text = string.Empty;
            txtDescripcion.Text = string.Empty;
        }
    }
}