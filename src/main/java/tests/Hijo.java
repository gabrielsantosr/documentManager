package tests;

import java.util.ArrayList;
import java.util.List;

public class Hijo  {
	private List<Object>lista;
	private String nombre;
	private String apellido;
	private Integer edad;
	public Hijo(){
		lista = new ArrayList<>();
		nombre = "Juan";
		apellido = "Pérez";
		edad = 26;
		lista.add(getNombre());
		lista.add(getApellido());
		lista.add(getEdad());
	}
	@Override
	public String toString() {
		String string="";
		for(Object o:lista) {
			string += String.valueOf(o) + ", ";
		}
		return string.substring(0,string.length()-2);
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public void setEdad(Integer edad) {
		this.edad = edad;
	}
	public String getNombre() {
		return nombre;
	}
	public String getApellido() {
		return apellido;
	}
	public Integer getEdad() {
		return edad;
	}
	
	
}
