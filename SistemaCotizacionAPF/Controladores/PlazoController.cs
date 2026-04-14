using SistemaCotizacionAPF.BD;
using SistemaCotizacionAPF.Modelos;
using System;
using System.Data;
using System.Data.SqlClient;

namespace SistemaCotizacionAPF.Controladores
{
    public class PlazoController
    {
        private readonly Conexion conexion = new Conexion();

        public DataTable Listar()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = conexion.ObtenerConexion())
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM plazos WHERE estado = 1", cn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }

            return dt;
        }

        public bool Insertar(Plazo p, out string mensaje)
        {
            mensaje = string.Empty;

            try
            {
                using (SqlConnection cn = conexion.ObtenerConexion())
                using (SqlCommand cmd = new SqlCommand("sp_insertar_plazo", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@plazo_meses", p.PlazoMeses);
                    cmd.Parameters.AddWithValue("@plazo_dias", p.PlazoDias);
                    cmd.Parameters.AddWithValue("@descripcion", p.Descripcion);
                    cmd.Parameters.AddWithValue("@usuario_creacion", "admin");

                    cn.Open();
                    cmd.ExecuteNonQuery();

                    mensaje = "Plazo insertado correctamente.";
                    return true;
                }
            }
            catch (Exception ex)
            {
                mensaje = "Error al insertar plazo: " + ex.Message;
                return false;
            }
        }
    }
}