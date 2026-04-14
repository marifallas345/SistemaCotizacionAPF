using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaCotizacionAPF.Modelos
{
    public class Cotizacion
    {
        public int IdCotizacion { get; set; }
        public string NumeroCotizacion { get; set; }
        public int IdCliente { get; set; }
        public int IdUsuario { get; set; }
        public int IdProducto { get; set; }
        public int IdPlazo { get; set; }
        public int IdTasa { get; set; }
        public decimal Monto { get; set; }
        public decimal TasaAplicada { get; set; }
        public decimal ImpuestoAplicado { get; set; }
        public decimal MontoTotalInteresBruto { get; set; }
        public decimal MontoTotalImpuesto { get; set; }
        public decimal MontoTotalNeto { get; set; }
        public DateTime FechaCotizacion { get; set; }
    }
}