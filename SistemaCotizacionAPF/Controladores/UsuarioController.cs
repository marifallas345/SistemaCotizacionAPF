using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacionAPF.BD;
using SistemaCotizacionAPF.Modelos;

namespace SistemaCotizacionAPF.Controladores
{
    public class UsuarioController
    {
        private readonly Conexion conexion = new Conexion();

        public bool RegistrarUsuario(Usuario u, out string mensaje)
        {
            mensaje = string.Empty;

            try
            {
                using (SqlConnection cn = conexion.ObtenerConexion())
                using (SqlCommand cmd = new SqlCommand("sp_registrar_usuario_nuevo", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_rol", u.IdRol);
                    cmd.Parameters.AddWithValue("@nombre_usuario", u.NombreUsuario);
                    cmd.Parameters.AddWithValue("@nombre_completo", u.NombreCompleto);
                    cmd.Parameters.AddWithValue("@correo", u.Correo);
                    cmd.Parameters.AddWithValue("@contrasena", u.Contrasena);
                    cmd.Parameters.AddWithValue("@telefono", string.IsNullOrWhiteSpace(u.Telefono) ? (object)DBNull.Value : u.Telefono);
                    cmd.Parameters.AddWithValue("@usuario_creacion", "sistema");

                    cn.Open();
                    int filas = cmd.ExecuteNonQuery();

                    mensaje = filas > 0
                        ? "Usuario registrado correctamente."
                        : "No se pudo registrar el usuario.";

                    return filas > 0;
                }
            }
            catch (Exception ex)
            {
                mensaje = "Error al registrar usuario: " + ex.Message;
                return false;
            }
        }

        public DataTable Login(string usuarioCorreo, string contrasena)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = conexion.ObtenerConexion())
            using (SqlCommand cmd = new SqlCommand("sp_login_usuario", cn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@usuario_o_correo", usuarioCorreo);
                cmd.Parameters.AddWithValue("@contrasena", contrasena);

                da.Fill(dt);
            }

            return dt;
        }
    }
}