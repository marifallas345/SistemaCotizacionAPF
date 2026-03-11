using System;
using SistemaCotizacionAPF.Controladores;
using SistemaCotizacionAPF.Modelos;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                UsuarioController controlador = new UsuarioController();
                Usuario usuario = controlador.Login(txtCorreo.Text.Trim(), txtPassword.Text.Trim());

                if (usuario != null)
                {
                    Session["IdUsuario"] = usuario.IdUsuario;
                    Session["NombreUsuario"] = usuario.NombreCompleto;
                    Session["Rol"] = usuario.NombreRol;

                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    lblMensaje.Text = "Credenciales incorrectas.";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = ex.ToString().Replace("\n", "<br/>").Replace("\r", "");
            }
        }
    }
}