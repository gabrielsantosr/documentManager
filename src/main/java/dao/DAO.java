package dao;

import java.util.List;

import entities.EntityParent;

public interface DAO {
	EntityParent get(Class<? extends EntityParent> entityClass, Integer id);
	EntityParent getEager (Class<? extends EntityParent> entityClass,Integer id);
	List<EntityParent>getAll(Class<? extends EntityParent> entityClass);
	List<EntityParent>getAllEager(Class<? extends EntityParent> entityClass);
	boolean save (EntityParent row);
	boolean update (EntityParent oldData, EntityParent newData);
	boolean delete (EntityParent row);
	
}
