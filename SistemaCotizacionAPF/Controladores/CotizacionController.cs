using SistemaCotizacionAPF.BD;
using SistemaCotizacionAPF.Modelos;
using System;
using System.Data;
using System.Data.SqlClient;

namespace SistemaCotizacionAPF.Controladores
{
    public class CotizacionController
    {
        private readonly Conexion conexion = new Conexion();

        public bool CrearCotizacion(Cotizacion c, out string mensaje)
        {
            mensaje = string.Empty;

            try
            {
                using (SqlConnection cn = conexion.ObtenerConexion())
                using (SqlCommand cmd = new SqlCommand("sp_crear_cotizacion", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@numero_cotizacion", c.NumeroCotizacion);
                    cmd.Parameters.AddWithValue("@id_cliente", c.IdCliente);
                    cmd.Parameters.AddWithValue("@id_usuario", c.IdUsuario);
                    cmd.Parameters.AddWithValue("@id_producto", c.IdProducto);
                    cmd.Parameters.AddWithValue("@id_plazo", c.IdPlazo);
                    cmd.Parameters.AddWithValue("@id_tasa", c.IdTasa);
                    cmd.Parameters.AddWithValue("@monto", c.Monto);
                    cmd.Parameters.AddWithValue("@usuario_creacion", "usuario");

                    cn.Open();
                    cmd.ExecuteNonQuery();

                    mensaje = "Cotización registrada correctamente.";
                    return true;
                }
            }
            catch (Exception ex)
            {
                mensaje = "Error al crear la cotización: " + ex.Message;
                return false;
            }
        }

        public DataTable HistorialPorUsuario(int idUsuario)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = conexion.ObtenerConexion())
            using (SqlCommand cmd = new SqlCommand("sp_consultar_historial", cn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_usuario", idUsuario);
                da.Fill(dt);
            }

            return dt;
        }
    }
}
