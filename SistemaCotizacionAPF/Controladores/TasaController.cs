using SistemaCotizacionAPF.BD;
using SistemaCotizacionAPF.Modelos;
using System;
using System.Data;
using System.Data.SqlClient;

namespace SistemaCotizacionAPF.Controladores
{
    public class TasaController
    {
        private readonly Conexion conexion = new Conexion();

        public DataTable Listar()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = conexion.ObtenerConexion())
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM vw_tasas_vigentes", cn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }

            return dt;
        }

        public DataTable ObtenerPorProductoYPlazo(int idProducto, int idPlazo)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = conexion.ObtenerConexion())
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM tasas WHERE id_producto = @id_producto AND id_plazo = @id_plazo AND estado = 1", cn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@id_producto", idProducto);
                cmd.Parameters.AddWithValue("@id_plazo", idPlazo);
                da.Fill(dt);
            }

            return dt;
        }

        public bool Insertar(Tasa t, out string mensaje)
        {
            mensaje = string.Empty;

            try
            {
                using (SqlConnection cn = conexion.ObtenerConexion())
                using (SqlCommand cmd = new SqlCommand("sp_insertar_tasa", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_producto", t.IdProducto);
                    cmd.Parameters.AddWithValue("@id_plazo", t.IdPlazo);
                    cmd.Parameters.AddWithValue("@tasa_anual", t.TasaAnual);
                    cmd.Parameters.AddWithValue("@impuesto", t.Impuesto);
                    cmd.Parameters.AddWithValue("@fecha_vigencia", t.FechaVigencia);
                    cmd.Parameters.AddWithValue("@usuario_creacion", "admin");

                    cn.Open();
                    cmd.ExecuteNonQuery();

                    mensaje = "Tasa insertada correctamente.";
                    return true;
                }
            }
            catch (Exception ex)
            {
                mensaje = "Error al insertar tasa: " + ex.Message;
                return false;
            }
        }
    }
}