using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaCotizacionAPF.Modelos
{
    public class ProductoAPF
    {
        public int IdProducto { get; set; }
        public string CodigoProducto { get; set; }
        public string NombreProducto { get; set; }
        public string Moneda { get; set; }
        public string Descripcion { get; set; }
    }
}