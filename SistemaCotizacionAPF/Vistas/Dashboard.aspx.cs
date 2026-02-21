using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("Cliente");
                dt.Columns.Add("Producto");
                dt.Columns.Add("Monto");
                dt.Columns.Add("Plazo");

                dt.Rows.Add("Maria Borbon", "Colón Crece", "₡50,000,000", "6 meses");
                dt.Rows.Add("Adrian Hernandez", "Dólar Seguro", "$15,000", "6 meses");

                gvCotizaciones.DataSource = dt;
                gvCotizaciones.DataBind();
            }
        }
    }
}
