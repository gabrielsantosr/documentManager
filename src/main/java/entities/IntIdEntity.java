package entities;

import java.lang.reflect.Method;
import java.util.List;

/*
 * El propósito de esta clase es ser heredada por entidades
 * con id Integer.
 * A su vez fuerza a implementar el método getLazyGetters,
 * que en DaoImpl va a permitir instanciar las lazy fetched collections.
 * Esto excluye a la entidad Authorship, que tiene una composite
 * key como id.
 * 
 */
public abstract class IntIdEntity{
	public abstract Integer getId();
	public abstract void setId(Integer id);
	public abstract List<Method>getLazyGetters();
	

}
