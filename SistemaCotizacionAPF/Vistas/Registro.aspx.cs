using System;
using SistemaCotizacionAPF.Controladores;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Registro : System.Web.UI.Page
    {
        private readonly CotizacionController _cotizacionController = new CotizacionController();
        private readonly UsuarioController _usuarioController = new UsuarioController();

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                // VALIDACIONES
                if (string.IsNullOrWhiteSpace(txtIdentificacion.Text))
                    throw new Exception("Ingrese la identificación.");

                if (string.IsNullOrWhiteSpace(txtNombre.Text))
                    throw new Exception("Ingrese el nombre.");

                if (string.IsNullOrWhiteSpace(txtTelefono.Text))
                    throw new Exception("Ingrese el teléfono.");

                if (string.IsNullOrWhiteSpace(txtCorreo.Text))
                    throw new Exception("Ingrese el correo.");

                if (string.IsNullOrWhiteSpace(txtPassword.Text))
                    throw new Exception("Ingrese la contraseña.");

                if (string.IsNullOrWhiteSpace(ddlTipoCliente.SelectedValue))
                    throw new Exception("Seleccione el tipo de cliente.");

                // 1. Insertar cliente
                int idCliente = _cotizacionController.InsertarCliente(
                    txtIdentificacion.Text.Trim(),
                    txtNombre.Text.Trim(),
                    txtTelefono.Text.Trim(),
                    txtCorreo.Text.Trim(),
                    ddlTipoCliente.SelectedValue
                );

                // 2. Crear usuario (nuevo método)
                _usuarioController.RegistrarUsuario(
                    txtNombre.Text.Trim(),
                    txtCorreo.Text.Trim(),
                    txtPassword.Text.Trim(),
                    idCliente
                );

                lblMensaje.CssClass = "mensaje-exito";
                lblMensaje.Text = "Usuario registrado correctamente.";

                Limpiar();
            }
            catch (Exception ex)
            {
                lblMensaje.CssClass = "mensaje-error";
                lblMensaje.Text = ex.Message;
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        private void Limpiar()
        {
            txtIdentificacion.Text = "";
            txtNombre.Text = "";
            txtTelefono.Text = "";
            txtCorreo.Text = "";
            txtPassword.Text = "";
            ddlTipoCliente.SelectedIndex = 0;
        }
    }
}