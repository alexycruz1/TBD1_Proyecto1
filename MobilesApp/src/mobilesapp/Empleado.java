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
public class Empleado {
    private String ID;
    private String RTN;
    private double Sueldo;
    private String Direccion;
    private Date FechaInicio;
    private String Telefono;
    private String Nombre;

    public Empleado() {
    }

    public Empleado(String ID, String RTN, double Sueldo, String Direccion, Date FechaInicio, String Telefono, String Nombre) {
        this.ID = ID;
        this.RTN = RTN;
        this.Sueldo = Sueldo;
        this.Direccion = Direccion;
        this.FechaInicio = FechaInicio;
        this.Telefono = Telefono;
        this.Nombre = Nombre;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getRTN() {
        return RTN;
    }

    public void setRTN(String RTN) {
        this.RTN = RTN;
    }

    public double getSueldo() {
        return Sueldo;
    }

    public void setSueldo(double Sueldo) {
        this.Sueldo = Sueldo;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public Date getFechaInicio() {
        return FechaInicio;
    }

    public void setFechaInicio(Date FechaInicio) {
        this.FechaInicio = FechaInicio;
    }

    public String getTelefono() {
        return Telefono;
    }

    public void setTelefono(String Telefono) {
        this.Telefono = Telefono;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }
    

    @Override
    public String toString() {
        return "Nombre: " + Nombre + " " + "ID: " + ID;
    }
}
