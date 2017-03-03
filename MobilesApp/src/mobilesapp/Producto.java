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
public class Producto {
    String ID;
    String IDProveedor;
    String Nombre;
    double PrecioVenta;
    double PrecioCompra;
    int Unidades;
    String Descripcion;

    public Producto() {
    }

    public Producto(String ID, String IDProveedor, String Nombre, double PrecioVenta, double PrecioCompra, int Unidades, String Descripcion) {
        this.ID = ID;
        this.IDProveedor = IDProveedor;
        this.Nombre = Nombre;
        this.PrecioVenta = PrecioVenta;
        this.PrecioCompra = PrecioCompra;
        this.Unidades = Unidades;
        this.Descripcion = Descripcion;
    }


    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public double getPrecioVenta() {
        return PrecioVenta;
    }

    public void setPrecioVenta(double PrecioVenta) {
        this.PrecioVenta = PrecioVenta;
    }

    public double getPrecioCompra() {
        return PrecioCompra;
    }

    public void setPrecioCompra(double PrecioCompra) {
        this.PrecioCompra = PrecioCompra;
    }

    public int getUnidades() {
        return Unidades;
    }

    public void setUnidades(int Unidades) {
        this.Unidades = Unidades;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public String getIDProveedor() {
        return IDProveedor;
    }

    public void setIDProveedor(String IDProveedor) {
        this.IDProveedor = IDProveedor;
    }
    

    @Override
    public String toString() {
        return "Nombre: " + Nombre + " " + "ID: " + ID;
    }
}
