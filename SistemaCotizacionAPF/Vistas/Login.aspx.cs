using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtCorreo.Text == "admin@apf.com" && txtPassword.Text == "1234")
            {
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                lblMensaje.Text = "Credenciales incorrectas";
            }
        }
    }
}