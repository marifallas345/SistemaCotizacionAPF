using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaCotizacionAPF.Modelos
{
    public class Cotizacion
    {
        public int IdCotizacion { get; set; }
        public int NumeroCotizacion { get; set; }
        public int IdCliente { get; set; }
        public int IdProducto { get; set; }
        public int IdUsuario { get; set; }
        public decimal Monto { get; set; }
        public int PlazoMeses { get; set; }
        public decimal TasaAnual { get; set; }
        public decimal ImpuestoPorcentaje { get; set; }
        public decimal InteresBruto { get; set; }
        public decimal ImpuestoMonto { get; set; }
        public decimal InteresNeto { get; set; }
    }
}