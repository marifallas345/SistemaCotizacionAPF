using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaCotizacionAPF.Modelos
{
    public string Identificacion { get; set; }
    public string NombreCompleto { get; set; }
    public string Telefono { get; set; }
    public string Correo { get; set; }

    public Cliente()
    {
    }

    public Cliente(string identificacion, string nombreCompleto, string telefono, string correo)
    {
        Identificacion = identificacion;
        NombreCompleto = nombreCompleto;
        Telefono = telefono;
        Correo = correo;
    }
}
