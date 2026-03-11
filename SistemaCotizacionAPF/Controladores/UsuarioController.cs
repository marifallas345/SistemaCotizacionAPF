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
                                NombreRol = dr["NombreRol"].ToString()
                            };

                            return usuario;
                        }
                    }
                }
            }

            return null;
        }
    }
}