/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mobilesapp;

import java.util.Date;

/**
 *
 * @author xyto_
 */
public class Orden {
    String ID;
    String IDEmpleado;
    String IDPuntoDeVenta;
    Date FechaOrden;

    public Orden() {
    }

    public Orden(String ID, String IDEmpleado, String IDPuntoDeVenta, Date FechaOrden) {
        this.ID = ID;
        this.IDEmpleado = IDEmpleado;
        this.IDPuntoDeVenta = IDPuntoDeVenta;
        this.FechaOrden = FechaOrden;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getIDEmpleado() {
        return IDEmpleado;
    }

    public void setIDEmpleado(String IDEmpleado) {
        this.IDEmpleado = IDEmpleado;
    }

    public String getIDPuntoDeVenta() {
        return IDPuntoDeVenta;
    }

    public void setIDPuntoDeVenta(String IDPuntoDeVenta) {
        this.IDPuntoDeVenta = IDPuntoDeVenta;
    }

    public Date getFechaOrden() {
        return FechaOrden;
    }

    public void setFechaOrden(Date FechaOrden) {
        this.FechaOrden = FechaOrden;
    }

    @Override
    public String toString() {
        return "ID: " + ID;
    }
    
    
}
