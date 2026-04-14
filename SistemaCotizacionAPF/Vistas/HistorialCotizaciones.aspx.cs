using SistemaCotizacionAPF.Controladores;
using System;
using System.Data;

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
                int idUsuario = Convert.ToInt32(Session["IdUsuario"]);
                string rol = Session["Rol"].ToString();

                gvHistorial.DataSource = _cotizacionController.ListarCotizaciones(idUsuario, rol);
                gvHistorial.DataBind();
            }
        }
        protected void btnPDFHistorial_Click(object sender, EventArgs e)
        {
            int idUsuario = Convert.ToInt32(Session["IdUsuario"]);
            string rol = Session["Rol"].ToString();

            DataTable dt = _cotizacionController.ObtenerReporteCotizaciones(idUsuario, rol);

            string folderPath = Server.MapPath("~/Reportes/");
            if (!System.IO.Directory.Exists(folderPath))
                System.IO.Directory.CreateDirectory(folderPath);

            string filePath = System.IO.Path.Combine(folderPath, "HistorialCotizaciones.pdf");

            using (var writer = new iText.Kernel.Pdf.PdfWriter(filePath))
            {
                using (var pdf = new iText.Kernel.Pdf.PdfDocument(writer))
                {
                    var document = new iText.Layout.Document(pdf);

                    document.Add(new iText.Layout.Element.Paragraph("REPORTE HISTÓRICO DE COTIZACIONES"));
                    document.Add(new iText.Layout.Element.Paragraph(" "));

                    
                    foreach (DataRow row in dt.Rows)
                    {
                        document.Add(new iText.Layout.Element.Paragraph("===================================="));

                        
                        foreach (DataColumn col in dt.Columns)
                        {
                            string texto = col.ColumnName + ": " + row[col].ToString();

                            document.Add(new iText.Layout.Element.Paragraph(texto));
                        }

                        document.Add(new iText.Layout.Element.Paragraph(" ")); 
                    }

                    document.Close();
                }
            }

            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=HistorialCotizaciones.pdf");
            Response.TransmitFile(filePath);
            Response.End();
        }
        protected void btnExcelHistorial_Click(object sender, EventArgs e)
        {
            int idUsuario = Convert.ToInt32(Session["IdUsuario"]);
            string rol = Session["Rol"].ToString();

            DataTable dt = _cotizacionController.ObtenerReporteCotizaciones(idUsuario, rol);

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=HistorialCotizaciones.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            // TÍTULO
            sb.Append("<table border='1'>");
            sb.Append("<tr>");
            sb.Append("<td colspan='10' style='font-size:18px;font-weight:bold;text-align:center;'>");
            sb.Append("REPORTE HISTÓRICO DE COTIZACIONES");
            sb.Append("</td>");
            sb.Append("</tr>");

            // ENCABEZADOS
            sb.Append("<tr style='background-color:#1693A5;color:#FFFFFF;font-weight:bold;'>");

            foreach (DataColumn column in dt.Columns)
            {
                sb.Append("<td>" + column.ColumnName + "</td>");
            }

            sb.Append("</tr>");

            // DATOS
            foreach (DataRow row in dt.Rows)
            {
                sb.Append("<tr>");

                foreach (var item in row.ItemArray)
                {
                    sb.Append("<td>" + item.ToString() + "</td>");
                }

                sb.Append("</tr>");
            }

            sb.Append("</table>");

            Response.Write(sb.ToString());
            Response.Flush();
            Response.End();
        }
    }
}