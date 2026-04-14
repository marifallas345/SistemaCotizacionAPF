using SistemaCotizacionAPF.BD;
using SistemaCotizacionAPF.Modelos;
using System;
using System.Data;
using System.Data.SqlClient;

namespace SistemaCotizacionAPF.Controladores
{
    public class ClienteController
    {
        private readonly Conexion conexion = new Conexion();

        public DataTable Listar()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = conexion.ObtenerConexion())
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM vw_clientes_activos", cn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }

            return dt;
        }

        public bool Insertar(Cliente c, out string mensaje)
        {
            mensaje = string.Empty;

            try
            {
                using (SqlConnection cn = conexion.ObtenerConexion())
                using (SqlCommand cmd = new SqlCommand("sp_insertar_cliente", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@identificacion", c.Identificacion);
                    cmd.Parameters.AddWithValue("@nombre_cliente", c.NombreCliente);
                    cmd.Parameters.AddWithValue("@telefono", string.IsNullOrWhiteSpace(c.Telefono) ? (object)DBNull.Value : c.Telefono);
                    cmd.Parameters.AddWithValue("@correo", string.IsNullOrWhiteSpace(c.Correo) ? (object)DBNull.Value : c.Correo);
                    cmd.Parameters.AddWithValue("@id_usuario", (object)c.IdUsuario ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@usuario_creacion", "admin");

                    cn.Open();
                    cmd.ExecuteNonQuery();

                    mensaje = "Cliente insertado correctamente.";
                    return true;
                }
            }
            catch (Exception ex)
            {
                mensaje = "Error al insertar cliente: " + ex.Message;
                return false;
            }
        }
    }
}