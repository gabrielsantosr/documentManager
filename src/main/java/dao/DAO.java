package dao;

import entities.AbstractEntity;

public interface DAO {
	AbstractEntity get (Class<?> clazz,Integer id);
	boolean save (AbstractEntity row);
	boolean update (AbstractEntity oldData, AbstractEntity newData);
	boolean delete (AbstractEntity row);
}
