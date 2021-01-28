package entities;

import java.lang.reflect.Method;
import java.util.List;

/*
 * El propósito de esta clase es ser heredada por entidades
 * con id Integer.\
 * 
 */
public abstract class IntIdEntity{
	public abstract Integer getId();
	public abstract void setId(Integer id);
	public abstract List<Method> getLazyGetters();
}
