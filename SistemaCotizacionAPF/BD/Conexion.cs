using System.Configuration;
using System.Data.SqlClient;

namespace SistemaCotizacionAPF.BD
{
    public class Conexion
    {
        private readonly string cadena = ConfigurationManager.ConnectionStrings["cnAPF"].ConnectionString;

        public SqlConnection ObtenerConexion()
        {
            return new SqlConnection(cadena);
        }
    }
}