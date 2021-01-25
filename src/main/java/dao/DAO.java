package dao;

import java.util.List;

import entities.AbstractEntity;

public interface DAO {
	AbstractEntity get (Class<? extends AbstractEntity> entityClass,Integer id);
	List<AbstractEntity>getAll(Class<? extends AbstractEntity> entityClass);
	boolean save (AbstractEntity row);
	boolean update (AbstractEntity oldData, AbstractEntity newData);
	boolean delete (AbstractEntity row);
	
}
