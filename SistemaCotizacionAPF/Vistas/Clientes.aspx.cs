using SistemaCotizacionAPF.Modelos;
using SistemaCotizacionAPF.Controladores;
using System;
using System.Web.UI;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Clientes : Page
    {
        private readonly ClienteController controller = new ClienteController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarClientes();
            }
        }

        private void CargarClientes()
        {
            gvClientes.DataSource = controller.Listar();
            gvClientes.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtIdentificacion.Text) ||
                    string.IsNullOrWhiteSpace(txtNombreCliente.Text))
                {
                    lblMensaje.Text = "La identificación y el nombre del cliente son obligatorios.";
                    return;
                }

                Cliente c = new Cliente
                {
                    Identificacion = txtIdentificacion.Text.Trim(),
                    NombreCliente = txtNombreCliente.Text.Trim(),
                    Telefono = txtTelefono.Text.Trim(),
                    Correo = txtCorreo.Text.Trim(),
                    IdUsuario = Session["IdUsuario"] != null ? Convert.ToInt32(Session["IdUsuario"]) : (int?)null
                };

                string mensaje;
                bool ok = controller.Insertar(c, out mensaje);
                lblMensaje.Text = mensaje;

                if (ok)
                {
                    LimpiarFormulario();
                    CargarClientes();
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al guardar el cliente: " + ex.Message;
            }
        }

        private void LimpiarFormulario()
        {
            txtIdentificacion.Text = string.Empty;
            txtNombreCliente.Text = string.Empty;
            txtTelefono.Text = string.Empty;
            txtCorreo.Text = string.Empty;
        }
    }
}