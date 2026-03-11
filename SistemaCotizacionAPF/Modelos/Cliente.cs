using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaCotizacionAPF.Modelos
{
    public class Cliente
    {
        public int IdCliente { get; set; }
        public string Identificacion { get; set; }
        public string NombreCompleto { get; set; }
        public string Telefono { get; set; }
        public string Correo { get; set; }
        public string TipoCliente { get; set; }
    }
}