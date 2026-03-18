using System;
using System.Data;
using SistemaCotizacionAPF.Controladores;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly CotizacionController _cotizacionController = new CotizacionController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IdUsuario"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string nombreUsuario = Session["NombreUsuario"] != null ? Session["NombreUsuario"].ToString() : "Usuario";
                string rol = Session["Rol"] != null ? Session["Rol"].ToString() : "Sin rol";

                lblBienvenida.Text = "Bienvenido al sistema, <b>" + nombreUsuario + "</b>";
                lblUsuarioActivo.Text = nombreUsuario;
                lblRol.Text = rol;

                CargarCotizaciones();
            }
        }

        private void CargarCotizaciones()
        {
            DataTable dt = _cotizacionController.ListarCotizaciones();
            gvCotizaciones.DataSource = dt;
            gvCotizaciones.DataBind();

            lblTotalCotizaciones.Text = dt.Rows.Count.ToString();
        }
    }
}