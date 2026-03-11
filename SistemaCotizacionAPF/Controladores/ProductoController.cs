using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacionAPF.BD;
using SistemaCotizacionAPF.Modelos;

namespace SistemaCotizacionAPF.Controladores
{
    public class ProductoController
    {
        private readonly ConexionBD _conexion = new ConexionBD();

        public List<ProductoAPF> ListarProductos()
        {
            List<ProductoAPF> lista = new List<ProductoAPF>();

            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand("sp_ListarProductos", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cn.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(new ProductoAPF
                            {
                                IdProducto = (int)dr["IdProducto"],
                                CodigoProducto = dr["CodigoProducto"].ToString(),
                                NombreProducto = dr["NombreProducto"].ToString(),
                                Moneda = dr["Moneda"].ToString(),
                                Descripcion = dr["Descripcion"].ToString()
                            });
                        }
                    }
                }
            }

            return lista;
        }

        public decimal ObtenerTasa(int idProducto, int plazoMeses)
        {
            using (SqlConnection cn = _conexion.ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand("sp_ObtenerTasaProducto", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdProducto", idProducto);
                    cmd.Parameters.AddWithValue("@PlazoMeses", plazoMeses);

                    cn.Open();
                    object resultado = null;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            resultado = dr["TasaAnual"];
                        }
                    }

                    return resultado == null ? 0m : (decimal)resultado;
                }
            }
        }
    }
}