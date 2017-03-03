/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mobilesapp;

/**
 *
 * @author xyto_
 */
public class PuntoDeVenta {
    String ID;
    String Direccion;
    String Ciudad;
    String Correo;
    String Telefono;

    public PuntoDeVenta() {
    }

    public PuntoDeVenta(String ID, String Direccion, String Ciudad, String Correo, String Telefono) {
        this.ID = ID;
        this.Direccion = Direccion;
        this.Ciudad = Ciudad;
        this.Correo = Correo;
        this.Telefono = Telefono;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getCiudad() {
        return Ciudad;
    }

    public void setCiudad(String Ciudad) {
        this.Ciudad = Ciudad;
    }

    public String getCorreo() {
        return Correo;
    }

    public void setCorreo(String Correo) {
        this.Correo = Correo;
    }

    public String getTelefono() {
        return Telefono;
    }

    public void setTelefono(String Telefono) {
        this.Telefono = Telefono;
    }

    @Override
    public String toString() {
        return "ID: " + ID;
    }
}
