using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SistemaCotizacionAPF.BD
{
    public class ConexionBD
    {
        private readonly string _connectionString;

        public ConexionBD()
        {
            ConnectionStringSettings cs = ConfigurationManager.ConnectionStrings["cnAPF"];

            if (cs == null)
            {
                throw new Exception("No se encontró la cadena de conexión 'cnAPF' en el Web.config.");
            }

            _connectionString = cs.ConnectionString;

            if (string.IsNullOrWhiteSpace(_connectionString))
            {
                throw new Exception("La cadena de conexión 'cnAPF' está vacía en el Web.config.");
            }
        }

        public SqlConnection ObtenerConexion()
        {
            return new SqlConnection(_connectionString);
        }
    }
}