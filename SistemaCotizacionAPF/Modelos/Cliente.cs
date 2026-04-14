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
        public string NombreCliente { get; set; }
        public string Telefono { get; set; }
        public string Correo { get; set; }
        public int? IdUsuario { get; set; }
        public bool Estado { get; set; }

        public Cliente()
        {
        }

        public Cliente(string identificacion, string nombreCliente, string telefono, string correo, int? idUsuario = null)
        {
            Identificacion = identificacion;
            NombreCliente = nombreCliente;
            Telefono = telefono;
            Correo = correo;
            IdUsuario = idUsuario;
            Estado = true;
        }
    }
}