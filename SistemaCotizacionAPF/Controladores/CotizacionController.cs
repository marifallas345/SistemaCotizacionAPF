using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacionAPF.BD;

namespace SistemaCotizacionAPF.Controladores
{
    public class CotizacionController
    {
        private readonly ConexionBD _conexion = new ConexionBD();

        public int InsertarCliente(string identificacion, string nombreCompleto, string telefono, string correo, string tipoCliente)
        {
            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                cn.Open();

                // Verificar si el cliente ya existe por identificación
                using (SqlCommand cmdBuscar = new SqlCommand("SELECT IdCliente FROM Clientes WHERE Identificacion = @Identificacion", cn))
                {
                    cmdBuscar.Parameters.AddWithValue("@Identificacion", identificacion);

                    object resultado = cmdBuscar.ExecuteScalar();

                    if (resultado != null)
                    {
                        return Convert.ToInt32(resultado);
                    }
                }

                // Si no existe, se inserta
                using (SqlCommand cmd = new SqlCommand("sp_InsertarCliente", cn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Identificacion", identificacion);
                    cmd.Parameters.AddWithValue("@NombreCompleto", nombreCompleto);
                    cmd.Parameters.AddWithValue("@Telefono", telefono);
                    cmd.Parameters.AddWithValue("@Correo", correo);
                    cmd.Parameters.AddWithValue("@TipoCliente", tipoCliente);

                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        public int InsertarCotizacion(int numeroCotizacion, int idCliente, int idProducto, int idUsuario,
            decimal monto, int plazoMeses, decimal tasaAnual, decimal impuestoPorcentaje,
            decimal interesBruto, decimal impuestoMonto, decimal interesNeto)
        {
            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand("sp_InsertarCotizacion", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@NumeroCotizacion", numeroCotizacion);
                    cmd.Parameters.AddWithValue("@IdCliente", idCliente);
                    cmd.Parameters.AddWithValue("@IdProducto", idProducto);
                    cmd.Parameters.AddWithValue("@IdUsuario", idUsuario);
                    cmd.Parameters.AddWithValue("@Monto", monto);
                    cmd.Parameters.AddWithValue("@PlazoMeses", plazoMeses);
                    cmd.Parameters.AddWithValue("@TasaAnual", tasaAnual);
                    cmd.Parameters.AddWithValue("@ImpuestoPorcentaje", impuestoPorcentaje);
                    cmd.Parameters.AddWithValue("@InteresBruto", interesBruto);
                    cmd.Parameters.AddWithValue("@ImpuestoMonto", impuestoMonto);
                    cmd.Parameters.AddWithValue("@InteresNeto", interesNeto);

                    cn.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        public void InsertarDetalleCotizacion(int idCotizacion, int numeroMes, decimal montoBase,
            decimal interesBrutoMes, decimal impuestoMes, decimal interesNetoMes)
        {
            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand("sp_InsertarDetalleCotizacion", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdCotizacion", idCotizacion);
                    cmd.Parameters.AddWithValue("@NumeroMes", numeroMes);
                    cmd.Parameters.AddWithValue("@MontoBase", montoBase);
                    cmd.Parameters.AddWithValue("@InteresBrutoMes", interesBrutoMes);
                    cmd.Parameters.AddWithValue("@ImpuestoMes", impuestoMes);
                    cmd.Parameters.AddWithValue("@InteresNetoMes", interesNetoMes);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public DataTable ListarCotizaciones(int idUsuario, string rol)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand("sp_ListarCotizaciones", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@IdUsuario", idUsuario);
                    cmd.Parameters.AddWithValue("@NombreRol", rol);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            return dt;
        }
        public DataTable ObtenerCotizacionPorId(int idCotizacion)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand("sp_ObtenerCotizacionPorId", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdCotizacion", idCotizacion);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            return dt;
        }

        public DataTable ObtenerReporteCotizaciones(int idUsuario, string rol)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand("sp_ReporteCotizaciones", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdUsuario", idUsuario);
                    cmd.Parameters.AddWithValue("@NombreRol", rol);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            return dt;
        }

    }
}