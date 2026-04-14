using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaCotizacionAPF.Modelos
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string NombreCompleto { get; set; }
        public string Correo { get; set; }
        public string NombreRol { get; set; }

        public int IdCliente { get; set; }
    }
}