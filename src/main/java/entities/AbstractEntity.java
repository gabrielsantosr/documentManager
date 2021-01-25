package entities;
/*
 * El propósito de esta clase es ser heredada por entidades
 * con id Integer.
 * Esto excluye a la entidad Authorship, que tiene una composite
 * key como id.
 * 
 */
public abstract class AbstractEntity{
	public abstract Integer getId();
	public abstract void setId(Integer id);

}
