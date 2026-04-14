using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacionAPF.BD;
using SistemaCotizacionAPF.Modelos;

namespace SistemaCotizacionAPF.Controladores
{
    public class UsuarioController
    {
        private readonly ConexionBD _conexion = new ConexionBD();

        public Usuario Login(string correo, string contrasena)
        {
            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand("sp_LoginUsuario", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Correo", correo);
                    cmd.Parameters.AddWithValue("@Contrasena", contrasena);

                    cn.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            Usuario usuario = new Usuario
                            {
                                IdUsuario = Convert.ToInt32(dr["IdUsuario"]),
                                NombreCompleto = dr["NombreCompleto"].ToString(),
                                Correo = dr["Correo"].ToString(),
                                NombreRol = dr["NombreRol"].ToString(),
                                IdCliente = dr["IdCliente"] != DBNull.Value ? Convert.ToInt32(dr["IdCliente"]) : 0
                            };

                            return usuario;
                        }
                    }
                }
            }

            return null;
        }

       public int RegistrarUsuario(string identificacion, string nombre, string telefono,
       string correo, string tipoCliente, string contrasena)
        {
            CotizacionController cotController = new CotizacionController();

            // 1. Crear cliente
            int idCliente = cotController.InsertarCliente(
                identificacion, nombre, telefono, correo, tipoCliente);

            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                cn.Open();

                using (SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Usuarios (NombreCompleto, Correo, Contrasena, IdRol, IdCliente) " +
                    "VALUES (@Nombre, @Correo, @Contrasena, 2, @IdCliente); SELECT SCOPE_IDENTITY();", cn))
                {
                    cmd.Parameters.AddWithValue("@Nombre", nombre);
                    cmd.Parameters.AddWithValue("@Correo", correo);
                    cmd.Parameters.AddWithValue("@Contrasena", contrasena);
                    cmd.Parameters.AddWithValue("@IdCliente", idCliente);

                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }
        public void RegistrarUsuario(string nombre, string correo, string contrasena, int idCliente)
        {
            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                string query = @"INSERT INTO Usuarios 
                        (NombreCompleto, Correo, Contrasena, IdRol, IdCliente)
                        VALUES (@Nombre, @Correo, @Pass, 2, @IdCliente)";

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cmd.Parameters.AddWithValue("@Nombre", nombre);
                    cmd.Parameters.AddWithValue("@Correo", correo);
                    cmd.Parameters.AddWithValue("@Pass", contrasena);
                    cmd.Parameters.AddWithValue("@IdCliente", idCliente);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}