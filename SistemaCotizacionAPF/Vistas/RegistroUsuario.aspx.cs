using SistemaCotizacionAPF.Modelos;
using SistemaCotizacionAPF.Controladores;
using SistemaCotizacionAPF.Utilidad;
using System;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class RegistroUsuario : System.Web.UI.Page
    {
        private readonly UsuarioController controller = new UsuarioController();

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtNombreCompleto.Text) ||
                    string.IsNullOrWhiteSpace(txtNombreUsuario.Text) ||
                    string.IsNullOrWhiteSpace(txtCorreo.Text) ||
                    string.IsNullOrWhiteSpace(txtContrasena.Text))
                {
                    lblMensaje.Text = "Debe completar todos los campos obligatorios.";
                    return;
                }

                Usuario u = new Usuario
                {
                    IdRol = 2,
                    NombreCompleto = txtNombreCompleto.Text.Trim(),
                    NombreUsuario = txtNombreUsuario.Text.Trim(),
                    Correo = txtCorreo.Text.Trim(),
                    Telefono = txtTelefono.Text.Trim(),
                    Contrasena = Seguridad.EncriptarSHA256(txtContrasena.Text.Trim()),
                    Estado = true
                };

                string mensaje;
                bool ok = controller.RegistrarUsuario(u, out mensaje);
                lblMensaje.Text = mensaje;

                if (ok)
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al registrar usuario: " + ex.Message;
            }
        }
    }
}