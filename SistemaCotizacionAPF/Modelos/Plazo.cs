using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaCotizacionAPF.Modelos
{
    public class Plazo
    {
        public int IdPlazo { get; set; }
        public int PlazoMeses { get; set; }
        public int PlazoDias { get; set; }
        public string Descripcion { get; set; }
        public bool Estado { get; set; }
    }
}