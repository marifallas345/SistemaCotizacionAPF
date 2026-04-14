using System;
using SistemaCotizacionAPF.Controladores;
using SistemaCotizacionAPF.Modelos;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMensaje.Text = string.Empty;
            lblMensaje.CssClass = string.Empty;

            try
            {
                UsuarioController controlador = new UsuarioController();
                Usuario usuario = controlador.Login(txtCorreo.Text.Trim(), txtPassword.Text.Trim());

                if (usuario != null)
                {
                    Session["IdUsuario"] = usuario.IdUsuario;
                    Session["NombreUsuario"] = usuario.NombreCompleto;
                    Session["Rol"] = usuario.NombreRol;
                    Session["IdCliente"] = usuario.IdCliente;

                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    lblMensaje.CssClass = "mensaje-error";
                    lblMensaje.Text = "Credenciales incorrectas.";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.CssClass = "mensaje-error";
                lblMensaje.Text = ex.Message.Replace("\n", "<br/>").Replace("\r", "");
            }
        }

        protected void btnRegistro_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registro.aspx");
        }
    
    
    }
}