using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaCotizacionAPF.Modelos
{
    public class DetalleCotizacion
    {
        public int IdDetalle { get; set; }
        public int IdCotizacion { get; set; }
        public int NumeroMes { get; set; }
        public decimal Monto { get; set; }
        public decimal InteresBruto { get; set; }
        public decimal Impuesto { get; set; }
        public decimal InteresNeto { get; set; }
    }
}