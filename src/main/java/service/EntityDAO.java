package service;

import java.util.List;

import entities.Authorship;
import entities.IntIdEntity;

public interface EntityDAO {
	IntIdEntity get(Class<? extends IntIdEntity> entityClass, Integer id);
	Authorship get(Integer docId, Integer authorId);
	IntIdEntity getEager (Class<? extends IntIdEntity> entityClass,Integer id);
	List<IntIdEntity>getAll(Class<? extends IntIdEntity> entityClass);
	List<IntIdEntity>getAllEager(Class<? extends IntIdEntity> entityClass);
	boolean save (Object row);
	boolean update (IntIdEntity oldData, IntIdEntity newData);
	boolean delete (IntIdEntity row);
	
}
