using System;
using SistemaCotizacionAPF.Controladores;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class HistorialCotizaciones : System.Web.UI.Page
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
                gvHistorial.DataSource = _cotizacionController.ListarCotizaciones();
                gvHistorial.DataBind();
            }
        }
    }
}