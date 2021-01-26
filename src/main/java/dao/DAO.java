package dao;

import java.util.List;

import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.IntIdEntity;

public interface DAO {
	IntIdEntity get(Class<? extends IntIdEntity> entityClass, Integer id);
	Authorship get(Integer docId, Integer authorId);
	IntIdEntity getEager (Class<? extends IntIdEntity> entityClass,Integer id);
	List<IntIdEntity>getAll(Class<? extends IntIdEntity> entityClass);
	List<IntIdEntity>getAllEager(Class<? extends IntIdEntity> entityClass);
	boolean save (IntIdEntity row);
	boolean update (IntIdEntity oldData, IntIdEntity newData);
	boolean delete (IntIdEntity row);
	
}
