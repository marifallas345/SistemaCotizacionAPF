using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaCotizacionAPF.Vistas
{
    public partial class NuevaCotizacion : System.Web.UI.Page
    {
        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            try
            {
                decimal monto = Convert.ToDecimal(txtMonto.Text);
                int plazo = Convert.ToInt32(txtPlazo.Text);

                decimal tasa = 0.041m; // 4.10%
                decimal interesBruto = (monto * tasa / 12) * plazo;
                decimal impuesto = interesBruto * 0.13m;
                decimal neto = interesBruto - impuesto;

                lblResultado.Text =
                    $"Interés Bruto: ₡{interesBruto:N2} | " +
                    $"Impuesto: ₡{impuesto:N2} | " +
                    $"Neto: ₡{neto:N2}";
            }
            catch
            {
                lblResultado.Text = "Error en los datos ingresados.";
            }
        }
    }
}