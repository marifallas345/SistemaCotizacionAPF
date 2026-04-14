using SistemaCotizacionAPF.Controladores;
using SistemaCotizacionAPF.Utilidad;
using System;
using System.Data;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly UsuarioController controller = new UsuarioController();

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            try
            {
                string usuario = txtUsuario.Text.Trim();
                string contrasena = Seguridad.EncriptarSHA256(txtContrasena.Text.Trim());

                if (string.IsNullOrWhiteSpace(usuario) || string.IsNullOrWhiteSpace(txtContrasena.Text))
                {
                    lblMensaje.Text = "Debe ingresar el usuario y la contraseña.";
                    return;
                }

                DataTable dt = controller.Login(usuario, contrasena);

                if (dt.Rows.Count > 0)
                {
                    Session["IdUsuario"] = dt.Rows[0]["id_usuario"].ToString();
                    Session["NombreUsuario"] = dt.Rows[0]["nombre_completo"].ToString();
                    Session["Rol"] = dt.Rows[0]["nombre_rol"].ToString();

                    Response.Redirect("~/Vistas/Clientes.aspx");
                }
                else
                {
                    lblMensaje.Text = "Credenciales inválidas.";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al iniciar sesión: " + ex.Message;
            }
        }
    }
}