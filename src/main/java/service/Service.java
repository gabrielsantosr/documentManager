package service;

import java.util.List;

import entities.Authorship;
import entities.IntIdEntity;

public class Service {
	
	private DaoImpl dao;
	
	public Service() {
		this.dao = new DaoImpl();
	}
	
	public IntIdEntity get(Class<? extends IntIdEntity> entityClass,Integer id, boolean eager) {
		dao.enableSession();
		IntIdEntity entity;
		if (eager) {
			entity = dao.getEager(entityClass, id);
		} else {
			entity = dao.get(entityClass, id);
		}
		dao.closeSession();
		return entity;
	}
	
	public Authorship get(Integer docId, Integer authorId) {
		dao.enableSession();
		Authorship authorship = dao.get(docId, authorId);
		dao.closeSession();
		return authorship;
		
	}
	
	public boolean save(Object row) {
		dao.enableSession();
		dao.enableTransaction();
		boolean success = dao.save(row);
		dao.commitTransaction();
		dao.closeSession();
		return success;
	}
	
	public boolean update(IntIdEntity oldData, IntIdEntity newData) {
		dao.enableSession();
		dao.enableTransaction();
		boolean success = dao.update(oldData, newData);
		dao.commitTransaction();
		dao.closeSession();
		return success;
	}

	public boolean delete(IntIdEntity rowType) {
		dao.enableSession();
		dao.enableTransaction();
		boolean success = dao.delete(rowType);
		dao.commitTransaction();
		dao.closeSession();
		return success;
	}
	
	public List<IntIdEntity> getAll(Class<? extends IntIdEntity> clazz) {
		dao.enableSession();
		List<IntIdEntity> list = dao.getAll(clazz);
		dao.closeSession();
		return list;
	}
	
	


	
	

}
