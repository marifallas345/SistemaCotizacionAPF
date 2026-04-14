using SistemaCotizacionAPF.Modelos;
using SistemaCotizacionAPF.Controladores;
using System;
using System.Web.UI;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Productos : Page
    {
        private readonly ProductoController controller = new ProductoController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
            }
        }

        private void CargarProductos()
        {
            gvProductos.DataSource = controller.Listar();
            gvProductos.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtCodigo.Text) ||
                    string.IsNullOrWhiteSpace(txtNombre.Text))
                {
                    lblMensaje.Text = "El código y el nombre del producto son obligatorios.";
                    return;
                }

                Producto p = new Producto
                {
                    IdMoneda = Convert.ToInt32(ddlMoneda.SelectedValue),
                    CodigoProducto = txtCodigo.Text.Trim(),
                    NombreProducto = txtNombre.Text.Trim(),
                    Descripcion = txtDescripcion.Text.Trim(),
                    Estado = true
                };

                string mensaje;
                bool ok = controller.Insertar(p, out mensaje);
                lblMensaje.Text = mensaje;

                if (ok)
                {
                    LimpiarFormulario();
                    CargarProductos();
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al guardar el producto: " + ex.Message;
            }
        }

        private void LimpiarFormulario()
        {
            ddlMoneda.SelectedIndex = 0;
            txtCodigo.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtDescripcion.Text = string.Empty;
        }
    }
}