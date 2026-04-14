using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaCotizacionAPF.Modelos
{
    public class Tasa
    {
        public int IdTasa { get; set; }
        public int IdProducto { get; set; }
        public int IdPlazo { get; set; }
        public decimal TasaAnual { get; set; }
        public decimal Impuesto { get; set; }
        public DateTime FechaVigencia { get; set; }
        public bool Estado { get; set; }
    }
}