using SistemaCotizacionAPF.Controladores;
using System;
using System.Web.UI;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class HistorialCotizaciones : Page
    {
        private readonly CotizacionController controller = new CotizacionController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["IdUsuario"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                int idUsuario = Convert.ToInt32(Session["IdUsuario"]);
                gvHistorial.DataSource = controller.HistorialPorUsuario(idUsuario);
                gvHistorial.DataBind();
            }
        }
    }
}