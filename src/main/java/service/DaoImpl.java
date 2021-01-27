package service;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

import entities.Author;
import entities.Authorship;
import entities.Document;
import entities.DocumentType;
import entities.IntIdEntity;
import entities.Note;

public class DaoImpl implements DAO{
	

	private SessionFactory sf;
	private Session session;
	private Transaction transaction;
	
	public DaoImpl(){
		Configuration config = new Configuration().configure()
    			.addAnnotatedClass(Document.class)
    			.addAnnotatedClass(DocumentType.class)
    			.addAnnotatedClass(Author.class)
    			.addAnnotatedClass(Authorship.class)
    			.addAnnotatedClass(Note.class);
    	ServiceRegistry reg = new ServiceRegistryBuilder().applySettings(config.getProperties()).buildServiceRegistry();
    	sf = config.buildSessionFactory(reg);
	}

	protected void openSession() {
		session = sf.openSession();
	}
	
	protected void newTransaction() {
 		transaction = session.beginTransaction();
	}
	
	protected void commitTransaction() {
		transaction.commit();
	}
	
	protected void closeSession() {
		session.close();
	}
	
	@Override
	public IntIdEntity get(Class<? extends IntIdEntity> entityClass,Integer id) {
		IntIdEntity fetched = (IntIdEntity) session.get(entityClass, id);
		return fetched;
	}
	
	
	@Override
	public Authorship get(Integer docId, Integer authorId) {
		SQLQuery sqlQuery =session
				.createSQLQuery("SELECT * FROM authorship where document_id=:dID AND author_id =:aID");
		sqlQuery.addEntity(Authorship.class);
		sqlQuery.setParameter("dID", docId);
		sqlQuery.setParameter("aID", authorId);
		Authorship fetched = (Authorship) sqlQuery.uniqueResult();
		Hibernate.initialize(fetched.getDocument().getAuthorships());
		Hibernate.initialize(fetched.getDocument().getNotes());
		return fetched;
	}

	@Override
	public boolean save(Object row) {
		boolean success = false;
		try {
			session.save(row);
			success = true;
		} catch (Exception e) {
			transaction.rollback();
		}
		return success;
	}

	@Override
	public boolean update(IntIdEntity oldData, IntIdEntity newData) {
		if(!oldData.getClass().equals(newData.getClass())) {
			return false;
		}
		boolean success = false;
		
		try {
			newData.setId(oldData.getId());
			
			session.update(newData);
			success = true;
		} catch (Exception e) {
			transaction.rollback();
		}
		return success;
	}

	@Override
	public boolean delete(IntIdEntity rowType) {
		boolean success = false;
		try {
			session.delete(rowType);
			success = true;
		} catch (Exception e) {
			transaction.rollback();
		}
		return success;
	}

	@Override
	public List<IntIdEntity> getAll(Class<? extends IntIdEntity> clazz) {
		
		List<IntIdEntity> lista = null;
		Query q = session.createQuery("FROM "+ clazz.getName());
		lista = (List<IntIdEntity>) (q.list());
		return lista;
	}

	@Override
	public IntIdEntity getEager(Class<? extends IntIdEntity> entityClass, Integer id) {
		IntIdEntity fetched = (IntIdEntity) session.get(entityClass, id);
		for (Method getter: fetched.getLazyGetters()) {
			try {
				Hibernate.initialize(getter.invoke(fetched,null));
			} catch (HibernateException | IllegalAccessException | IllegalArgumentException
					| InvocationTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return fetched;
	}

	@Override
	public List<IntIdEntity> getAllEager(Class<? extends IntIdEntity> entityClass) {
		
		return null;
	}

}
