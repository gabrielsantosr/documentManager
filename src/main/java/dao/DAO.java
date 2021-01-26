package dao;

import java.util.List;

import entities.IntIdEntity;

public interface DAO {
	IntIdEntity get(Class<? extends IntIdEntity> entityClass, Integer id);
	IntIdEntity getEager (Class<? extends IntIdEntity> entityClass,Integer id);
	List<IntIdEntity>getAll(Class<? extends IntIdEntity> entityClass);
	List<IntIdEntity>getAllEager(Class<? extends IntIdEntity> entityClass);
	boolean save (IntIdEntity row);
	boolean update (IntIdEntity oldData, IntIdEntity newData);
	boolean delete (IntIdEntity row);
	
}
